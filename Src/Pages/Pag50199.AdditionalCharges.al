page 50199 "Additional Charges"
{
    Caption = 'Additional Charges';
    PageType = List;
    SourceTable = "Additional Charges - Receiving";
    ApplicationArea = all;
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
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Container ID field.';
                    Editable = false;
                }
                field("Charges Code"; Rec."Charges Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Charges Code field.';
                }
                field(Rate;Rec.Rate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rate field.';
                }
            }
        }
    }
}
