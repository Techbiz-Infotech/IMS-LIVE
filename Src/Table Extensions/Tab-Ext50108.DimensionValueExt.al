tableextension 50108 "Dimension Value Ext" extends "Dimension Value"
{
    fields
    {
        field(50100; "Container/Chassis No."; Code[30])
        {
            Caption = 'Container/Chassis No.';
            DataClassification = ToBeClassified;
        }
        field(50101; "BL No."; Code[30])
        {
            Caption = 'BL No.';
            DataClassification = ToBeClassified;
        }
        field(50102; "Container Status"; Enum "Container Status Ext")
        {
            Caption = 'Container Status';
            DataClassification = ToBeClassified;
        }
        field(50103; "Position No."; Code[20])
        {
            Caption = 'Position No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50104; "Job File No."; Code[20])
        {
            Caption = 'Job File No.';
            DataClassification = ToBeClassified;
            TableRelation = "Manifest Line";
        }
        field(50105; "Manifest Line No."; Integer)
        {
            Caption = 'Manifest Line No.';
            DataClassification = ToBeClassified;
            // TableRelation = "Manifest Line";
        }
        field(50106; "Customer No."; code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
        }
        field(50107; "Customer Name"; text[50])
        {
            Caption = 'Customer Name';
            DataClassification = ToBeClassified;
        }
        field(50108; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
            FieldClass = FlowField;
            CalcFormula = lookup("Manifest Line"."Shortcut Dimension 4 Code" where("Global Dimension 1 Code" = field(Code)));
        }
        

        field(50109; "Container Type"; Enum ContainerTypeEnum)
        {
            Caption = 'Container Type';
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup("Manifest Line"."Container Type" where("Global Dimension 1 Code" = field(Code)));
        }
        field(50110; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
            FieldClass = FlowField;
            CalcFormula = lookup("Manifest Line"."Global Dimension 2 Code" where("Global Dimension 1 Code" = field(Code)));
        }
        field(50111; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
            FieldClass = FlowField;
            CalcFormula = lookup("Manifest Line"."Shortcut Dimension 3 Code" where("Global Dimension 1 Code" = field(Code)));
        }
        field(50112; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
            FieldClass = FlowField;
            CalcFormula = lookup("Manifest Line"."Shortcut Dimension 5 Code" where("Global Dimension 1 Code" = field(Code)));
        }
        field(50113; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
            FieldClass = FlowField;
            CalcFormula = lookup("Manifest Line"."Shortcut Dimension 6 Code" where("Global Dimension 1 Code" = field(Code)));
        }
        field(50114; Transporter; Text[50])
        {
            Caption = 'Transporter';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(ReceivingLog.Transporter where("Global Dimension 1 Code" = field(Code)));
        }
        field(50115; "Cargo Type"; Code[20])
        {
            Caption = 'Cargo Type';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
	field(50116; "Skip KPA Charges"; Boolean)
        {
            Caption = 'Skip KPA Charges';
            DataClassification = ToBeClassified;
        }
    }
    // fieldgroups
    // {
    //     addlast(DropDown; "Container/Chassis No.", "BL No.", "Job File No.") { }

    // }
}
