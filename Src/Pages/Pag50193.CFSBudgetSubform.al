page 50193 "CFS Budget Subform"
{
    Caption = 'CFS Budget Lines';
    PageType = ListPart;
    SourceTable = "CFS Budget Line";
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Budget Year"; Rec."Budget Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BudgetYear field.';
                    Visible = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                    Visible = false;
                }
                field("Budget Type"; rec."Budget Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Budget Type field.';
                    Visible = false;

                }

                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.';
                    Visible = false;
                }
                field("Shortcut Dimension 4 Code"; rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
                    Editable = false;
                }
                field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                    Visible = false;
                }
                field("Shortcut Dimension 5 Code"; rec."Shortcut Dimension 5 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.';
                    Editable = false;
                }

                field("Shortcut Dimension 6 Code"; rec."Shortcut Dimension 6 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 6 Code field.';
                    Visible = false;
                }

                field(January; rec.January)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the January field.';
                }
                field(February; rec.February)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Feburary field.';
                }
                field(March; Rec.March)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the March field.';
                }
                field(April; Rec.April)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the April field.';
                }
                field(May; Rec.May)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the May field.';
                }
                field(June; Rec.June)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the June field.';
                }
                field(July; Rec.July)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the July field.';
                }
                field(August; Rec.August)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the August field.';
                }
                field(September; rec.September)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the September field.';
                }
                field(October; rec.October)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the October field.';
                }
                field(November; rec.November)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the November field.';
                }
                field(December; rec.December)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the December field.';
                }

            }
        }
    }
}
