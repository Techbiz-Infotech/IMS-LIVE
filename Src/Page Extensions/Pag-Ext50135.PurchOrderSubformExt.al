pageextension 50135 PurchOrderSubformExt extends "Purchase Order Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Description of Goods";Rec."Description of Goods")
            {
                ToolTip = 'Description of Goods';
                ApplicationArea = All;
            }
        }
    }
}
