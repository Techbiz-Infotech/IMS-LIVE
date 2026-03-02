pageextension 50107 CustomerLedgerEntriesExt extends "Customer Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field("Proforma No."; Rec."Proforma No.")
            {
                ApplicationArea = All;
            }
            field("BL No."; Rec."BL No.")
            {
                ApplicationArea = All;
            }
            field("IMS Document Type"; Rec."IMS Document Type")
            {
                ApplicationArea = All;
            }
            field("Clearing Agent Code"; Rec."Clearing Agent Code")
            {
                ApplicationArea = All;
            }
            field("Clearing Agent Name"; Rec."Clearing Agent Name")
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
            // action("Customer Receipt")
            // {
            //     Caption = 'Customer Receipt';
            //     ApplicationArea = All;

            //     trigger OnAction()
            //     var
            //         CustLedg: Record "Cust. Ledger Entry";
            //     begin
            //         CustLedg.reset;
            //         CustLedg.SetRange("Customer No.", rec."Customer No.");
            //         CustLedg.SetRange("Document No.", rec."Document No.");
            //         CustLedg.SetRange("Posting Date", rec."Posting Date");
            //         IF CustLedg.FindFirst() then
            //             Report.Run(50103, true, true, CustLedg);
            //     end;
            // }
            // action("Customer Receipt1")
            // {
            //     Caption = 'Customer Receipt1';
            //     ApplicationArea = All;

            //     trigger OnAction()
            //     var
            //         CustLedg: Record "Cust. Ledger Entry";
            //     begin
            //         CustLedg.reset;
            //         CustLedg.SetRange("Customer No.", rec."Customer No.");
            //         CustLedg.SetRange("Document No.", rec."Document No.");
            //         CustLedg.SetRange("Posting Date", rec."Posting Date");
            //         IF CustLedg.FindFirst() then
            //             Report.Run(50135, true, true, CustLedg);
            //     end;
            // }
            action("Customer Receipt2")
            {
                Caption = 'Customer Receipt';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;
                trigger OnAction()
                var
                    CustLedg: Record "Cust. Ledger Entry";
                begin
                    CustLedg.reset;
                    CustLedg.SetRange("Customer No.", rec."Customer No.");
                    CustLedg.SetRange("Document No.", rec."Document No.");
                    CustLedg.SetRange("Posting Date", rec."Posting Date");
                    IF CustLedg.FindFirst() then
                        Report.Run(50136, true, true, CustLedg);
                end;
            }
            action("Proforma Card")
            {
                Caption = 'Proforma Card';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                //RunPageLink =
                RunObject = page ClosedProformaCard;
                RunPageLink = "Document Type" = const(Order), "No." = field("Proforma No.");
            }
        }
    }
}
