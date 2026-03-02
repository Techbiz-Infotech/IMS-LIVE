table 50114 AdditionalChargesVerification
{
    Caption = 'Additional Charges - Verification';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Container ID"; Code[20])
        {
            Caption = 'Container ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Verification Type"; Enum "Verification TypeEnum")
        {
            Caption = 'Verification Type';
            DataClassification = ToBeClassified;
        }
        field(4; "Verification Charges"; Decimal)
        {
            Caption = 'Verification Charges';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Container ID", "Line No.")
        {
            Clustered = true;
        }
    }
}
