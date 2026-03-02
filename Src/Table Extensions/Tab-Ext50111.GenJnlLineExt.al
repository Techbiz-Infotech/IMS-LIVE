tableextension 50111 "GenJnlLine Ext" extends "Gen. Journal Line"
{
    fields
    {
        field(50100; "Prepayment Reversed"; Boolean)
        {
            Caption = 'Prepayment Reversed';
            DataClassification = ToBeClassified;
        }
        field(50101; "IMS Document Type"; Enum IMSDocTypeEnum)
        {
            Caption = 'IMS Document Type';
            DataClassification = ToBeClassified;
        }
    }
}
