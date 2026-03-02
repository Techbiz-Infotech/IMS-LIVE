tableextension 50117 CustomerExt extends Customer
{
    fields
    {
        field(50100; "Last Recieved Date"; Date)
        {
            Caption = 'Last Recieved Date';
            FieldClass = FlowField;
            CalcFormula = max("Manifest Line"."Date Received" where("Invoicing Party No." = field("No.")));
            Editable = false;
        }
        field(50101; "Terminal ChargeID Assignments"; Integer)
        {
            Caption = 'Terminal Charge ID Assignments';
            FieldClass = FlowField;
            CalcFormula = count("Charge ID Assignment" where("Customer No." = field("No.")));
            Editable = false;
        }

        modify("Credit Limit (LCY)")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin

            end;
        }


    }
}
