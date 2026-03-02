tableextension 50121 PurchaseLineExt extends "Purchase Line"
{
    fields
    {
        field(50100; "Description of goods"; Text[250])
        {
            Caption = 'Description of goods';
            DataClassification = ToBeClassified;
        }
    }
}
