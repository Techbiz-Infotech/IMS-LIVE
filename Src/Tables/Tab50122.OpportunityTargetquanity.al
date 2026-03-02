table 50122 "Opportunity Estimated Quanity"
{
    Caption = 'Opportunity Estimated Quanity';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Opportunity No."; Code[20])
        {
            Caption = 'Opportunity No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }

        field(3; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }
        field(4; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }
        field(5; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }
        field(6; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }
        field(7; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }
        field(8; "BL No."; Code[20])
        {
            Caption = 'BL No.';
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        field(9; "Estimated Quantity"; Decimal)
        {
            Caption = 'Estimated Quantity';
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        field(10; "Manifested Quantity"; Integer)
        {
            Caption = 'Manifested Quantity';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count("Manifest Line" where("BL No." = FIELD("BL No."), "Shortcut Dimension 5 Code" = field("Shortcut Dimension 5 Code"),
                                                                                 "Global Dimension 2 Code" = field("Shortcut Dimension 2 Code"),
                                                                                 "Shortcut Dimension 3 Code" = field("Shortcut Dimension 3 Code"),
                                                                                 "Shortcut Dimension 4 Code" = field("Shortcut Dimension 4 Code"),
                                                                                 "Shortcut Dimension 6 Code" = field("Shortcut Dimension 6 Code"), Manifested = FILTER(true)));
        }
    }
    keys
    {
        key(PK; "Opportunity No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
