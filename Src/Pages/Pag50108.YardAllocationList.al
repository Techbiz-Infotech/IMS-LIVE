page 50108 YardAllocationList
{
    Caption = 'Yard Allocations';
    PageType = List;
    SourceTable = YardAllocation;
    CardPageId = YardAllocationCard;
    ApplicationArea = all;
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Control123)
            {
                field("Yard Allocation No."; Rec."Yard Allocation No.")
                {
                    ToolTip = 'Specifies the value of the Yard Allocation No. field.';
                    ApplicationArea = All;
                }
                field("Allocation Date"; Rec."Allocation Date")
                {
                    ToolTip = 'Specifies the value of the Machine Operator field.';
                    ApplicationArea = All;
                }
                field("Allocation Time"; rec."Allocation Time")
                {
                    ToolTip = 'Specifies the value of the Machine Operator field.';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Container No./Chassis No."; rec."Container No./Chassis No.")
                {
                    ToolTip = 'Specifies the value of the Container No. field.';
                    ApplicationArea = All;
                }
                field(Position; Rec.Position)
                {
                    ToolTip = 'Specifies the value of the Position field.';
                    ApplicationArea = All;
                }
                field("Machine No."; Rec."Machine No.")
                {
                    ToolTip = 'Specifies the value of the Machine No. field.';
                    ApplicationArea = All;
                }
                field("Machine Operator"; Rec."Machine Operator")
                {
                    ToolTip = 'Specifies the value of the Machine Operator field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}