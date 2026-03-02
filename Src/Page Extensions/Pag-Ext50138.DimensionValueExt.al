pageextension 50138 DimensionValueExt extends "Dimension Values"
{
    layout
    {
        addafter(Blocked)
        {
            field("Cargo Type"; Rec."Cargo Type")
            {
                ToolTip = 'Cargo Type';
                ApplicationArea = All;
            }
            field("Skip KPA Charges"; rec."Skip KPA Charges")
            {
                ToolTip = '"Skip KPA Charges';
                ApplicationArea = All;
            }
        }
    }
}
