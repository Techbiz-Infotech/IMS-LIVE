page 50114 PositionCard
{
    Caption = 'Position Card';
    PageType = Card;
    SourceTable = Position;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(" Position ID"; Rec." Position ID")
                {
                    ToolTip = 'Specifies the value of the  Position ID field.';
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                    begin
                        if rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
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
    actions
    {
        area(Navigation)
        {
            action(Post)
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                end;
            }
        }
    }
}