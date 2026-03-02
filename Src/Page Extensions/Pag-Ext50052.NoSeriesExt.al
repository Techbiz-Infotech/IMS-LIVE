pageextension 50052 "No.Series Ext" extends "No. Series"
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

    trigger OnDeleteRecord(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.get(UserId);
        if not UserSetup."General Posting Setup" then
            Error('You do not have permission to Delete');
    end;

}

