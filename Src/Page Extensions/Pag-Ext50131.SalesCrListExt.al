pageextension 50131 SalesCrExt extends "Sales Credit Memo"
{
    layout
    {
        addlast(General)
        {
            field("Credit Note Reason Type";Rec."Credit Note Reason Type")
            {
                caption = 'Credit Note Reason Type';
                ApplicationArea = All;
                ShowMandatory = true;
            }
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
            field("Clearing Agent"; rec."Clearing Agent")
            {
                Caption = 'Clearing Agent';
                ApplicationArea = All;
            }
            field("Clearing Agent Name"; rec."Clearing Agent Name")
            {
                Caption = 'Clearing Agent Name';
                ApplicationArea = All;
            }
        }
       
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        Error('you can not create new record');
    end;
}
