tableextension 50104 CompanyInfoExt extends "Company Information"
{
    fields
    {
        field(50100; "Bank Account Name"; Text[50])
        {
            Caption = 'Bank Account Name';
            DataClassification = ToBeClassified;
        }
        field(50101; "LCY Account 1"; Text[50])
        {
            Caption = 'LCY Account 1';
            DataClassification = ToBeClassified;
        }
        field(50102; "LCY Account 2"; Text[50])
        {
            Caption = 'LCY Account 2';
            DataClassification = ToBeClassified;
        }
        field(50103; "FCY Account 1"; Text[50])
        {
            Caption = 'FCY Account 1';
            DataClassification = ToBeClassified;
        }
        field(50104; "FCY Account 2"; Text[50])
        {
            Caption = 'FCY Account 2';
            DataClassification = ToBeClassified;
        }
        field(50105; "MPESA Account"; Text[50])
        {
            Caption = 'MPESA Account';
            DataClassification = ToBeClassified;
        }
    }
}
