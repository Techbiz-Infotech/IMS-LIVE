page 50101 "Container Card"
{
    Caption = 'Container';
    PageType = Card;
    SourceTable = "Dimension Value";
    SourceTableView = where("Dimension Code" = filter('CONTAINER'));
    //Editable = false;


    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the code for the dimension value.';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies a descriptive name for the dimension value.';
                    ApplicationArea = All;
                }
                field("Customer No."; REC."Customer No.")
                {
                    ApplicationArea = ALL;
                    TableRelation = Customer;

                }
                field("Customer Name"; REC."Customer Name")
                {
                    ApplicationArea = ALL;
                }
                field("Container/Chassis No."; Rec."Container/Chassis No.")
                {
                    ToolTip = 'Specifies the value of the Container/Chassis No. field.';
                    ApplicationArea = All;
                }
                field("BL No."; Rec."BL No.")
                {
                    ToolTip = 'Specifies the value of the BL No. field.';
                    ApplicationArea = All;
                }
                field("Position No."; Rec."Position No.")
                {
                    ToolTip = 'Specifies the value of the Position No. field.';
                    ApplicationArea = All;
                }
                field("Job File No."; Rec."Job File No.")
                {
                    ToolTip = 'Specifies the value of the Job File No. field.';
                    ApplicationArea = All;
                }
                field("Manifest Line No."; Rec."Manifest Line No.")
                {
                    ToolTip = 'Specifies the value of the Manifest Line No. field.';
                    ApplicationArea = All;
                }
                field("Container Status"; Rec."Container Status")
                {
                    ToolTip = 'Specifies the value of the Container Status field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dimension 3 field.';
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dimension 4 field.';
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dimension 5 field.';
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dimension 6 field.';
                }
            }
        }

    }
    trigger OnModifyRecord(): Boolean
    var
        usersetup: Record "User Setup";
    begin
        if usersetup.Get(UserId) then begin
            if not usersetup.Containers then
                error('You do not have permission to edit')
            else
                exit;
        end;

    end;
}
