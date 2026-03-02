table 50116 AdditionalChargesStripping
{
    Caption = 'Additional Charges - Stripping';
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
        field(3; "Stripping Type"; Enum "Stripping TypeEnum")
        {
            Caption = 'Stripping Type';
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
            ObsoleteReason = 'As per client request';
            
        }
        field(4; "Stripping Charges"; Decimal)
        {
            Caption = 'Stripping Charges';
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
