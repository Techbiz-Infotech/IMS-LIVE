pageextension 50108 VendorLEdgEntriesExt extends "Vendor Ledger Entries"
{
    actions
    {
        //addafter("Bank Accounts")
        addbefore(Dimensions)
        {
            action("Payment Receipt")
            {
                Caption = 'Payment Receipt';
                ApplicationArea = All;

                trigger OnAction()
                var
                    VendLedg: Record "Vendor Ledger Entry";
                begin
                    VendLedg.reset;
                    VendLedg.SetRange("Vendor No.", rec."Vendor No.");
                    VendLedg.SetRange("Document No.", rec."Document No.");
                    VendLedg.SetRange("Posting Date", rec."Posting Date");
                    IF VendLedg.FindFirst() then
                        Report.Run(50116, true, true, VendLedg);
                end;
            }
        }
    }
}
