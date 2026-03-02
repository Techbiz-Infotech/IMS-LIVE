pageextension 50115 PostedSalesInvoicesListExt extends "Posted Sales Invoices"
{
    layout
    {
        addbefore("Currency Code")
        {
            field("BL No."; rec."BL No.")
            {
                caption = 'BL  No.';
                ApplicationArea = All;
            }
            field("Proforma No."; Rec."Proforma No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Job File No."; rec."Job File No.")
            {
                Caption = 'Job File No.';
                ApplicationArea = All;
            }
            field("Job File Date"; rec."Job File Date")
            {
                Caption = 'job File Date';
                ApplicationArea = All;
            }
            field("Clearing Agent"; rec."Clearing Agent")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Clearing Agent Name"; rec."Clearing Agent Name")
            {
                ApplicationArea = all;
                Editable = false;
            }

        }

    }
    actions
    {
        modify(Print)
        {
            Caption = 'Terminal Sales Invoice';
        }


    }
}
