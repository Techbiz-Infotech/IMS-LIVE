pageextension 50124 VendorCardExt extends "Vendor card"
{
    layout
    {
        modify("VAT Registration No.")
        {
            Caption = 'KRA PIN No.';

            trigger OnAfterValidate()
            var
                Vend: Record Vendor;
            begin
                Vend.Reset();
                Vend.SetRange("VAT Registration No.", Rec."VAT Registration No.");
                If Vend.FindFirst() then
                    Error('KRA Pin already Used for %1', Vend."No.")
                else
                    exit;
            end;
        }
    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.get(UserId);
        if not UserSetup.Vendor then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;
    end;

    trigger OnAfterGetRecord()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.get(UserId);
        if not UserSetup.Vendor then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;
    end;
}
