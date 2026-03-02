pageextension 50122 GenPostSetupCardExt extends "General Posting Setup Card"
{
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.get(UserId);
        if not UserSetup."General Posting Setup" then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;
    end;

    trigger OnAfterGetRecord()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.get(UserId);
        if not UserSetup."General Posting Setup" then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;
    end;
}
