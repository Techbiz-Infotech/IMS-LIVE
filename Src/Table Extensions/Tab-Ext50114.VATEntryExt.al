tableextension 50114 VATEntryExt extends "VAT Entry"
{
    fields
    {
        field(50100; "Cust/Vend Name"; Text[100])
        {
            Caption = 'Cust/Vend Name';
            DataClassification = ToBeClassified;
        }
        field(50101; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(50102; "CU Number";  Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'CU Number';
        }  
    }
}
