report 50121 "Proforma Invoice- IMS"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Src/Reports/Layouts/ProformaInvoiceIMS.rdlc';
    //UsageCategory = ReportsAndAnalysis;
    //ApplicationArea = All;
    Caption = 'Proforma-Invoice';
    PreviewMode = PrintLayout;
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";

            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }
            column(CountOfContainer; CountOfContainer)
            { }
            column(No_; "No.")
            { }
            column(Created_By_User_ID;"Created By User ID")
            { }
            column(Posting_Date; "Posting Date")
            { }
            column(Amount_Including_VAT; "Amount Including VAT")
            {
                AutoFormatExpression = GetCurrencySymbol();
                AutoFormatType = 1;
            }
            column(Amount; Amount)
            { }

            column(CompanyLogo; CompanyInfo.Picture)
            { }
            column(BankAccountName; CompanyInfo."Bank Account Name")
            { }
            column(LCYAccount1; CompanyInfo."LCY Account 1")
            {
            }
            column(LCYAccount2; CompanyInfo."LCY Account 2")
            {
            }
            column(FCYAccount1; CompanyInfo."FCY Account 1")
            { }
            column(FCYAccount2; CompanyInfo."FCY Account 2")
            { }
            column(BankAccountNo; CompanyInfo."Bank Account No.")
            { }
            column(SwiftCode; CompanyInfo."SWIFT Code")
            { }
            column(BranchCode; CompanyInfo."Bank Branch No.")
            { }
            column(BankName; CompanyInfo."Bank Name")
            { }
            column(LineDiscAmount; LineDiscAmount)
            { }

            column(VATAmount; VATAmount)
            { }
            column(portDischarge; manifestLineInfo."Port of Discharge")
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
            column(Currency_Code; "Currency Code")
            { }
            column(CurrencyCap; CurrencyCap)
            { }
            column(TotalAmt; TotalAmt)
            { }
            column(RateExh; RateExh)
            { }
            column(StorageStarts; StorageStarts)
            { }
            column(Job_File_No_; manifestLineInfo."Job File No.")
            { }
            column(Expected_Arrival_Date; manifestLineInfo."Expected Arrival Date")
            { }
            column(Vessel_Arrival_Date; manifestLineInfo."Vessel Arrival Date")
            { }
            column(Last_Sling_Date; manifestLineInfo."Last Sling Date")
            { }
            column(Vessel_Name; manifestLineInfo."Vessel Name")
            { }
            column(ConsigneeName; manifestLineInfo."Consignee Name")
            { }
            column(ClearingAgent; ClearingAgentName)
            { }
            column(Voyage_No_; manifestLineInfo."Voyage No.")
            { }
            column(ShortcutDimension1Code; SalesLineRec."Shortcut Dimension 1 Code")
            { }
            column(BLNo; "BL No.")
            { }
            column(Text001; Text001)
            { }
            column(text002; text002)
            { }
            column(Text003; Text003)
            { }
            column(Text004; Text004)
            { }
            column(Text005; Text005)
            { }
            column(Text006; Text006)
            { }
            column(Text007; Text007)
            { }
            column(Text008; Text008)
            { }
            column(Text009; Text009)
            { }
            column(Text010; Text010)
            { }
            column(Text011; Text011)
            { }
            column(text012; text012)
            { }
            column(Text013; Text013)
            { }
            column(Text014; Text014)
            { }
            column(Text015; Text015)
            { }


            trigger OnAfterGetRecord()
            var
            begin
                SalesLineRec.Reset();
                SalesLineRec.SetRange("Document Type", "Document Type");
                SalesLineRec.SetRange("Document No.", "No.");
                IF SalesLineRec.FindFirst() then begin
                    manifestLineInfo.Reset();
                    manifestLineInfo.SetRange("Global Dimension 1 Code", SalesLineRec."Shortcut Dimension 1 Code");
                    if manifestLineInfo.FindFirst() then begin
                       // manifestheaderInfo.Get(manifestLineInfo."Job File No.");
                        //:= manifestheaderInfo."Job File No.";
                        VATAmount := "Sales Header"."Amount Including VAT" - "Sales Header".Amount;

                        If clearingAgentRec.get(manifestLineInfo."Clearing Agent") then
                            ClearingAgentName := clearingAgentRec."Clearing Agent Name"
                        else
                            ClearingAgentName := '';
                    end;
                    clear(CountOfContainer);

                    SalesLineRec.Reset();
                    SalesLineRec.SetCurrentKey("Shortcut Dimension 1 Code");
                    SalesLineRec.SetAscending("Shortcut Dimension 1 Code", true);
                    SalesLineRec.setrange("Document No.", "No.");
                    if SalesLineRec.FindSet() then begin
                        repeat
                            if GroupByContainerID <> SalesLineRec."Shortcut Dimension 1 Code" then begin
                                GroupByContainerID := SalesLineRec."Shortcut Dimension 1 Code";
                                CountOfContainer := CountOfContainer + 1;
                            end else
                                GroupByContainerID := SalesLineRec."Shortcut Dimension 1 Code";
                        until SalesLineRec.Next() = 0;

                    end;
                    IF Amount <> "Amount Including VAT" then
                        VATInUSD := ("Amount Including VAT" - Amount)
                    else
                        VATInUSD := 0;
                    IF "Currency Code" <> '' then begin
                        Clear(GrossKshs);
                        Clear(RateExh);
                        CurrencyExc.Reset();
                        CurrencyExc.SetRange("Currency Code", "Sales Header"."Currency Code");
                        IF CurrencyExc.FindLast() then begin
                            //GrossUSD := "Sales Header"."Currency Code";
                            CurrencyCap := "Sales Header"."Currency Code";
                            //RateExh := (CurrencyExc."Relational Exch. Rate Amount" / CurrencyExc."Exchange Rate Amount");
                            RateExh := (1 / "Sales Header"."Currency Factor");
                            GrossKshs := Amount * RateExh;
                            VATInUSD := VATInUSD * RateExh;

                        end;
                    end else begin
                        GrossKshs := Amount;
                        VATInUSD := VATInUSD;
                        RateExh := 0;
                        //CurrencyCap := '';
                        CurrencyCap := 'KSH';
                    end;
                    TotalAmt := Round(GrossKshs) + Round(VATInUSD);
                end;
                Clear(LineDiscAmount);
                SalesLineRec.Reset();
                SalesLineRec.SetRange("Document Type", "Document Type"::Order);
                SalesLineRec.SetRange("Document No.", "Sales Header"."No.");
                if SalesLineRec.FindFirst() then
                    repeat
                        LineDiscAmount += SalesLineRec."Line Discount Amount";
                    until SalesLineRec.next = 0;

            end;

            trigger OnPostDataItem()
            begin

            end;
        }
        dataitem("Sales Line"; "Sales Line")
        {
            DataItemLinkReference = "Sales Header";
            DataItemLink = "Document No." = field("No.");

            DataItemTableView = sorting("Document No.", "Line No.");
            column(Description_SalesInvoiceLine; Description)
            { }
            column(Unit_Price_SalesInvoiceLine; "Unit Price")
            { }
            column(Quantity; Quantity)
            { }
            column(Line_Discount_Amount; "Line Discount Amount")
            { }
            column(VAT_Base_Amount; "VAT Base Amount")
            { }
            column(Line_Amount; "Line Amount")
            { }
            column(VAT__; "VAT %")
            { }
            column(InvBL_No; "BL No.")
            { }
            column(Container_No__Chassis_No_; "Container No./Chassis No.")
            { }
            column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
            { }
            column(Storage_Start_Date; "Storage Start Date")
            { }
            column(Free_Days; freedays)
            { }
            column(Storage_Days; storageDays)
            { }
            column(No_SalesLineNo; "No.")
            { }
            column(Weight; manifestlineinfo.Weight)
            { }
            column(CBM_Tonage; manifestLineInfo."CBM Tonage")
            { }
            column(Seal_Engine_No_; manifestlineinfo."Seal/Engine No.")
            { }
            column(Description; manifestlineinfo.Description)
            { }
            column(Consignee_Name; manifestlineinfo."Consignee Name")
            { }
            column(ItemNo; "No.")
            { }
            column(Charge_ID; "Charge ID")
            { }
            trigger OnAfterGetRecord()
            begin
                ManifestLineinfo.Reset();
                ManifestLineinfo.SetRange("Global Dimension 1 Code", "Sales Line"."Shortcut Dimension 1 Code");
                if ManifestLineinfo.FindFirst() then;

                SalesLine2.reset;
                SalesLine2.SetRange("Document No.", "Sales Header"."No.");
                SalesLine2.SetRange("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                SalesLine2.SetFilter("Free Days", '<>%1', 0);
                if SalesLine2.FindFirst() then
                    Freedays := SalesLine2."Free Days";
                StorageDays := SalesLine2."Storage Days";
            end;
        }
    }
    var
        myInt: Integer;
        //manifestheaderInfo: Record "Manifest Header";
        manifestLineInfo: Record "Manifest Line";
        CompanyInfo: Record "Company Information";
        TotalKSHTOPAY: Decimal;
        TotalUSDTOPAY: Decimal;
        Totalwaiver: decimal;
        Rate: Decimal;
        GrossUSD: Code[20];
        GrossKshs: Decimal;
        VATInKshs: Decimal;
        VATAmount: Decimal;
        VATInUSD: Decimal;
        StorageStarts: Date;
        CountOfContainer: Integer;
        GroupByContainerID: code[20];
        ExchangeRate: Decimal;
        RateExh: Decimal;
        StorageDays, Freedays : Decimal;
        CurrencyCap: Code[20];
        TotalAmt: Decimal;
        CurrencyExc: Record "Currency Exchange Rate";
        ChargeIDinfo: Record "Charge ID Group Header";
        SalesLine2, SalesLineRec : Record "Sales Line";
        Text001: label 'We advise that you make any';
        text002: Label 'Cash Deposits';
        Text003: Label 'or';
        LineDiscAmount: Decimal;

        Text004: Label 'RTGS';
        Text005: Label 'to the following bank accounts only. Deliver all other payments in';
        Text006: Label 'Bankers CHQ';
        Text007: Label 'to the cashier';
        Text008: Label 'Nairobi Inland Cargo Terminal Ltd';
        Text009: Label 'Transnational Bank (K) Ltd';
        Text010: Label 'City Hall Way';
        Text011: Label '0210397001';
        text012: Label '0210397002';
        Text013: Label 'TNBLKENA';
        Text014: Label '26';
        Text015: Label '001';
        ClearingAgentName: Text[50];
        ClearingAgentRec: Record "Clearing Agent";
    //ExchangeRate: Record "Currency Exchange Rate";

    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture)
    end;
}