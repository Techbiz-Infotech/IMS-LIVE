table 50102 "Additional Charges - Receiving"
{
    Caption = 'Additional Charges - Receiving';
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
            Caption = 'Charge Code';
            DataClassification = ToBeClassified;
            TableRelation = Item;
            trigger OnValidate()
            var
                AddChg: Record "Additional Charges - Receiving";
            begin
                AddChg.Reset();
                AddChg.SetRange("Container ID", Rec."Container ID");
                AddChg.SetRange("Charges Code", Rec."Charges Code");
                if AddChg.FindFirst() then
                    Error('Item No. %1 already exist for the container ID', Rec."Charges Code");
            end;
        }
        field(4; Rate; Decimal)
        {
            Caption = 'Rate';
            DataClassification = ToBeClassified;
        }
        field(5; Invoiced; Boolean)
        {
            Caption = 'Invoiced';
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
