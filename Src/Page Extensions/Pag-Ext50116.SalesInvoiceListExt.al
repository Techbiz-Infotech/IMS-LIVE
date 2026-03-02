pageextension 50116 SalesInvoiceListExt extends "Sales Invoice List"
{    
    layout
    {
        addbefore("External Document No.")
        {
            field("BL No."; rec."BL No.")
            {
                caption = 'BL  No.';
                ApplicationArea = All;
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
            field("Clearing Agent";rec."Clearing Agent")
            {
                Caption = 'Clearing Agent';
                ApplicationArea = All;
            }
            field("Clearing Agent Name";rec."Clearing Agent Name")
            {
                Caption = 'Clearing Agent Name';
                ApplicationArea = All;
            }
        }
    }
}