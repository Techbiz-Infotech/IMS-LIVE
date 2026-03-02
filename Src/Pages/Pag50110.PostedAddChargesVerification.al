page 50110 "Posted AddCharges Verification"
{
    //ApplicationArea = All;
    Caption = 'Posted AddCharges Verification';
    PageType = List;
    SourceTable = "Posted AddCharges Verification";
    UsageCategory = History;
    //Editable = false;

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
