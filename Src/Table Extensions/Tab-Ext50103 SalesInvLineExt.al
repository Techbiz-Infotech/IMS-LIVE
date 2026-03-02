tableextension 50103 SaleInvLineExt extends "Sales Invoice Line"
{
    fields
    {
        field(50100; "BL No."; Code[20])
        {
            Caption = 'BL No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50101; "Job File No."; Code[20])
        {
            Caption = 'Job File No.';
            DataClassification = ToBeClassified;
            Editable = false;
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
            trigger onvalidate()
            var
                myInt: Integer;
            begin
                //Rec.ValidateShortcutDimCode(5, "Shortcut Dimension 5 Code");
            end;
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
        field(50111; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
            trigger onvalidate()
            var
                myInt: Integer;
            begin
                // rec.ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(50112; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
            trigger onvalidate()
            var
                myInt: Integer;
            begin
                //rec.ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(50113; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
            trigger onvalidate()
            var
                myInt: Integer;
            begin
                // rec.ValidateShortcutDimCode(6, "Shortcut Dimension 6 Code");
            end;
        }
        field(50114; "No. Of Bags for Billing"; Decimal)
        {
            Caption = 'No. Of Bags for Billing';
            DataClassification = ToBeClassified;
        }
        field(50115; "Free Days"; Decimal)
        {
            Caption = 'Free Days';
            DataClassification = ToBeClassified;
        }
        field(50116; "Storage Start Date"; Date)
        {
            Caption = 'Storage Start Date';
            DataClassification = ToBeClassified;
        }
        field(50117; "Clearing Agent"; Code[20])
        {
            Caption = 'Clearing Agent';
            DataClassification = ToBeClassified;
            TableRelation = "Clearing Agent";
        }
        field(50118; "Clearing Agent Name"; Text[100])
        {
            Caption = 'Clearing Agent Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50119; "Chargable Storage Days"; Integer)
        {
            Caption = 'Chargable Storage Days';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50120; "Reefer Hours"; Decimal)
        {
            Caption = 'Reefer Hours';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50121; "Auto Calculated"; Boolean)
        {
            Caption = 'Auto Calculated';
            DataClassification = ToBeClassified;
        }
        field(50122; "Verification Log No."; Integer)
        {
            Caption = 'Verification Log No.';
            DataClassification = ToBeClassified;
        }
        field(50123; "Stripping Log No."; Integer)
        {
            Caption = 'Stripping Log No.';
            DataClassification = ToBeClassified;
        }
        field(50150; Cancelled; Boolean)
        {
            CalcFormula = Exist("Cancelled Document" WHERE("Source ID" = CONST(112),
                                                            "Cancelled Doc. No." = FIELD("Document No.")));
            Caption = 'Cancelled';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}
