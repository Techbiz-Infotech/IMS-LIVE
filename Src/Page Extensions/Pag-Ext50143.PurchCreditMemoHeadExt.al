pageextension 50143 PurchCreditMemoHeadExt extends "Purchase Credit Memo"
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
