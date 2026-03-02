pageextension 50105 "Customer Card Ext" extends "Customer Card"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("Terminal ChargeID Assignments"; Rec."Terminal ChargeID Assignments")
            {
                ApplicationArea = all;
            }
        }
        modify("IC Partner Code")
        {
            Visible = false;
        }
        modify("Prices Including VAT")
        {
            Visible = false;
        }
        modify("VAT Registration No.")
        {
            Caption = 'KRA PIN No.';

            trigger OnAfterValidate()
            var
                Cust: Record Customer;
            begin
                Cust.Reset();
                cust.SetRange("VAT Registration No.", Rec."VAT Registration No.");
                If Cust.FindFirst() then
                    Error('KRA Pin already Used for %1', Cust."No.")
                else
                    exit;
            end;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Service Zone Code")
        {
            Visible = false;
        }
        modify("Document Sending Profile")
        {
            Visible = false;
        }
        modify("EORI Number")
        {
            Visible = false;
        }
        modify("Use GLN in Electronic Document")
        {
            Visible = false;
        }
        modify(GLN)
        {
            Visible = false;
        }
        modify("Customer Disc. Group")
        {
            Visible = false;
        }
        modify("Customer Price Group")
        {
            Visible = false;
        }
        modify("Reminder Terms Code")
        {
            Visible = false;
        }
        modify("Fin. Charge Terms Code")
        {
            Visible = false;
        }
        modify("VAT Bus. Posting Group")
        {
            ShowMandatory = true;
        }
        modify("Salesperson Code")
        {
            ShowMandatory = true;
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
