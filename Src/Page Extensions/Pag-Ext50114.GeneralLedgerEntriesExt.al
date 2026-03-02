pageextension 50114 GeneralLedgerEntriesExt extends "General Ledger Entries"
{
    layout
    {
        addafter("Document Type")
        {
            field("IMS Document Type"; Rec."IMS Document Type")
            {
                ApplicationArea = All;
            }
            field("Prepayment Reversed";rec."Prepayment Reversed")
            {
                ApplicationArea = All;
            }
            
        }
    }
    actions
    {
        //addafter("Bank Accounts")
        addbefore(Dimensions)
        {
            action("Print Voucher")
            {
                Caption = 'Print Voucher';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;
                trigger OnAction()
                var
                    GLLedg: Record "G/L Entry";
                begin
                    GLLedg.reset;
                    GLLedg.SetRange("Document No.", rec."Document No.");
                    GLLedg.SetRange("Posting Date", rec."Posting Date");
                    IF GLLedg.FindFirst() then
                        Report.Run(50118, true, true, GLLedg);
                end;
            }
        }
    }
}
