pageextension 50201 BankAccountledgerentries extends "Bank Account Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
                ToolTip = 'External Document No.';
            }
        }
    }
}
