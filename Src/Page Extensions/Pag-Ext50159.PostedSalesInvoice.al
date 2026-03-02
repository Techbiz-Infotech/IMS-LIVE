pageextension 50159 "Posted Sales Invoice" extends "Posted Sales Invoice"

{
    layout
    {
        addlast(General)
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
    actions
    {
        modify(Print)
        {
            Caption = 'Terminal Sales Invoice';
        }
        // addlast(Category_Category6)
        // {
        //     actionref(Print_Promoted_3; "Print")
        //     {
        //     }
        // }

    }
}


