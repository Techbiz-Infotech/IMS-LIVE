page 50136 "Vehicle Card"
{
    Caption = 'Vehicle';
    PageType = Card;
    SourceTable = Vehicle;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ToolTip = 'Specifies the value of the Vehicle No. field.';
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                    begin
                        if rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Vehicle Name"; Rec."Driver Name")
                {
                    ToolTip = 'Specifies the value of the Vehicle Name field.';
                    ApplicationArea = All;
                }
                field(Trailer; Rec.Trailer)
                {
                    ApplicationArea = All;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
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
