pageextension 50117 ChartOfaccountsExt extends "Chart of Accounts"
{
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
