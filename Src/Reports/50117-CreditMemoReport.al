report 50117 "Credit Memo Report"
{
    Caption = 'Credit Memo IMS';
    DefaultLayout = RDLC;
    RDLCLayout = './Src/Reports/Layouts/SalesCreditMemoSICD.rdlc';
    UsageCategory = ReportsAndAnalysis;
    //ApplicationArea = All;

    PreviewMode = PrintLayout;
    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Credit memo';
            column(No_SalesCredHeader; "No.")
            {

            }
            column(Created_By_User_ID; "User ID")
            { }
            column(VAT_Registration_No_; Custrec."VAT Registration No.") { }

            column(CountOfContainer; CountOfContainer)
            { }
            column(Currency_Code; "Currency Code")
            { }
            column(CurrencyCap; CurrencyCap)
            { }
            //column(GrossKshs; GrossKshs)
            //{ }
            //column(VATFCY; VATFCY)
            //{ }
            column(TotalAmt; TotalAmt)
            { }
            column(RateExh; RateExh)
            { }
            column(VATFCY; VATFCY)
            { }

            column(portdischarge; manifestLineInfo."Port of Discharge")
            { }
            column(Sell_to_Customer_Name_SalescredHeader; "Sell-to Customer Name")
            {

            }

            column(Posting_Date; "Posting Date")
            { }
            column(Amount; Amount)
            {
                //AutoFormatExpression = GetCurrencySymbol();
                //AutoFormatType = 1;
            }
            column(Amount_Including_VAT; "Amount Including VAT")
            {
                //AutoFormatExpression = GetCurrencySymbol();
                //AutoFormatType = 1;
            }




            column(BL_No_; "BL No.")
            { }
            column(ClearingAgent; manifestLineInfo."Clearing Agent")
            { }
            column(Destination_Type; "Destination Type")
            { }
            column(Consignee_Name; manifestlineinfo."Consignee Name")
            { }
            column(Expected_Arrival_Date; manifestlineinfo."Expected Arrival Date")
            { }
            column(Vessel_Arrival_Date; manifestlineinfo."Vessel Arrival Date")
            { }
            column(JobFileNO; manifestlineinfo."Job File No.")
            { }
            column(Last_Sling_Date; manifestlineinfo."Last Sling Date")
            { }
            column(Vessel_Name; manifestlineinfo."Vessel Name")
            { }
            column(Voyage_No_; manifestlineinfo."Voyage No.")
            { }
            column(CompanyLogo; CompanyInfo.Picture)
            { }
            column(CompanyName; CompanyInfo.Name)
            { }
            column(CompanyAddress; CompanyInfo.Address)
            { }
            column(CompanyAddress2; CompanyInfo."Address 2")
            { }
            column(CompanyPhone; CompanyInfo."Phone No.")
            { }
            column(CompanyEmail; CompanyInfo."E-Mail")
            { }
            column(CompanyVATNo; CompanyInfo."VAT Registration No.")
            { }
            column(CaptionKsh; CaptionKsh)
            { }
            column(LineDiscAmount; LineDiscAmount)
            { }
            column(ValueKsh; ValueKsh)
            { }
            trigger OnPreDataItem()
            begin
                if "Sales Cr.Memo Header".Warehouse then
                    Error('Please Use Warehouse Invoice');
            end;


            trigger OnAfterGetRecord()
            begin
                if CustRec.get("Sales Cr.Memo Header"."Sell-to Customer No.") then;
                SaleCredLine.Reset();
                SaleCredLine.SetRange("Document No.", "No.");
                SaleCredLine.SetFilter("Shortcut Dimension 1 Code", '<>%1', ' ');
                IF SaleCredLine.FindSet() then begin
                    manifestLineInfo.Reset();
                    manifestLineInfo.SetRange("Global Dimension 1 Code", SaleCredLine."Shortcut Dimension 1 Code");
                    if manifestLineInfo.FindFirst() then begin
                        // VATAmount := "Amount Including VAT" - Amount;
                        //:= manifestheaderInfo."Job File No.";
                    end;
                end;
                VATAmount := "Sales Cr.Memo Header"."Amount Including VAT" - "Sales Cr.Memo Header".Amount;
                clear(CountOfContainer);

                SaleCredLine.Reset();
                SaleCredLine.SetCurrentKey("Shortcut Dimension 1 Code");
                SaleCredLine.SetAscending("Shortcut Dimension 1 Code", true);
                SaleCredLine.setrange("Document No.", "No.");
                if SaleCredLine.FindSet() then begin
                    repeat
                        if GroupByContainerID <> SaleCredLine."Shortcut Dimension 1 Code" then begin
                            GroupByContainerID := SaleCredLine."Shortcut Dimension 1 Code";
                            CountOfContainer := CountOfContainer + 1;
                        end else
                            GroupByContainerID := SaleCredLine."Shortcut Dimension 1 Code";
                    until SaleCredLine.Next() = 0;
                    //Message(Format(CountOfContainer));
                end;
                GLsetUp.get;
                IF Amount <> "Amount Including VAT" then
                    VATFCY := ("Amount Including VAT" - Amount)
                else
                    VATFCY := 0;
                IF "Currency Code" <> '' then begin
                    Clear(GrossKshs);
                    Clear(RateExh);
                    CurrencyCap := "Sales Cr.Memo Header"."Currency Code";
                    RateExh := (1 / "Sales Cr.Memo Header"."Currency Factor");
                    GrossKshs := Amount * RateExh;
                    ValueKsh := Format(GrossKshs);
                    CaptionKsh := 'Gross Kshs.';
                    VATFCY := VATFCY * RateExh;
                end else begin
                    GrossKshs := Amount;
                    CaptionKsh := '';
                    ValueKsh := '';
                    VATFCY := VATFCY;
                    RateExh := 1;
                    //CurrencyCap := 'GBP';
                    CurrencyCap := GLsetUp."LCY Code";
                end;
                TotalAmt := Round(GrossKshs) + Round(VATFCY);
                Clear(LineDiscAmount);
                SaleCredLine.Reset();
                SaleCredLine.SetRange("Document No.", "Sales Cr.Memo Header"."No.");
                if SaleCredLine.FindFirst() then
                    repeat
                        LineDiscAmount += SaleCredLine."Line Discount Amount";
                    until SaleCredLine.next = 0;
            end;

        }
        dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
        {
            DataItemLink = "Document No." = field("No.");
            DataItemLinkReference = "Sales Cr.Memo Header";
            DataItemTableView = sorting("Document No.", "Line No.");
            column(Description_SalesCredLine; Description)
            { }
            column(Unit_Price_SalesCredLine; "Unit Price")
            { }
            column(Quantity; Quantity)
            { }
            column(Line_Discount_Amount; "Line Discount Amount")
            { }
            // column(Amount;Amount){}
            column(VAT_Base_Amount; "VAT Base Amount")
            { }
            column(Line_Amount; "Line Amount")
            { }
            //column(Container_No__Chassis_No_; "Container No./Chassis No.")
            //{ }
            column(Weight; manifestlineinfo.Weight)
            { }
            column(CBM_Tonage; manifestLineInfo."CBM Tonage")
            { }
            column(Container_Chassis_No_; manifestlineinfo."Container/Chassis No.")
            { }
            column(Seal_Engine_No_; manifestlineinfo."Seal/Engine No.")
            { }
            column(Description; manifestlineinfo.Description)
            { }
            column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
            { }
            column(SalesCreBL; "BL No.")
            { }
            column(ItemNo; "No.")
            { }
            column(VATAmount; VATAmount)
            { }
            column(TotalKSHToPAY; TotalKSHToPAY)
            { }
            column(GrossKshs; GrossKshs)
            { }
            column(GrossUSD; GrossUSD)
            { }
            column(VATInKshs; VATInKshs)
            { }

            column(TotalUSDtopay; TotalUSDtopay)
            { }
            column(VATInUSD; VATInUSD)
            { }
            column(Totalwaiver; Totalwaiver)
            { }
            column(Rate; Rate)
            { }
            column(Charge_ID; "Charge ID")
            { }
            column(HSCode; HSCode)
            { }
            trigger OnAfterGetRecord()
            begin
                ManifestLineinfo.Reset();
                ManifestLineinfo.SetRange("Global Dimension 1 Code", "Sales Cr.Memo Line"."Shortcut Dimension 1 Code");
                if ManifestLineinfo.FindFirst() then;
                IMSSetup.Get();
                if ("Sales Cr.Memo Line".Type = "Sales Cr.Memo Line".Type::Item) or ("Sales Cr.Memo Line".Type = "Sales Cr.Memo Line".Type::"G/L Account") then begin
                    IF "Sales Cr.Memo Line"."VAT Prod. Posting Group" = 'EXEMPT' then
                        HSCode := IMSSetup."Default HS Code";
                    IF "Sales Cr.Memo Line"."VAT Prod. Posting Group" = 'ZERO' then
                        HSCode := IMSSetup."Default HS Code Zero rated";
                end;
            end;


        }


    }

    var
        CustRec: Record Customer;
        myInt: Integer;

        manifestLineInfo: Record "Manifest Line";
        CompanyInfo: Record "Company Information";
        GLsetUp: Record "General Ledger Setup";
        TotalKSHToPAy: Decimal;
        TotalUSDtopay: Decimal;
        Totalwaiver: decimal;
        Rate: Decimal;
        GrossUSD: Decimal;
        GrossKshs: Decimal;
        VATInKshs: Decimal;
        VATAmount: Decimal;
        VATInUSD: Decimal;
        RateExh: Decimal;
        GroupByContainerID: code[20];
        SaleCredLine: Record "Sales Cr.Memo Line";
        SaleCredHeader: Record "Sales Cr.Memo Header";
        CountOfContainer: integer;
        CurrencyCap: Code[20];
        TotalAmt: Decimal;
        CurrencyExc: Record "Currency Exchange Rate";
        GROSSGROSSFCYF: Decimal;
        GROSSLCY: Decimal;
        LineDiscAmount: Decimal;



        VATLCY: Decimal;
        VATFCY: Decimal;

        CaptionKsh: text[50];
        ValueKsh: Text[50];
        IMSSetup: Record "IMS Setup";
        HSCode: Code[20];




    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture)
    end;
}