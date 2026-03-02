table 50115 "Posted AddCharges Verification"
{
    Caption = 'Posted AddCharges Verification';
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
        field(5; "Verification Entry No."; Integer)
        {
            Caption = 'Verification Entry No.';
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
