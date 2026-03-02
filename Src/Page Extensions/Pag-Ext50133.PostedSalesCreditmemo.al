pageextension 50133 PostedSalesCreditmemo extends "Posted Sales Credit Memo"
{
    layout
    {
        addlast(General)
        {
            field("Credit Note Reason Type"; Rec."Credit Note Reason Type")
            {
                caption = 'Credit Note Reason Type';
                ApplicationArea = All;
            }
            field("BL No."; rec."BL No.")
            {
                caption = 'BL  No.';
                ApplicationArea = All;
            }
            field("Job File No."; rec."Job File No.")
            {
                Caption = 'Job File No.';
                ApplicationArea = All;
            }
            field("Job File Date"; rec."Job File Date")
            {
                Caption = 'job File Date';
                ApplicationArea = All;
            }
            field("Clearing Agent"; rec."Clearing Agent")
            {
                Caption = 'Clearing Agent';
                ApplicationArea = All;
            }
            field("Clearing Agent Name"; rec."Clearing Agent Name")
            {
                Caption = 'Clearing Agent Name';
                ApplicationArea = All;
            }
        }
    }
    actions
    {


        modify(Print)
        {
            Caption = 'Terminal Sales Cr.Memo';
        }


        // }
        // addafter(SendCustom)
        // {
        // action("Terminal Sales Cr.Memo")
        // {
        //     ApplicationArea = Basic, Suite;
        //     Caption = 'Terminal Sales Cr.Memo';
        //     Ellipsis = true;
        //     Image = Print;
        //     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
        //     //PromotedCategory = Category5;
        //     ToolTip = 'View or print the Sales Cr.Memo';

        //     trigger OnAction()
        //     var
        //         SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        //     begin
        //         //DocPrint.PrintProformaSalesInvoice(Rec);
        //         SalesCrMemoHeader.Reset();
        //         SalesCrMemoHeader.SetRange("No.", Rec."No.");
        //         IF SalesCrMemoHeader.FindFirst() then begin
        //             //if SalesCrMemoHeader.Warehouse = false then
        //                 report.RunModal(report::"Credit Memo Report", true, true, SalesCrMemoHeader)
        //             // else
        //             //     Error('Please use WarehouseHouse Credit Memo');

        //         end;
        //     end;
        // }
        // }

        // }
    }
}
