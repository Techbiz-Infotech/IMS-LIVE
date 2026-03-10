tableextension 50124 PurchaseInvLine extends "Purch. Inv. Line"
{
    fields
    {
        field(50100; "Description of goods"; Text[250])
        {
            Caption = 'Description of goods';
            DataClassification = ToBeClassified;
        }
         field(50101; "IMS Item Category Code"; Code[20])
        {
            Caption = 'IMS Item Category Code';
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Item Category Code" where("No." = field("No.")));
        }


    }
}
