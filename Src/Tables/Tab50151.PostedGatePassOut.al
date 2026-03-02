table 50151 "Posted Gate Pass Out"
{
    Caption = 'Posted Gate Pass Out';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Gate Pass No."; Code[20])
        {
            Caption = 'Gate Pass No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Invoice No."; Code[20])
        {
            Caption = 'Invoice No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Job File No."; Code[20])
        {
            Caption = 'Job File No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "BL No."; Code[20])
        {
            Caption = 'BL No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Receipt No."; Code[20])
        {
            Caption = 'Receipt No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Invoice Date"; Date)
        {
            Caption = 'Invoice Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Activity Date"; Date)
        {
            Caption = 'Activity Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Activity Time"; Time)
        {
            Caption = 'Activity Time';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Container /Chasis No."; Code[20])
        {
            Caption = 'Container /Chasis No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Gate Pass Status"; Enum "Active/In-Active Enum")
        {
            Caption = 'Gate Pass Status';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "No. Of Bags"; Decimal)
        {
            Caption = 'No. Of Bags';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Truck No."; Code[20])
        {
            Caption = 'Truck No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Agent Name"; Text[20])
        {
            Caption = 'Agent Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Agent Port Pass"; Code[20])
        {
            Caption = 'Agent Port Pass';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Tranporter/Driver Name"; Text[40])
        {
            Caption = 'Tranporter/Driver Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16; Remarks; Text[50])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; Released; Boolean)
        {
            Caption = 'Released';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "Released Date"; Date)
        {
            Caption = 'Released Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "Storage Days"; Integer)
        {
            Caption = 'Storage Days';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "Trailer No."; code[20])
        {
            Caption = 'Trailer No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; "Position ID"; code[20])
        {
            Caption = 'Position ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26; "Released Time"; Time)
        {
            Caption = 'Released Time';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(36; "Clearing Agent"; Code[20])
        {
            Caption = 'Clearing Agent';
            DataClassification = ToBeClassified;
            TableRelation = "Clearing Agent";
            trigger OnValidate()
            var
                ClearingAgent: Record "Clearing Agent";
            begin
                if ClearingAgent.get("Clearing Agent") then
                    "Clearing Agent Name" := ClearingAgent."Clearing Agent Name"
                else
                    "Clearing Agent Name" := '';
            end;
        }
        field(37; "Clearing Agent Name"; Text[100])
        {
            Caption = 'Clearing Agent Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(39; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(40; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(41; "Global Dimension 1 Filter"; Code[20])
        {
            Caption = 'Global Dimension 1 Filter';

            FieldClass = FlowFilter;
            CaptionClass = '1,3,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(42; "Global Dimension 2 Filter"; Code[20])
        {
            Caption = 'Global Dimension 1 Filter';

            FieldClass = FlowFilter;
            CaptionClass = '1,3,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(43; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
            Editable = false;
        }
        field(44; "Consignee No."; Code[20])
        {
            Caption = 'Consignee No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(45; "Consignee Name"; Text[100])
        {
            Caption = 'Consignee Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(46; "Gate Pass Printed"; Boolean)
        {
            Caption = 'Gate Pass Printed';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(47; Approved; Boolean)
        {
            Caption = 'Approved';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(48; "Approved By"; Code[50])
        {
            Caption = 'Approved By';
            DataClassification = ToBeClassified;
            TableRelation = User;
            Editable = false;
        }
        field(49; "Approved Date Time"; DateTime)
        {
            Caption = 'Approved Date Time';
            DataClassification = ToBeClassified;
            Editable = false;
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
    }
    keys
    {
        key(PK; "Gate Pass No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        Rec."User ID" := UserId;
    end;

    trigger OnDelete()
    var
        GPLine: Record "Posted Gate Pass out Line";
    begin
        TestField(Released, false);
        GPLine.reset;
        GPLine.SetRange("Gate Pass No.", "Gate Pass No.");
        if GPLine.FindSet() then
            GPLine.DeleteAll();
    end;

    procedure UpdateManifest()
    var
        myInt: Integer;
        ManiRec: Record "Manifest Line";
        PedningGateOutLine: Record "Posted Gate Pass out Line";
    begin
        PedningGateOutLine.Reset();
        PedningGateOutLine.SetRange("Gate Pass No.", Rec."Gate Pass No.");
        IF PedningGateOutLine.FindSet() then
            repeat
                ManiRec.Reset();
                //ManiRec.SetRange("Job File No.", PedningGateOutLine."Job File No.");
                ManiRec.SetRange("Global Dimension 1 Code", PedningGateOutLine."Global Dimension 1 Code");
                if ManiRec.FindFirst() then
                    repeat
                        ManiRec.Validate("No. of Bags Released", PedningGateOutLine."No. Of Bags");
                        ManiRec.Validate("Date Released", Rec."Released Date");
                        ManiRec.Validate("Custom Entry No.", PedningGateOutLine."Custom Entry No.");
                        ManiRec.Validate("GP Delivery Order No.", PedningGateOutLine."Delivery Order No.");
                        ManiRec.Validate(Released, true);
                        ManiRec.Modify();
                    until ManiRec.Next() = 0;
            until PedningGateOutLine.Next() = 0;
    end;

    procedure UpdatePositionLog()
    var
        GPSRec: Record "Gate Pass Out";
        PosLog: Record "Position Log";
        EntryNo: Integer;
        PostGateLine: Record "Posted Gate Pass out Line";
    begin
        PostGateLine.Reset();
        PostGateLine.SetRange("Gate Pass No.", "Gate Pass No.");
        if PostGateLine.FindSet() then
            repeat

                IF PosLog.FindLast() then
                    EntryNo := PosLog."Entry No." + 1
                else
                    EntryNo := 1;
                PosLog.Init();
                PosLog."Entry No." := EntryNo;
                PosLog."Document No." := rec."Gate Pass No.";
                PosLog."Position Code" := PostGateLine."Position ID";
                PosLog."Activity Type" := PosLog."Activity Type"::Pick;
                PosLog.Qunatity := -1;
                PosLog."Container No./Chassis No." := PostGateLine."Container /Chasis No.";
                PosLog."Global Dimension 1 Code" := PostGateLine."Global Dimension 1 Code";
                PosLog."Entry Type" := PosLog."Entry Type"::"Gate Pass Out";
                PosLog."Acitivity Date" := today();
                PosLog."Acitivity Time" := time;
                PosLog.Insert();
            until PostGateLine.next = 0;
    end;

    procedure UpdatePosition()
    var
        PositionRec: Record Position;
        PostGateLine: Record "Posted Gate Pass out Line";
    begin
        PostGateLine.Reset();
        PostGateLine.SetRange("Gate Pass No.", "Gate Pass No.");
        if PostGateLine.FindSet() then
            repeat
                if PositionRec.GET(PostGateLine."Position ID") then begin
                    PositionRec."Container No./Chassis No." := '';
                    PositionRec."Global Dimension 1 Code" := '';
                    PositionRec.Status := PositionRec.Status::Open;
                    PositionRec.Modify();
                end;
            until PostGateLine.Next() = 0;
    end;

    procedure UpdateContainer()
    var
        ContainerRec: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        PendingGatePassLineRec: Record "Posted Gate Pass out Line";
    begin
        GLSetup.get();
        PendingGatePassLineRec.Reset();
        PendingGatePassLineRec.SetRange("Gate Pass No.", REC."Gate Pass No.");
        IF PendingGatePassLineRec.FindSet() then
            repeat
                IF ContainerRec.get(GLSetup."Global Dimension 1 Code", PendingGatePassLineRec."Global Dimension 1 Code") then begin
                    ContainerRec."Position No." := '';
                    ContainerRec."Container Status" := ContainerRec."Container Status"::Delivered;
                    ContainerRec.Modify();
                end;
            until PendingGatePassLineRec.next = 0;

    end;
}
