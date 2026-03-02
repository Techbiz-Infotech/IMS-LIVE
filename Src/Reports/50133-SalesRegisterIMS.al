report 50133 SalesRegisterIMS
{
    ApplicationArea = All;
    Caption = 'Sales Register IMS';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Src/Reports/Layouts/SalesRegisterIMS.rdlc';
    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
        {
            CalcFields = "Clearing Agent", "Clearing Agent Name";
            RequestFilterFields = "Sell-to Customer No.", "Posting Date", "Clearing Agent", "BL No.";
            column(No; "No.") { }
            column(PostingDate; "Posting Date") { }
            column(SelltoCustomerName; "Sell-to Customer Name") { }
            column(ClearingAgentName; "Clearing Agent Name") { }
            column(BLNo; "BL No.") { }
            column(JobFileNo; "Job File No.") { }
            column(Amount; Amount) { }
            column(AmountIncludingVAT; "Amount Including VAT") { }
            column(CurrencyCode; "Currency Code") { }
            column(CurrExchRate; CurrExchRate) { }
            column(VATAmount; VATAmount) { }
            column(AmountLCY; AmountLCY) { }
            column(AmountWithVATLCY; AmountWithVATLCY) { }
            column(VATAmountLCY; VATAmountLCY) { }
            column(Applies_to_Doc__Type; "Applies-to Doc. Type") { }
            column(Applies_to_Doc__No_; "Applies-to Doc. No.") { }


            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(Document_No_; "Document No.") { }
                column(Description; Description) { }
                column(Line_Amount; "Line Amount") { }

            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                VATAmount := 0;
                AmountLCY := 0;
                AmountWithVATLCY := 0;
                VATAmountLCY := 0;
                IF SalesInvoiceHeader."Currency Code" <> '' then begin
                    VATAmount := SalesInvoiceHeader."Amount Including VAT" - SalesInvoiceHeader.Amount;
                    CurrExchRate := (1 / SalesInvoiceHeader."Currency Factor");
                    AmountLCY := SalesInvoiceHeader.Amount * CurrExchRate;
                    AmountWithVATLCY := SalesInvoiceHeader."Amount Including VAT" * CurrExchRate;
                    VATAmountLCY := VATAmount * CurrExchRate;
                end else begin
                    AmountLCY := SalesInvoiceHeader.Amount;
                    AmountWithVATLCY := SalesInvoiceHeader."Amount Including VAT";
                    VATAmountLCY := AmountWithVATLCY - AmountLCY;
                end;
            end;
        }
        dataitem(SalesCrHeader; "Sales Cr.Memo Header")
        {
            CalcFields = "Clearing Agent", "Clearing Agent Name";
            RequestFilterFields = "Sell-to Customer No.", "Posting Date", "Clearing Agent", "BL No.";
            column(CrNo; "No.") { }
            column(CrPostingDate; "Posting Date") { }
            column(CrSelltoCustomerName; "Sell-to Customer Name") { }
            column(CrClearingAgentName; "Clearing Agent Name") { }
            column(CrBLNo; "BL No.") { }
            column(CrJobFileNo; "Job File No.") { }
            column(CrAmount; Amount) { }
            column(CrAmountIncludingVAT; "Amount Including VAT") { }
            column(CrCurrencyCode; "Currency Code") { }
            column(CrCurrExchRate; CrCurrExchRate) { }
            column(CrVATAmount; CrVATAmount) { }
            column(CrAmountLCY; CrAmountLCY) { }
            column(CrAmountWithVATLCY; CrAmountWithVATLCY) { }
            column(CrVATAmountLCY; CrVATAmountLCY) { }
            column(CrApplies_to_Doc__No_; "Applies-to Doc. No.") { }
            column(CrApplies_to_Doc__Type; "Applies-to Doc. Type") { }
            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(CrDocument_No_; "Document No.") { }
                column(CrDescription; Description) { }
                column(CrLine_Amount; "Line Amount") { }
            }
            trigger OnAfterGetRecord()
            begin
                CrVATAmount := 0;
                CrAmountLCY := 0;
                CrAmountWithVATLCY := 0;
                CrVATAmountLCY := 0;
                IF SalesCrHeader."Currency Code" <> '' then begin
                    CrVATAmount := SalesCrHeader."Amount Including VAT" - SalesCrHeader.Amount;
                    CrCurrExchRate := (1 / SalesCrHeader."Currency Factor");
                    CrAmountLCY := SalesCrHeader.Amount * CrCurrExchRate;
                    CrAmountWithVATLCY := SalesCrHeader."Amount Including VAT" * CrCurrExchRate;
                    CrVATAmountLCY := CrVATAmount * CrCurrExchRate;
                end else begin
                    CrAmountLCY := SalesCrHeader.Amount;
                    CrAmountWithVATLCY := SalesCrHeader."Amount Including VAT";
                    CrVATAmountLCY := CrAmountWithVATLCY - CrAmountLCY;
                end;



            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        VATAmount: Decimal;
        CurrExchRate: Decimal;
        AmountLCY: Decimal;
        AmountWithVATLCY: Decimal;
        VATAmountLCY: Decimal;
        CrVATAmount: Decimal;
        CrCurrExchRate: Decimal;
        CrAmountLCY: Decimal;
        CrAmountWithVATLCY: Decimal;
        CrVATAmountLCY: Decimal;


}
