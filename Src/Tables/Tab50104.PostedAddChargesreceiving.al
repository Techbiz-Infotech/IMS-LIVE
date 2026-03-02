table 50104 "Posted Add. Charges receiving"
{

    Caption = 'Posted Additional Charges - Receiving';
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
        field(3; "Charges Code"; Code[20])
        {
            Caption = 'Charges Code';
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(4; "Receiving Entry No."; Integer)
        {
            Caption = 'Receiving Entry No.';
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

