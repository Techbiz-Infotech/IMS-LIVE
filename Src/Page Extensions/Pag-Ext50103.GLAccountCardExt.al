pageextension 50103 "GL Account Card Ext" extends "G/L Account Card"
{
    layout
    {
        addlast(General)
        {
            field("Prepayment Reversal Account"; Rec."Prepayment Reversal Account")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.get(UserId);
        if not UserSetup."Chart of Accounts" then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;
    end;
    trigger OnAfterGetRecord()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.get(UserId);
        if not UserSetup."Chart of Accounts" then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;
    end;
}
