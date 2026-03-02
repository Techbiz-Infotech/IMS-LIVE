pageextension 50134 PostedSalesInvoiceLinesExt extends "Posted Sales Invoice Lines"
{
    layout
    {
        addafter(Amount)
        {
            field("Posting Date";Rec."Posting Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Posting Date field.';
            }
            field("BL No."; Rec."BL No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the BL No. field.';
            }
            field("Job File No."; Rec."Job File No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Job File No. field.';
            }
            field("Container No./Chassis No."; Rec."Container No./Chassis No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Container No./Chassis No. field.';
            }
            field("Charge ID"; Rec."Charge ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Charge ID field.';
            }
            field("Job File Date"; Rec."Job File Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Job File Date field.';
            }
            field("Container Type"; Rec."Container Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Container Type field.';
            }
            field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.';
            }
            field("Destination Type"; Rec."Destination Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Destination Type field.';
            }
            field("Storage Days"; Rec."Storage Days")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Storage Days field.';
            }
            field("Position ID"; Rec."Position ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Position ID field.';
            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
            }
            field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
            }
            field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortcut Dimension 6 Code field.';
            }
            field("Free Days"; Rec."Free Days")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Free Days field.';
            }
            field("Storage Start Date"; Rec."Storage Start Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Storage Start Date field.';
            }
            field("Clearing Agent"; Rec."Clearing Agent")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Clearing Agent field.';
            }
            field("Clearing Agent Name"; Rec."Clearing Agent Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Clearing Agent Name field.';
            }
            field("Chargable Storage Days"; Rec."Chargable Storage Days")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Chargable Storage Days field.';
            }
            field("Reefer Hours";rEC."Reefer Hours")
            {
                ApplicationArea = All;
                Editable = False;
                ToolTip = 'Specifies the value of the Chargable Reefer Hours field.';
            }
        }
    }
}
