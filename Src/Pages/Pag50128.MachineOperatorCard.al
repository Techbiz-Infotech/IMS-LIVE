page 50128 "Machine Operator Card"
{
    Caption = 'Machine Operator';
    PageType = Card;
    SourceTable = "Machine Operator";
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Machine Operator Code"; Rec."Machine Operator Code")
                {
                    ToolTip = 'Specifies the value of the Machine Operator Code field.';
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                    begin
                        if rec.AssistEdit(xRec) then CurrPage.Update();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
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
                    Message('Posted Successfully');
                end;
            }
        }
    }
}
