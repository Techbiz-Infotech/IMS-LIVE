table 50101 "Clearing Agent"
{
    Caption = 'Clearing Agent';
    DataClassification = ToBeClassified;
    LookupPageId = "Clearing Agent List";
    DrillDownPageId = "Clearing Agent List";

    fields
    {
        field(1; "Clearing Agent Code"; Code[20])
        {
            Caption = 'Clearing Agent Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Clearing Agent Name"; Text[50])
        {
            Caption = 'Clearing Agent Name';
            DataClassification = ToBeClassified;
        }
        field(3; "E-mail"; Text[80])
        {
            Caption = 'Email';
            DataClassification = ToBeClassified;
        }
        field(4; "Contact-Person Email"; Text[80])
        {
            Caption = 'Contact-Person Email';
            DataClassification = ToBeClassified;
        }
        field(5; Address; Text[100])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Clearing Agent Code")
        {
            Clustered = true;
        }
    }
}
