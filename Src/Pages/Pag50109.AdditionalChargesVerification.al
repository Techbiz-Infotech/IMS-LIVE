page 50109 "AdditionalCharges Verification"
{
    //ApplicationArea = All;
    Caption = 'AdditionalCharges Verification';
    PageType = List;
    SourceTable = AdditionalChargesVerification;
    UsageCategory = Lists;
    AutoSplitKey = true;
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
                field("Verification Type"; Rec."Verification Type")
                {
                    ToolTip = 'Specifies the value of the Verification Type field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
