page 50146 "AdditionalCharges Stripping"
{
   // ApplicationArea = All;
    Caption = 'AdditionalCharges Stripping';
    PageType = List;
    SourceTable = AdditionalChargesStripping;
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
                
                field("Stripping Charges"; Rec."Stripping Charges")
                {
                    ToolTip = 'Specifies the value of the Stripping Charges field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
