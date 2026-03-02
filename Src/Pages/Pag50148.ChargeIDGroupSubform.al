page 50148 "Charge ID Group Subform"
{
    Caption = 'Charge ID Group Subform';
    PageType = ListPart;
    SourceTable = "Charge ID Group Line";
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Charge ID Group Code"; Rec."Charge ID Group Code")
                {
                    ToolTip = 'Specifies the value of the Charge ID Group Code field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Charge; Rec.Charge)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Charge Description "; Rec."Charge Description ")
                {
                    ToolTip = 'Specifies the value of the Charge Description field.';
                    ApplicationArea = All;
                }
                field("First Interval"; Rec."First Interval")
                {
                    ToolTip = 'Specifies the value of the First Bracket field.';
                    ApplicationArea = All;
                }
                field("Second Interval"; Rec."Second Interval")
                {
                    ToolTip = 'Specifies the value of the Second Bracket field.';
                    ApplicationArea = All;
                }
                field("Third Interval"; Rec."Third Interval")
                {
                    ToolTip = 'Specifies the value of the Third Bracket field.';
                    ApplicationArea = All;
                }
                field(HenceForth; rec.HenceForth)
                {
                    ToolTip = 'Specifies the value of the Hence Fourth field.';
                    ApplicationArea = All;
                }
                field("Free Days"; Rec."Free Days")
                {
                    ToolTip = 'Specifies the value of the Free Days field.';
                    ApplicationArea = All;
                }
                field("Based On CBM/ Weight"; Rec."Based On CBM/ Weight")
                {
                    ToolTip = 'Specifies the value of the Based On CBM/ Weight field.';
                    ApplicationArea = All;
                }
                field("Relay On Storage"; Rec."Rely On Storage")
                {
                    ToolTip = 'Specifies the value of the "Relay On Storage field.';
                    ApplicationArea = All;
                }
                field("Active/In-Active"; Rec."Active/In-Active")
                {
                    ToolTip = 'Specifies the value of the "Relay On Storage field.';
                    ApplicationArea = All;
                }
                field("Calculate if Storage Days"; Rec."Calculate if Storage Days")
                {
                    ToolTip = 'Specifies the value of the Calculate if Storage Days field.';
                    ApplicationArea = All;
                }
                field("Charge Category"; rec."Charge Category")
                {
                    ToolTip = 'Specifies the value of the Charge Category field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
