tableextension 50120 PurchaseInvheadExt extends "Purch. Inv. Header"
{
    fields
    {
        field(50100; "Created By User ID"; Code[50])
        {
            Caption = 'Created By User ID';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(50101; "CU Number"; Code[50])
        {
            Caption = 'CU Number';
            DataClassification = ToBeClassified;
        }
    }
}
