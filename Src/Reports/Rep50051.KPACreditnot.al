report 50051 "KPA Payment CRInvoice report"
{
    ApplicationArea = All;
    //Caption = 'KPA Payment Invoice and Credit Memo Report';
    Caption = 'KPA Payment Invoice report';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        // ==================== DATAITEM 1: PURCHASE INVOICES (SHEET 1) ====================
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            RequestFilterFields = "Posting Date", "No.", Closed;
            DataItemTableView = sorting("Posting Date") where("Pay-to Vendor No." = const('KPA001'));

            trigger OnPreDataItem()
            begin
                DateFilterText := "Purch. Inv. Header".GETFILTER("Posting Date");
                FilterString := DateFilterText;
                CreateExcelHeader();
            end;

            trigger OnAfterGetRecord()
            begin
                ProcessInvoiceRecord();
                CreateExcelBodyInv();
            end;

            trigger OnPostDataItem()
            begin
                CreateExcelSheet(CopyStr("Purch. Inv. Header".TableName, 1, 250), true);
            end;
        }

        // ==================== DATAITEM 2: PURCHASE CREDIT MEMOS (SHEET 2) ====================
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            RequestFilterFields = "Posting Date", "No.";
            DataItemTableView = sorting("Posting Date") where("Pay-to Vendor No." = const('KPA001'));

            trigger OnPreDataItem()
            begin


                // Get date filter if not already set from invoices
                if FilterString = '' then begin
                    DateFilterText := "Purch. Cr. Memo Hdr.".GETFILTER("Posting Date");
                    FilterString := DateFilterText;
                end;

                CreateExcelHeader();
            end;

            trigger OnAfterGetRecord()
            begin
                ProcessCreditMemoRecord();
                CreateExcelBodyCr();
            end;


            trigger OnPostDataItem()
            begin
                CreateExcelSheet(CopyStr("Purch. Cr. Memo Hdr.".TableName, 1, 250), false);
            end;

        }
    }

    trigger OnInitReport()
    begin
        TempExcelBuffer.DeleteAll();
    end;

    trigger OnPostReport()
    begin
        CreateExcelBook();
    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        DateFilterText: Text[50];
        FilterString: Text[250];
        InvoiceSheetCreated: Boolean;
        CreditMemoSheetCreated: Boolean;

        // Invoice Line Records
        PurchaseInvLine: Record "Purch. Inv. Line";
        PurchaseInvLine1: Record "Purch. Inv. Line";
        PurchaseInvLine2: Record "Purch. Inv. Line";
        PurchaseInvLine3: Record "Purch. Inv. Line";
        PurchaseInvLine4: Record "Purch. Inv. Line";
        PurchaseInvLine5: Record "Purch. Inv. Line";
        PurchaseInvLine6: Record "Purch. Inv. Line";
        PurchaseInvLine7: Record "Purch. Inv. Line";
        PurchaseInvLine8: Record "Purch. Inv. Line";
        PurchaseInvLine9: Record "Purch. Inv. Line";
        PurchaseInvLine10: Record "Purch. Inv. Line";
        PurchaseInvLine11: Record "Purch. Inv. Line";
        PurchaseInvLine12: Record "Purch. Inv. Line";
        PurchaseInvLine13: Record "Purch. Inv. Line";
        PurchaseInvLine14: Record "Purch. Inv. Line";
        PurchaseInvLine15: Record "Purch. Inv. Line";
        // Credit Memo Line Records
        PurchaseCrMemoLine: Record "Purch. Cr. Memo Line";
        PurchaseCrMemoLine1: Record "Purch. Cr. Memo Line";
        PurchaseCrMemoLine2: Record "Purch. Cr. Memo Line";
        PurchaseCrMemoLine3: Record "Purch. Cr. Memo Line";
        PurchaseCrMemoLine4: Record "Purch. Cr. Memo Line";
        PurchaseCrMemoLine5: Record "Purch. Cr. Memo Line";
        PurchaseCrMemoLine6: Record "Purch. Cr. Memo Line";
        PurchaseCrMemoLine7: Record "Purch. Cr. Memo Line";
        PurchaseCrMemoLine8: Record "Purch. Cr. Memo Line";
        PurchaseCrMemoLine9: Record "Purch. Cr. Memo Line";
        PurchaseCrMemoLine10: Record "Purch. Cr. Memo Line";
        PurchaseCrMemoLine11: Record "Purch. Cr. Memo Line";
        PurchaseCrMemoLine12: Record "Purch. Cr. Memo Line";
        PurchaseCrMemoLine13: Record "Purch. Cr. Memo Line";
        PurchaseCrMemoLine14: Record "Purch. Cr. Memo Line";
        PurchaseCrMemoLine15: Record "Purch. Cr. Memo Line";


        // Shared Calculation Variables
        ShorehandlingCharges20FT: Decimal;
        CFShandlingCharges20FT: Decimal;
        ShorehandlingCharges40FT: Decimal;
        CFShandlingCharges40FT: Decimal;
        CBMCharges: Decimal;
        ShorehandlingSum: Decimal;
        wharfageSum: Decimal;
        RemarshallingSum: Decimal;
        StorageSum: Decimal;
        ReeferCahrgesSum: Decimal;
        IMCOChargesSum: Decimal;
        TollChargesSum: Decimal;
        ImcoTollChargesSum: Decimal;
        WithouVATSum: Decimal;
        WithVAT: Decimal;
        VATKSH: Decimal;
        TotalUSD: Decimal;
        TotalKSH: Decimal;
        TotalAmount: Decimal;
        ContainerId_gCode: Code[20];
        ContainerId20ft_gCode: Code[20];
        DimensionSetEntry: Record "Dimension Set Entry";
        ManifestLine1: Record "Manifest Line";
        AmountKSH: Decimal;
        RateExh: Decimal;
        ContainerId_gCode40FT: Code[20];
        Wharfage20Ft: Decimal;
        Wharfage40Ft: Decimal;
        Countof40FT: Integer;
        CountofCBM: Integer;
        UnitsCount: Integer;
        Countof20FT: Integer;
        ContainerId_gCode20FT: Code[20];
        BLNo: Code[20];
        VATUSD: Decimal;
        AmountPayble: Decimal;
        WHTVATKSH: Decimal;
        IMSSetup: Record "IMS Setup";

    // ==================== INVOICE PROCESSING PROCEDURE ====================
    local procedure ProcessInvoiceRecord()
    begin
        //ClearVars();

        // Exchange Rate and Amount Calculations
        Clear(RateExh);
        Clear(AmountKSH);
        if "Purch. Inv. Header"."Currency Code" <> '' then begin
            RateExh := (1 / "Purch. Inv. Header"."Currency Factor");
            "Purch. Inv. Header".CalcFields("Amount Including VAT");
            AmountKSH := RateExh * "Purch. Inv. Header"."Amount Including VAT";
        end;

        Clear(VATUSD);
        if "Purch. Inv. Header".Amount <> "Purch. Inv. Header"."Amount Including VAT" then begin
            "Purch. Inv. Header".CalcFields("Amount Including VAT");
            VATUSD := "Purch. Inv. Header"."Amount Including VAT" - "Purch. Inv. Header".Amount;
        end else begin
            VATUSD := 0;
        end;

        VATKSH := VATUSD * RateExh;
        WithVAT := (VATUSD / 0.16) * 0.02;
        AmountPayble := "Purch. Inv. Header".Amount - WithVAT;
        WHTVATKSH := WithVAT * RateExh;

        // 20FT Calculation
        Clear(Countof20FT);
        PurchaseInvLine.Reset();
        PurchaseInvLine.SetCurrentKey("Shortcut Dimension 1 Code", "Document No.");
        PurchaseInvLine.SetRange("Document No.", "Purch. Inv. Header"."No.");
        if PurchaseInvLine.FindFirst() then begin
            repeat
                if ContainerId_gCode20FT <> PurchaseInvLine."Shortcut Dimension 1 Code" then begin
                    DimensionSetEntry.Reset();
                    DimensionSetEntry.SetRange("Dimension Set ID", PurchaseInvLine."Dimension Set ID");
                    DimensionSetEntry.SetRange("Dimension Code", 'CONTAINER SIZE');
                    DimensionSetEntry.SetRange("Dimension Value Code", '20FT');
                    if DimensionSetEntry.FindSet() then begin
                        Countof20FT += 1;
                    end;
                    ContainerId_gCode20FT := PurchaseInvLine."Shortcut Dimension 1 Code";
                end;
            until PurchaseInvLine.Next() = 0;
        end;

        // 40FT Calculation
        Clear(Countof40FT);
        PurchaseInvLine1.Reset();
        PurchaseInvLine1.SetCurrentKey("Shortcut Dimension 1 Code", "Document No.");
        PurchaseInvLine1.SetRange("Document No.", "Purch. Inv. Header"."No.");
        if PurchaseInvLine1.FindFirst() then begin
            repeat
                if ContainerId_gCode <> PurchaseInvLine1."Shortcut Dimension 1 Code" then begin
                    DimensionSetEntry.Reset();
                    DimensionSetEntry.SetRange("Dimension Set ID", PurchaseInvLine1."Dimension Set ID");
                    DimensionSetEntry.SetRange("Dimension Code", 'CONTAINER SIZE');
                    DimensionSetEntry.SetRange("Dimension Value Code", '40FT');
                    if DimensionSetEntry.FindSet() then begin
                        Countof40FT += 1;
                    end;
                    ContainerId_gCode := PurchaseInvLine1."Shortcut Dimension 1 Code";
                end;
            until PurchaseInvLine1.Next() = 0;
        end;

        // CBM Calculation
        Clear(CountofCBM);
        PurchaseInvLine2.Reset();
        PurchaseInvLine2.SetCurrentKey("Shortcut Dimension 1 Code", "Document No.");
        PurchaseInvLine2.SetRange("Document No.", "Purch. Inv. Header"."No.");
        //PurchaseInvLine2.SetRange("Posting Date", "Purch. Inv. Header"."Posting Date");
        if PurchaseInvLine2.FindFirst() then begin
            repeat
                if ContainerId_gCode <> PurchaseInvLine2."Shortcut Dimension 1 Code" then begin
                    DimensionSetEntry.Reset();
                    DimensionSetEntry.SetRange("Dimension Set ID", PurchaseInvLine2."Dimension Set ID");
                    DimensionSetEntry.SetRange("Dimension Code", 'CARGO TYPE');
                    DimensionSetEntry.SetRange("Dimension Value Code", 'UNIT');
                    if DimensionSetEntry.FindSet() then begin
                        CountofCBM += 1;
                    end;
                    ContainerId_gCode := PurchaseInvLine2."Shortcut Dimension 1 Code";
                end;
            until PurchaseInvLine2.Next() = 0;
        end;

        // CFShandling 20FT Calculation
        Clear(CFShandlingCharges20FT);
        PurchaseInvLine3.Reset();
        PurchaseInvLine3.SetRange("Document No.", "Purch. Inv. Header"."No.");
        PurchaseInvLine3.SetRange("Posting Date", "Purch. Inv. Header"."Posting Date");
        PurchaseInvLine3.SetRange("Item Category Code", 'SHOREHANDLING');
        if PurchaseInvLine3.FindFirst() then begin
            repeat
                DimensionSetEntry.Reset();
                DimensionSetEntry.SetRange("Dimension Set ID", PurchaseInvLine3."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", 'CONTAINER SIZE');
                DimensionSetEntry.SetRange("Dimension Value Code", '20FT');
                if DimensionSetEntry.FindSet() then begin
                    CFShandlingCharges20FT += PurchaseInvLine3."Unit Cost";
                end;
            until PurchaseInvLine3.Next() = 0;
        end;

        // Wharfage 20FT Calculation
        Clear(Wharfage20Ft);
        PurchaseInvLine5.Reset();
        PurchaseInvLine5.SetRange("Document No.", "Purch. Inv. Header"."No.");
        PurchaseInvLine5.SetRange("Posting Date", "Purch. Inv. Header"."Posting Date");
        PurchaseInvLine5.SetRange("Item Category Code", 'WHARFAGE');
        if PurchaseInvLine5.FindFirst() then begin
            repeat
                DimensionSetEntry.Reset();
                DimensionSetEntry.SetRange("Dimension Set ID", PurchaseInvLine5."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", 'CONTAINER SIZE');
                DimensionSetEntry.SetRange("Dimension Value Code", '20FT');
                if DimensionSetEntry.FindSet() then begin
                    Wharfage20Ft += PurchaseInvLine5."Unit Cost";
                end;
            until PurchaseInvLine5.Next() = 0;
        end;

        // CFShandling 40FT Calculation
        Clear(CFShandlingCharges40FT);
        PurchaseInvLine4.Reset();
        PurchaseInvLine4.SetRange("Document No.", "Purch. Inv. Header"."No.");
        PurchaseInvLine4.SetRange("Posting Date", "Purch. Inv. Header"."Posting Date");
        PurchaseInvLine4.SetRange("Item Category Code", 'SHOREHANDLING');
        if PurchaseInvLine4.FindFirst() then begin
            repeat
                DimensionSetEntry.Reset();
                DimensionSetEntry.SetRange("Dimension Set ID", PurchaseInvLine4."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", 'CONTAINER SIZE');
                DimensionSetEntry.SetRange("Dimension Value Code", '40FT');
                if DimensionSetEntry.FindSet() then begin
                    CFShandlingCharges40FT += PurchaseInvLine4."Unit Cost";
                end;
            until PurchaseInvLine4.Next() = 0;
        end;

        // Wharfage 40FT Calculation
        Clear(Wharfage40Ft);
        PurchaseInvLine6.Reset();
        PurchaseInvLine6.SetRange("Document No.", "Purch. Inv. Header"."No.");
        PurchaseInvLine6.SetRange("Posting Date", "Purch. Inv. Header"."Posting Date");
        PurchaseInvLine6.SetRange("Item Category Code", 'WHARFAGE');
        if PurchaseInvLine6.FindFirst() then begin
            repeat
                DimensionSetEntry.Reset();
                DimensionSetEntry.SetRange("Dimension Set ID", PurchaseInvLine6."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", 'CONTAINER SIZE');
                DimensionSetEntry.SetRange("Dimension Value Code", '40FT');
                if DimensionSetEntry.FindSet() then begin
                    Wharfage40Ft += PurchaseInvLine6."Unit Cost";
                end;
            until PurchaseInvLine6.Next() = 0;
        end;

        // CBM Charges Calculation
        Clear(CBMCharges);
        PurchaseInvLine7.Reset();
        PurchaseInvLine7.SetRange("Document No.", "Purch. Inv. Header"."No.");
        PurchaseInvLine7.SetRange("Posting Date", "Purch. Inv. Header"."Posting Date");
        if PurchaseInvLine7.FindFirst() then begin
            repeat
                DimensionSetEntry.Reset();
                DimensionSetEntry.SetRange("Dimension Set ID", PurchaseInvLine7."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", 'CARGO TYPE');
                DimensionSetEntry.SetRange("Dimension Value Code", 'UNIT');
                if DimensionSetEntry.FindSet() then begin
                    CBMCharges += PurchaseInvLine7."Unit Cost";
                end;
            until PurchaseInvLine7.Next() = 0;
        end;

        // Shorehandling Charges Calculation
        Clear(ShorehandlingSum);
        PurchaseInvLine8.Reset();
        PurchaseInvLine8.SetRange("Document No.", "Purch. Inv. Header"."No.");
        PurchaseInvLine8.SetRange("Posting Date", "Purch. Inv. Header"."Posting Date");
        PurchaseInvLine8.SetRange("Item Category Code", 'SHOREHANDLING');
        if PurchaseInvLine8.FindFirst() then begin
            repeat
                DimensionSetEntry.Reset();
                DimensionSetEntry.SetRange("Dimension Set ID", PurchaseInvLine8."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", 'CARGO TYPE');
                DimensionSetEntry.SetRange("Dimension Value Code", 'CONTAINER');
                if DimensionSetEntry.FindSet() then begin
                    ShorehandlingSum += PurchaseInvLine8."Unit Cost";
                end;
            until PurchaseInvLine8.Next() = 0;
        end;

        // Wharfage Charges Calculation
        Clear(wharfageSum);
        PurchaseInvLine9.Reset();
        PurchaseInvLine9.SetRange("Document No.", "Purch. Inv. Header"."No.");
        PurchaseInvLine9.SetRange("Posting Date", "Purch. Inv. Header"."Posting Date");
        PurchaseInvLine9.SetRange("Item Category Code", 'WHARFAGE');
        if PurchaseInvLine9.FindFirst() then begin
            repeat
                DimensionSetEntry.Reset();
                DimensionSetEntry.SetRange("Dimension Set ID", PurchaseInvLine9."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", 'CARGO TYPE');
                DimensionSetEntry.SetRange("Dimension Value Code", 'CONTAINER');
                if DimensionSetEntry.FindSet() then begin
                    wharfageSum += PurchaseInvLine9."Unit Cost";
                end;
            until PurchaseInvLine9.Next() = 0;
        end;

        // Remarshalling Charges Calculation
        Clear(RemarshallingSum);
        PurchaseInvLine10.Reset();
        PurchaseInvLine10.SetRange("Document No.", "Purch. Inv. Header"."No.");
        PurchaseInvLine10.SetRange("Posting Date", "Purch. Inv. Header"."Posting Date");
        PurchaseInvLine10.SetRange("Item Category Code", 'REMARSHALLING');
        if PurchaseInvLine10.FindFirst() then begin
            repeat
                DimensionSetEntry.Reset();
                DimensionSetEntry.SetRange("Dimension Set ID", PurchaseInvLine10."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", 'CARGO TYPE');
                DimensionSetEntry.SetRange("Dimension Value Code", 'CONTAINER');
                if DimensionSetEntry.FindSet() then begin
                    RemarshallingSum += PurchaseInvLine10."Unit Cost";
                end;
            until PurchaseInvLine10.Next() = 0;
        end;

        // Storage Charges Calculation
        Clear(StorageSum);
        PurchaseInvLine11.Reset();
        PurchaseInvLine11.SetRange("Document No.", "Purch. Inv. Header"."No.");
        PurchaseInvLine11.SetRange("Posting Date", "Purch. Inv. Header"."Posting Date");
        PurchaseInvLine11.SetRange("Item Category Code", 'STORAGE');
        if PurchaseInvLine11.FindFirst() then begin
            repeat
                DimensionSetEntry.Reset();
                DimensionSetEntry.SetRange("Dimension Set ID", PurchaseInvLine11."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", 'CARGO TYPE');
                DimensionSetEntry.SetRange("Dimension Value Code", 'CONTAINER');
                if DimensionSetEntry.FindSet() then begin
                    StorageSum += PurchaseInvLine11."Unit Cost";
                end;
            until PurchaseInvLine11.Next() = 0;
        end;

        // Reefer Charges Calculation
        Clear(ReeferCahrgesSum);
        PurchaseInvLine12.Reset();
        PurchaseInvLine12.SetRange("Document No.", "Purch. Inv. Header"."No.");
        PurchaseInvLine12.SetRange("Posting Date", "Purch. Inv. Header"."Posting Date");
        PurchaseInvLine12.SetRange("Item Category Code", 'REEFER');
        if PurchaseInvLine12.FindFirst() then begin
            repeat
                DimensionSetEntry.Reset();
                DimensionSetEntry.SetRange("Dimension Set ID", PurchaseInvLine12."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", 'CARGO TYPE');
                DimensionSetEntry.SetRange("Dimension Value Code", 'CONTAINER');
                if DimensionSetEntry.FindSet() then begin
                    ReeferCahrgesSum += PurchaseInvLine12."Unit Cost";
                end;
            until PurchaseInvLine12.Next() = 0;
        end;

        // IMCO Charges Calculation
        Clear(IMCOChargesSum);
        PurchaseInvLine13.Reset();
        PurchaseInvLine13.SetRange("Document No.", "Purch. Inv. Header"."No.");
        PurchaseInvLine13.SetRange("Posting Date", "Purch. Inv. Header"."Posting Date");
        PurchaseInvLine13.SetRange("Item Category Code", 'IMCO');
        if PurchaseInvLine13.FindFirst() then begin
            IMCOChargesSum := 0;
            repeat
                DimensionSetEntry.Reset();
                DimensionSetEntry.SetRange("Dimension Set ID", PurchaseInvLine13."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", 'CARGO TYPE');
                DimensionSetEntry.SetRange("Dimension Value Code", 'CONTAINER');
                if DimensionSetEntry.FindSet() then begin
                    IMCOChargesSum += PurchaseInvLine13."Unit Cost";
                end;
            until PurchaseInvLine13.Next() = 0;
        end;
        //Toll Charges Calculation
        Clear(TollChargesSum);
        PurchaseInvLine14.Reset();
        PurchaseInvLine14.SetRange("Document No.", "Purch. Inv. Header"."No.");
        PurchaseInvLine14.SetRange("Posting Date", "Purch. Inv. Header"."Posting Date");
        PurchaseInvLine14.SetRange("No.", 'I0045');
        if PurchaseInvLine14.FindFirst() then begin
            TollChargesSum := 0;
            repeat
                DimensionSetEntry.Reset();
                DimensionSetEntry.SetRange("Dimension Set ID", PurchaseInvLine14."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", 'CARGO TYPE');
                DimensionSetEntry.SetRange("Dimension Value Code", 'CONTAINER');
                if DimensionSetEntry.FindSet() then begin
                    TollChargesSum += PurchaseInvLine14."Unit Cost";
                end;
            until PurchaseInvLine14.Next() = 0;
        end;
        //Toll charges end
        //IMCO Toll Charges Calculation
        Clear(ImcoTollChargesSum);
        PurchaseInvLine15.Reset();
        PurchaseInvLine15.SetRange("Document No.", "Purch. Inv. Header"."No.");
        PurchaseInvLine15.SetRange("Posting Date", "Purch. Inv. Header"."Posting Date");
        PurchaseInvLine15.SetRange("Item Category Code", 'IMCO MSA TOLL');
        if PurchaseInvLine14.FindFirst() then begin
            ImcoTollChargesSum := 0;
            repeat
                DimensionSetEntry.Reset();
                DimensionSetEntry.SetRange("Dimension Set ID", PurchaseInvLine15."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", 'CARGO TYPE');
                DimensionSetEntry.SetRange("Dimension Value Code", 'CONTAINER');
                if DimensionSetEntry.FindSet() then begin
                    ImcoTollChargesSum += PurchaseInvLine14."Unit Cost";
                end;
            until PurchaseInvLine14.Next() = 0;
        end;
        //IMCO Toll charges end

        // Manifest lookup
        PurchaseInvLine.Reset();
        PurchaseInvLine.SetRange("Document No.", "Purch. Inv. Header"."No.");
        PurchaseInvLine.SetRange("Posting Date", "Purch. Inv. Header"."Posting Date");
        if PurchaseInvLine.FindFirst() then
            repeat
                ManifestLine1.Reset();
                ManifestLine1.SetRange("Global Dimension 1 Code", PurchaseInvLine."Shortcut Dimension 1 Code");
                if ManifestLine1.FindFirst() then;
            until PurchaseInvLine.Next() = 0;
    end;

    // ==================== CREDIT MEMO PROCESSING PROCEDURE ====================
    local procedure ProcessCreditMemoRecord()
    begin
        //ClearVars();

        // Exchange Rate and Amount Calculations for Credit Memo
        Clear(RateExh);
        Clear(AmountKSH);
        if "Purch. Cr. Memo Hdr."."Currency Code" <> '' then begin
            RateExh := (1 / "Purch. Cr. Memo Hdr."."Currency Factor");
            "Purch. Cr. Memo Hdr.".CalcFields("Amount Including VAT");
            AmountKSH := RateExh * "Purch. Cr. Memo Hdr."."Amount Including VAT";
        end;

        Clear(VATUSD);
        if "Purch. Cr. Memo Hdr.".Amount <> "Purch. Cr. Memo Hdr."."Amount Including VAT" then begin
            "Purch. Cr. Memo Hdr.".CalcFields("Amount Including VAT");
            VATUSD := "Purch. Cr. Memo Hdr."."Amount Including VAT" - "Purch. Cr. Memo Hdr.".Amount;
        end else begin
            VATUSD := 0;
        end;

        VATKSH := VATUSD * RateExh;
        WithVAT := (VATUSD / 0.16) * 0.02;
        AmountPayble := "Purch. Cr. Memo Hdr.".Amount - WithVAT;
        WHTVATKSH := WithVAT * RateExh;

        // 20FT Calculation
        Clear(Countof20FT);
        PurchaseCrMemoLine.Reset();
        PurchaseCrMemoLine.SetCurrentKey("Shortcut Dimension 1 Code", "Document No.");
        PurchaseCrMemoLine.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
        if PurchaseCrMemoLine.FindFirst() then begin
            repeat
                if ContainerId_gCode20FT <> PurchaseCrMemoLine."Shortcut Dimension 1 Code" then begin
                    DimensionSetEntry.Reset();
                    DimensionSetEntry.SetRange("Dimension Set ID", PurchaseCrMemoLine."Dimension Set ID");
                    DimensionSetEntry.SetRange("Dimension Code", 'CONTAINER SIZE');
                    DimensionSetEntry.SetRange("Dimension Value Code", '20FT');
                    if DimensionSetEntry.FindSet() then begin
                        Countof20FT += 1;
                    end;
                    ContainerId_gCode20FT := PurchaseCrMemoLine."Shortcut Dimension 1 Code";
                end;
            until PurchaseCrMemoLine.Next() = 0;
        end;

        // 40FT Calculation
        Clear(Countof40FT);
        PurchaseCrMemoLine1.Reset();
        PurchaseCrMemoLine1.SetCurrentKey("Shortcut Dimension 1 Code", "Document No.");
        PurchaseCrMemoLine1.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
        if PurchaseCrMemoLine1.FindFirst() then begin
            repeat
                if ContainerId_gCode <> PurchaseCrMemoLine1."Shortcut Dimension 1 Code" then begin
                    DimensionSetEntry.Reset();
                    DimensionSetEntry.SetRange("Dimension Set ID", PurchaseCrMemoLine1."Dimension Set ID");
                    DimensionSetEntry.SetRange("Dimension Code", 'CONTAINER SIZE');
                    DimensionSetEntry.SetRange("Dimension Value Code", '40FT');
                    if DimensionSetEntry.FindSet() then begin
                        Countof40FT += 1;
                    end;
                    ContainerId_gCode := PurchaseCrMemoLine1."Shortcut Dimension 1 Code";
                end;
            until PurchaseCrMemoLine1.Next() = 0;
        end;

        // CBM Calculation
        Clear(CountofCBM);
        PurchaseCrMemoLine2.Reset();
        PurchaseCrMemoLine2.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
        PurchaseCrMemoLine2.SetCurrentKey("Shortcut Dimension 1 Code", "Document No.");
        // PurchaseCrMemoLine2.SetRange("Posting Date", "Purch. Cr. Memo Hdr."."Posting Date");
        if PurchaseCrMemoLine2.FindFirst() then begin
            repeat
                if ContainerId_gCode <> PurchaseCrMemoLine2."Shortcut Dimension 1 Code" then begin
                    DimensionSetEntry.Reset();
                    DimensionSetEntry.SetRange("Dimension Set ID", PurchaseCrMemoLine2."Dimension Set ID");
                    DimensionSetEntry.SetRange("Dimension Code", 'CARGO TYPE');
                    DimensionSetEntry.SetRange("Dimension Value Code", 'UNIT');
                    if DimensionSetEntry.FindSet() then begin
                        CountofCBM += 1;
                    end;
                    ContainerId_gCode := PurchaseCrMemoLine2."Shortcut Dimension 1 Code";
                end;
            until PurchaseCrMemoLine2.Next() = 0;
        end;

        // CFShandling 20FT Calculation
        Clear(CFShandlingCharges20FT);
        PurchaseCrMemoLine3.Reset();
        PurchaseCrMemoLine3.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
        PurchaseCrMemoLine3.SetRange("Posting Date", "Purch. Cr. Memo Hdr."."Posting Date");
        PurchaseCrMemoLine3.SetRange("Item Category Code", 'SHOREHANDLING');
        if PurchaseCrMemoLine3.FindFirst() then begin
            repeat
                DimensionSetEntry.Reset();
                DimensionSetEntry.SetRange("Dimension Set ID", PurchaseCrMemoLine3."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", 'CONTAINER SIZE');
                DimensionSetEntry.SetRange("Dimension Value Code", '20FT');
                if DimensionSetEntry.FindSet() then begin
                    CFShandlingCharges20FT += PurchaseCrMemoLine3."Unit Cost";
                end;
            until PurchaseCrMemoLine3.Next() = 0;
        end;

        // Wharfage 20FT Calculation
        Clear(Wharfage20Ft);
        PurchaseCrMemoLine5.Reset();
        PurchaseCrMemoLine5.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
        PurchaseCrMemoLine5.SetRange("Posting Date", "Purch. Cr. Memo Hdr."."Posting Date");
        PurchaseCrMemoLine5.SetRange("Item Category Code", 'WHARFAGE');
        if PurchaseCrMemoLine5.FindFirst() then begin
            repeat
                DimensionSetEntry.Reset();
                DimensionSetEntry.SetRange("Dimension Set ID", PurchaseCrMemoLine5."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", 'CONTAINER SIZE');
                DimensionSetEntry.SetRange("Dimension Value Code", '20FT');
                if DimensionSetEntry.FindSet() then begin
                    Wharfage20Ft += PurchaseCrMemoLine5."Unit Cost";
                end;
            until PurchaseCrMemoLine5.Next() = 0;
        end;

        // CFShandling 40FT Calculation
        Clear(CFShandlingCharges40FT);
        PurchaseCrMemoLine4.Reset();
        PurchaseCrMemoLine4.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
        PurchaseCrMemoLine4.SetRange("Posting Date", "Purch. Cr. Memo Hdr."."Posting Date");
        PurchaseCrMemoLine4.SetRange("Item Category Code", 'SHOREHANDLING');
        if PurchaseCrMemoLine4.FindFirst() then begin
            repeat
                DimensionSetEntry.Reset();
                DimensionSetEntry.SetRange("Dimension Set ID", PurchaseCrMemoLine4."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", 'CONTAINER SIZE');
                DimensionSetEntry.SetRange("Dimension Value Code", '40FT');
                if DimensionSetEntry.FindSet() then begin
                    CFShandlingCharges40FT += PurchaseCrMemoLine4."Unit Cost";
                end;
            until PurchaseCrMemoLine4.Next() = 0;
        end;

        // Wharfage 40FT Calculation
        Clear(Wharfage40Ft);
        PurchaseCrMemoLine6.Reset();
        PurchaseCrMemoLine6.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
        PurchaseCrMemoLine6.SetRange("Posting Date", "Purch. Cr. Memo Hdr."."Posting Date");
        PurchaseCrMemoLine6.SetRange("Item Category Code", 'WHARFAGE');
        if PurchaseCrMemoLine6.FindFirst() then begin
            repeat
                DimensionSetEntry.Reset();
                DimensionSetEntry.SetRange("Dimension Set ID", PurchaseCrMemoLine6."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", 'CONTAINER SIZE');
                DimensionSetEntry.SetRange("Dimension Value Code", '40FT');
                if DimensionSetEntry.FindSet() then begin
                    Wharfage40Ft += PurchaseCrMemoLine6."Unit Cost";
                end;
            until PurchaseCrMemoLine6.Next() = 0;
        end;

        // CBM Charges Calculation
        Clear(CBMCharges);
        PurchaseCrMemoLine7.Reset();
        PurchaseCrMemoLine7.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
        PurchaseCrMemoLine7.SetRange("Posting Date", "Purch. Cr. Memo Hdr."."Posting Date");
        if PurchaseCrMemoLine7.FindFirst() then begin
            repeat
                DimensionSetEntry.Reset();
                DimensionSetEntry.SetRange("Dimension Set ID", PurchaseCrMemoLine7."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", 'CARGO TYPE');
                DimensionSetEntry.SetRange("Dimension Value Code", 'UNIT');
                if DimensionSetEntry.FindSet() then begin
                    CBMCharges += PurchaseCrMemoLine7."Unit Cost";
                end;
            until PurchaseCrMemoLine7.Next() = 0;
        end;

        // Shorehandling Charges Calculation
        Clear(ShorehandlingSum);
        PurchaseCrMemoLine8.Reset();
        PurchaseCrMemoLine8.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
        PurchaseCrMemoLine8.SetRange("Posting Date", "Purch. Cr. Memo Hdr."."Posting Date");
        PurchaseCrMemoLine8.SetRange("Item Category Code", 'SHOREHANDLING');
        if PurchaseCrMemoLine8.FindFirst() then begin
            repeat
                DimensionSetEntry.Reset();
                DimensionSetEntry.SetRange("Dimension Set ID", PurchaseCrMemoLine8."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", 'CARGO TYPE');
                DimensionSetEntry.SetRange("Dimension Value Code", 'CONTAINER');
                if DimensionSetEntry.FindSet() then begin
                    ShorehandlingSum += PurchaseCrMemoLine8."Unit Cost";
                end;
            until PurchaseCrMemoLine8.Next() = 0;
        end;

        // Wharfage Charges Calculation
        Clear(wharfageSum);
        PurchaseCrMemoLine9.Reset();
        PurchaseCrMemoLine9.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
        PurchaseCrMemoLine9.SetRange("Posting Date", "Purch. Cr. Memo Hdr."."Posting Date");
        PurchaseCrMemoLine9.SetRange("Item Category Code", 'WHARFAGE');
        if PurchaseCrMemoLine9.FindFirst() then begin
            repeat
                DimensionSetEntry.Reset();
                DimensionSetEntry.SetRange("Dimension Set ID", PurchaseCrMemoLine9."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", 'CARGO TYPE');
                DimensionSetEntry.SetRange("Dimension Value Code", 'CONTAINER');
                if DimensionSetEntry.FindSet() then begin
                    wharfageSum += PurchaseCrMemoLine9."Unit Cost";
                end;
            until PurchaseCrMemoLine9.Next() = 0;
        end;

        // Remarshalling Charges Calculation
        Clear(RemarshallingSum);
        PurchaseCrMemoLine10.Reset();
        PurchaseCrMemoLine10.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
        PurchaseCrMemoLine10.SetRange("Posting Date", "Purch. Cr. Memo Hdr."."Posting Date");
        PurchaseCrMemoLine10.SetRange("Item Category Code", 'REMARSHALLING');
        if PurchaseCrMemoLine10.FindFirst() then begin
            repeat
                DimensionSetEntry.Reset();
                DimensionSetEntry.SetRange("Dimension Set ID", PurchaseCrMemoLine10."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", 'CARGO TYPE');
                DimensionSetEntry.SetRange("Dimension Value Code", 'CONTAINER');
                if DimensionSetEntry.FindSet() then begin
                    RemarshallingSum += PurchaseCrMemoLine10."Unit Cost";
                end;
            until PurchaseCrMemoLine10.Next() = 0;
        end;

        // Storage Charges Calculation
        Clear(StorageSum);
        PurchaseCrMemoLine11.Reset();
        PurchaseCrMemoLine11.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
        PurchaseCrMemoLine11.SetRange("Posting Date", "Purch. Cr. Memo Hdr."."Posting Date");
        PurchaseCrMemoLine11.SetRange("Item Category Code", 'STORAGE');
        if PurchaseCrMemoLine11.FindFirst() then begin
            repeat
                DimensionSetEntry.Reset();
                DimensionSetEntry.SetRange("Dimension Set ID", PurchaseCrMemoLine11."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", 'CARGO TYPE');
                DimensionSetEntry.SetRange("Dimension Value Code", 'CONTAINER');
                if DimensionSetEntry.FindSet() then begin
                    StorageSum += PurchaseCrMemoLine11."Unit Cost";
                end;
            until PurchaseCrMemoLine11.Next() = 0;
        end;

        // Reefer Charges Calculation
        Clear(ReeferCahrgesSum);
        PurchaseCrMemoLine12.Reset();
        PurchaseCrMemoLine12.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
        PurchaseCrMemoLine12.SetRange("Posting Date", "Purch. Cr. Memo Hdr."."Posting Date");
        PurchaseCrMemoLine12.SetRange("Item Category Code", 'REEFER');
        if PurchaseCrMemoLine12.FindFirst() then begin
            repeat
                DimensionSetEntry.Reset();
                DimensionSetEntry.SetRange("Dimension Set ID", PurchaseCrMemoLine12."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", 'CARGO TYPE');
                DimensionSetEntry.SetRange("Dimension Value Code", 'CONTAINER');
                if DimensionSetEntry.FindSet() then begin
                    ReeferCahrgesSum += PurchaseCrMemoLine12."Unit Cost";
                end;
            until PurchaseCrMemoLine12.Next() = 0;
        end;

        // IMCO Charges Calculation
        Clear(IMCOChargesSum);
        PurchaseCrMemoLine13.Reset();
        PurchaseCrMemoLine13.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
        PurchaseCrMemoLine13.SetRange("Posting Date", "Purch. Cr. Memo Hdr."."Posting Date");
        PurchaseCrMemoLine13.SetRange("Item Category Code", 'IMCO');
        if PurchaseCrMemoLine13.FindFirst() then begin
            IMCOChargesSum := 0;
            repeat
                DimensionSetEntry.Reset();
                DimensionSetEntry.SetRange("Dimension Set ID", PurchaseCrMemoLine13."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", 'CARGO TYPE');
                DimensionSetEntry.SetRange("Dimension Value Code", 'CONTAINER');
                if DimensionSetEntry.FindSet() then begin
                    IMCOChargesSum += PurchaseCrMemoLine13."Unit Cost";
                end;
            until PurchaseCrMemoLine13.Next() = 0;
        end;
        Clear(TollChargesSum);
        PurchaseCrMemoLine14.Reset();
        PurchaseCrMemoLine14.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
        PurchaseCrMemoLine14.SetRange("Posting Date", "Purch. Cr. Memo Hdr."."Posting Date");
        PurchaseCrMemoLine14.SetRange("No.", 'I0045');
        if PurchaseCrMemoLine14.FindFirst() then begin
            TollChargesSum := 0;
            repeat
                DimensionSetEntry.Reset();
                DimensionSetEntry.SetRange("Dimension Set ID", PurchaseCrMemoLine14."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", 'CARGO TYPE');
                DimensionSetEntry.SetRange("Dimension Value Code", 'CONTAINER');
                if DimensionSetEntry.FindSet() then begin
                    TollChargesSum += PurchaseCrMemoLine14."Unit Cost";
                end;
            until PurchaseCrMemoLine14.Next() = 0;
        end;
        //Imco Toll Charges Calculation
        Clear(ImcoTollChargesSum);
        PurchaseCrMemoLine15.Reset();
        PurchaseCrMemoLine15.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
        PurchaseCrMemoLine15.SetRange("Posting Date", "Purch. Cr. Memo Hdr."."Posting Date");
        PurchaseCrMemoLine15.SetRange("Item Category Code", 'IMCO MSA TOLL');
        if PurchaseCrMemoLine15.FindFirst() then begin
            ImcoTollChargesSum := 0;
            repeat
                DimensionSetEntry.Reset();
                DimensionSetEntry.SetRange("Dimension Set ID", PurchaseCrMemoLine15."Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", 'CARGO TYPE');
                DimensionSetEntry.SetRange("Dimension Value Code", 'CONTAINER');
                if DimensionSetEntry.FindSet() then begin
                    ImcoTollChargesSum += PurchaseCrMemoLine15."Unit Cost";
                end;
            until PurchaseCrMemoLine15.Next() = 0;
        end;
        //Imco Toll Charges Calculation End

        // Manifest lookup
        PurchaseCrMemoLine.Reset();
        PurchaseCrMemoLine.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
        PurchaseCrMemoLine.SetRange("Posting Date", "Purch. Cr. Memo Hdr."."Posting Date");
        if PurchaseCrMemoLine.FindFirst() then
            repeat
                ManifestLine1.Reset();
                ManifestLine1.SetRange("Global Dimension 1 Code", PurchaseCrMemoLine."Shortcut Dimension 1 Code");
                if ManifestLine1.FindFirst() then;
            until PurchaseCrMemoLine.Next() = 0;
    end;

    // ==================== UTILITY PROCEDURES ====================
    // local procedure ClearVars()
    // begin
    //     Clear(RateExh);
    //     Clear(AmountKSH);
    //     Clear(VATUSD);
    //     Clear(VATKSH);
    //     Clear(WithVAT);
    //     Clear(AmountPayble);
    //     Clear(WHTVATKSH);
    //     Clear(Countof20FT);
    //     Clear(Countof40FT);
    //     Clear(CountofCBM);
    //     Clear(CFShandlingCharges20FT);
    //     Clear(Wharfage20Ft);
    //     Clear(CFShandlingCharges40FT);
    //     Clear(Wharfage40Ft);
    //     Clear(CBMCharges);
    //     Clear(ShorehandlingSum);
    //     Clear(wharfageSum);
    //     Clear(RemarshallingSum);
    //     Clear(StorageSum);
    //     Clear(ReeferCahrgesSum);
    //     Clear(IMCOChargesSum);
    //     Clear(ContainerId_gCode);
    //     Clear(ContainerId_gCode20FT);
    //     Clear(ContainerId_gCode40FT);
    //     Clear(ManifestLine1);
    // end;

    procedure CreateExcelHeader()
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(CompanyName, false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(UserId, false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(FORMAT(FilterString), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('KPA Payment Invoice Report', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Date', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('VESSEL', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Invoice No.', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('CU No.', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Amount KSH', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Amount USD', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('BL No.', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('20Ft Container Qty', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('40Ft Container Qty', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('MV Units CBM', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Client', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('ROE', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('20FT Container Shore Handling Rate(USD)', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('20FT Container Wharfage Rate(USD)', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('40FT Container Shore Handling Rate(USD)', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('40FT Container Wharfage Rate(USD)', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('CBM Rate(USD)', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Shore handling Charges-USD', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Wharfage Charges-USD', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Re-Marshalling Charges-USD', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Storage Charges-USD', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Reefer charges-USD', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('IMCO Charge-USD', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('TollCharge-USD', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Shore handling Charges-KSH', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Wharfage Charges-KSH', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Re-Marshalling Charges-KSH', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Storage Charges-KSH', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Reefer charges-KSH', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('IMCO Charge-KSH', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('TollCharge-KSH', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('VAT', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('WHT VAT', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('VAT KSH', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('TOTAL USD', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('TOTAL KSH', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('AMOUNT PAYABLE', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('WHT VAT - KSH', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
    end;

    procedure CreateExcelBodyInv()
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn("Purch. Inv. Header"."Posting Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn(ManifestLine1."Vessel Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Purch. Inv. Header"."Vendor Invoice No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Purch. Inv. Header"."CU Number", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(AmountKSH, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn("Purch. Inv. Header"."Amount Including VAT", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(ManifestLine1."BL No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Countof20FT, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(Countof40FT, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CountofCBM, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(ManifestLine1."Consignee Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RateExh, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CFShandlingCharges20FT, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(Wharfage20Ft, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CFShandlingCharges40FT, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(Wharfage40Ft, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CBMCharges, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(ShorehandlingSum, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(wharfageSum, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(RemarshallingSum, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(StorageSum, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(ReeferCahrgesSum, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(IMCOChargesSum, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(TollChargesSum, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(ShorehandlingSum * RateExh, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(wharfageSum * RateExh, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(RemarshallingSum * RateExh, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(StorageSum * RateExh, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(ReeferCahrgesSum * RateExh, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(IMCOChargesSum * RateExh, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(TollChargesSum * RateExh, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(VATUSD, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(WithVAT, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(VATKSH, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn("Purch. Inv. Header".Amount, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(AmountKSH, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(AmountPayble, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(WHTVATKSH, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
    end;

    procedure CreateExcelBodyCr()
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn("Purch. Cr. Memo Hdr."."Posting Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn(ManifestLine1."Vessel Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Purch. Cr. Memo Hdr."."Vendor Cr. Memo No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Purch. Cr. Memo Hdr."."CU Number", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(AmountKSH, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn("Purch. Cr. Memo Hdr."."Amount Including VAT", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(ManifestLine1."BL No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Countof20FT, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(Countof40FT, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CountofCBM, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(ManifestLine1."Consignee Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RateExh, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CFShandlingCharges20FT, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(Wharfage20Ft, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CFShandlingCharges40FT, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(Wharfage40Ft, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CBMCharges, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(ShorehandlingSum, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(wharfageSum, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(RemarshallingSum, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(StorageSum, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(ReeferCahrgesSum, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(IMCOChargesSum, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(TollChargesSum, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(ShorehandlingSum * RateExh, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(wharfageSum * RateExh, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(RemarshallingSum * RateExh, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(StorageSum * RateExh, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(ReeferCahrgesSum * RateExh, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(IMCOChargesSum * RateExh, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(TollChargesSum * RateExh, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(VATUSD, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(WithVAT, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(VATKSH, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn("Purch. Cr. Memo Hdr.".Amount, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(AmountKSH, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(AmountPayble, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(WHTVATKSH, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
    end;

    local procedure CreateExcelSheet(SheetName: Text[250]; NewBook: Boolean)
    begin
        if NewBook then
            TempExcelBuffer.CreateNewBook(SheetName)
        else
            TempExcelBuffer.SelectOrAddSheet(SheetName);
        TempExcelBuffer.WriteSheet(SheetName, CompanyName, UserId);
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.ClearNewRow();
    end;

    local procedure CreateExcelBook()
    begin
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename('Multi SHeet Export');
        TempExcelBuffer.OpenExcel();
    end;
}