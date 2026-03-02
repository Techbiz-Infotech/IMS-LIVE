pageextension 50119 ItemListExt extends "Item List"
{
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.get(UserId);
        if not UserSetup.Item then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;
    end;
    trigger OnAfterGetRecord()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.get(UserId);
        if not UserSetup.Item then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;
    end;
}
