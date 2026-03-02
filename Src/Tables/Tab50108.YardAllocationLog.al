table 50108 YardAllocationLog
{
    Caption = 'Yard Allocation Log';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Yard Allocation No."; Code[20])
        {
            Caption = 'Yard Allocation No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Container No./Chassis No."; Code[20])
        {
            Caption = 'Container No./Chassis No.';
            DataClassification = ToBeClassified;
        }
        field(4; Position; code[20])
        {
            Caption = 'Position';
            DataClassification = ToBeClassified;

        }
        field(5; "Machine No."; Code[20])
        {
            Caption = 'Machine No.';
            DataClassification = ToBeClassified;
        }
        field(6; "Machine Operator"; Text[20])
        {
            Caption = 'Machine Operator';
            DataClassification = ToBeClassified;
            TableRelation = "Machine Operator";
        }

        field(7; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(8; "Allocation Date"; Date)
        {
            Caption = 'Allocation Date';
            DataClassification = ToBeClassified;
        }
        field(9; "Allocation Time"; Time)
        {
            Caption = 'Allocation Time';
            DataClassification = ToBeClassified;
        }
        field(39; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            Editable = false;
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
    }
    keys
    {
        key(PK; "Entry No.")
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
}
