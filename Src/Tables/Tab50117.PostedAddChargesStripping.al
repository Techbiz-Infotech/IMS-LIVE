table 50117 "Posted AddCharges Stripping"
{
    Caption = 'Posted AddCharges Stripping';
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
        field(5; "Stripping Entry No."; Integer)
        {
            Caption = 'Stripping Entry No.';
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
