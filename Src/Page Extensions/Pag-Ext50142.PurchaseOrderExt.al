pageextension 50142 PurchaseOrderExt extends "Purchase Order"
{
    layout
    {
        addlast(General)
        {
            field("CU Number"; Rec."CU Number")
            {
                caption = 'CU Number';
                ApplicationArea = All;
            }
        }
    }
}
