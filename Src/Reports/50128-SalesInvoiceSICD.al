report 50128 "Sales Invoice - SICD"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Src/Reports/Layouts/SalesInvoiceSICD.rdl';
    UsageCategory = ReportsAndAnalysis;
    //ApplicationArea = All;
    Caption = 'Sales-Invoice SICD';
    PreviewMode = PrintLayout;
    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';
            column(No_SalesInvHeader; "No.")
            { }
            column(Created_By_User_ID; "Created By User ID")
            { }
            column(SystemCreatedAt; SystemCreatedAt) { }
            column(SystemCreatedBy; "User ID") { }
            column(CountOfContainer; CountOfContainer)
            { }
            column(Currency_Code; "Currency Code")
            { }
            column(VAT_Registration_No_; "VAT Registration No.") { }
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
            column(Sell_to_Customer_Name_SalesInvoiceHeader; "Sell-to Customer Name")
            {

            }

            column(Posting_Date; "Posting Date")
            { }
            column(Amount; Amount)
            {
                AutoFormatExpression = GetCurrencySymbol();
                AutoFormatType = 1;
            }
            column(Amount_Including_VAT; "Amount Including VAT")
            {
                AutoFormatExpression = GetCurrencySymbol();
                AutoFormatType = 1;
            }




            column(BL_No_; "BL No.")
            { }
            column(ClearingAgent; GetClearingAgentName(manifestLineInfo."Clearing Agent"))
            { }
            column(Destination_Type; "Destination Type")
            { }
            column(Consignee_Name; manifestlineinfo."Consignee Name")
            { }
            column(Expected_Arrival_Date; manifestLineInfo."Expected Arrival Date")
            { }
            column(Vessel_Arrival_Date; manifestLineInfo."Vessel Arrival Date")
            { }
            column(JobFileNO; manifestLineInfo."Job File No.")
            { }
            column(Last_Sling_Date; manifestLineInfo."Last Sling Date")
            { }
            column(Vessel_Name; manifestLineInfo."Vessel Name")
            { }
            column(Voyage_No_; manifestLineInfo."Voyage No.")
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
            column(CBM_Tonage; manifestLineInfo."CBM Tonage")
            { }
            // column(Weight; manifestlineinfo.Weight)
            // { }
            // column(CBM; CBM) { }
            column(Weight; Weight) { }
            trigger OnPreDataItem()
            begin
                if "Sales Invoice Header".Warehouse then
                    Error('Please Use Warehouse Invoice');
                GLsetUp.get;

            end;


            trigger OnAfterGetRecord()
            begin
                SalesInvoiceLine.Reset();
                SalesInvoiceLine.SetRange("Document No.", "No.");
                SalesInvoiceLine.SetFilter(Type, '<>%1', SalesInvoiceLine.Type::" ");
                IF SalesInvoiceLine.FindFirst() then begin
                    manifestLineInfo.Reset();
                    manifestLineInfo.SetRange("Global Dimension 1 Code", SalesInvoiceLine."Shortcut Dimension 1 Code");
                    manifestlineInfo.setrange("BL No.", SalesInvoiceLine."BL No.");
                    if manifestLineInfo.FindFirst() then begin
                        //if manifestheaderInfo.Get(manifestLineInfo."Job File No.") then;
                        VATAmount := "Sales Invoice Header"."Amount Including VAT" - "Sales Invoice Header".Amount;
                        // VATAmount := "Amount Including VAT" - Amount;
                        //:= manifestheaderInfo."Job File No.";
                    end;
                    Clear(CBM);
                    Clear(Weight);
                    clear(CountOfContainer);

                    SaleInvLine.Reset();

                    SaleInvLine.SetCurrentKey("Shortcut Dimension 1 Code");

                    SaleInvLine.SetAscending("Shortcut Dimension 1 Code", true);

                    SaleInvLine.setrange("Document No.", "No.");

                    if SaleInvLine.FindSet() then begin

                        repeat

                            if GroupByContainerID <> SaleInvLine."Shortcut Dimension 1 Code" then begin

                                GroupByContainerID := SaleInvLine."Shortcut Dimension 1 Code";

                                CountOfContainer := CountOfContainer + 1;
                                //Clear(Weight);
                                ManifestLine.Reset();
                                ManifestLine.SetRange("Global Dimension 1 Code", SaleInvLine."Shortcut Dimension 1 Code");
                                if ManifestLine.FindSet() then begin
                                    repeat
                                        Weight += ManifestLine.Weight;
                                        CBM += ManifestLine."CBM Tonage";
                                    // Weight := Weight;
                                    until ManifestLine.Next() = 0;
                                end;

                            end else
                                GroupByContainerID := SaleInvLine."Shortcut Dimension 1 Code";

                        until SaleInvLine.Next() = 0;


                        //Message(Format(CountOfContainer));

                    end;

                    IF Amount <> "Amount Including VAT" then
                        VATFCY := ("Amount Including VAT" - Amount)
                    else
                        VATFCY := 0;
                    IF "Currency Code" <> '' then begin
                        Clear(GrossKshs);
                        Clear(RateExh);
                        CurrencyExc.Reset();
                        CurrencyExc.SetRange("Currency Code", "Sales Invoice Header"."Currency Code");
                        IF CurrencyExc.FindLast() then begin
                            CurrencyCap := "Sales Invoice Header"."Currency Code";
                            RateExh := (1 / "Sales Invoice Header"."Currency Factor");
                            GrossKshs := Amount * RateExh;
                            ValueKsh := Format(GrossKshs);
                            CaptionKsh := 'Gross Kshs.';
                            VATFCY := VATFCY * RateExh;

                            //VATInUSD := VATInUSD * (CurrencyExc."Relational Exch. Rate Amount" / CurrencyExc."Exchange Rate Amount");
                        end;
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
                end;
                Clear(LineDiscAmount);
                SaleInvLine.Reset();
                SaleInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                if SaleInvLine.FindFirst() then
                    repeat
                        LineDiscAmount += SaleInvLine."Line Discount Amount";
                    until SaleInvLine.next = 0;

            end;


        }
        dataitem("Sales Invoice Line"; "Sales Invoice Line")
        {
            DataItemLink = "Document No." = field("No.");
            DataItemLinkReference = "Sales Invoice Header";
            DataItemTableView = sorting("Document No.", "Line No.");
            column(Description_SalesInvoiceLine; Description)
            { }
            column(Unit_Price_SalesInvoiceLine; "Unit Price")
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
            column(Container_No__Chassis_No_; "Container No./Chassis No.")
            { }


            //column(Container_Chassis_No_; manifestlineinfo."Container/Chassis No.")
            //{ }
            column(Seal_Engine_No_; manifestlineinfo."Seal/Engine No.")
            { }
            column(Description; manifestlineinfo.Description)
            { }
            column(Shortcut_Dimension_1_Code; "Container No./Chassis No.")
            { }
            column(SalesInvBL; "BL No.")
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
            column(Storage_Start_Date; "Storage Start Date")
            { }
            column(Free_Days; freedays)
            { }
            column(Storage_Days; storageDays)
            { }
            trigger OnAfterGetRecord()
            begin
                ManifestLineinfo.Reset();
                ManifestLineinfo.SetRange("Global Dimension 1 Code", "Sales Invoice Line"."Shortcut Dimension 1 Code");
                if ManifestLineinfo.FindFirst() then;
                IMSSetup.Get();
                if ("Sales Invoice Line".Type = "Sales Invoice Line".Type::Item) or ("Sales Invoice Line".Type = "Sales Invoice Line".Type::"G/L Account") then begin
                    IF "Sales Invoice Line"."VAT Prod. Posting Group" = 'EXEMPT' then
                        HSCode := IMSSetup."Default HS Code";
                    IF "Sales Invoice Line"."VAT Prod. Posting Group" = 'ZERO' then
                        HSCode := IMSSetup."Default HS Code Zero rated";
                end;

                SalesInvoiceLine.reset;
                SalesInvoiceLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                SalesInvoiceLine.SetRange("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                SalesInvoiceLine.SetFilter("Free Days", '<>%1', 0);
                if SalesInvoiceLine.FindFirst() then
                    Freedays := SalesInvoiceLine."Free Days";
                StorageDays := SalesInvoiceLine."Storage Days";
            end;


        }


    }

    var
        myInt: Integer;
        //manifestheaderInfo: Record "Manifest Header";
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
        CBM: Decimal;
        Weight: Decimal;
        SalesInvoiceLine: Record "Sales Invoice Line";
        GroupByContainerID: code[20];
        SaleInvLine: Record "Sales Invoice Line";
        SaleInvHeader: Record "Sales Invoice Header";
        ManifestLine: Record "Manifest Line";
        CountOfContainer: integer;
        CurrencyCap: Code[20];
        TotalAmt: Decimal;
        CurrencyExc: Record "Currency Exchange Rate";
        GROSSGROSSFCYF: Decimal;
        GROSSLCY: Decimal;
        LineDiscAmount: Decimal;
        StorageDays, Freedays : Decimal;
        CBMgroup: Code[20];



        VATLCY: Decimal;
        VATFCY: Decimal;

        CaptionKsh: text[50];
        ValueKsh: Text[50];
        IMSSetup: Record "IMS Setup";
        HSCode: Code[20];


    procedure GetClearingAgentName(Clearingagent: Code[20]) ClearingAgentName: text[100]
    var
        myInt: Integer;
        ClearingAgentRec: Record "Clearing Agent";
    begin
        if ClearingAgentRec.get(Clearingagent) then
            ClearingAgentName := ClearingAgentRec."Clearing Agent Name"
        else
            ClearingAgentName := '';
    end;

    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture)
    end;
}