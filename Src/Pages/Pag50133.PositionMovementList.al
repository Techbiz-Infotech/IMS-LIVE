page 50133 PositionMovementList
{
    ApplicationArea = All;
    Caption = 'Position Movements ';
    PageType = List;
    SourceTable = "Position Movement";

    UsageCategory = Lists;
    CardPageId = "Position Movement Card";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Position Movement No."; Rec."Position Movement No.")
                {
                    ToolTip = 'Specifies the value of the Position Movement No. field.';
                    ApplicationArea = All;
                }
                field("Movement Date"; Rec."Movement Date")
                {
                    ToolTip = 'Specifies the value of the Movement Date field.';
                    ApplicationArea = All;
                }
                field("Movement Time"; Rec."Movement Time")
                {
                    ToolTip = 'Specifies the value of the Movement Time field.';
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

                field("Position From"; Rec."Position From")
                {
                    ToolTip = 'Specifies the value of the Position From field.';
                    ApplicationArea = All;
                }
                field("Position To"; Rec."Position To")
                {
                    ToolTip = 'Specifies the value of the Position To field.';
                    ApplicationArea = All;
                }
                field(Machine; Rec.Machine)
                {
                    ToolTip = 'Specifies the value of the Machine field.';
                    ApplicationArea = All;
                }
                field("Machine Operator"; Rec."Machine Operator")
                {
                    ToolTip = 'Specifies the value of the Machine Operator field.';
                    ApplicationArea = All;
                }
                field("User ID"; rec."User ID")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
}
