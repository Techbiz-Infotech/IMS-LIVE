tableextension 50110 "GLAccount Ext" extends "G/L Account"
{
    fields
    {
        field(50100; "Prepayment Reversal Account"; Code[20])
        {
            Caption = 'Prepayment Reversal Account';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
    }
}
