page 50105 ContainerListForProforma
{

    Caption = 'Container List for Proforma';
    PageType = List;
    SourceTable = "Manifest Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("BL No."; Rec."BL No.")
                {
                    ToolTip = 'Specifies the value of the BL No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Container/Chassis No."; Rec."Container/Chassis No.")
                {
                    ToolTip = 'Specifies the value of the Container/Chassis No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Job File No."; Rec."Job File No.")
                {
                    ToolTip = 'Specifies the value of the Job File No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Destination Type"; Rec."Destination Type")
                {
                    ToolTip = 'Specifies the value of the Destination Type field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 4 Code"; rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Cargo Type field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 5 Code"; rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the value of the Container Size field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Container Type"; Rec."Container Type")
                {
                    ToolTip = 'Specifies the value of the Cargo Type field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Consignee No."; Rec."Consignee No.")
                {
                    ToolTip = 'Specifies the value of the Consignee No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Clearing Agent"; Rec."Clearing Agent")
                {
                    ToolTip = 'Specifies the value of the Clearing Agent field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Date Received"; Rec."Date Received")
                {
                    ToolTip = 'Specifies the value of the Date Received field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("KPA Charges Calculated"; rec."KPA Charges Calculated")
                {
                    ToolTip = 'Specifies the value of the KPA Charges Calculated field.';
                    ApplicationArea = All;
                }

                // field("Remaining Bags"; Rec."Remaining Bags")
                // {
                //     ApplicationArea = All;
                //     Editable = NoBagsEditable;
                // }
            }

        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        NoBagsEdit();
    end;

    trigger OnAfterGetRecord()
    begin
        NoBagsEdit;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        ChargeGroupHead: Record "Charge ID Group Header";
        ChargeGroupLine3, ChargeGroupLine2, ChargeGroupLine : Record "Charge ID Group Line";
        PostedAddReceivingCharges: Record "Posted Add. Charges receiving";
        AddCharges: Record "Additional Charges - Receiving";
        PostedAddVerificationCharges: Record VerificationLog;
        PostedAddStrippingCharges: Record "Posted AddCharges Stripping";
        IMSSetup: Record "IMS Setup";
        StorageChargeID, RemarshallingChargeID, ChargeID : Code[20];
        RecItem: Record Item;
        // ManifestHead: Record "Manifest Header";
        TestManifestLine, ManifestLine : Record "Manifest Line";
        ReceivingLog: Record ReceivingLog;
        RecSalesLine2, RecSalesLine, Salesline : Record "Sales Line";
        PostedCrMemoLine: Record "Sales Cr.Memo Line";
        TempSalesline: Record "Sales Line";
        PurchInvHead: Record "Purch. Inv. Header";
        PurchInvLine: Record "Purch. Inv. Line";
        TempPurchInvLine: Record "Purchase Line" temporary;
        PurchCrHead: Record "Purch. Cr. Memo Hdr.";
        PurchCrLine: Record "Purch. Cr. Memo Line";
        PostedSalesInvLine: Record "Sales Invoice Line";
        BeforeReceivedStorageDays, LineNo2, LineNo1, StorageDays, EntryNo : Integer;
        StorageStartDate, AfterBaseOnDate : Date;
        ReeferInvoicedChargeAmount, InvoicedChargeAmount, RemainingChargeAmount, ChargeAmount, CRChargedAmount : Decimal;
        ChargedReeferStorageHours, ReeferStorageHours : Decimal;
        ChargedStorageDays, InvChargableStorageDays, ChargableStorageDays, CRChargedStorageDays : Integer;
        RemainingFirstDays: Integer;
        RemainingSecondDays: Integer;
        RemainingThirdDays: Integer;
        RemainingFourthDays: Integer;
        FirstIntervalAmount: Decimal;
        SecondIntervalAmount: Decimal;
        ThirdIntervalAmount: Decimal;
        FourthIntervalAmount: Decimal;
        TotalBasechargeAmount: Decimal;
        SuccessMessage: TextConst ENU = 'Calculated Successfully';
        lrec_TmpSalesLine2, lrec_TmpSalesLine : record "Sales line" temporary;
        lrec_SalesInvLine: Record "Sales Invoice Line";
        lrec_SalesCrMemoLine: record "Sales Cr.Memo Line";
        LNo, l_LineNo : Integer;
        RemarshallingExist, AlreadyInvoiced : Boolean;
        PostedSalesCrLine: Record "Sales Cr.Memo Line";
        GLSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        KPAChargesCalculated: Boolean;
    begin
        IF CloseAction IN [ACTION::OK, ACTION::LookupOK] THEN BEGIN
            lrec_TmpSalesLine.reset;
            lrec_TmpSalesLine.DeleteAll();

            CurrPage.SETSELECTIONFILTER(ManifestLine);
            if ManifestLine.FINDSET then
                repeat
                    TempManifestLine := ManifestLine;
                    TempManifestLine.INSERT;
                    TempManifestLine.Modify();
                until ManifestLine.NEXT = 0;
            Salesline.Reset();
            Salesline.SetRange("Document Type", Salesline."Document Type"::Order);
            Salesline.SetRange("Document No.", SalesOrderNo);
            IF Salesline.FindSet() then begin
                IF Confirm('Do you want to delete the existing lines?', true) then
                    Salesline.DeleteAll()
                else
                    exit;
            end;

            TempManifestLine.RESET;
            if TempManifestLine.FINDSET then
                repeat
                    TempManifestLine.TestField("Clearing Agent");

                    GLSetup.get();//Cheking KPA Charges For Process Type
                    TempManifestLine.CalcFields("KPA Charges Calculated");
                    //TempManifestLine.SetRange("KPA Charges Calculated", true);
                    DimensionValue.Reset();
                    DimensionValue.SetRange("Dimension Code", GLSetup."Shortcut Dimension 6 Code");
                    DimensionValue.SetRange(Code, TempManifestLine."Shortcut Dimension 6 Code");
                    if DimensionValue.FindFirst() then;
                    KPAChargesCalculated := false;
                    if not DimensionValue."Skip KPA Charges" then begin
                        if TempManifestLine."KPA Charges Calculated" then
                            KPAChargesCalculated := true
                        else
                            KPAChargesCalculated := false;
                        //For Loose Begin //Sh 26-02-2025
                        if KPAChargesCalculated = false then begin
                            if TempManifestLine."Parent Container ID" <> '' then
                                KPAChargesCalculated := true
                            else
                                KPAChargesCalculated := false;
                            //For Loose End //Sh 26-02-2025
                        end;
                    end else
                        KPAChargesCalculated := true;//Cheking KPA Charges For Process Type End

                    if KPAChargesCalculated = false then begin////Checking KPA Charges For Cargotype Begin
                        DimensionValue.Reset();
                        DimensionValue.SetRange("Dimension Code", GLSetup."Shortcut Dimension 4 Code");
                        DimensionValue.SetRange(Code, TempManifestLine."Shortcut Dimension 4 Code");
                        if DimensionValue.FindFirst() then;
                       // KPAChargesCalculated := false;
                        if not DimensionValue."Skip KPA Charges" then begin
                            if TempManifestLine."KPA Charges Calculated" then
                                KPAChargesCalculated := true
                            else
                                KPAChargesCalculated := false;
                            //For Loose Begin //Sh 26-02-2025
                            if KPAChargesCalculated = false then begin
                                if TempManifestLine."Parent Container ID" <> '' then
                                    KPAChargesCalculated := true
                                else
                                    KPAChargesCalculated := false;
                                //For Loose End //Sh 26-02-2025
                            end;
                        end else
                            KPAChargesCalculated := true;
                    end;//Checking KPA Charges For Cargotype END
                    if KPAChargesCalculated = false then
                        Error('KPA charges not calculated');
                    if KPAChargesCalculated then begin
                        lrec_TmpSalesLine.reset;
                        lrec_TmpSalesLine.DeleteAll();
                        AlreadyInvoiced := false;
                        ChargeID := GetChargeID(TempManifestLine, CustNo);
                        IMSSetup.Get();
                        //GK
                        lrec_SalesInvLine.Reset();
                        lrec_SalesInvLine.SetRange("Shortcut Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                        lrec_SalesInvLine.SetRange(Type, lrec_SalesInvLine.Type::Item);
                        lrec_SalesInvLine.SetFilter(Quantity, '<>%1', 0);
                        //lrec_SalesInvLine.SetFilter(Amount, '<>%1', 0);
                        if lrec_SalesInvLine.FindSet() then
                            repeat

                                AlreadyInvoiced := true;
                                lrec_TmpSalesLine.Reset();
                                lrec_TmpSalesLine.SetRange("No.", lrec_SalesInvLine."No.");
                                lrec_TmpSalesLine.SetRange("Shortcut Dimension 1 Code", lrec_SalesInvLine."Shortcut Dimension 1 Code");
                                if lrec_TmpSalesLine.FindSet() then begin

                                    lrec_TmpSalesLine.Quantity += lrec_SalesInvLine.Quantity;
                                    lrec_TmpSalesLine.Amount += lrec_SalesInvLine.Amount;
                                    lrec_TmpSalesLine."Chargable Storage Days" += lrec_SalesInvLine."Chargable Storage Days";
                                    lrec_TmpSalesLine."Outstanding Quantity" += lrec_SalesInvLine.Quantity;
                                    lrec_TmpSalesLine."Outstanding Amount" += lrec_SalesInvLine.Amount;
                                    lrec_TmpSalesLine."Line Amount" += lrec_SalesInvLine."Line Amount";
                                    lrec_TmpSalesLine."Line Discount Amount" += lrec_SalesInvLine."Line Discount Amount";
                                    lrec_TmpSalesLine."Item Category Code" := lrec_SalesInvLine."Item Category Code";
                                    lrec_TmpSalesLine."Reefer Hours" += lrec_SalesInvLine."Reefer Hours"; //CR
                                    lrec_TmpSalesLine."Shortcut Dimension 1 Code" := lrec_SalesInvLine."Shortcut Dimension 1 Code";
                                    lrec_TmpSalesLine."Shortcut Dimension 2 Code" := lrec_SalesInvLine."Shortcut Dimension 2 Code";
                                    lrec_TmpSalesLine."Shortcut Dimension 3 Code" := lrec_SalesInvLine."Shortcut Dimension 3 Code";
                                    lrec_TmpSalesLine."Shortcut Dimension 4 Code" := lrec_SalesInvLine."Shortcut Dimension 4 Code";
                                    lrec_TmpSalesLine."Shortcut Dimension 5 Code" := lrec_SalesInvLine."Shortcut Dimension 5 Code";
                                    lrec_TmpSalesLine."Shortcut Dimension 6 Code" := lrec_SalesInvLine."Shortcut Dimension 6 Code";
                                    lrec_TmpSalesLine."Clearing Agent" := lrec_SalesInvLine."Clearing Agent";
                                    lrec_TmpSalesLine."Clearing Agent Name" := lrec_SalesInvLine."Clearing Agent Name";
                                    lrec_TmpSalesLine."Container No./Chassis No." := lrec_SalesInvLine."Container No./Chassis No.";
                                    lrec_TmpSalesLine."Container Type" := lrec_SalesInvLine."Container Type";
                                    lrec_TmpSalesLine."Job File No." := lrec_SalesInvLine."Job File No.";
                                    lrec_TmpSalesLine.Modify();
                                end else begin
                                    l_LineNo += 10000;
                                    lrec_TmpSalesLine.init;
                                    lrec_TmpSalesLine."Document Type" := lrec_TmpSalesLine."Document Type"::Order;
                                    lrec_TmpSalesLine."Line No." := l_LineNo;
                                    lrec_TmpSalesLine."Document No." := SalesOrderNo;
                                    lrec_TmpSalesLine.Type := lrec_TmpSalesLine.Type::Item;
                                    lrec_TmpSalesLine."No." := lrec_SalesInvLine."No.";
                                    lrec_TmpSalesLine.Quantity := lrec_SalesInvLine.Quantity;
                                    lrec_TmpSalesLine."Chargable Storage Days" := lrec_SalesInvLine."Chargable Storage Days";
                                    lrec_TmpSalesLine."Reefer Hours" := lrec_SalesInvLine."Reefer Hours"; //CR
                                    lrec_TmpSalesLine."Unit Price" := lrec_SalesInvLine."Unit Price";
                                    lrec_TmpSalesLine."Line Amount" := lrec_SalesInvLine."Line Amount";
                                    lrec_TmpSalesLine."Line Discount Amount" := lrec_SalesInvLine."Line Discount Amount";
                                    lrec_TmpSalesLine.Amount := lrec_SalesInvLine.Amount;
                                    lrec_TmpSalesLine."Shortcut Dimension 1 Code" := lrec_SalesInvLine."Shortcut Dimension 1 Code";
                                    lrec_TmpSalesLine."Shortcut Dimension 2 Code" := lrec_SalesInvLine."Shortcut Dimension 2 Code";
                                    lrec_TmpSalesLine."Shortcut Dimension 3 Code" := lrec_SalesInvLine."Shortcut Dimension 3 Code";
                                    lrec_TmpSalesLine."Shortcut Dimension 4 Code" := lrec_SalesInvLine."Shortcut Dimension 4 Code";
                                    lrec_TmpSalesLine."Shortcut Dimension 5 Code" := lrec_SalesInvLine."Shortcut Dimension 5 Code";
                                    lrec_TmpSalesLine."Shortcut Dimension 6 Code" := lrec_SalesInvLine."Shortcut Dimension 6 Code";
                                    lrec_TmpSalesLine."Clearing Agent" := lrec_SalesInvLine."Clearing Agent";
                                    lrec_TmpSalesLine."Clearing Agent Name" := lrec_SalesInvLine."Clearing Agent Name";
                                    lrec_TmpSalesLine."Container No./Chassis No." := lrec_SalesInvLine."Container No./Chassis No.";
                                    lrec_TmpSalesLine."Container Type" := lrec_SalesInvLine."Container Type";
                                    lrec_TmpSalesLine."Job File No." := lrec_SalesInvLine."Job File No.";
                                    lrec_TmpSalesLine."Outstanding Quantity" := lrec_SalesInvLine.Quantity;
                                    lrec_TmpSalesLine."Outstanding Amount" := lrec_SalesInvLine.Amount;
                                    lrec_TmpSalesLine."Item Category Code" := lrec_SalesInvLine."Item Category Code";
                                    lrec_TmpSalesLine.Insert();
                                end;
                            until lrec_SalesInvLine.Next() = 0;

                        //page.run(page::"Proforma SubForm", lrec_TmpSalesLine);
                        //exit;
                        lrec_SalesCrMemoLine.Reset();
                        lrec_SalesCrMemoLine.SetRange("Shortcut Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                        lrec_SalesCrMemoLine.SetRange(Type, lrec_SalesCrMemoLine.Type::Item);
                        lrec_SalesCrMemoLine.SetFilter(Quantity, '<>%1', 0);
                        if lrec_SalesCrMemoLine.FindSet() then
                            repeat
                                lrec_TmpSalesLine.Reset();
                                lrec_TmpSalesLine.SetRange("No.", lrec_SalesCrMemoLine."No.");
                                lrec_TmpSalesLine.SetRange("Shortcut Dimension 1 Code", lrec_SalesCrMemoLine."Shortcut Dimension 1 Code");
                                if lrec_TmpSalesLine.FindSet() then begin
                                    lrec_TmpSalesLine.Quantity -= lrec_SalesCrMemoLine.Quantity;
                                    //InvoicedChargeAmount := lrec_TmpSalesLine.Amount;
                                    //ChargedStorageDays := lrec_TmpSalesLine."Chargable Storage Days";
                                    lrec_TmpSalesLine.Modify();
                                end;
                            until lrec_SalesCrMemoLine.Next() = 0;
                        IMSSetup.Get();
                        //page.run(page::"Proforma SubForm", lrec_TmpSalesLine);
                        // exit;
                        lrec_TmpSalesLine.Reset();
                        lrec_TmpSalesLine.Setfilter(Quantity, '<>%1', 0);
                        if lrec_TmpSalesLine.FindSet() then
                            AlreadyInvoiced := true
                        else
                            AlreadyInvoiced := false;

                        if AlreadyInvoiced then begin
                            lrec_TmpSalesLine.Reset();
                            if lrec_TmpSalesLine.FindSet() then
                                repeat
                                    Salesline.Reset();
                                    Salesline.SetRange("Document Type", Salesline."Document Type"::Order);
                                    Salesline.SetRange("Document No.", SalesOrderNo);
                                    if Salesline.FindLast() then
                                        LNo := Salesline."Line No." + 10000
                                    else
                                        LNo := 10000;
                                    if lrec_TmpSalesLine.Quantity < lrec_TmpSalesLine."Outstanding Quantity" then begin
                                        //                LNo += 10000;
                                        Salesline.reset;
                                        Salesline.init;
                                        Salesline."Document Type" := Salesline."Document Type"::Order;
                                        Salesline."Document No." := SalesOrderNo;
                                        Salesline."Line No." := LNo;
                                        Salesline.Type := Salesline.Type::Item;
                                        Salesline.validate("No.", lrec_TmpSalesLine."No.");
                                        Salesline.validate(Quantity, 1);
                                        Salesline.Validate("Unit Price", lrec_TmpSalesLine."Unit Price");
                                        Salesline."Chargable Storage Days" := lrec_TmpSalesLine."Chargable Storage Days";
                                        Salesline."Reefer Hours" := lrec_TmpSalesLine."Reefer Hours";
                                        //Salesline.Amount := lrec_TmpSalesLine.Amount;
                                        Salesline."Shortcut Dimension 1 Code" := lrec_TmpSalesLine."Shortcut Dimension 1 Code";
                                        Salesline."Shortcut Dimension 2 Code" := lrec_TmpSalesLine."Shortcut Dimension 2 Code";
                                        Salesline."Shortcut Dimension 3 Code" := lrec_TmpSalesLine."Shortcut Dimension 3 Code";
                                        Salesline."Shortcut Dimension 4 Code" := lrec_TmpSalesLine."Shortcut Dimension 4 Code";
                                        Salesline."Shortcut Dimension 5 Code" := lrec_TmpSalesLine."Shortcut Dimension 5 Code";
                                        Salesline."Shortcut Dimension 6 Code" := lrec_TmpSalesLine."Shortcut Dimension 6 Code";
                                        Salesline."Clearing Agent" := lrec_TmpSalesLine."Clearing Agent";
                                        Salesline."Clearing Agent Name" := lrec_TmpSalesLine."Clearing Agent Name";
                                        Salesline."Container No./Chassis No." := lrec_TmpSalesLine."Container No./Chassis No.";
                                        Salesline."Container Type" := lrec_TmpSalesLine."Container Type";
                                        Salesline."Job File No." := lrec_TmpSalesLine."Job File No.";
                                        Salesline."Auto Calculated" := true;
                                        //Salesline."Outstanding Quantity" := lrec_TmpSalesLine.Quantity;
                                        //Salesline."Outstanding Amount" := lrec_TmpSalesLine.Amount;
                                        //InvoicedChargeAmount := lrec_TmpSalesLine.Amount;
                                        //  ChargedStorageDays := lrec_TmpSalesLine."Chargable Storage Days";
                                        Salesline.Insert();
                                    end;
                                until lrec_TmpSalesLine.Next() = 0;
                        end;
                        //*****We are calculating this blog for chrged storage days*****/// 
                        InvoicedChargeAmount := 0;
                        ChargedStorageDays := 0;
                        clear(InvoicedChargeAmount);
                        Clear(ChargedStorageDays);
                        lrec_TmpSalesLine2.Reset();
                        lrec_TmpSalesLine2.DeleteAll();
                        ChargeID := GetChargeID(TempManifestLine, CustNo);
                        StorageChargeID := '';
                        ChargeGroupLine3.Reset();
                        ChargeGroupLine3.SetRange("Charge ID Group Code", ChargeID);
                        ChargeGroupLine3.SetRange("Charge Category", IMSSetup."Category Code for Storage");
                        if ChargeGroupLine3.FindFirst() then
                            StorageChargeID := ChargeGroupLine3.Charge;
                        lrec_TmpSalesLine.Reset();
                        lrec_TmpSalesLine.SetRange("No.", StorageChargeID);
                        if lrec_TmpSalesLine.FindSet() then
                            repeat
                                lrec_TmpSalesLine2.Reset();
                                lrec_TmpSalesLine2.SetRange("Document Type", lrec_TmpSalesLine2."Document Type"::Order);
                                lrec_TmpSalesLine2.SetRange("Document No.", SalesOrderNo);
                                if lrec_TmpSalesLine2.FindLast() then
                                    LNo := lrec_TmpSalesLine2."Line No." + 10000
                                else
                                    LNo := 10000;
                                //if lrec_TmpSalesLine."No." = StorageChargeID then begin

                                //LNo += 10000;
                                lrec_TmpSalesLine2.reset;
                                lrec_TmpSalesLine2.init;
                                lrec_TmpSalesLine2."Document Type" := lrec_TmpSalesLine2."Document Type"::Order;
                                lrec_TmpSalesLine2."Line No." := LNo;
                                lrec_TmpSalesLine2."Document No." := SalesOrderNo;
                                lrec_TmpSalesLine2.Type := lrec_TmpSalesLine2.Type::Item;
                                lrec_TmpSalesLine2.validate("No.", lrec_TmpSalesLine."No.");
                                lrec_TmpSalesLine2.validate(Quantity, 1);
                                lrec_TmpSalesLine2.Validate("Unit Price", lrec_TmpSalesLine."Unit Price");
                                lrec_TmpSalesLine2."Chargable Storage Days" := lrec_TmpSalesLine."Chargable Storage Days";
                                //Salesline.Amount := lrec_TmpSalesLine.Amount;
                                lrec_TmpSalesLine2."Shortcut Dimension 1 Code" := lrec_TmpSalesLine."Shortcut Dimension 1 Code";
                                Salesline."Outstanding Quantity" := lrec_TmpSalesLine.Quantity;
                                Salesline."Outstanding Amount" := lrec_TmpSalesLine.Amount;
                                InvoicedChargeAmount := lrec_TmpSalesLine.Amount + lrec_TmpSalesLine."Line Discount Amount";
                                ChargedStorageDays := lrec_TmpSalesLine."Chargable Storage Days";
                                lrec_TmpSalesLine2.Insert();
                            until lrec_TmpSalesLine.Next() = 0;
                        //*****We are calculating this blog for chrged storage days*****END/// 
                        Clear(ReeferInvoicedChargeAmount);
                        IMSSetup.Get();
                        lrec_TmpSalesLine.Reset();
                        lrec_TmpSalesLine.SetRange("No.", IMSSetup."Default Charge ID Reefer");
                        if lrec_TmpSalesLine.FindSet() then
                            repeat
                                clear(ChargedReeferStorageHours);
                                LNo += 10000;
                                lrec_TmpSalesLine2.reset;
                                lrec_TmpSalesLine2.init;
                                lrec_TmpSalesLine2."Document Type" := lrec_TmpSalesLine2."Document Type"::Order;
                                lrec_TmpSalesLine2."Line No." := LNo;
                                lrec_TmpSalesLine2."Document No." := SalesOrderNo;
                                lrec_TmpSalesLine2.Type := Salesline.Type::Item;
                                lrec_TmpSalesLine2.validate("No.", lrec_TmpSalesLine."No.");
                                lrec_TmpSalesLine2.validate(Quantity, 1);
                                lrec_TmpSalesLine2.Validate("Unit Price", lrec_TmpSalesLine."Unit Price");
                                lrec_TmpSalesLine2."Chargable Storage Days" := lrec_TmpSalesLine."Chargable Storage Days";
                                lrec_TmpSalesLine2."Reefer Hours" := lrec_TmpSalesLine."Reefer Hours";
                                //Salesline.Amount := lrec_TmpSalesLine.Amount;
                                lrec_TmpSalesLine2."Shortcut Dimension 1 Code" := lrec_TmpSalesLine."Shortcut Dimension 1 Code";
                                Salesline."Outstanding Quantity" := lrec_TmpSalesLine.Quantity;
                                Salesline."Outstanding Amount" := lrec_TmpSalesLine.Amount;
                                ReeferInvoicedChargeAmount := lrec_TmpSalesLine.Amount + lrec_TmpSalesLine."Line Discount Amount";
                                ChargedReeferStorageHours := lrec_TmpSalesLine."Reefer Hours";
                                lrec_TmpSalesLine2.Insert();
                            until lrec_TmpSalesLine.Next() = 0;
                        //reefer
                        RemarshallingChargeID := '';
                        RemarshallingExist := false;
                        ChargeID := GetChargeID(TempManifestLine, CustNo);
                        lrec_TmpSalesLine.Reset();
                        if lrec_TmpSalesLine.FindSet() then
                            repeat
                                ChargeGroupLine3.Reset();
                                ChargeGroupLine3.SetRange("Charge ID Group Code", ChargeID);
                                ChargeGroupLine3.SetRange("Calculate if Storage Days", true);
                                ChargeGroupLine3.SetRange("Rely On Storage", false);
                                if ChargeGroupLine3.FindFirst() then
                                    RemarshallingChargeID := ChargeGroupLine3.Charge;
                                if lrec_TmpSalesLine."No." = RemarshallingChargeID then
                                    RemarshallingExist := true
                                else
                                    RemarshallingExist := false;
                                if RemarshallingExist then
                                    break;
                            until lrec_TmpSalesLine.Next() = 0;

                        //page.run(page::"Sales Order Subform", lrec_TmpSalesLine);
                        //exit;
                        //GK    //
                        //IfInvoiced begin
                        if AlreadyInvoiced then begin
                            ChargeID := GetChargeID(TempManifestLine, CustNo);
                            ChargeGroupHead.Reset();
                            ChargeGroupHead.SetRange("Charge ID Group Code", ChargeID);
                            if ChargeGroupHead.FindFirst() then begin
                                // ManifestHead.Reset();
                                // ManifestHead.SetRange("Job File No.", TempManifestLine."Job File No.");
                                // IF ManifestHead.FindFirst() then begin
                                if ChargeGroupHead."Base On" = ChargeGroupHead."Base On"::"Received Date" then begin
                                    TestManifestLine.Reset();
                                    TestManifestLine.SetRange("Job File No.", TempManifestLine."Job File No.");
                                    TestManifestLine.SetRange("Global Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                                    IF TestManifestLine.FindFirst() then begin
                                        StorageStartDate := TestManifestLine."Date Received"
                                    end;
                                end;
                                IF ChargeGroupHead."Base On" = ChargeGroupHead."Base On"::"ETA Date" then
                                    StorageStartDate := TempManifestLine."Expected Arrival Date";
                                IF ChargeGroupHead."Base On" = ChargeGroupHead."Base On"::"Last Sling Date" then
                                    StorageStartDate := TempManifestLine."Last Sling Date";
                                IF ChargeGroupHead."Base On" = ChargeGroupHead."Base On"::ActualDate then
                                    StorageStartDate := TempManifestLine."Vessel Arrival Date";
                                //end;
                                IF StorageStartDate <> 0D then begin
                                    IF ChargeGroupHead."Start After" > 1 then
                                        AfterBaseOnDate := CalcDate(FORMAT(ChargeGroupHead."Start After") + 'D', StorageStartDate)
                                    else
                                        AfterBaseOnDate := StorageStartDate;
                                end;

                                SalesHead.Reset();
                                SalesHead.SetRange("Document Type", SalesHead."Document Type"::Order);
                                SalesHead.SetRange("No.", SalesOrderNo);
                                IF SalesHead.FindFirst() then
                                    SOPostingDate := SalesHead."Posting Date";
                                if AfterBaseOnDate <> 0D then
                                    BeforeReceivedStorageDays := SOPostingDate - AfterBaseOnDate;

                                if ChargeGroupHead."Include Received Day" then
                                    StorageDays := BeforeReceivedStorageDays + 1
                                else
                                    StorageDays := BeforeReceivedStorageDays;

                                ChargeGroupLine2.Reset();
                                ChargeGroupLine2.SetRange("Charge ID Group Code", ChargeGroupHead."Charge ID Group Code");
                                ChargeGroupLine2.SetRange("Active/In-Active", ChargeGroupLine2."Active/In-Active"::Active);
                                IF ChargeGroupLine2.FindFirst() then begin
                                    repeat
                                        ChargeGroupLine.Reset();
                                        ChargeGroupLine.SetRange("Charge ID Group Code", ChargeGroupLine2."Charge ID Group Code");
                                        ChargeGroupLine.SetRange("Line No.", ChargeGroupLine2."Line No.");
                                        if StorageDays > ChargeGroupLine2."Free Days" then
                                            ChargeGroupLine.SetRange("Calculate if Storage Days", true);
                                        if RemarshallingExist then
                                            ChargeGroupLine.SetRange("Rely On Storage", true);
                                        if ChargeGroupLine.FindFirst() then begin
                                            if StorageDays > ChargeGroupLine2."Free Days" then begin
                                                Salesline.Reset();
                                                Salesline.SetRange("Document Type", Salesline."Document Type"::Order);
                                                Salesline.SetRange("Document No.", SalesOrderNo);
                                                IF Salesline.Findlast() then
                                                    EntryNo := Salesline."Line No." + 10000
                                                else
                                                    EntryNo := 10000;
                                                repeat
                                                    Clear(ChargeAmount);
                                                    Clear(ChargableStorageDays);
                                                    Clear(RemainingFirstDays);
                                                    Clear(RemainingSecondDays);
                                                    Clear(RemainingThirdDays);
                                                    Clear(RemainingFourthDays);
                                                    Clear(FirstIntervalAmount);
                                                    Clear(SecondIntervalAmount);
                                                    Clear(ThirdIntervalAmount);
                                                    Clear(FourthIntervalAmount);
                                                    Clear(TotalBasechargeAmount);

                                                    // if StorageDays < ChargeGroupLine."Free Days" then
                                                    //     ChargeGroupLine.SetRange("Calculate if Storage Days", false);
                                                    // if ChargeGroupLine.FindFirst() then;

                                                    Salesline.Init;
                                                    Salesline.validate("Document Type", Salesline."Document Type"::Order);
                                                    Salesline.VAlidate("Document No.", SalesOrderNo);
                                                    Salesline.Validate("Line No.", EntryNo);
                                                    Salesline.Insert;
                                                    Salesline.validate(Type, Salesline.Type::Item);
                                                    Salesline.Validate("No.", ChargeGroupLine.Charge);
                                                    Salesline.Description := ChargeGroupLine."Charge Description ";
                                                    Salesline.validate("Shortcut Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                                                    Salesline.validate("Shortcut Dimension 2 Code", TempManifestLine."Global Dimension 2 Code");
                                                    Salesline.validate("Shortcut Dimension 5 Code", TempManifestLine."Shortcut Dimension 5 Code");
                                                    Salesline.validate("Shortcut Dimension 3 Code", TempManifestLine."Shortcut Dimension 3 Code");
                                                    Salesline.validate("Shortcut Dimension 4 Code", TempManifestLine."Shortcut Dimension 4 Code");
                                                    Salesline.validate("Shortcut Dimension 6 Code", TempManifestLine."Shortcut Dimension 6 Code");
                                                    Salesline.Validate("Container No./Chassis No.", TempManifestLine."Container/Chassis No.");
                                                    salesline.validate("Container Type", TempManifestLine."Container Type");
                                                    Salesline.validate("BL No.", TempManifestLine."BL No.");
                                                    Salesline.validate("Charge ID", ChargeID);
                                                    Salesline.validate("Clearing Agent", TempManifestLine."Clearing Agent");
                                                    Salesline.validate("Clearing Agent Name", GetClearingAgentName(TempManifestLine."Clearing Agent"));
                                                    Salesline.validate("Position ID", TempManifestLine."Allocated Position");
                                                    Salesline.validate("Job File No.", TempManifestLine."Job File No.");
                                                    Salesline.Validate("Job File Date", TempManifestLine."Job File Date");
                                                    Salesline.validate("No. Of Bags for Billing", TempManifestLine."Remaining Bags");
                                                    Salesline."Auto Calculated" := true;
                                                    Salesline.Validate(Quantity, 1);
                                                    if ChargeGroupLine.Charge <> IMSSetup."Default Charge ID Reefer" then begin
                                                        Salesline."Storage Days" := StorageDays;
                                                        ChargableStorageDays := 0;
                                                        IF ChargeGroupLine."Free Days" <> 0 then begin
                                                            ChargableStorageDays := StorageDays - ChargeGroupLine."Free Days";
                                                            Salesline."Storage Start Date" := CalcDate(FORMAT(ChargeGroupLine."Free Days") + 'D', AfterBaseOnDate);
                                                            Salesline."Free Days" := ChargeGroupLine."Free Days";
                                                            Salesline."Chargable Storage Days" := ChargableStorageDays - ChargedStorageDays;
                                                            //end else begin
                                                            //ChargableStorageDays := StorageDays;
                                                            //Salesline."Storage Start Date" := AfterBaseOnDate;
                                                            //message('Chargable storage Days %1 and Charged Storage Days', ChargableStorageDays, ChargedStorageDays);
                                                        end else begin
                                                            ChargableStorageDays := StorageDays;
                                                            Salesline."Storage Start Date" := AfterBaseOnDate;
                                                            Salesline."Chargable Storage Days" := ChargableStorageDays - ChargedStorageDays;
                                                            Salesline."Free Days" := ChargeGroupLine."Free Days";
                                                            //message('Chargable storage Days %1 and Charged Storage Days', ChargableStorageDays, ChargedStorageDays);
                                                        end;



                                                        IF ChargableStorageDays > 0 then begin
                                                            IF ChargableStorageDays > ChargeGroupHead."First Bracket" then
                                                                RemainingFirstDays := ChargableStorageDays - ChargeGroupHead."First Bracket";
                                                            //Message('RemainingFirstDays %1', RemainingFirstDays);
                                                            IF (RemainingFirstDays > 0) then
                                                                RemainingSecondDays := RemainingFirstDays - ChargeGroupHead."Second Bracket";
                                                            //Message('RemainingSecondDays %1', RemainingSecondDays);
                                                            if RemainingSecondDays > 0 then
                                                                RemainingThirdDays := RemainingSecondDays - ChargeGroupHead."Third Bracket";
                                                            //Message('RemainingThirdDays %1', RemainingThirdDays);
                                                        end;
                                                        IF ChargableStorageDays > 0 THEN begin
                                                            IF ChargableStorageDays > ChargeGroupHead."First Bracket" then
                                                                FirstIntervalAmount := ChargeGroupHead."First Bracket" * ChargeGroupLine."First Interval"
                                                            else
                                                                FirstIntervalAmount := ChargableStorageDays * ChargeGroupLine."First Interval";
                                                            //Message('FirstIntervalAmount %1', FirstIntervalAmount);
                                                            IF RemainingFirstDays > 0 THEN begin
                                                                IF RemainingFirstDays > ChargeGroupHead."Second Bracket" then
                                                                    SecondIntervalAmount := ChargeGroupHead."Second Bracket" * ChargeGroupLine."Second Interval"
                                                                else
                                                                    SecondIntervalAmount := RemainingFirstDays * ChargeGroupLine."Second Interval";
                                                                //Message('SecondIntervalAmount %1', SecondIntervalAmount);
                                                            end;
                                                            IF RemainingSecondDays > 0 THEN begin
                                                                if RemainingSecondDays > ChargeGroupHead."Third Bracket" then
                                                                    ThirdIntervalAmount := ChargeGroupHead."Third Bracket" * ChargeGroupLine."Third Interval"
                                                                else
                                                                    ThirdIntervalAmount := RemainingSecondDays * ChargeGroupLine."Third Interval";
                                                                //Message('ThirdIntervalAmount %1', ThirdIntervalAmount);
                                                            end;
                                                            if RemainingThirdDays > 0 then
                                                                FourthIntervalAmount := RemainingThirdDays * ChargeGroupLine.HenceForth;
                                                            //Message('FourthIntervalAmount %1', FourthIntervalAmount);
                                                        end;

                                                        TotalBasechargeAmount := FirstIntervalAmount + SecondIntervalAmount + ThirdIntervalAmount + FourthIntervalAmount;

                                                        IF (ChargeGroupLine."Based On CBM/ Weight" = false) AND (ChargeGroupLine."Rely On Storage" = false) then
                                                            ChargeAmount := ChargeGroupLine."First Interval";

                                                        IF (ChargeGroupLine."Based On CBM/ Weight" = true) AND (ChargeGroupLine."Rely On Storage" = true) then begin
                                                            ManifestLine.Reset();
                                                            ManifestLine.SetRange("Job File No.", TempManifestLine."Job File No.");
                                                            ManifestLine.SetRange("Global Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                                                            if ManifestLine.FindFirst() then
                                                                ChargeAmount := TotalBasechargeAmount * ManifestLine."CBM-Wt Difference";
                                                        end;

                                                        IF (ChargeGroupLine."Based On CBM/ Weight" = true) AND (ChargeGroupLine."Rely On Storage" = false) then begin
                                                            ManifestLine.Reset();
                                                            ManifestLine.SetRange("Job File No.", TempManifestLine."Job File No.");
                                                            ManifestLine.SetRange("Global Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                                                            if ManifestLine.FindFirst() then
                                                                ChargeAmount := ChargeGroupLine."First Interval" * ManifestLine."CBM-Wt Difference";
                                                        end;

                                                        IF (ChargeGroupLine."Based On CBM/ Weight" = false) AND (ChargeGroupLine."Rely On Storage" = true) then
                                                            ChargeAmount := TotalBasechargeAmount;


                                                        if (salesline."Chargable Storage Days" = 0) or (salesline."Chargable Storage Days" > 0) and (ChargeGroupLine."Rely On Storage" = true) and (ChargeGroupLine."Calculate if Storage Days" = true) then begin
                                                            RemainingChargeAmount := ChargeAmount - InvoicedChargeAmount
                                                        end else begin
                                                            RemainingChargeAmount := ChargeAmount;
                                                            //Message('Remaining Charge Amount %1,Charge Amount %2, Invoiced ChargeAmount %3', RemainingChargeAmount, ChargeAmount, InvoicedChargeAmount);
                                                        end;


                                                    end else begin
                                                        //Storage Hours
                                                        IMSSetup.Get();
                                                        if ChargeGroupLine.Charge = IMSSetup."Default Charge ID Reefer" then begin
                                                            //For Reefer
                                                            Salesline."Storage Start Date" := ManifestLine."Landing Date";
                                                            ReeferStorageHours := GetReeferHours(TempManifestLine);
                                                            //Message(FORMAT(ReeferStorageHours));
                                                            Salesline."Reefer Hours" := ReeferStorageHours - ChargedReeferStorageHours;
                                                            RemainingChargeAmount := ChargeGroupLine."First Interval" * ReeferStorageHours - ReeferInvoicedChargeAmount;
                                                        end;
                                                    end;
                                                    Salesline.Validate("Unit Price", RemainingChargeAmount);
                                                    Salesline.Modify();
                                                    EntryNo += 10000;
                                                until ChargeGroupLine.Next() = 0;
                                            end;
                                        end;
                                    until ChargeGroupLine2.Next() = 0;
                                end;
                            end;
                        end;
                        //IfInvoiced end
                        //If not Invoiced begin 
                        if not AlreadyInvoiced then begin
                            ChargeID := GetChargeID(TempManifestLine, CustNo);
                            ChargeGroupHead.Reset();
                            ChargeGroupHead.SetRange("Charge ID Group Code", ChargeID);
                            if ChargeGroupHead.FindFirst() then begin
                                // ManifestHead.Reset();
                                // ManifestHead.SetRange("Job File No.", TempManifestLine."Job File No.");
                                // IF ManifestHead.FindFirst() then begin
                                if ChargeGroupHead."Base On" = ChargeGroupHead."Base On"::"Received Date" then begin
                                    TestManifestLine.Reset();
                                    TestManifestLine.SetRange("Global Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                                    IF TestManifestLine.FindFirst() then begin
                                        StorageStartDate := TestManifestLine."Date Received"
                                    end;
                                end;
                                IF ChargeGroupHead."Base On" = ChargeGroupHead."Base On"::"ETA Date" then
                                    StorageStartDate := TestManifestLine."Expected Arrival Date";
                                IF ChargeGroupHead."Base On" = ChargeGroupHead."Base On"::"Last Sling Date" then
                                    StorageStartDate := TestManifestLine."Last Sling Date";
                                IF ChargeGroupHead."Base On" = ChargeGroupHead."Base On"::ActualDate then
                                    StorageStartDate := TestManifestLine."Vessel Arrival Date";
                                // end;
                                IF StorageStartDate <> 0D then begin
                                    IF ChargeGroupHead."Start After" > 1 then
                                        AfterBaseOnDate := CalcDate(FORMAT(ChargeGroupHead."Start After") + 'D', StorageStartDate)
                                    else
                                        AfterBaseOnDate := StorageStartDate;
                                end;

                                SalesHead.Reset();
                                SalesHead.SetRange("Document Type", SalesHead."Document Type"::Order);
                                SalesHead.SetRange("No.", SalesOrderNo);
                                IF SalesHead.FindFirst() then
                                    SOPostingDate := SalesHead."Posting Date";
                                if AfterBaseOnDate <> 0D then
                                    BeforeReceivedStorageDays := SOPostingDate - AfterBaseOnDate;

                                if ChargeGroupHead."Include Received Day" then
                                    StorageDays := BeforeReceivedStorageDays + 1
                                else
                                    StorageDays := BeforeReceivedStorageDays;

                                //Message(FORMAT(StorageDays));
                                ChargeGroupLine2.Reset();
                                ChargeGroupLine2.SetRange("Charge ID Group Code", ChargeGroupHead."Charge ID Group Code");
                                ChargeGroupLine2.SetRange("Active/In-Active", ChargeGroupLine2."Active/In-Active"::Active);
                                IF ChargeGroupLine2.FindFirst() then begin
                                    repeat
                                        ChargeGroupLine.Reset();
                                        ChargeGroupLine.SetRange("Charge ID Group Code", ChargeGroupLine2."Charge ID Group Code");
                                        ChargeGroupLine.SetRange("Line No.", ChargeGroupLine2."Line No.");
                                        if (StorageDays < ChargeGroupLine2."Free Days") or (StorageDays = ChargeGroupLine2."Free Days") then
                                            ChargeGroupLine.SetRange("Calculate if Storage Days", false);
                                        IF ChargeGroupLine.FindFirst() then begin
                                            Salesline.Reset();
                                            Salesline.SetRange("Document Type", Salesline."Document Type"::Order);
                                            Salesline.SetRange("Document No.", SalesOrderNo);
                                            IF Salesline.Findlast() then
                                                EntryNo := Salesline."Line No." + 10000
                                            else
                                                EntryNo := 10000;
                                            repeat
                                                Clear(ChargeAmount);
                                                clear(ChargableStorageDays);
                                                Clear(RemainingFirstDays);
                                                Clear(RemainingSecondDays);
                                                Clear(RemainingThirdDays);
                                                Clear(RemainingFourthDays);
                                                Clear(FirstIntervalAmount);
                                                Clear(SecondIntervalAmount);
                                                Clear(ThirdIntervalAmount);
                                                Clear(FourthIntervalAmount);
                                                Clear(TotalBasechargeAmount);



                                                Salesline.Init;
                                                Salesline.validate("Document Type", Salesline."Document Type"::Order);
                                                Salesline.VAlidate("Document No.", SalesOrderNo);
                                                Salesline.Validate("Line No.", EntryNo);
                                                Salesline.Insert;
                                                Salesline.validate(Type, Salesline.Type::Item);
                                                Salesline.Validate("No.", ChargeGroupLine.Charge);
                                                Salesline.Description := ChargeGroupLine."Charge Description ";
                                                Salesline.validate("Shortcut Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                                                Salesline.validate("Shortcut Dimension 2 Code", TempManifestLine."Global Dimension 2 Code");
                                                Salesline.validate("Shortcut Dimension 5 Code", TempManifestLine."Shortcut Dimension 5 Code");
                                                Salesline.validate("Shortcut Dimension 3 Code", TempManifestLine."Shortcut Dimension 3 Code");
                                                Salesline.validate("Shortcut Dimension 4 Code", TempManifestLine."Shortcut Dimension 4 Code");
                                                Salesline.validate("Shortcut Dimension 6 Code", TempManifestLine."Shortcut Dimension 6 Code");
                                                Salesline.Validate("Container No./Chassis No.", TempManifestLine."Container/Chassis No.");
                                                salesline.validate("Container Type", TempManifestLine."Container Type");
                                                Salesline.validate("BL No.", TempManifestLine."BL No.");
                                                Salesline.validate("Charge ID", ChargeID);
                                                Salesline.validate("Clearing Agent", TempManifestLine."Clearing Agent");
                                                Salesline.validate("Clearing Agent Name", GetClearingAgentName(TempManifestLine."Clearing Agent"));
                                                Salesline.validate("Position ID", TempManifestLine."Allocated Position");
                                                Salesline.validate("Job File No.", TempManifestLine."Job File No.");
                                                Salesline.Validate("Job File Date", TempManifestLine."Job File Date");
                                                Salesline.validate("No. Of Bags for Billing", TempManifestLine."Remaining Bags");
                                                Salesline."Auto Calculated" := true;
                                                Salesline.Validate(Quantity, 1);
                                                if ChargeGroupLine.Charge <> IMSSetup."Default Charge ID Reefer" then begin
                                                    Salesline."Storage Days" := StorageDays;
                                                    IF ChargeGroupLine."Free Days" <> 0 then begin
                                                        ChargableStorageDays := StorageDays - ChargeGroupLine."Free Days";
                                                        Salesline."Storage Start Date" := CalcDate(FORMAT(ChargeGroupLine."Free Days") + 'D', AfterBaseOnDate);
                                                        Salesline."Free Days" := ChargeGroupLine."Free Days";
                                                        Salesline."Chargable Storage Days" := ChargableStorageDays;
                                                        //end else begin
                                                        //ChargableStorageDays := StorageDays;
                                                        //Salesline."Storage Start Date" := AfterBaseOnDate;
                                                    end else begin
                                                        ChargableStorageDays := StorageDays;
                                                        Salesline."Storage Start Date" := AfterBaseOnDate;

                                                        //Salesline."Chargable Storage Days" := ChargableStorageDays;
                                                        Salesline."Free Days" := ChargeGroupLine."Free Days";
                                                    end;
                                                    //IF ChargeGroupLine."Free Days" <> 0 then


                                                    IF ChargableStorageDays > 0 then begin
                                                        IF ChargableStorageDays > ChargeGroupHead."First Bracket" then
                                                            RemainingFirstDays := ChargableStorageDays - ChargeGroupHead."First Bracket";
                                                        //Message('RemainingFirstDays %1', RemainingFirstDays);
                                                        IF (RemainingFirstDays > 0) then
                                                            RemainingSecondDays := RemainingFirstDays - ChargeGroupHead."Second Bracket";
                                                        //Message('RemainingSecondDays %1', RemainingSecondDays);
                                                        if RemainingSecondDays > 0 then
                                                            RemainingThirdDays := RemainingSecondDays - ChargeGroupHead."Third Bracket";
                                                        //Message('RemainingThirdDays %1', RemainingThirdDays);
                                                    end;
                                                    IF ChargableStorageDays > 0 THEN begin
                                                        IF ChargableStorageDays > ChargeGroupHead."First Bracket" then
                                                            FirstIntervalAmount := ChargeGroupHead."First Bracket" * ChargeGroupLine."First Interval"
                                                        else
                                                            FirstIntervalAmount := ChargableStorageDays * ChargeGroupLine."First Interval";
                                                        //Message('FirstIntervalAmount %1', FirstIntervalAmount);
                                                        IF RemainingFirstDays > 0 THEN begin
                                                            IF RemainingFirstDays > ChargeGroupHead."Second Bracket" then
                                                                SecondIntervalAmount := ChargeGroupHead."Second Bracket" * ChargeGroupLine."Second Interval"
                                                            else
                                                                SecondIntervalAmount := RemainingFirstDays * ChargeGroupLine."Second Interval";
                                                            //Message('SecondIntervalAmount %1', SecondIntervalAmount);
                                                        end;
                                                        IF RemainingSecondDays > 0 THEN begin
                                                            if RemainingSecondDays > ChargeGroupHead."Third Bracket" then
                                                                ThirdIntervalAmount := ChargeGroupHead."Third Bracket" * ChargeGroupLine."Third Interval"
                                                            else
                                                                ThirdIntervalAmount := RemainingSecondDays * ChargeGroupLine."Third Interval";
                                                            //Message('ThirdIntervalAmount %1', ThirdIntervalAmount);
                                                        end;
                                                        if RemainingThirdDays > 0 then
                                                            FourthIntervalAmount := RemainingThirdDays * ChargeGroupLine.HenceForth;
                                                        //Message('FourthIntervalAmount %1', FourthIntervalAmount);
                                                    end;

                                                    TotalBasechargeAmount := FirstIntervalAmount + SecondIntervalAmount + ThirdIntervalAmount + FourthIntervalAmount;

                                                    IF (ChargeGroupLine."Based On CBM/ Weight" = false) AND (ChargeGroupLine."Rely On Storage" = false) then
                                                        ChargeAmount := ChargeGroupLine."First Interval";

                                                    IF (ChargeGroupLine."Based On CBM/ Weight" = true) AND (ChargeGroupLine."Rely On Storage" = true) then begin
                                                        ManifestLine.Reset();
                                                        ManifestLine.SetRange("Job File No.", TempManifestLine."Job File No.");
                                                        ManifestLine.SetRange("Global Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                                                        if ManifestLine.FindFirst() then
                                                            ChargeAmount := TotalBasechargeAmount * ManifestLine."CBM-Wt Difference";
                                                    end;

                                                    IF (ChargeGroupLine."Based On CBM/ Weight" = true) AND (ChargeGroupLine."Rely On Storage" = false) then begin
                                                        ManifestLine.Reset();
                                                        ManifestLine.SetRange("Job File No.", TempManifestLine."Job File No.");
                                                        ManifestLine.SetRange("Global Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                                                        if ManifestLine.FindFirst() then
                                                            ChargeAmount := ChargeGroupLine."First Interval" * ManifestLine."CBM-Wt Difference";
                                                    end;

                                                    IF (ChargeGroupLine."Based On CBM/ Weight" = false) AND (ChargeGroupLine."Rely On Storage" = true) then
                                                        ChargeAmount := TotalBasechargeAmount;
                                                end else begin
                                                    //Storage Hours
                                                    IMSSetup.Get();
                                                    if ChargeGroupLine.Charge = IMSSetup."Default Charge ID Reefer" then begin
                                                        //For Reefer
                                                        Salesline."Storage Start Date" := ManifestLine."Landing Date";
                                                        ReeferStorageHours := GetReeferHours(TempManifestLine);
                                                        Salesline."Reefer Hours" := ReeferStorageHours;
                                                        Message(FORMAT(ReeferStorageHours));
                                                        ChargeAmount := ChargeGroupLine."First Interval" * ReeferStorageHours;
                                                    end;

                                                end;
                                                Salesline.Validate("Unit Price", ChargeAmount);
                                                Salesline.Modify();
                                                EntryNo += 10000;
                                            until ChargeGroupLine.Next() = 0;
                                        end;
                                    until ChargeGroupLine2.Next() = 0;
                                end;
                            end;
                        end;
                        //If not Invoiced end
                        // RecSalesLine.Reset();
                        // RecSalesLine.SetRange("Shortcut Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                        // if RecSalesLine.FindFirst() then
                        //     repeat
                        //         RecSalesLine."Chargable Storage Days" := ChargableStorageDays;
                        //         RecSalesLine.Modify();
                        //     until RecSalesLine.next = 0;



                        //Additional Charges from Manifest
                        AddCharges.Reset();
                        AddCharges.SetRange("Container ID", TempManifestLine."Global Dimension 1 Code");
                        AddCharges.SetFilter("Charges Code", '<>%1', '');
                        IF AddCharges.FindFirst() then
                            repeat
                                if AddCharges.Rate = 0 then
                                    Error('Please mention additional charge rate for %1 container %2', AddCharges."Charges Code", AddCharges."Container ID");
                                PostedSalesInvLine.Reset();
                                PostedSalesInvLine.SetRange("Shortcut Dimension 1 Code", AddCharges."Container ID");
                                PostedSalesInvLine.SetRange(Type, PostedSalesInvLine.Type::Item);
                                PostedSalesInvLine.SetRange("No.", AddCharges."Charges Code");
                                if postedsalesinvline.findfirst then begin
                                    PostedSalesCrLine.Reset();
                                    PostedSalesCrLine.SetRange("Shortcut Dimension 1 Code", AddCharges."Container ID");
                                    PostedSalesCrLine.SetRange(Type, PostedSalesCrLine.Type::Item);
                                    PostedSalesCrLine.SetRange("No.", PostedSalesInvLine."No.");
                                    if PostedSalesCrLine.findfirst then begin
                                        RecSalesLine.Reset();
                                        RecSalesLine.SetRange("Document Type", RecSalesLine."Document Type"::Order);
                                        RecSalesLine.SetRange("Document No.", SalesOrderNo);
                                        IF RecSalesLine.FindLast() then
                                            LineNo1 := RecSalesLine."Line No." + 10000;
                                        RecSalesLine.init;
                                        RecSalesLine."Document Type" := RecSalesLine."Document Type"::Order;
                                        RecSalesLine."Document No." := SalesOrderNo;
                                        RecSalesLine."Line No." := LineNo1;
                                        RecSalesLine.Type := RecSalesLine.Type::Item;
                                        RecSalesLine.validate("No.", AddCharges."Charges Code");
                                        RecSalesLine.validate("Shortcut Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                                        RecSalesLine.Validate("Shortcut Dimension 2 Code", TempManifestLine."Global Dimension 2 Code");
                                        RecSalesLine.Validate("Shortcut Dimension 3 Code", TempManifestLine."Shortcut Dimension 3 Code");
                                        RecSalesLine.validate("Shortcut Dimension 4 Code", TempManifestLine."Shortcut Dimension 4 Code");
                                        RecSalesLine.validate("Shortcut Dimension 5 Code", TempManifestLine."Shortcut Dimension 5 Code");
                                        RecSalesLine.validate("Shortcut Dimension 6 Code", TempManifestLine."Shortcut Dimension 6 Code");
                                        RecSalesLine.Validate("Container No./Chassis No.", TempManifestLine."Container/Chassis No.");
                                        RecSalesline.validate("BL No.", TempManifestLine."BL No.");
                                        RecSalesline.validate("Charge ID", ChargeID);
                                        RecSalesline.validate("Position ID", TempManifestLine."Allocated Position");
                                        RecSalesline.validate("Job File No.", TempManifestLine."Job File No.");
                                        RecSalesline.Validate("Job File Date", TempManifestLine."Job File Date");
                                        RecSalesline.validate("No. Of Bags for Billing", TempManifestLine."Remaining Bags");
                                        RecSalesline.Validate(Quantity, 1);
                                        RecSalesLine.Validate("Unit Price", AddCharges.Rate);
                                        RecSalesline."Auto Calculated" := true;
                                        RecSalesLine.insert;
                                        LineNo1 += 10000;
                                    end;
                                end else begin
                                    RecSalesLine.Reset();
                                    RecSalesLine.SetRange("Document Type", RecSalesLine."Document Type"::Order);
                                    RecSalesLine.SetRange("Document No.", SalesOrderNo);
                                    IF RecSalesLine.FindLast() then
                                        LineNo1 := RecSalesLine."Line No." + 10000;
                                    RecSalesLine.init;
                                    RecSalesLine."Document Type" := RecSalesLine."Document Type"::Order;
                                    RecSalesLine."Document No." := SalesOrderNo;
                                    RecSalesLine."Line No." := LineNo1;
                                    RecSalesLine.Type := RecSalesLine.Type::Item;
                                    RecSalesLine.validate("No.", AddCharges."Charges Code");
                                    RecSalesLine.validate("Shortcut Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                                    RecSalesLine.Validate("Shortcut Dimension 2 Code", TempManifestLine."Global Dimension 2 Code");
                                    RecSalesLine.Validate("Shortcut Dimension 3 Code", TempManifestLine."Shortcut Dimension 3 Code");
                                    RecSalesLine.validate("Shortcut Dimension 4 Code", TempManifestLine."Shortcut Dimension 4 Code");
                                    RecSalesLine.validate("Shortcut Dimension 5 Code", TempManifestLine."Shortcut Dimension 5 Code");
                                    RecSalesLine.validate("Shortcut Dimension 6 Code", TempManifestLine."Shortcut Dimension 6 Code");
                                    RecSalesLine.Validate("Container No./Chassis No.", TempManifestLine."Container/Chassis No.");
                                    RecSalesline.validate("BL No.", TempManifestLine."BL No.");
                                    RecSalesline.validate("Charge ID", ChargeID);
                                    RecSalesline.validate("Position ID", TempManifestLine."Allocated Position");
                                    RecSalesline.validate("Job File No.", TempManifestLine."Job File No.");
                                    RecSalesline.Validate("Job File Date", TempManifestLine."Job File Date");
                                    RecSalesline.validate("No. Of Bags for Billing", TempManifestLine."Remaining Bags");
                                    RecSalesline.Validate(Quantity, 1);
                                    RecSalesLine.Validate("Unit Price", AddCharges.Rate);
                                    RecSalesline."Auto Calculated" := true;
                                    RecSalesLine.insert;
                                    LineNo1 += 10000;
                                    // end;
                                end;
                            until AddCharges.next = 0;


                        //Additional charges from Manifest


                        // Additional Receiving Charges



                        PostedAddReceivingCharges.Reset();
                        PostedAddReceivingCharges.SetRange("Container ID", TempManifestLine."Global Dimension 1 Code");
                        IF PostedAddReceivingCharges.FindFirst() then
                            repeat
                                PostedSalesInvLine.Reset();
                                PostedSalesInvLine.SetRange("Shortcut Dimension 1 Code", PostedAddReceivingCharges."Container ID");
                                PostedSalesInvLine.SetRange(Type, PostedSalesInvLine.Type::Item);
                                PostedSalesInvLine.SetRange("No.", PostedAddReceivingCharges."Charges Code");
                                if not postedsalesinvline.findfirst then begin
                                    RecSalesLine.Reset();
                                    RecSalesLine.SetRange("Document Type", RecSalesLine."Document Type"::Order);
                                    RecSalesLine.SetRange("Document No.", SalesOrderNo);
                                    IF RecSalesLine.FindLast() then
                                        LineNo1 := RecSalesLine."Line No." + 10000;
                                    RecSalesLine.init;
                                    RecSalesLine."Document Type" := RecSalesLine."Document Type"::Order;
                                    RecSalesLine."Document No." := SalesOrderNo;
                                    RecSalesLine."Line No." := LineNo1;
                                    RecSalesLine.Type := RecSalesLine.Type::Item;
                                    RecSalesLine.validate("No.", PostedAddReceivingCharges."Charges Code");
                                    RecSalesLine.validate("Shortcut Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                                    RecSalesLine.Validate("Shortcut Dimension 2 Code", TempManifestLine."Global Dimension 2 Code");
                                    RecSalesLine.Validate("Shortcut Dimension 3 Code", TempManifestLine."Shortcut Dimension 3 Code");
                                    RecSalesLine.validate("Shortcut Dimension 4 Code", TempManifestLine."Shortcut Dimension 4 Code");
                                    RecSalesLine.validate("Shortcut Dimension 5 Code", TempManifestLine."Shortcut Dimension 5 Code");
                                    RecSalesLine.validate("Shortcut Dimension 6 Code", TempManifestLine."Shortcut Dimension 6 Code");
                                    RecSalesLine.Validate("Container No./Chassis No.", TempManifestLine."Container/Chassis No.");
                                    RecSalesline.validate("BL No.", TempManifestLine."BL No.");
                                    RecSalesline.validate("Charge ID", ChargeID);
                                    RecSalesline.validate("Position ID", TempManifestLine."Allocated Position");
                                    RecSalesline.validate("Job File No.", TempManifestLine."Job File No.");
                                    RecSalesline.Validate("Job File Date", TempManifestLine."Job File Date");
                                    RecSalesline.validate("No. Of Bags for Billing", TempManifestLine."Remaining Bags");
                                    RecSalesline.Validate(Quantity, 1);
                                    RecSalesline."Auto Calculated" := true;
                                    RecSalesLine.insert;
                                    LineNo1 += 10000;
                                end;
                            until PostedAddReceivingCharges.next = 0;

                        // Additional Receiving Charges

                        // Additional Verification Charges
                        if TempManifestLine."Shortcut Dimension 4 Code" = 'CONTAINER' then begin
                            PostedAddVerificationCharges.Reset();
                            PostedAddVerificationCharges.SetRange("Global Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                            PostedAddVerificationCharges.setfilter("Verification Type", '%1|%2', PostedAddVerificationCharges."Verification Type"::Full, PostedAddVerificationCharges."Verification Type"::Partial);
                            IF PostedAddVerificationCharges.FindFirst() then begin
                                PostedSalesInvLine.reset;
                                PostedSalesInvLine.SetRange("Shortcut Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                                PostedSalesInvLine.SetRange(Type, PostedSalesInvLine.Type::Item);
                                if TempManifestLine."Shortcut Dimension 5 Code" = '20FT' then
                                    PostedSalesInvLine.SetRange("No.", IMSSetup."Charge ID 20FT Verification");
                                if TempManifestLine."Shortcut Dimension 5 Code" = '40FT' then
                                    PostedSalesInvLine.SetRange("No.", IMSSetup."Charge ID 40FT Verification");
                                if not PostedSalesInvLine.FindFirst() then begin
                                    RecSalesLine.Reset();
                                    RecSalesLine.SetRange("Document Type", RecSalesLine."Document Type"::Order);
                                    RecSalesLine.SetRange("Document No.", SalesOrderNo);
                                    IF RecSalesLine.FindLast() then
                                        LineNo1 := RecSalesLine."Line No." + 10000;
                                    RecSalesLine.init;
                                    RecSalesLine."Document Type" := RecSalesLine."Document Type"::Order;
                                    RecSalesLine."Document No." := SalesOrderNo;
                                    RecSalesLine."Line No." := LineNo1;
                                    RecSalesLine.Type := RecSalesLine.Type::Item;
                                    IMSSetup.get();
                                    If TempManifestLine."Shortcut Dimension 5 Code" = '20FT' then
                                        RecSalesLine.validate("No.", IMSSetup."Charge ID 20FT Verification")
                                    else
                                        if TempManifestLine."Shortcut Dimension 5 Code" = '40FT' then
                                            RecSalesLine.validate("No.", IMSSetup."Charge ID 40FT Verification");
                                    RecSalesLine.validate("Shortcut Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                                    RecSalesLine.Validate("Shortcut Dimension 2 Code", TempManifestLine."Global Dimension 2 Code");
                                    RecSalesLine.Validate("Shortcut Dimension 3 Code", TempManifestLine."Shortcut Dimension 3 Code");
                                    RecSalesLine.validate("Shortcut Dimension 4 Code", TempManifestLine."Shortcut Dimension 4 Code");
                                    RecSalesLine.validate("Shortcut Dimension 5 Code", TempManifestLine."Shortcut Dimension 5 Code");
                                    RecSalesLine.validate("Shortcut Dimension 6 Code", TempManifestLine."Shortcut Dimension 6 Code");
                                    RecSalesLine.Validate("Container No./Chassis No.", TempManifestLine."Container/Chassis No.");
                                    RecSalesline.validate("BL No.", TempManifestLine."BL No.");
                                    RecSalesline.validate("Charge ID", ChargeID);
                                    RecSalesline.validate("Position ID", TempManifestLine."Allocated Position");
                                    RecSalesline.validate("Job File No.", TempManifestLine."Job File No.");
                                    RecSalesline.Validate("Job File Date", TempManifestLine."Job File Date");
                                    RecSalesLine.validate("Verification Log No.", PostedAddVerificationCharges."Entry No.");
                                    RecSalesline.validate("No. Of Bags for Billing", TempManifestLine."Remaining Bags");
                                    RecSalesline.Validate(Quantity, 1);
                                    if PostedAddVerificationCharges."Verification Type" = PostedAddVerificationCharges."Verification Type"::"Full" then begin
                                        if TempManifestLine."Shortcut Dimension 5 Code" = '40FT' then
                                            RecSalesLine.Validate("Unit Price", IMSSetup."40FT Full Verification Rate");
                                        If TempManifestLine."Shortcut Dimension 5 Code" = '20FT' then
                                            RecSalesLine.Validate("Unit Price", IMSSetup."20FT Full Verification Rate");
                                    end;
                                    if PostedAddVerificationCharges."Verification Type" = PostedAddVerificationCharges."Verification Type"::Sighting then
                                        RecSalesLine.Validate("Unit Price", IMSSetup."Sighting Verification Rate");
                                    if PostedAddVerificationCharges."Verification Type" = PostedAddVerificationCharges."Verification Type"::Partial then begin
                                        if TempManifestLine."Shortcut Dimension 5 Code" = '40FT' then
                                            RecSalesLine.Validate("Unit Price", IMSSetup."40FT Partial Verification Rate");
                                        If TempManifestLine."Shortcut Dimension 5 Code" = '20FT' then
                                            RecSalesLine.Validate("Unit Price", IMSSetup."Partial Verification Rate");
                                    end;
                                    Desc := RecSalesLine.Description;
                                    RecSalesLine.insert;
                                    RecSalesline."Auto Calculated" := true;
                                    RecSalesLine.Description := Desc + '-' + FORMAT(PostedAddVerificationCharges."Verification Type");
                                    RecSalesLine.Modify();

                                    LineNo1 += 10000;
                                end;
                            end;
                        end;
                        // Additional Verification Charges

                        // Additional Stripping Charges
                        PostedAddStrippingCharges.Reset();
                        PostedAddStrippingCharges.SetRange("Container ID", TempManifestLine."Global Dimension 1 Code");
                        IF PostedAddStrippingCharges.FindFirst() then
                            repeat
                                IMSSetup.get();
                                PostedSalesInvLine.Reset();
                                PostedSalesInvLine.SetRange("Shortcut Dimension 1 Code", PostedAddStrippingCharges."Container ID");
                                PostedSalesInvLine.SetRange(Type, PostedSalesInvLine.Type::Item);
                                PostedSalesInvLine.SetRange("No.", IMSSetup."Charge ID for Stripping");
                                if postedsalesinvline.findfirst then begin
                                    PostedSalesCrLine.Reset();
                                    PostedSalesCrLine.SetRange("Shortcut Dimension 1 Code", PostedAddStrippingCharges."Container ID");
                                    PostedSalesCrLine.SetRange(Type, PostedSalesCrLine.Type::Item);
                                    PostedSalesCrLine.SetRange("No.", PostedSalesInvLine."No.");
                                    if PostedSalesCrLine.findfirst then begin
                                        RecSalesLine.Reset();
                                        RecSalesLine.SetRange("Document Type", RecSalesLine."Document Type"::Order);
                                        RecSalesLine.SetRange("Document No.", SalesOrderNo);
                                        IF RecSalesLine.FindLast() then
                                            LineNo1 := RecSalesLine."Line No." + 10000;
                                        RecSalesLine.init;
                                        RecSalesLine."Document Type" := RecSalesLine."Document Type"::Order;
                                        RecSalesLine."Document No." := SalesOrderNo;
                                        RecSalesLine."Line No." := LineNo1;
                                        RecSalesLine.Type := RecSalesLine.Type::Item;
                                        IMSSetup.get();
                                        RecSalesLine.validate("No.", IMSSetup."Charge ID for Stripping");
                                        RecSalesLine.validate("Shortcut Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                                        RecSalesLine.Validate("Shortcut Dimension 2 Code", TempManifestLine."Global Dimension 2 Code");
                                        RecSalesLine.Validate("Shortcut Dimension 3 Code", TempManifestLine."Shortcut Dimension 3 Code");
                                        RecSalesLine.validate("Shortcut Dimension 4 Code", TempManifestLine."Shortcut Dimension 4 Code");
                                        RecSalesLine.validate("Shortcut Dimension 5 Code", TempManifestLine."Shortcut Dimension 5 Code");
                                        RecSalesLine.validate("Shortcut Dimension 6 Code", TempManifestLine."Shortcut Dimension 6 Code");
                                        RecSalesLine.Validate("Container No./Chassis No.", TempManifestLine."Container/Chassis No.");
                                        RecSalesline.validate("BL No.", TempManifestLine."BL No.");
                                        RecSalesline.validate("Charge ID", ChargeID);
                                        RecSalesline.validate("Position ID", TempManifestLine."Allocated Position");
                                        RecSalesline.validate("Job File No.", TempManifestLine."Job File No.");
                                        RecSalesline.Validate("Job File Date", TempManifestLine."Job File Date");
                                        RecSalesline.validate("No. Of Bags for Billing", TempManifestLine."Remaining Bags");
                                        RecSalesline.Validate(Quantity, 1);
                                        RecSalesLine.Validate("Unit Price", PostedAddStrippingCharges."Stripping Charges");
                                        RecSalesline."Auto Calculated" := true;
                                        RecSalesLine.insert;
                                        LineNo1 += 10000;
                                    end;
                                end else begin
                                    RecSalesLine.Reset();
                                    RecSalesLine.SetRange("Document Type", RecSalesLine."Document Type"::Order);
                                    RecSalesLine.SetRange("Document No.", SalesOrderNo);
                                    IF RecSalesLine.FindLast() then
                                        LineNo1 := RecSalesLine."Line No." + 10000;
                                    RecSalesLine.init;
                                    RecSalesLine."Document Type" := RecSalesLine."Document Type"::Order;
                                    RecSalesLine."Document No." := SalesOrderNo;
                                    RecSalesLine."Line No." := LineNo1;
                                    RecSalesLine.Type := RecSalesLine.Type::Item;
                                    IMSSetup.get();
                                    RecSalesLine.validate("No.", IMSSetup."Charge ID for Stripping");
                                    RecSalesLine.validate("Shortcut Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                                    RecSalesLine.Validate("Shortcut Dimension 2 Code", TempManifestLine."Global Dimension 2 Code");
                                    RecSalesLine.Validate("Shortcut Dimension 3 Code", TempManifestLine."Shortcut Dimension 3 Code");
                                    RecSalesLine.validate("Shortcut Dimension 4 Code", TempManifestLine."Shortcut Dimension 4 Code");
                                    RecSalesLine.validate("Shortcut Dimension 5 Code", TempManifestLine."Shortcut Dimension 5 Code");
                                    RecSalesLine.validate("Shortcut Dimension 6 Code", TempManifestLine."Shortcut Dimension 6 Code");
                                    RecSalesLine.Validate("Container No./Chassis No.", TempManifestLine."Container/Chassis No.");
                                    RecSalesline.validate("BL No.", TempManifestLine."BL No.");
                                    RecSalesline.validate("Charge ID", ChargeID);
                                    RecSalesline.validate("Position ID", TempManifestLine."Allocated Position");
                                    RecSalesline.validate("Job File No.", TempManifestLine."Job File No.");
                                    RecSalesline.Validate("Job File Date", TempManifestLine."Job File Date");
                                    RecSalesline.validate("No. Of Bags for Billing", TempManifestLine."Remaining Bags");
                                    RecSalesline.Validate(Quantity, 1);
                                    RecSalesLine.Validate("Unit Price", PostedAddStrippingCharges."Stripping Charges");
                                    RecSalesline."Auto Calculated" := true;
                                    RecSalesLine.insert;
                                    LineNo1 += 10000;
                                end;
                            until PostedAddStrippingCharges.next = 0;
                        // Additional Stripping Charges

                        //KPA Charges
                        IMSSetup.Get();
                        TempPurchInvLine.Reset();
                        TempPurchInvLine.DeleteAll();

                        PurchInvLine.Reset();
                        PurchInvLine.SetRange(Type, PurchInvLine.Type::Item);
                        PurchInvLine.SetRange("Shortcut Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                        PurchInvLine.Setfilter(Quantity, '<>%1', 0);
                        if PurchInvLine.FindFirst() then
                            repeat
                                TempPurchInvLine.Reset();
                                TempPurchInvLine.SetRange(Type, PurchInvLine.Type::Item);
                                TempPurchInvLine.SetRange("Shortcut Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                                TempPurchInvLine.SetRange("No.", PurchInvLine."No.");
                                if TempPurchInvLine.FindFirst() then begin
                                    TempPurchInvLine.Quantity += PurchInvLine.Quantity;
                                    TempPurchInvLine."Unit Cost" += PurchInvLine."Unit Cost";
                                    TempPurchInvLine.Amount += PurchInvLine.Amount;
                                    TempPurchInvLine."Outstanding Quantity" += PurchInvLine.Quantity;
                                    TempPurchInvLine."Outstanding Amount" += PurchInvLine.Amount;
                                    TempPurchInvLine."Line Amount" += PurchInvLine."Line Amount";
                                    TempPurchInvLine."Line Discount Amount" += TempPurchInvLine."Line Discount Amount";
                                    TempPurchInvLine.Modify();
                                end else begin
                                    l_LineNo += 10000;
                                    TempPurchInvLine.init;
                                    TempPurchInvLine."Document Type" := TempPurchInvLine."Document Type"::Invoice;
                                    TempPurchInvLine."Line No." := l_LineNo;
                                    TempPurchInvLine."Document No." := PurchInvLine."Document No.";
                                    TempPurchInvLine.Type := TempPurchInvLine.Type::Item;
                                    TempPurchInvLine."No." := PurchInvLine."No.";
                                    TempPurchInvLine.Description := PurchInvLine.Description;
                                    TempPurchInvLine.Quantity := PurchInvLine.Quantity;
                                    TempPurchInvLine."Unit Cost" := PurchInvLine."Unit Cost";
                                    TempPurchInvLine."Line Amount" := PurchInvLine."Line Amount";
                                    TempPurchInvLine."Line Discount Amount" := PurchInvLine."Line Discount Amount";
                                    TempPurchInvLine.Amount := PurchInvLine.Amount;
                                    TempPurchInvLine."Shortcut Dimension 1 Code" := PurchInvLine."Shortcut Dimension 1 Code";
                                    TempPurchInvLine."Shortcut Dimension 2 Code" := PurchInvLine."Shortcut Dimension 2 Code";
                                    TempPurchInvLine."Outstanding Quantity" := PurchInvLine.Quantity;
                                    TempPurchInvLine."Outstanding Amount" := PurchInvLine.Amount;
                                    TempPurchInvLine.Insert();
                                end;
                            until PurchInvLine.Next() = 0;
                        PurchCrLine.Reset();
                        PurchCrLine.SetRange("Shortcut Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                        PurchCrLine.SetRange(Type, PurchCrLine.Type::Item);
                        PurchCrLine.SetFilter(Quantity, '<>%1', 0);
                        if PurchCrLine.FindSet() then
                            repeat
                                TempPurchInvLine.Reset();
                                TempPurchInvLine.SetRange("No.", PurchCrLine."No.");
                                TempPurchInvLine.SetRange("Shortcut Dimension 1 Code", PurchCrLine."Shortcut Dimension 1 Code");
                                if TempPurchInvLine.FindSet() then begin
                                    TempPurchInvLine.Quantity -= PurchCrLine.Quantity;
                                    TempPurchInvLine."Unit Cost" -= PurchCrLine."Unit Cost";
                                    TempPurchInvLine.Modify();
                                end;
                            until PurchCrLine.Next() = 0;
                        TempPurchInvLine.Reset();
                        TempPurchInvLine.Setfilter(Quantity, '<>%1', 0);
                        if TempPurchInvLine.FindSet() then
                            repeat
                                if (TempPurchInvLine.Quantity < TempPurchInvLine."Outstanding Quantity") or (TempPurchInvLine.Quantity = TempPurchInvLine."Outstanding Quantity") then begin
                                    PostedSalesInvLine.Reset();
                                    PostedSalesInvLine.SetRange("Shortcut Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                                    PostedSalesInvLine.SetRange(type, PostedSalesInvLine.Type::Item);
                                    PostedSalesInvLine.SetRange("No.", TempPurchInvLine."No.");
                                    if not PostedSalesInvLine.FindFirst() then begin
                                        RecSalesLine2.Reset();
                                        RecSalesLine2.SetRange("Document Type", RecSalesLine2."Document Type"::Order);
                                        RecSalesLine2.SetRange("Document No.", SalesOrderNo);
                                        IF RecSalesLine2.FindLast() then
                                            LineNo2 := RecSalesLine2."Line No." + 10000
                                        else
                                            LineNo2 := 10000;
                                        IMSSetup.Get();
                                        RecItem.Reset();
                                        if CompanyName = 'MICT' then
                                            RecItem.SetFilter("Item Category Code", '%1|%2', IMSSetup."Category Code for Transport", IMSSetup."Category Code for Rebate")
                                        else
                                            RecItem.SetRange("Item Category Code", IMSSetup."Category Code for Transport");
                                        RecItem.SetRange("No.", TempPurchInvLine."No.");
                                        if not RecItem.Findset() then begin
                                            RecSalesLine.Reset();
                                            RecSalesLine.SetRange("Shortcut Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                                            RecSalesLine.SetRange("Document Type", RecSalesLine."Document Type"::Order);
                                            RecSalesLine.SetRange("Document No.", SalesOrderNo);
                                            RecSalesLine.SetRange("No.", TempPurchInvLine."No.");
                                            IF not RecSalesLine.Findset() then begin
                                                TempSalesLine.init;
                                                TempSalesLine."Document Type" := TempSalesLine."Document Type"::Order;
                                                TempSalesLine."Document No." := SalesOrderNo;
                                                TempSalesLine."Line No." := LineNo2;
                                                TempSalesLine.Type := TempSalesLine.Type::Item;
                                                IMSSetup.get();
                                                TempSalesLine.validate("No.", TempPurchInvLine."No.");
                                                TempSalesLine.validate(Description, TempPurchInvLine.Description + '-KPA');
                                                TempSalesLine.validate("Shortcut Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                                                TempSalesLine.Validate("Shortcut Dimension 2 Code", TempManifestLine."Global Dimension 2 Code");
                                                TempSalesLine.Validate("Shortcut Dimension 3 Code", TempManifestLine."Shortcut Dimension 3 Code");
                                                TempSalesLine.validate("Shortcut Dimension 4 Code", TempManifestLine."Shortcut Dimension 4 Code");
                                                TempSalesLine.validate("Shortcut Dimension 5 Code", TempManifestLine."Shortcut Dimension 5 Code");
                                                TempSalesLine.validate("Shortcut Dimension 6 Code", TempManifestLine."Shortcut Dimension 6 Code");
                                                TempSalesLine.Validate("Container No./Chassis No.", TempManifestLine."Container/Chassis No.");
                                                TempSalesline.validate("Clearing Agent", TempManifestLine."Clearing Agent");
                                                TempSalesline.validate("Clearing Agent Name", GetClearingAgentName(TempManifestLine."Clearing Agent"));
                                                TempSalesLine.validate("BL No.", TempManifestLine."BL No.");
                                                TempSalesLine.validate("Charge ID", ChargeID);
                                                TempSalesLine.validate("Position ID", TempManifestLine."Allocated Position");
                                                TempSalesLine.validate("Job File No.", TempManifestLine."Job File No.");
                                                TempSalesLine.Validate("Job File Date", TempManifestLine."Job File Date");
                                                TempSalesLine.Validate(Quantity, 1);
                                                TempSalesLine.Validate("Unit Price", TempPurchInvLine."Unit Cost");
                                                TempSalesline."Auto Calculated" := true;
                                                TempSalesLine.insert;
                                            end;
                                        end;

                                        LineNo2 += 10000;
                                    end else begin
                                        //if sales invoice KPA reversed
                                        PostedCrMemoLine.Reset();
                                        PostedCrMemoLine.SetRange("Shortcut Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                                        PostedCrMemoLine.SetRange(type, PostedCrMemoLine.Type::Item);
                                        PostedCrMemoLine.SetRange("No.", TempPurchInvLine."No.");
                                        if PostedCrMemoLine.FindFirst() then begin
                                            RecSalesLine2.Reset();
                                            RecSalesLine2.SetRange("Document Type", RecSalesLine2."Document Type"::Order);
                                            RecSalesLine2.SetRange("Document No.", SalesOrderNo);
                                            IF RecSalesLine2.FindLast() then
                                                LineNo2 := RecSalesLine2."Line No." + 10000
                                            else
                                                LineNo2 := 10000;
                                            IMSSetup.Get();
                                            RecItem.Reset();
                                            RecItem.SetRange("Item Category Code", IMSSetup."Category Code for Transport");
                                            RecItem.SetRange("No.", TempPurchInvLine."No.");
                                            if not RecItem.Findset() then begin
                                                RecSalesLine.Reset();
                                                RecSalesLine.SetRange("Shortcut Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                                                RecSalesLine.SetRange("Document Type", RecSalesLine."Document Type"::Order);
                                                RecSalesLine.SetRange("Document No.", SalesOrderNo);
                                                RecSalesLine.SetRange("No.", TempPurchInvLine."No.");
                                                IF not RecSalesLine.Findset() then begin
                                                    TempSalesLine.init;
                                                    TempSalesLine."Document Type" := TempSalesLine."Document Type"::Order;
                                                    TempSalesLine."Document No." := SalesOrderNo;
                                                    TempSalesLine."Line No." := LineNo2;
                                                    TempSalesLine.Type := TempSalesLine.Type::Item;
                                                    IMSSetup.get();
                                                    TempSalesLine.validate("No.", TempPurchInvLine."No.");
                                                    TempSalesLine.validate(Description, TempPurchInvLine.Description + '-KPA');
                                                    TempSalesLine.validate("Shortcut Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                                                    TempSalesLine.Validate("Shortcut Dimension 2 Code", TempManifestLine."Global Dimension 2 Code");
                                                    TempSalesLine.Validate("Shortcut Dimension 3 Code", TempManifestLine."Shortcut Dimension 3 Code");
                                                    TempSalesLine.validate("Shortcut Dimension 4 Code", TempManifestLine."Shortcut Dimension 4 Code");
                                                    TempSalesLine.validate("Shortcut Dimension 5 Code", TempManifestLine."Shortcut Dimension 5 Code");
                                                    TempSalesLine.validate("Shortcut Dimension 6 Code", TempManifestLine."Shortcut Dimension 6 Code");
                                                    TempSalesLine.Validate("Container No./Chassis No.", TempManifestLine."Container/Chassis No.");
                                                    TempSalesline.validate("Clearing Agent", TempManifestLine."Clearing Agent");
                                                    TempSalesline.validate("Clearing Agent Name", GetClearingAgentName(TempManifestLine."Clearing Agent"));
                                                    TempSalesLine.validate("BL No.", TempManifestLine."BL No.");
                                                    TempSalesLine.validate("Charge ID", ChargeID);
                                                    TempSalesLine.validate("Position ID", TempManifestLine."Allocated Position");
                                                    TempSalesLine.validate("Job File No.", TempManifestLine."Job File No.");
                                                    TempSalesLine.Validate("Job File Date", TempManifestLine."Job File Date");
                                                    TempSalesLine.Validate(Quantity, 1);
                                                    TempSalesLine.Validate("Unit Price", TempPurchInvLine."Unit Cost");
                                                    TempSalesline."Auto Calculated" := true;
                                                    TempSalesLine.insert;
                                                end;
                                            end;
                                            LineNo2 += 10000;
                                        end;
                                    end;
                                end;
                            until TempPurchInvLine.Next() = 0;
                        //KPA Charges
                        AlreadyInvoiced := false;
                    end;
                until TempManifestLine.NEXT = 0;
            message(SuccessMessage);
            RecSalesLine.Reset();
            CurrPage.UPDATE(false);
        END;
    end;

    procedure GetChargeID(var
                              MFL: Record "Manifest Line";
                              NewCustNo: Code[20]) returnvalue: code[20]
    var
        ChargeIDAssRec: Record "Charge ID Assignment";
    begin
        ChargeIDAssRec.reset();
        ChargeIDAssRec.SetRange("Customer No.", NewCustNo);
        ChargeIDAssRec.SetRange("Global Dimension 2 Code", MFL."Global Dimension 2 Code");
        ChargeIDAssRec.SetRange(ChargeIDAssRec."Unit Type Container type/Vehic", MFL."Container Type");
        ChargeIDAssRec.SetRange(ChargeIDAssRec."Shortcut Dimension 5 Code", MFL."Shortcut Dimension 5 Code");
        ChargeIDAssRec.SetRange(ChargeIDAssRec."Clearing Agent Code", MFL."Clearing Agent");
        ChargeIDAssRec.SetRange("Destination Local or Transit", MFL."Destination Type");
        ChargeIDAssRec.SetFilter("Effective From Date", '<=%1', MFL."Date Received");
        ChargeIDAssRec.SetFilter("Effective To Date", '>=%1', MFL."Date Received");
        IF ChargeIDAssRec.FindFirst() then begin
            ChargeIDAssRec.CalcFields(Status);
            if (ChargeIDAssRec.Status <> ChargeIDAssRec.Status::Released) or (ChargeIDAssRec."Assignment Status" <> ChargeIDAssRec."Assignment Status"::Released) then
                Error('Charge Group: %1 Approval Status is %2. \ Charge ID Assignment Approval Status is %3. \ for Container ID: %4. Please contact Group Audit.', ChargeIDAssRec."Charge Id Group Code", ChargeIDAssRec.Status, chargeidassrec."Assignment Status", MFL."Container/Chassis No.")
            else
                exit(ChargeIDAssRec."Charge Id Group Code");
        end
        else
            error('Charge Group or Charge ID Assignment does not exist with the mentioned specifications for Container  %1. \ Please check Charge ID assignment and try again', mfl."Container/Chassis No.");
    end;

    procedure GetReeferHours(var MFL: Record "Manifest Line") LStorageHours: Decimal
    var
        StartDateTime, EndDateTime : Datetime;
        StorageHours: Duration;
    begin
        StartDateTime := CREATEDATETIME(MFL."Landing Date", MFL."Landing Time");
        EndDateTime := CREATEDATETIME(SalesHead."Posting Date", SalesHead."Reefer Hours Upto");
        StorageHours := EndDateTime - StartDateTime;
        LStorageHours := ROUND(StorageHours / 3600000, 0.01, '>');
        IF LStorageHours <> 0 then
            exit(LStorageHours)
        else
            exit(0);
    end;

    procedure GetSalesOrderNo(var NewSalesHeadNo: Code[20]; NewCustNo: Code[20])
    begin
        SalesOrderNo := NewSalesHeadNo;
        CustNo := NewCustNo;
    end;

    procedure NoBagsEdit()
    begin
        IF Rec."Shortcut Dimension 4 Code" = 'LOOSE' then
            NoBagsEditable := true
        else
            NoBagsEditable := false;
    end;

    procedure GetClearingAgentName(Clearingagent: Code[20]) ClearingAgentName: text[100]
    var
        myInt: Integer;
        ClearingAgentRec: Record "Clearing Agent";
    begin
        if ClearingAgentRec.get(Clearingagent) then
            ClearingAgentName := ClearingAgentRec."Clearing Agent Name"
        else
            ClearingAgentName := '';
    end;

    var
        myInt: Integer;
        NoBagsEditable: Boolean;
        SalesOrderNo: Code[20];
        CustNo: Code[20];
        //ManifestLine: Record "Manifest Line";
        SalesHead: Record "Sales Header";
        SOPostingDate: Date;
        TempManifestLine: Record "Manifest Line" temporary;
        Desc: Text[200];
}
