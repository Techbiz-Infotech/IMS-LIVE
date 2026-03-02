table 50124 "Position Log"
{
    Caption = 'Position Log';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Position Code"; Text[20])
        {
            Caption = 'Position Code';
            DataClassification = ToBeClassified;
        }
        field(3; "No.Series"; Code[10])
        {
            Caption = 'No.series';
            DataClassification = ToBeClassified;
        }
        field(4; "Activity Type"; enum EnumActivityType)
        {
            Caption = 'Activity Type';
            DataClassification = ToBeClassified;
        }
        field(5; Qunatity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }
        field(6; "Acitivity Date"; date)
        {
            Caption = 'Activity Date';
            DataClassification = ToBeClassified;
        }
        field(7; "Acitivity Time"; time)
        {
            Caption = 'Acitivity Time';
            DataClassification = ToBeClassified;
        }
        field(8; "Container No./Chassis No."; code[20])
        {
            Caption = 'Container No./Chassis No.';
            DataClassification = ToBeClassified;

        }
        field(9; "Entry Type"; Enum EntryType)
        {
            Caption = 'Entry Type';
            DataClassification = ToBeClassified;
        }
        field(10; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(11; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(12; "Machine No."; code[20])
        {
            Caption = 'Machine No.';
            DataClassification = ToBeClassified;
        }
        field(13; "Machine Operater No."; code[20])
        {
            Caption = 'Machine Operater No.';
            DataClassification = ToBeClassified;
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
