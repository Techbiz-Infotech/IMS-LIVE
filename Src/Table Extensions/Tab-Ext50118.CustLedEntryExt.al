tableextension 50118 CustLedEntryExt extends "Cust. Ledger Entry"
{
    fields
    {
        field(50101; "IMS Document Type"; Enum IMSDocTypeEnum)
        {
            Caption = 'IMS Document Type';
            DataClassification = ToBeClassified;
        }
        field(50102; "Clearing Agent Code"; Code[20])
        {
            Caption = 'Clearing Agent Code';
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Invoice Line"."Clearing Agent" WHERE ("Document No."=FIELD("Document No.")));
        }
        field(50103; "Clearing Agent Name"; Text[100])
        {
            Caption = 'Clearing Agent Name';
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Invoice Line"."Clearing Agent Name" WHERE ("Document No."=FIELD("Document No.")));
        }
        field(50104; "Proforma No."; Code[20])
        {
            Caption = 'Proforma No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Invoice Header"."Proforma No." WHERE ("No."=FIELD("Document No.")));
        }
        field(50105; "BL No."; Code[20])
        {
            Caption = 'BL No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Invoice Header"."BL No." WHERE ("No."=FIELD("Document No.")));
        }
    }
}
