pageextension 50106 CashReceiptJournalExt extends "Cash Receipt Journal"
{
    layout
    {
        addafter(Description)
        {
            field("Payment Method Code1"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
            }
        }
        modify("External Document No.")
        {
            caption = 'Check No.';
        }
    }
}
