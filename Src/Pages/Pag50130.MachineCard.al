page 50130 MachineCard
{
    Caption = 'Machine Card';
    PageType = Card;
    SourceTable = Machine;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Machine Code"; Rec."Machine Code")
                {
                    ToolTip = 'Specifies the value of the Machine Code field.';
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
                field("Machine Serial No."; Rec."Machine Serial No.")
                {
                    ApplicationArea = All;
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
