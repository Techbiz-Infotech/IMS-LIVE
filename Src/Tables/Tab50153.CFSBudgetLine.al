table 50153 "CFS Budget Line"
{
    Caption = 'CFS Budget Line';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Budget Year"; Integer)
        {
            Caption = 'Budget Year';
            DataClassification = ToBeClassified;
        }
        field(2; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }

        field(4; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }
        field(5; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
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
        field(8; January; Decimal)
        {
            Caption = 'January';
            DataClassification = ToBeClassified;
        }
        field(9; February; Decimal)
        {
            Caption = 'February';
            DataClassification = ToBeClassified;
        }
        field(10; March; Decimal)
        {
            Caption = 'March';
            DataClassification = ToBeClassified;
        }
        field(11; April; Decimal)
        {
            Caption = 'April';
            DataClassification = ToBeClassified;
        }
        field(12; May; Decimal)
        {
            Caption = 'May';
            DataClassification = ToBeClassified;
        }
        field(13; June; Decimal)
        {
            Caption = 'June';
            DataClassification = ToBeClassified;
        }
        field(14; July; Decimal)
        {
            Caption = 'July';
            DataClassification = ToBeClassified;
        }
        field(15; August; Decimal)
        {
            Caption = 'August';
            DataClassification = ToBeClassified;
        }
        field(16; September; Decimal)
        {
            Caption = 'September';
            DataClassification = ToBeClassified;
        }
        field(17; October; Decimal)
        {
            Caption = 'October';
            DataClassification = ToBeClassified;
        }
        field(18; November; Decimal)
        {
            Caption = 'November';
            DataClassification = ToBeClassified;
        }
        field(19; December; Decimal)
        {
            Caption = 'December';
            DataClassification = ToBeClassified;
        }
        field(20; "Budget Type"; Enum "CFS Budget type")
        {
            Caption = 'Budget Type';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(k1; "Budget Year", "Shortcut Dimension 3 Code", "Budget Type", "Line No.")
        {
            Clustered = true;
        }

    }

}