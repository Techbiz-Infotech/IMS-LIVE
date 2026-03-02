tableextension 50105 "Sales Header Ext" extends "Sales Header"
{
    fields
    {
        field(50100; "BL No."; Code[20])
        {
            Caption = 'BL No.';
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        field(50101; "Job File No."; Code[20])
        {
            Caption = 'Job File No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        // field(50102; "Client Type"; Enum ManifestClientTypeEnum)
        // {
        //     Caption = 'Client Type';
        //     DataClassification = ToBeClassified;
        //     Editable = false;
        // }
        field(50102; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }
        field(50103; "Container No./Chassis No."; Code[20])
        {
            Caption = 'Container No./Chassis No.';
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(50104; "Charge ID"; Code[20])
        {
            Caption = 'Charge ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50105; "Job File Date"; Date)
        {
            Caption = 'Job File Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50106; "Container Type"; Enum ContainerTypeEnum)
        {
            Caption = 'Container Type';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50107; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }
        field(50108; "Destination Type"; Enum DestinationTypeEnum)
        {
            Caption = 'Destination Type';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50109; "Storage Days"; Integer)
        {
            Caption = 'Storage Days';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50110; "Position ID"; Code[20])
        {
            Caption = 'Position ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50111; Closed; Boolean)
        {
            Caption = 'Closed';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50112; "Reefer Hours Upto"; time)
        {
            Caption = 'Reefer Hours Upto';
            DataClassification = ToBeClassified;
        }
        field(50113; "Clearing Agent"; Code[20])
        {
            Caption = 'Clearing Agent';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Line"."Clearing Agent" where("Document Type" = Field("Document Type"), "Document No." = Field("No.")));
        }
        field(50114; "Clearing Agent Name"; Text[100])
        {
            Caption = 'Clearing Agent Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Line"."Clearing Agent Name" where("Document Type" = Field("Document Type"), "Document No." = Field("No.")));
        }
        field(50115; "Proforma No."; Code[20])
        {
            Caption = 'Proforma No.';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50116; "Credit Note Reason Type"; Enum CreditNoteReasonTypeEnum)
        {
            Caption = 'Credit Note Reason Type';
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50117; Expired; Boolean)
        {
            Caption = 'Expired';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50118; "Expired Date"; Date)
        {
            Caption = 'Expired Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50119; "Expired Time"; Time)
        {
            Caption = 'Expired Time';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50120; "Created By User ID"; Code[50])
        {
            Caption = 'Created By User ID';
            Editable = false;
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(50123; Warehouse; Boolean)
        {
            Caption = 'Warehouse';
            dataclassification = ToBeClassified;
        }
    }
    trigger OnAfterInsert()
    var
    begin
        if Rec."Document Type" = Rec."Document Type"::Order then
            Rec."Proforma No." := Rec."No.";
    end;

    trigger OnInsert()
    var
        myInt: Integer;
    begin
        "Created By User ID" := UserId;
    end;

    procedure GetManifestDetails()
    var
        ManifestRec: Record "Manifest Line";
        SalesHead: Record "Sales Header";
        DimValRec: Record "Dimension Value";
    begin
        ManifestRec.Reset();
        ManifestRec.SetRange("BL No.", rec."BL No.");
        if ManifestRec.FindFirst() then begin
            rec."BL No." := ManifestRec."BL No.";
            rec."Job File No." := ManifestRec."Job File No.";
            rec."Job File Date" := ManifestRec."Job File Date";
            rec.Modify();
        end else begin
            rec."BL No." := '';
            rec."Job File No." := '';
            rec."Job File Date" := 0D;
            rec.Modify();
        end;
    end;

    procedure GetChargeID()
    var
        ChargeIDAssRec: Record "Charge ID Assignment";

    begin
        ChargeIDAssRec.reset();
        ChargeIDAssRec.SetRange("Customer No.", rec."Sell-to Customer No.");
        ChargeIDAssRec.SetRange("Global Dimension 2 Code", rec."Shortcut Dimension 2 Code");
        ChargeIDAssRec.SetRange(ChargeIDAssRec."Unit Type Container type/Vehic", Rec."Container Type");
        ChargeIDAssRec.SetRange(ChargeIDAssRec."Shortcut Dimension 5 Code", Rec."Shortcut Dimension 5 Code");
        ChargeIDAssRec.SetRange("Destination Local or Transit", Rec."Destination Type");
        IF ChargeIDAssRec.FindFirst() then begin
            rec.Validate("Charge ID", ChargeIDAssRec."Charge Id Group Code");
        end;
    end;

    // procedure CalculateStorageCharges()
    // var
    //     //ManifestHead: Record "Manifest Header";
    //     ManifestLine: Record "Manifest Line";
    //     ReceivingLog: Record ReceivingLog;
    //     Salesline: Record "Sales Line";
    //     StorageDays: Integer;
    //     ReceivedDate: Date;
    //     ChargeAmount: Decimal;
    //     ChargableStorageDays: Integer;
    //     RemainingFirstDays: Integer;
    //     RemainingSecondDays: Integer;
    //     RemainingThirdDays: Integer;
    //     RemainingFourthDays: Integer;
    //     FirstIntervalAmount: Decimal;
    //     SecondIntervalAmount: Decimal;
    //     ThirdIntervalAmount: Decimal;
    //     FourthIntervalAmount: Decimal;
    //     TotalBasechargeAmount: Decimal;
    // begin
    //     ChargeGroupHead.Reset();
    //     ChargeGroupHead.SetRange("Charge ID Group Code", "Charge ID");
    //     IF ChargeGroupHead.FindFirst() then begin
    //         ManifestLine.Reset();
    //         ManifestLine.SetRange("Job File No.", rec."Job File No.");
    //         //ManifestLine.SetRange("Global Dimension 1 Code", rec."Shortcut Dimension 1 Code");//need tp ask sir
    //         IF ManifestLine.FindFirst() then begin
    //             if ChargeGroupHead."Base On" = ChargeGroupHead."Base On"::"Received Date" then begin
    //                 ReceivingLog.Reset();
    //                 ReceivingLog.SetRange("Global Dimension 1 Code", rec."Shortcut Dimension 1 Code");
    //                 IF ReceivingLog.FindFirst() then begin
    //                     ReceivedDate := ReceivingLog."Received Date";
    //                     StorageDays := TODAY - ReceivedDate;
    //                 end;
    //             end;
    //             IF ChargeGroupHead."Base On" = ChargeGroupHead."Base On"::"ETA Date" then
    //                 StorageDays := TODAY - ManifestLine."Expected Arrival Date";
    //             IF ChargeGroupHead."Base On" = ChargeGroupHead."Base On"::"Last Sling Date" then
    //                 StorageDays := TODAY - ManifestLine."Last Sling Date";
    //             IF ChargeGroupHead."Base On" = ChargeGroupHead."Base On"::ActualDate then
    //                 StorageDays := today - ManifestLine."Vessel Arrival Date";
    //         end;

    //         ChargeGroupLine.Reset();
    //         ChargeGroupLine.SetRange("Charge ID Group Code", ChargeGroupHead."Charge ID Group Code");
    //         ChargeGroupLine.SetRange("Active/In-Active", ChargeGroupLine."Active/In-Active"::Active);
    //         IF ChargeGroupLine.FindFirst() then begin
    //             Salesline.Reset();
    //             Salesline.SetRange("Document Type", rec."Document Type"::Order);
    //             Salesline.SetRange("Document No.", rec."No.");
    //             IF Salesline.FindSet() then begin
    //                 IF Confirm('Do you want to delete the existing lines?', true) then
    //                     Salesline.DeleteAll()
    //                 else
    //                     exit;
    //             end;
    //             repeat
    //                 Clear(ChargeAmount);
    //                 clear(ChargableStorageDays);
    //                 Clear(RemainingFirstDays);
    //                 Clear(RemainingSecondDays);
    //                 Clear(RemainingThirdDays);
    //                 Clear(RemainingFourthDays);
    //                 Clear(FirstIntervalAmount);
    //                 Clear(SecondIntervalAmount);
    //                 Clear(ThirdIntervalAmount);
    //                 Clear(FourthIntervalAmount);
    //                 Clear(TotalBasechargeAmount);

    //                 Salesline.Init;
    //                 Salesline.validate("Document Type", Salesline."Document Type"::Order);
    //                 Salesline.VAlidate("Document No.", rec."No.");
    //                 Salesline.Validate("Line No.", ChargeGroupLine."Line No.");
    //                 Salesline.Insert;
    //                 Salesline.validate(Type, Salesline.Type::Item);
    //                 Salesline.Validate("No.", ChargeGroupLine.Charge);
    //                 Salesline.Description := ChargeGroupLine."Charge Description ";
    //                 Salesline.Validate(Quantity, 1);
    //                 IF ChargeGroupLine."Free Days" <> 0 then begin
    //                     ChargableStorageDays := StorageDays - ChargeGroupLine."Free Days";
    //                 end else begin
    //                     ChargableStorageDays := StorageDays;
    //                 end;
    //                 "Storage Days" := ChargableStorageDays;

    //                 IF ChargableStorageDays <> 0 then begin
    //                     IF ChargableStorageDays > ChargeGroupHead."First Bracket" then
    //                         RemainingFirstDays := ChargableStorageDays - ChargeGroupHead."First Bracket";

    //                     IF (RemainingFirstDays > 0) then
    //                         RemainingSecondDays := RemainingFirstDays - ChargeGroupHead."Second Bracket";
    //                     if RemainingSecondDays > 0 then
    //                         RemainingThirdDays := RemainingSecondDays - ChargeGroupHead."Third Bracket";
    //                 end;
    //                 IF ChargableStorageDays <> 0 THEN begin
    //                     IF ChargableStorageDays > ChargeGroupHead."First Bracket" then
    //                         FirstIntervalAmount := ChargeGroupHead."First Bracket" * ChargeGroupLine."First Interval"
    //                     else
    //                         FirstIntervalAmount := ChargableStorageDays * ChargeGroupLine."First Interval";

    //                     IF RemainingFirstDays <> 0 THEN begin
    //                         IF RemainingFirstDays > ChargeGroupHead."Second Bracket" then
    //                             SecondIntervalAmount := ChargeGroupHead."Second Bracket" * ChargeGroupLine."Second Interval"
    //                         else
    //                             SecondIntervalAmount := RemainingFirstDays * ChargeGroupLine."Second Interval";
    //                     end;

    //                     IF RemainingSecondDays <> 0 THEN begin
    //                         if RemainingSecondDays > ChargeGroupHead."Third Bracket" then
    //                             ThirdIntervalAmount := ChargeGroupHead."Third Bracket" * ChargeGroupLine."Third Interval"
    //                         else
    //                             ThirdIntervalAmount := RemainingSecondDays * ChargeGroupLine."Third Interval";
    //                     end;

    //                     FourthIntervalAmount := RemainingThirdDays * ChargeGroupLine.HenceForth;
    //                 end;

    //                 TotalBasechargeAmount := FirstIntervalAmount + SecondIntervalAmount + ThirdIntervalAmount + FourthIntervalAmount;

    //                 IF (ChargeGroupLine."Based On CBM/ Weight" = false) AND (ChargeGroupLine."Rely On Storage" = false) then
    //                     ChargeAmount := ChargeGroupLine."First Interval";

    //                 IF (ChargeGroupLine."Based On CBM/ Weight" = true) AND (ChargeGroupLine."Rely On Storage" = true) then begin
    //                     ManifestLine.Reset();
    //                     ManifestLine.SetRange("Job File No.", rec."Job File No.");
    //                     ManifestLine.SetRange("Global Dimension 1 Code", rec."Shortcut Dimension 1 Code");
    //                     if ManifestLine.FindFirst() then
    //                         ChargeAmount := TotalBasechargeAmount * ManifestLine."CBM-Wt Difference";
    //                 end;

    //                 IF (ChargeGroupLine."Based On CBM/ Weight" = true) AND (ChargeGroupLine."Rely On Storage" = false) then begin
    //                     ManifestLine.Reset();
    //                     ManifestLine.SetRange("Job File No.", rec."Job File No.");
    //                     ManifestLine.SetRange("Global Dimension 1 Code", rec."Shortcut Dimension 1 Code");
    //                     if ManifestLine.FindFirst() then
    //                         ChargeAmount := ChargeGroupLine."First Interval" * ManifestLine."CBM-Wt Difference";
    //                 end;

    //                 IF (ChargeGroupLine."Based On CBM/ Weight" = false) AND (ChargeGroupLine."Rely On Storage" = true) then
    //                     ChargeAmount := TotalBasechargeAmount;
    //                 Salesline.Validate("Unit Price", ChargeAmount);
    //                 Salesline.Modify();
    //             until ChargeGroupLine.Next() = 0;
    //         end;
    //     end;
    // end;        we are not using this function



    var
        ChargeGroupHead: Record "Charge ID Group Header";
        ChargeGroupLine: Record "Charge ID Group Line";
}