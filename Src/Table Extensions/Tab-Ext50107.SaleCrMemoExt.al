tableextension 50107 "Sale Cr Memo Ext" extends "Sales Cr.Memo Header"
{
    fields
    {
        field(50100; "BL No."; Code[20])
        {
            Caption = 'BL No.';
            DataClassification = ToBeClassified;
        }
        field(50101; "Job File No."; Code[20])
        {
            Caption = 'Job File No.';
            DataClassification = ToBeClassified;
        }
        // field(50102; "Client Type"; Enum ManifestClientTypeEnum)
        // {
        //     Caption = 'Client Type';
        //     DataClassification = ToBeClassified;
        // }
        field(50102; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        

        field(50103; "Container No."; Code[20])
        {
            Caption = 'Container No.';
            DataClassification = ToBeClassified;
        }
        field(50104; "Charge ID"; Code[20])
        {
            Caption = 'Charge ID';
            DataClassification = ToBeClassified;
        }
        field(50105; "Job File Date"; Date)
        {
            Caption = 'Job File Date';
            DataClassification = ToBeClassified;
        }
        field(50106; "Container Type"; Enum ContainerTypeEnum)
        {
            Caption = 'Container Type';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        // field(50107; "Container Size"; Enum ContainerSizeEnum)
        // {
        //     Caption = 'Container Size';
        //     DataClassification = ToBeClassified;
        //     Editable = false;
        // }
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
        field(50113; "Clearing Agent"; Code[20])
        {
            Caption = 'Clearing Agent';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Line"."Clearing Agent" where("BL No." = field("BL No.")));
        }
        field(50114; "Clearing Agent Name"; Text[100])
        {
            Caption = 'Clearing Agent Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Line"."Clearing Agent Name" where("BL No." = field("BL No.")));
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
}
