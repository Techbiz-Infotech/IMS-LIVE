table 50113 "Posted Gate Pass out Line"
{
    Caption = ' Posted Gate Pass Out Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Gate Pass No."; Code[20])
        {
            Caption = 'Gate Pass No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Invoice No."; Code[20])
        {
            Caption = 'Invoice No.';
            DataClassification = ToBeClassified;
            TableRelation = "Sales Invoice Header";

        }

        field(4; "Invoice Date"; Date)
        {
            Caption = 'Invoice Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Receipt No."; Code[20])
        {
            Caption = 'Receipt No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Container /Chasis No."; Code[20])
        {
            Caption = 'Container /Chasis No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Gate Pass Status"; Enum "Active/In-Active Enum")
        {
            Caption = 'Gate Pass Status';
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        field(8; "No. Of Bags"; Decimal)
        {
            Caption = 'No. Of Bags';
            DataClassification = ToBeClassified;
        }
        field(9; "Truck No."; Code[20])
        {
            Caption = 'Truck No.';
            DataClassification = ToBeClassified;
        }
        field(10; "Agent Name"; Text[20])
        {
            Caption = 'Agent Name';
            DataClassification = ToBeClassified;
        }
        field(11; "Agent Port Pass"; Code[20])
        {
            Caption = 'Agent Port Pass';
            DataClassification = ToBeClassified;
        }
        field(12; "Tranporter/Driver Name"; Text[40])
        {
            Caption = 'Tranporter/Driver Name';
            DataClassification = ToBeClassified;
        }
        field(13; Remarks; Text[50])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(14; "Trailer No."; Code[20])
        {
            Caption = 'Trailer No.';
            DataClassification = ToBeClassified;
        }
        field(15; "Position ID"; code[20])
        {
            Caption = 'Position ID';
            DataClassification = ToBeClassified;
            TableRelation = Position." Position ID" where(Status = const(Allocated));
            Editable = false;
        }
        field(16; "No.Series"; code[20])
        {
            Caption = 'No.Series';
            DataClassification = ToBeClassified;
        }
        field(17; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            Editable = false;
        }
        field(18; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            //Editable = false;
        }
        field(19; "Global Dimension 1 Filter"; Code[20])
        {
            Caption = 'Global Dimension 1 Filter';

            FieldClass = FlowFilter;
            CaptionClass = '1,3,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(20; "Global Dimension 2 Filter"; Code[20])
        {
            Caption = 'Global Dimension 1 Filter';

            FieldClass = FlowFilter;
            CaptionClass = '1,3,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(21; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(22; "Consignee No."; Code[20])
        {
            Caption = 'Consignee No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer;
            Editable = false;
        }
        field(23; "Consignee Name"; Text[100])
        {
            Caption = 'Consignee Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(24; "Job File No."; code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "BL No."; code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(27; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(28; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }
        field(29; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }
        field(30; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }
        field(31; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }
        field(32; Released; Boolean)
        {
            Caption = 'Released';
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        field(33; "Released Date"; Date)
        {
            Caption = 'Released Date';
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        field(34; "Released Time"; Time)
        {
            Caption = 'Released Time';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(35; "Custom Entry No."; Text[50])
        {
            Caption = 'Custom Entry No.';
            DataClassification = ToBeClassified;

        }
        field(36; "Payment Method"; Code[20])
        {
            Caption = 'Payment Method';
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";

        }
        field(37; "Delivery Order No."; Code[30])
        {
            Caption = 'Delivery Order No.';
            DataClassification = ToBeClassified;
        }
        field(38; "Payment Terms"; Code[20])
        {
            Caption = 'Payment Terms';
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms";

        }
        field(39; "Clearing Agent"; Code[20])
        {
            Caption = 'Clearing Agent';
            DataClassification = ToBeClassified;
            TableRelation = "Clearing Agent";
            trigger OnValidate()
            var
                ClearingAgent: Record "Clearing Agent";
            begin
                if ClearingAgent.get("Clearing Agent") then
                    "Agent Name" := ClearingAgent."Clearing Agent Name"
                else
                    "Agent Name" := '';
            end;
        }
        field(40; "Activity Date"; Date)
        {
            Caption = 'Activity Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(41; "Activity Time"; Time)
        {
            Caption = 'Activity Time';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(42; "Container Structural Status"; Enum ContainerStructuralStatusEnum)
        {
            Caption = 'Container Structural Status';
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup(ReceivingLog."Container Structural Status" where("Global Dimension 1 Code" = FIELD("Global Dimension 1 Code")));
        }
        field(50; "Expired Date"; Date)
        {
            Caption = 'Expired Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51; "Expired Time"; Time)
        {
            Caption = 'Expired Time';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(52; "DO No. Expiry date"; Date)
        {
            Caption = 'DO No. Expiry Date';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Gate Pass No.", "Line No.")
        {
            Clustered = true;
        }
        key(PK2; "Global Dimension 1 Code")
        {

        }
        key(PK3; "Expired Date")
        {

        }
    }
    procedure UpdateManifest()
    var
        myInt: Integer;
        ManiRec: Record "Manifest Line";
    begin
        ManiRec.Reset();
        ManiRec.SetRange("Job File No.", Rec."Job File No.");
        ManiRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        if ManiRec.FindFirst() then
            repeat
                ManiRec.Validate("No. of Bags Released", Rec."No. Of Bags");
                ManiRec.Validate("Date Released", Rec."Released Date");
                ManiRec.Validate(Released, true);
                ManiRec.Modify();
            until ManiRec.Next() = 0;
    end;

    procedure UpdatePositionLog()
    var
        GPSRec: Record "Gate Pass Out";
        PosLog: Record "Position Log";
        EntryNo: Integer;
    begin
        IF PosLog.FindLast() then
            EntryNo := PosLog."Entry No." + 1
        else
            EntryNo := 1;
        PosLog.Init();
        PosLog."Entry No." := EntryNo;
        PosLog."Document No." := rec."Gate Pass No.";
        PosLog."Position Code" := "Position ID";
        PosLog."Activity Type" := PosLog."Activity Type"::Pick;
        PosLog.Qunatity := -1;
        PosLog."Container No./Chassis No." := Rec."Container /Chasis No.";
        PosLog."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
        PosLog."Entry Type" := PosLog."Entry Type"::"Gate Pass Out";
        PosLog."Acitivity Date" := today();
        PosLog."Acitivity Time" := time;
        PosLog.Insert();
    end;

    procedure UpdatePosition()
    var
        PositionRec: Record Position;
    begin
        if PositionRec.GET(Rec."Position ID") then begin
            PositionRec."Container No./Chassis No." := '';
            PositionRec."Global Dimension 1 Code" := '';
            PositionRec.Status := PositionRec.Status::Open;
            PositionRec.Modify();
        end;

    end;

    procedure UpdateContainer()
    var
        ContainerRec: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.get();
        IF ContainerRec.get(GLSetup."Global Dimension 1 Code", Rec."Global Dimension 1 Code") then begin
            ContainerRec."Position No." := '';
            ContainerRec."Container Status" := ContainerRec."Container Status"::Delivered;
            ContainerRec.Modify();
        end;
    end;
}
