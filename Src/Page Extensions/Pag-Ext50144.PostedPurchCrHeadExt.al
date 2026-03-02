pageextension 50144 PostedPurchCrHeadExt extends "Posted Purchase Credit Memo"
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

