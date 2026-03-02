page 50115 "Position List"
{
    Caption = 'Positions';
    PageType = List;
    SourceTable = Position;
    ApplicationArea = all;
    UsageCategory = Lists;
    CardPageId = 50114;
    //Editable = false;
    layout
    {
        area(content)
        {
            repeater(Genenal)
            {
                field(" Position ID"; Rec." Position ID")
                {
                    ToolTip = 'Specifies the value of the  Position ID field.';
                    ApplicationArea = All;
                }
                field("Position Description"; Rec."Position Description")
                {
                    ToolTip = 'Specifies the value of the Position Description field.';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Container No./Chassis No."; rec."Container No./Chassis No.")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
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
