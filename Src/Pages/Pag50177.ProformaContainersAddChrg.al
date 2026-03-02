page 50177 ProformaContainersAddChrg
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
                field("Remaining Bags"; Rec."Remaining Bags")
                {
                    ApplicationArea = All;
                    Editable = NoBagsEditable;
                }
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
        ChargeGroupLine2, ChargeGroupLine : Record "Charge ID Group Line";
        PostedAddReceivingCharges: Record "Posted Add. Charges receiving";
        PostedAddVerificationCharges: Record "Posted AddCharges Verification";
        PostedAddStrippingCharges: Record "Posted AddCharges Stripping";
        IMSSetup: Record "IMS Setup";
        ChargeID: Code[20];
        RecItem: Record Item;
        //ManifestHead: Record "Manifest Header";
        TestManifestLine, ManifestLine : Record "Manifest Line";
        ReceivingLog: Record ReceivingLog;
        RecSalesLine, Salesline : Record "Sales Line";
        TempSalesline: Record "Sales Line";
        PurchInvHead: Record "Purch. Inv. Header";
        PurchInvLine: Record "Purch. Inv. Line";
        PurchCrHead: Record "Purch. Cr. Memo Hdr.";
        PurchCrLine: Record "Purch. Cr. Memo Line";
        LineNo2, LineNo1, StorageDays, EntryNo : Integer;
        StorageStartDate, AfterBaseOnDate : Date;
        ChargeAmount: Decimal;
        Invoiced: Boolean;
        SalesInvHead: Record "Sales Invoice Header";
        SalesInvLine: Record "Sales Invoice Line";
        SalesCrHead: Record "Sales Cr.Memo Header";
        SalesCrLine: Record "Sales Cr.Memo Line";
        InvoicedStorageDays, CrStorageDays, IChargableStorageDays, ChargableStorageDays : Integer;
        RemainingFirstDays, RemainingSecondDays, RemainingThirdDays, RemainingFourthDays : Integer;
        FirstIntervalAmount, SecondIntervalAmount, ThirdIntervalAmount, FourthIntervalAmount, TotalBasechargeAmount : Decimal;
        InvoicedStorageAmount, CreditMemoStorageAmount, AdditionalChargesAmt : Decimal;
        SuccessMessage: TextConst ENU = 'Calculated Successfully';
    begin
        IF CloseAction IN [ACTION::OK, ACTION::LookupOK] THEN BEGIN
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
                    ChargeID := GetChargeID(TempManifestLine, CustNo);
                    ChargeGroupHead.Reset();
                    ChargeGroupHead.SetRange("Charge ID Group Code", ChargeID);
                    IF ChargeGroupHead.FindFirst() then begin
                        // ManifestHead.Reset();
                        // ManifestHead.SetRange("Job File No.", TempManifestLine."Job File No.");
                        // IF ManifestHead.FindFirst() then begin
                        if ChargeGroupHead."Base On" = ChargeGroupHead."Base On"::"Received Date" then begin
                            // TestManifestLine.Reset();
                            // TestManifestLine.SetRange("Global Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                            // IF TestManifestLine.FindFirst() then begin
                            StorageStartDate := TempManifestLine."Date Received"
                            //end;
                        end;
                        IF ChargeGroupHead."Base On" = ChargeGroupHead."Base On"::"ETA Date" then
                            StorageStartDate := TempManifestLine."Expected Arrival Date";
                        IF ChargeGroupHead."Base On" = ChargeGroupHead."Base On"::"Last Sling Date" then
                            StorageStartDate := TempManifestLine."Last Sling Date";
                        IF ChargeGroupHead."Base On" = ChargeGroupHead."Base On"::ActualDate then
                            StorageStartDate := TempManifestLine."Vessel Arrival Date";
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
                            StorageDays := SOPostingDate - AfterBaseOnDate;


                        ChargeGroupLine2.Reset();
                        ChargeGroupLine2.SetRange("Charge ID Group Code", ChargeGroupHead."Charge ID Group Code");
                        ChargeGroupLine2.SetRange("Active/In-Active", ChargeGroupLine2."Active/In-Active"::Active);
                        ChargeGroupLine2.SetRange("Calculate if Storage Days", true);
                        IF ChargeGroupLine2.FindFirst() then begin
                            repeat
                                Invoiced := False;
                                SalesInvLine.Reset();
                                SalesInvLine.SetRange("Shortcut Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                                SalesInvLine.SetRange("No.", ChargeGroupLine2.Charge);
                                if SalesInvLine.FindFirst() then
                                    Invoiced := true;

                                IMSSetup.Get();
                                ChargeGroupLine.Reset();
                                ChargeGroupLine.SetRange("Charge ID Group Code", ChargeGroupLine2."Charge ID Group Code");
                                ChargeGroupLine.SetRange("Line No.", ChargeGroupLine2."Line No.");
                                ChargeGroupLine.CalcFields("Charge Category");
                                if Invoiced then
                                    ChargeGroupLine.SetRange("Charge Category", IMSSetup."Category Code for Storage");

                                // if StorageDays < ChargeGroupLine2."Free Days" then
                                //     ChargeGroupLine.SetRange("Calculate if Storage Days", false);
                                IF ChargeGroupLine.FindFirst() then begin
                                    Salesline.Reset();
                                    Salesline.SetRange("Document Type", Salesline."Document Type"::Order);
                                    Salesline.SetRange("Document No.", SalesOrderNo);
                                    IF Salesline.Findlast() then
                                        EntryNo := Salesline."Line No." + 10000
                                    else
                                        EntryNo := 10000;
                                    if StorageDays < ChargeGroupLine."Free Days" then
                                        Error('Free Days are more than storage Days');
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
                                        clear(InvoicedStorageAmount);
                                        Clear(CreditMemoStorageAmount);
                                        //Billed Sales Invoice
                                        Clear(InvoicedStorageDays);
                                        SalesInvLine.Reset();
                                        SalesInvLine.SetRange("Shortcut Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                                        SalesInvLine.SetRange("No.", ChargeGroupLine.Charge);
                                        if SalesInvLine.FindFirst() then begin
                                            repeat
                                                InvoicedStorageDays += SalesInvLine."Chargable Storage Days";
                                                InvoicedStorageAmount += SalesInvLine."Line Amount";
                                            until SalesInvLine.Next() = 0;
                                        end;
                                        //Billed Sales Credit memos
                                        Clear(CrStorageDays);
                                        SalesCrLine.Reset();
                                        SalesCrLine.SetRange("Shortcut Dimension 1 Code", TempManifestLine."Global Dimension 1 Code");
                                        SalesCrLine.SetRange("No.", ChargeGroupLine.Charge);
                                        if SalesCrLine.FindFirst() then begin
                                            repeat
                                                CrStorageDays += SalesCrLine."Chargable Storage Days";
                                                CreditMemoStorageAmount += SalesCrLine."Line Amount";
                                            until SalesCrLine.Next() = 0;
                                        end;


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
                                        Salesline.Validate(Quantity, 1);
                                        Salesline."Storage Days" := StorageDays;
                                        IF ChargeGroupLine."Free Days" <> 0 then begin
                                            ChargableStorageDays := StorageDays - ChargeGroupLine."Free Days";
                                            Salesline."Storage Start Date" := CalcDate(FORMAT(ChargeGroupLine."Free Days") + 'D', AfterBaseOnDate);
                                            IChargableStorageDays := StorageDays - ChargeGroupLine."Free Days";
                                            Salesline."Chargable Storage Days" := ChargableStorageDays;
                                            //end else begin
                                            //ChargableStorageDays := StorageDays;
                                            //Salesline."Storage Start Date" := AfterBaseOnDate;
                                        end;
                                        Salesline."Free Days" := ChargeGroupLine."Free Days";
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
                                        AdditionalChargesAmt := ChargeAmount - InvoicedStorageAmount + CreditMemoStorageAmount;
                                        Salesline.Validate("Unit Price", AdditionalChargesAmt);
                                        Salesline.Modify();
                                        EntryNo += 10000;
                                    until ChargeGroupLine.Next() = 0;
                                end;
                            until ChargeGroupLine2.Next() = 0;
                        end;
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
        ChargeIDAssRec.SetRange("Destination Local or Transit", MFL."Destination Type");
        IF ChargeIDAssRec.FindFirst() then
            exit(ChargeIDAssRec."Charge Id Group Code");

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
        ManifestLine: Record "Manifest Line";
        SalesHead: Record "Sales Header";
        SOPostingDate: Date;
        TempManifestLine: Record "Manifest Line" temporary;
}
