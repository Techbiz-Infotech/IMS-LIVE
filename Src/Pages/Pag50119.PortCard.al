page 50119 "Port Card"
{
    Caption = 'Port Card';
    PageType = Card;
    SourceTable = Port;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Port Code"; Rec."Port Code")
                {
                    ToolTip = 'Specifies the value of the Port Code field.';
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                    begin
                        if rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("User ID"; rec."User ID")
                {
                    ToolTip = 'Specifies the value of the Start After field.';
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
