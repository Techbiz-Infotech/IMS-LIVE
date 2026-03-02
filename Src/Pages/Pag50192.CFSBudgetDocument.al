page 50192 "CFS Budget Document"
{
    Caption = 'CFS Budget Document';
    PageType = Document;
    SourceTable = "CFS Budget Header";
    InsertAllowed = false;


    layout
    {
        area(content)
        {
            group(General)
            {
                field("Budget Year"; rec."Budget Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Budget Year field.';
                    Editable = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                    Editable = false;
                }
                field("Budget Type"; rec."Budget Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Budget Type field.';

                }
            }
            part(CFSBudgetLine; 50193)
            {
                ApplicationArea = all;
                SubPageLink = "Budget Year" = field("Budget Year"), "Shortcut Dimension 3 Code" = field("Shortcut Dimension 3 Code"), "Budget Type" = field("Budget Type");
                UpdatePropagation = Both;

            }
        }
    }
}
