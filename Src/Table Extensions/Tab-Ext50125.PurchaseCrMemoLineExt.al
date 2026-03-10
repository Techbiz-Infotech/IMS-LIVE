tableextension 50125 "Purchase Cr Memo Line Ext" extends "Purch. Cr. Memo Line"
{
    fields
    {
        field(50101; "IMS Item Category Code"; Code[20])
        {
            Caption = 'IMS Item Category Code';
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Item Category Code" where("No." = field("No.")));
        }
    }
}
