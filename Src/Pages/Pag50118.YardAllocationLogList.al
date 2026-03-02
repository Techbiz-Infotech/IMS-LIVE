page 50118 "Yard Allocation Log List"
{
    Caption = 'Yard Allocation Logs';
    PageType = List;
    SourceTable = "YardAllocationLog";
    ApplicationArea = all;
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
                field("Yard Allocation No."; rec."Yard Allocation No.")
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Allocation Date"; rec."Allocation Date")
                {
                    ApplicationArea = All;
                }
                field("Allocation Time"; rec."Allocation Time")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Container No./Chassis No."; rec."Container No./Chassis No.")
                {
                    ApplicationArea = All;
                }
                field(Position; rec.Position)
                {
                    ApplicationArea = All;
                }
                field("Machine No."; rec."Machine No.")
                {
                    ApplicationArea = All;
                }
                field("Machine Operator"; rec."Machine Operator")
                {
                    ApplicationArea = All;
                }
                field("User ID"; rec."User ID")
                {

                    ToolTip = 'Specifies the value of the Start After field.';
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
}
