table 50143 VerificationLog
{
    Caption = 'Verification Log';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Verification No."; Code[10])
        {
            Caption = 'Verification No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Verification Date"; Date)
        {
            Caption = 'Verification Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Verification Time"; Time)
        {
            Caption = 'Verification Time';
            DataClassification = ToBeClassified;
        }
        field(5; "Container No./Chassis No."; Code[20])
        {
            Caption = 'Container No./Chassis No.';
            DataClassification = ToBeClassified;
        }
        field(6; "BL No."; Code[20])
        {
            Caption = 'BL No.';
            DataClassification = ToBeClassified;
        }
        field(7; "Container Type"; Enum ContainerTypeEnum)
        {
            Caption = 'Container Type';
            DataClassification = ToBeClassified;
        }
        // field(8; "Container Size"; Enum ContainerSizeEnum)
        // {
        //     Caption = 'Container Size';
        //     DataClassification = ToBeClassified;
        // }
        field(8; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }
        field(9; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(10; "Verification Type"; enum "Verification TypeEnum")
        {
            Caption = 'Verification Type';
            DataClassification = ToBeClassified;
        }
        field(11; "Verification Notes"; Text[30])
        {
            Caption = 'Verification Notes';
            DataClassification = ToBeClassified;
        }
        field(12; "Shipper Seal"; Text[30])
        {
            Caption = 'Shipper Seal';
            DataClassification = ToBeClassified;
        }
        field(13; "No.Series"; Code[30])
        {
            Caption = 'No.series';
            DataClassification = ToBeClassified;
        }
        field(14; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(17; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }

        field(18; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }

        field(19; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
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
        }
        field(44; "Job File No."; Code[20])
        {
            Caption = 'Job File No.';
            DataClassification = ToBeClassified;
        }
        field(45; "Manifest Line No."; Integer)
        {
            Caption = 'Manifest Line No.';
            DataClassification = ToBeClassified;
        }
        field(46; "New Seal"; Text[100])
        {
            Caption = 'New Seal';
            DataClassification = ToBeClassified;
        }
        field(47; Invoiced; Boolean)
        {
            Caption = 'Invoiced';
            DataClassification = ToBeClassified;
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

