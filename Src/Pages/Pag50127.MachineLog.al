page 50127 "Machine Log"
{
    ApplicationArea = All;
    Caption = 'Machine Logs';
    PageType = List;
    SourceTable = "Position Log";
    SourceTableView = SORTING("Entry No.") ORDER(Descending);
    UsageCategory = History;
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                    ApplicationArea = All;
                }
                field("Entry Type"; rec."Entry Type")
                {
                    ApplicationArea = all;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("Position Code"; rec."Position Code")
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Activity Type"; rec."Activity Type")
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field(Qunatity; rec.Qunatity)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Acitivity Date"; rec."Acitivity Date")
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Acitivity Time"; rec."Acitivity Time")
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Container No./Chassis No."; rec."Container No./Chassis No.")
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("User ID"; rec."User ID")
                {
                    ToolTip = 'Specifies the value of the Description field.';

                    ApplicationArea = All;
                    Visible = false;
                }
                field("Machine No."; rec."Machine No.")
                {
                    ApplicationArea = all;
                }
                field("Machine Operater No."; rec."Machine Operater No.")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
