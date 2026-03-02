pageextension 50123 CustomerListExt extends "Customer List"
{
    layout
    {
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Phone No.")
        {
            Visible = false;
        }
    }
    actions
    {
        //addafter("Bank Accounts")
        addbefore(Dimensions)
        {
            action("Charge Id Assignment")
            {
                Caption = 'Terminal Charge ID Assignment';
                ApplicationArea = All;
                RunObject = page "Charge ID Assignment";
                RunPageLink = "Customer No." = field("No.");
                trigger OnAction()
                begin

                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.get(UserId);
        if not UserSetup.Customer then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;
    end;

    trigger OnAfterGetRecord()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.get(UserId);
        if not UserSetup.Customer then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;
    end;
}
