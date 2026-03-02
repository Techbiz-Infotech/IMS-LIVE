report 50179 "KPA Payment Invoice report"
{
    //ApplicationArea = All;
    Caption = 'KPA Payment Invoice report';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            RequestFilterFields = "Posting Date", "No.";
            //     // //cfshandling40ft code
            //     // CFShandlingCharges40FT := 0;
            //     // IMSSetup.Get();
            //     // PurchaseInvLine.Reset();
            //     // PurchaseInvLine.SetRange("Document No.", PurchaseInvHeader."No.");
            //     // PurchaseInvLine.SetRange('40FT');
            //     // PurchaseInvLine.SetRange("Item Category Code", IMSSetup."Category Code for CFS Handling");
            //     // if PurchaseInvLine.FindFirst() then
            //     //     CFShandlingCharges40FT := PurchaseInvLine."Unit Cost"
            //     // else
            //     //     CFShandlingCharges40FT := 0;
            //     // //cfshandling40ft code

            //     // PurchaseInvLine.Reset();
            //     // PurchaseInvLine.SetRange("Document No.", "No.");
            //     // if PurchaseInvLine.FindFirst() then begin
            //     //     repeat
            //     //         Clear(BLNo);

            //     // BLNo := ManifestLine1."BL No.";
            //     // until PurchaseInvLine.Next() = 0;
            //     //end;
            //     //end;
            // }
            trigger OnPreDataItem()
            begin
                "Purch. Inv. Header".SetRange("Pay-to Vendor No.", 'KPA001');
            end;

            trigger OnAfterGetRecord()
            begin
                //Code for Amount USD and KSH begin
                Clear(RateExh);
                Clear(AmountKSH);
                if "Currency Code" <> '' then begin
                    RateExh := (1 / "Currency Factor");
                    CalcFields(Amount);
                    AmountKSH := RateExh * Amount;

                end;
                Clear(VATUSD);
                IF Amount <> "Amount Including VAT" then begin
                    CalcFields("Amount Including VAT");
                    VATUSD := "Amount Including VAT" - Amount;
                end else begin
                    VATUSD := 0;
                end;
                VATKSH := VATUSD * RateExh;
                WithVAT := (VATUSD / 0.16) * 0.02;
                AmountPayble := "Purch. Inv. Header".Amount - WithVAT;
                WHTVATKSH := WithVAT * RateExh;

                // VATKSH := VATInUSD * (CurrencyExc."Relational Exch. Rate Amount" / CurrencyExc."Exchange Rate Amount");
                //20Ft Calculation
                Clear(Countof20FT);
                PurchaseInvLine.Reset();
                PurchaseInvLine.SetCurrentKey("Shortcut Dimension 1 Code", "Document No.");
                PurchaseInvLine.SetRange("Document No.", "Purch. Inv. Header"."No.");
                //PurchaseInvLine.SetRange("Posting Date", "Purch. Inv. Header"."Posting Date");
                if PurchaseInvLine.FindFirst() then begin
                    repeat
                        IF ContainerId_gCode20FT <> PurchaseInvLine."Shortcut Dimension 1 Code" then begin
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
                //40FT Calculation
                Clear(Countof40FT);
                PurchaseInvLine1.Reset();
                PurchaseInvLine1.SetCurrentKey("Shortcut Dimension 1 Code", "Document No.");
                PurchaseInvLine1.SetRange("Document No.", "Purch. Inv. Header"."No.");
                // PurchaseInvLine1.SetRange("Posting Date", "Purch. Inv. Header"."Posting Date");
                if PurchaseInvLine1.FindFirst() then begin
                    repeat
                        IF ContainerId_gCode <> PurchaseInvLine1."Shortcut Dimension 1 Code" then begin
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
                //CBM Calculation
                Clear(CountofCBM);
                PurchaseInvLine2.Reset();
                PurchaseInvLine2.SetRange("Document No.", "Purch. Inv. Header"."No.");
                PurchaseInvLine2.SetRange("Posting Date", "Purch. Inv. Header"."Posting Date");
                if PurchaseInvLine2.FindFirst() then begin
                    repeat
                        DimensionSetEntry.Reset();
                        DimensionSetEntry.SetRange("Dimension Set ID", PurchaseInvLine2."Dimension Set ID");
                        DimensionSetEntry.SetRange("Dimension Code", 'CARGO TYPE');
                        DimensionSetEntry.SetRange("Dimension Value Code", 'UNIT');
                        if DimensionSetEntry.FindSet() then begin
                            CountofCBM += 1;
                        end;
                    until PurchaseInvLine2.Next() = 0;
                end;
                //CFShandling 20FT Calculation
                Clear(CFShandlingCharges20FT);
                PurchaseInvLine3.Reset();
                PurchaseInvLine3.SetRange("Document No.", "No.");
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
                //Wharfage 20FT Calculation
                Clear(Wharfage20Ft);
                PurchaseInvLine5.Reset();
                PurchaseInvLine5.SetRange("Document No.", "No.");
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
                //CFShandling 40FT Calculation
                Clear(CFShandlingCharges40FT);
                PurchaseInvLine4.Reset();
                PurchaseInvLine4.SetRange("Document No.", "No.");
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
                //Wharfage 40FT Calculation
                Clear(Wharfage40Ft);
                PurchaseInvLine6.Reset();
                PurchaseInvLine6.SetRange("Document No.", "No.");
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
                //CBM Charges Calculation
                Clear(CBMCharges);
                PurchaseInvLine7.Reset();
                PurchaseInvLine7.SetRange("Document No.", "No.");
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
                //Shorehandling Charges Calculation
                Clear(ShorehandlingSum);
                PurchaseInvLine8.Reset();
                PurchaseInvLine8.SetRange("Document No.", "No.");
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
                //Wharfage Charges Calculation
                Clear(wharfageSum);
                PurchaseInvLine9.Reset();
                PurchaseInvLine9.SetRange("Document No.", "No.");
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
                //Remarshalling Charges Calculation
                Clear(RemarshallingSum);
                PurchaseInvLine10.Reset();
                PurchaseInvLine10.SetRange("Document No.", "No.");
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
                //Storage Charges Calculation
                Clear(StorageSum);
                PurchaseInvLine11.Reset();
                PurchaseInvLine11.SetRange("Document No.", "No.");
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
                //Reefer Charges Calculation
                Clear(ReeferCahrgesSum);
                PurchaseInvLine12.Reset();
                PurchaseInvLine12.SetRange("Document No.", "No.");
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

                //IMCO Charges Calculation
                Clear(IMCOChargesSum);
                PurchaseInvLine13.Reset();
                PurchaseInvLine13.SetRange("Document No.", "No.");
                PurchaseInvLine13.SetRange("Posting Date", "Purch. Inv. Header"."Posting Date");
                PurchaseInvLine13.SetRange("No.", '1001');
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
                //  //IMCO Charges Calculation-end
                PurchaseInvLine.Reset();
                PurchaseInvLine.SetRange("Document No.", "No.");
                PurchaseInvLine.SetRange("Posting Date", "Purch. Inv. Header"."Posting Date");
                if PurchaseInvLine.FindFirst() then
                    repeat
                        ManifestLine1.Reset();
                        ManifestLine1.SetRange("Global Dimension 1 Code", PurchaseInvLine."Shortcut Dimension 1 Code");
                        if ManifestLine1.FindFirst() then;
                    until PurchaseInvLine.Next() = 0;

                //KSH Charges Calcultion for all charges.

                CreateExcelbody();

            end;
        }
    }

    trigger OnPreReport()
    begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        DateFilterText := "Purch. Inv. Header".GETFILTER("Posting Date");
        FilterString := DateFilterText;
        CreateExcelHeader();
    end;

    trigger OnPostReport()
    begin
        CreateExcelSheet();
    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        Startdate, Enddate : Date;
        DateFilterText: Text[50];
        FilterString: Text[250];
        ShorehandlingCharges20FT, CFShandlingCharges20FT, ShorehandlingCharges40FT, CFShandlingCharges40FT : Decimal;
        CBMCharges: Decimal;
        ShorehandlingSum: Decimal;
        wharfageSum: Decimal;
        RemarshallingSum: Decimal;
        StorageSum: Decimal;
        ReeferCahrgesSum: Decimal;
        IMCOChargesSum: Decimal;
        OtherChargesSum: Decimal;
        WithouVATSum: Decimal;
        WithVAT: Decimal;
        VATKSH: Decimal;
        TotalUSD: Decimal;
        TotalKSH: Decimal;
        TotalAmount: Decimal;
        ContainerId_gCode, ContainerId20ft_gCode : Code[20];
        DimensionSetEntry, DimensionSetEntry1, DimensionSetEntry2, DimensionSetEntry3, DimensionSetEntry4, DimensionSetEntry5, DimensionSetEntry6, DimensionSetEntry7, DimensionSetEntry8c : Record "Dimension Set Entry";
        ManifestLine, ManifestLine1 : Record "Manifest Line";
        AmountKSH: Decimal;
        PurchaseInvLine, PurchaseInvLine1, PurchaseInvLine2, PurchaseInvLine3, PurchaseInvLine4, PurchaseInvLine5, PurchaseInvLine6, PurchaseInvLine7, PurchaseInvLine8, PurchaseInvLine9, PurchaseInvLine10 : Record "Purch. Inv. Line";
        PurchaseInvLine11, PurchaseInvLine12, PurchaseInvLine13 : Record "Purch. Inv. Line";
        SalesInvLine: Record "Sales Invoice Line";
        RateExh: Decimal;
        ContainerId_gCode40FT: Code[20];
        Wharfage20Ft, Wharfage40Ft : Decimal;
        Wharfage20FtCode, Wharfage40FtCode : Code[20];
        GLsetup: Record "General Ledger Setup";

        CFShandlingCharges40FT_GCode40FT, CFShandlingCharges20FT_GCode20FT : Code[20];
        Countof40FT: Integer;
        CountofCBM: Integer;
        UnitsCount: Integer;
        Countof20FT: Integer;
        ContainerId_gCode20FT: Code[20];
        BLNo: Code[20];
        ChargeGroupLine: Record "Charge ID Group Line";
        PurchaseInvHeader: Record "Purch. Inv. Header";
        Item: Record Item;

        IMSSetup: Record "IMS Setup";
        VATUSD: Decimal;
        AmountPayble: Decimal;
        WHTVATKSH: Decimal;

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
        TempExcelBuffer.AddColumn('Shore handling Charges-KSH', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Wharfage Charges-KSH', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Re-Marshalling Charges-KSH', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Storage Charges-KSH', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Reefer charges-KSH', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('IMCO Charge-KSH', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        // TempExcelBuffer.AddColumn('Other', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('VAT', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('WHT VAT', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('VAT KSH', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('TOTAL USD', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('TOTAL KSH', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('AMOUNT PAYABLE', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('WHT VAT - KSH', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
    end;

    procedure CreateExcelBody()
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn("Purch. Inv. Header"."Posting Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn(ManifestLine1."Vessel Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::text);
        TempExcelBuffer.AddColumn("Purch. Inv. Header"."Vendor Invoice No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Purch. Inv. Header"."CU Number", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(AmountKSH, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(format("Purch. Inv. Header".Amount), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(ManifestLine1."BL No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Countof20FT, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(Countof40FT, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CountofCBM, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(ManifestLine1."Consignee Name", false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(RateExh, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
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
        TempExcelBuffer.AddColumn(ShorehandlingSum * RateExh, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(wharfageSum * RateExh, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(RemarshallingSum * RateExh, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(StorageSum * RateExh, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(ReeferCahrgesSum * RateExh, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(IMCOChargesSum * RateExh, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(VATUSD, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(WithVAT, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(VATKSH, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(format("Purch. Inv. Header".Amount), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(AmountKSH, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(AmountPayble, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(WHTVATKSH, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
    end;


    procedure CreateExcelSheet()
    begin
        TempExcelBuffer.CreateNewBook('KPA Payment Invoice');
        TempExcelBuffer.WriteSheet('KPA Payment Invoice', CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename('KPA Payment Invoice');
        TempExcelBuffer.OpenExcel();
    end;
}
