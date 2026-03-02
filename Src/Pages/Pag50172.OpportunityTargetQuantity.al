page 50172 "Opportunity Estimated Quanity"
{
    //ApplicationArea = All;
    Caption = 'Opportunity Estimated Quanity';
    PageType = List;
    SourceTable = "Opportunity Estimated Quanity";
    UsageCategory = Lists;
    AutoSplitKey = true;
    DelayedInsert = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Opportunity No."; Rec."Opportunity No.")
                {
                    ToolTip = 'Specifies the value of the Opportunity No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 6 Code field.';
                    ApplicationArea = All;
                }
                field("BL No."; Rec."BL No.")
                {
                    ToolTip = 'Specifies the value of the BL No. field.';
                    ApplicationArea = All;
                }
                field(Quantity; Rec."Estimated Quantity")
                {
                    ToolTip = 'Specifies the value of the Esitamted Quantity field.';
                    ApplicationArea = All;
                }
                field("Manifested Quantity"; Rec."Manifested Quantity")
                {
                    ToolTip = 'Specifies the value of the Manifested Quantity field.';
                    ApplicationArea = All;
                }

            }
        }
    }
}
