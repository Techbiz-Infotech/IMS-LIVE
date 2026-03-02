page 50106 "Additional Charges - Receiving"
{
    //ApplicationArea = All;
    Caption = 'Additional Charges - Receiving';
    PageType = List;
    SourceTable = "Additional Charges - Receiving";
    UsageCategory = Lists;
    AutoSplitKey = true;
    DelayedInsert = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Container ID"; Rec."Container ID")
                {
                    ToolTip = 'Specifies the value of the Container ID field.';
                    ApplicationArea = All;
                }
                // field("Line No."; Rec."Line No.")
                // {
                //     ToolTip = 'Specifies the value of the Line No. field.';
                //     ApplicationArea = All;
                // }
                field("Charges Code"; Rec."Charges Code")
                {
                    ToolTip = 'Specifies the value of the Charges Code field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
