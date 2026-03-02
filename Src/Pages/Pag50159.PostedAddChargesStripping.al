page 50159 "Posted AddCharges Stripping"
{
    //ApplicationArea = All;
    Caption = 'Posted AddCharges Stripping';
    PageType = List;
    SourceTable = "Posted AddCharges Stripping";
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
                
                field("Stripping Charges"; Rec."Stripping Charges")
                {
                    ToolTip = 'Specifies the value of the Stripping Charges field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
