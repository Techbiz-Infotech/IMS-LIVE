pageextension 50200 SalesOrderExt extends "Sales Order"
{
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        IF (UserId <> 'GROUP.AUDIT') and (UserId <> 'TECHBIZINFOTECH') then
            error('You are not Authorized to view this area. Please contact Group Audit');
    end;
}
