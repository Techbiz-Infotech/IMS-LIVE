pageextension 50139 PaymentJournalExt extends "Payment Journal"
{
    layout
    {
        addafter(Description)
        {
            field("Deferral Code"; Rec."Deferral Code")
            {
                ApplicationArea = All;
            }
            field("Deferral Line No.";Rec."Deferral Line No.")
            {
                ApplicationArea = All;
            }
        }

    }
}
