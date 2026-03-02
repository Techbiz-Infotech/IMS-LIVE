pageextension 50104 SalesInvoiceLineExt extends "Posted Sales Invoice Subform"
{
    layout
    {
        addafter("Shortcut Dimension 1 Code")
        {
            // field("Shortcut Dimension 3 Code"; rec."Shortcut Dimension 3 Code")
            // {
            //     Editable = False;
            //     ApplicationArea = All;

            // }
            // field("Shortcut Dimension 4 Code"; rec."Shortcut Dimension 4 Code")
            // {
            //     Editable = False;
            //     ApplicationArea = All;

            // }
            // field("Shortcut Dimension 5 Code"; rec."Shortcut Dimension 5 Code")
            // {
            //     Editable = False;
            //     ApplicationArea = All;

            // }
            // field("Shortcut Dimension 6 Code"; rec."Shortcut Dimension 6 Code")
            // {
            //     Editable = False;
            //     ApplicationArea = All;
            // }
            field("BL No."; Rec."BL No.")
            {
                ApplicationArea = All;
                //Editable = False;
            }

            field("Container Type"; Rec."Container Type")
            {
                ApplicationArea = All;
                //Editable = False;
            }
            field("Job File No."; Rec."Job File No.")
            {
                ApplicationArea = All;
                //Editable = False;
            }
            field("Job File Date"; Rec."Job File Date")
            {
                ApplicationArea = All;
                Editable = False;
            }
            field("Position ID"; Rec."Position ID")
            {
                ApplicationArea = All;
                Editable = False;
            }
            field("Charge ID"; Rec."Charge ID")
            {
                ApplicationArea = All;
                Editable = False;
            }
            field("Storage Start Date"; Rec."Storage Start Date")
            {
                ApplicationArea = All;
                Editable = False;
            }
            field("Free Days"; Rec."Free Days")
            {
                ApplicationArea = All;
                Editable = False;
            }
            field("Storage Days"; Rec."Storage Days")
            {
                ApplicationArea = All;
                Editable = False;
            }
            field("Reefer Hours";rEC."Reefer Hours")
            {
                ApplicationArea = All;
                Editable = False;
            }
            field("Container No./Chassis No."; rec."Container No./Chassis No.")
            {
                ApplicationArea = All;
                Editable = False;
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
            field("Chargable Storage Days";rec."Chargable Storage Days")
            {
                ApplicationArea = All;
                Editable = False;
            }

        }
    }
}
