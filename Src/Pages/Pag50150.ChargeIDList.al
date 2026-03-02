page 50150 "ChargeID Groups"
{
    ApplicationArea = All;
    Caption = 'Charge ID Groups';
    PageType = List;
    SourceTable = "Charge ID Group Header";
    UsageCategory = Lists;
    CardPageId = 50149;
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Charge ID Group Code"; Rec."Charge ID Group Code")
                {
                    ToolTip = 'Specifies the value of the Charge Group Code field.';
                    ApplicationArea = All;
                }
                field("Charge Description"; Rec."Charge Description")
                {
                    ToolTip = 'Specifies the value of the Charge Description field.';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                }
                field("Total Standard Charges amount"; Rec."Total Standard Charges amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Standard Charges amount field.';
                }
                field("Free Days"; Rec."Free Days")
                {
                    ToolTip = 'Specifies the value of the Free Days field.';
                    ApplicationArea = All;
                }
                field("First Bracket"; Rec."First Bracket")
                {
                    ToolTip = 'Specifies the value of the First Bracket field.';
                    ApplicationArea = All;
                }
                field("Second Bracket"; Rec."Second Bracket")
                {
                    ToolTip = 'Specifies the value of the Second Bracket field.';
                    ApplicationArea = All;
                }
                field("Third Bracket"; Rec."Third Bracket")
                {
                    ToolTip = 'Specifies the value of the Second Bracket field.';
                    ApplicationArea = All;
                }
                // field(HenceForth; rec.HenceForth)
                // {
                //     ToolTip = 'Specifies the value of the Fourth Bracket field.';
                //     ApplicationArea = All;
                // }
                field("Calculation Type"; Rec."Calculation Type")
                {
                    ToolTip = 'Specifies the value of the Calculation Type field.';
                    ApplicationArea = All;
                }
                field("Start After"; Rec."Start After")
                {
                    ToolTip = 'Specifies the value of the Start After field.';
                    ApplicationArea = All;
                }
                field("Base On"; Rec."Base On")
                {
                    ToolTip = 'Specifies the value of the Start After field.';
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the Start After field.';
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

}
