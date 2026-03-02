report 50136 "Customer Receipt2"
{
    UsageCategory = ReportsAndAnalysis;
    //ApplicationArea = All;
    Caption = 'Customer Receipt IMS2';
    RDLCLayout = './Src/Reports/Layouts/Customer Receipt 2.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = SORTING("Document Type", "Customer No.", "Posting Date", "Currency Code") WHERE("Document Type" = FILTER(Payment | Refund));
            RequestFilterFields = "Customer No.", "Posting Date", "Document No.";
            CalcFields = Amount, "Amount (LCY)", "Remaining Amount", "Remaining Amt. (LCY)";

            column(Entry_No_CustLedgentry; "Entry No.")
            { }

            dataitem(PageLoop; Integer)
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(External_Document_No_; "Cust. Ledger Entry"."External Document No.")
                { }
                column(Description; "Cust. Ledger Entry".Description)
                { }
                column(Customer_Name; "Cust. Ledger Entry"."Customer Name")
                { }

                column(Document_No_; "Cust. Ledger Entry"."Document No.")
                { }
                column(Customer_No_; "Cust. Ledger Entry"."Customer No.")
                { }
                column(Currency_Code; CurrencyCode("Cust. Ledger Entry"."Currency Code"))
                { }
                column(CompanyLogo; CompanyInfo.Picture)
                { }
                column(CompanyName; CompanyInfo.Name)
                { }
                column(VATRegistrationNo; CustomerRec."VAT Registration No.")
                { }
                column(VesselName; ManifestLineRec."Vessel Name")
                { }
                column(VoyageNo; ManifestLineRec."Voyage No.")
                { }
                column(Consigneename; ManifestLineRec."Consignee Name")
                { }
                column(BLNo; SalesInvHead."BL No.")
                { }
                column(InvoicingpartyNo; ManifestLineRec."Invoicing Party No.")
                { }
                column(Text003; Text003)
                { }
                column(PinNoCaptionLbl; PinNoCaptionLbl)
                { }
                column(VatNoCaptionLbl; VatNoCaptionLbl)
                { }
                column(VesselCaptionLbl; VesselCaptionLbl)
                { }
                column(CompanyInfoBankAccNoCaptionLbl; CompanyInfoBankAccNoCaptionLbl)
                { }
                column(RcptNoCaptionLbl; RcptNoCaptionLbl)
                { }
                column(BLCaptionLbl; BLCaptionLbl)
                { }
                column(PostingDateCaptionLbl; PostingDateCaptionLbl)
                { }
                column(Posting_Date; "Cust. Ledger Entry"."Posting Date")
                { }
                column(AmtCaptionLbl; AmtCaptionLbl)
                { }
                column(CustLedgEntryAmount; CustLedgEntry."Amount to Apply") { }
                column(ReceivedFromCaptionLbl; ReceivedFromCaptionLbl)
                { }
                column(INvoiceCaptionLbl; INvoiceCaptionLbl)
                { }
                column(ConsigneeCaptionLbl; ConsigneeCaptionLbl)
                { }
                column(CheckCaptionLbl; CheckCaptionLbl)
                { }
                column(DesCaptionLbl; DesCaptionLbl)
                { }
                column(RemainingAmtLbl; RemainingAmtLbl) { }
                column(AppliedAmtLbl; AppliedAmtLbl) { }
                column(DocumentNoLbl; DocumentNoLbl) { }
                column(CuurecnyCodelbl; CuurecnyCodelbl) { }
                column(RemarcaptionLbl; RemarcaptionLbl)
                { }
                column(InvoiceAmtlbl; InvoiceAmtlbl) { }
                column(AmountReccaptionlbl; AmountReccaptionlbl)
                { }
                column(AmounwordsCaptionlbl; AmounwordsCaptionlbl)
                { }
                // column(BankAccountNo; CompanyInfo."Bank Account No.")
                // {
                // }
                column(BankAccountNo; GetBankAccNo("Cust. Ledger Entry"."Bal. Account No."))
                { }
                column(Amount; "Cust. Ledger Entry".Amount)
                { }
                column(DocumnentNo; GlEntry."Document No.")
                { }
                column(GlAccountNo; GlEntry."G/L Account No.")

                { }
                column(GlDesc; GlEntry.Description)
                { }
                column(G_DrAmount; G_DrAmount)
                { }
                column(G_CrAmount; G_CrAmount)
                { }
                column(G_Glname; G_Glname)
                { }
                column(G_GlAccountNo; G_GlAccountNo)
                { }
                column(G_DrText; G_DrText)
                { }
                column(G_CrText; G_CrText)
                { }
                column(G_Amount; G_Amount)
                { }
                column(ValueInText; ValueInText)
                {
                }
                // column(RemainingAt; RemainingAmt)
                // { }

                dataitem("DetailedCustLedgEntry1"; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Applied Cust. Ledger Entry No." = field("Entry No.");
                    DataItemLinkReference = "Cust. Ledger Entry";
                    DataItemTableView = sorting("Applied Cust. Ledger Entry No.", "Entry Type") where(Unapplied = const(false));
                    column(AppCuLedgEndeNo_; "Applied Cust. Ledger Entry No.")
                    { }
                    dataitem("Cust. Ledger Entry1"; "Cust. Ledger Entry")
                    {
                        DataItemLink = "Entry No." = field("Cust. Ledger Entry No.");
                        DataItemLinkReference = "DetailedCustLedgEntry1";
                        DataItemTableView = sorting("Entry No.");
                        column(Posting_DateCust; Format("Posting Date"))
                        { }
                        column(ShowAmount; ShowAmount)
                        { }
                        column(Document_Nocustledg1_; "Document No.")
                        { }
                        column(Descriptioncustledg1; Description)
                        { }
                        column(Currency_Code1; CurrencyCode("Currency Code"))
                        { }

                        column(Amount1; Amount)
                        { }
                        column(No__Series; "No. Series")
                        { }
                        column(Remaining_Amt___LCY_; "Remaining Amt. (LCY)") { }
                        column(Remaining_Amount; "Remaining Amount")
                        { }
                        trigger OnAfterGetRecord()
                        begin
                            if "Entry No." = "Cust. Ledger Entry"."Entry No." then
                                CurrReport.Skip();

                            PmtDiscInvCurr := 0;
                            PmtTolInvCurr := 0;
                            PmtDiscPmtCurr := 0;
                            PmtTolPmtCurr := 0;

                            ShowAmount := -DetailedCustLedgEntry1.Amount;
                            if "Cust. Ledger Entry"."Currency Code" <> "Currency Code" then begin
                                PmtDiscInvCurr := Round("Pmt. Disc. Given (LCY)" * "Original Currency Factor");
                                PmtTolInvCurr := Round("Pmt. Tolerance (LCY)" * "Original Currency Factor");
                                AppliedAmount :=
                                     Round(
                                       -DetailedCustLedgEntry1.Amount / "Original Currency Factor" *
                                       "Cust. Ledger Entry"."Original Currency Factor", Currency."Amount Rounding Precision");
                            end else begin
                                PmtDiscInvCurr := Round("Pmt. Disc. Given (LCY)" * "Cust. Ledger Entry"."Original Currency Factor");
                                PmtTolInvCurr := Round("Pmt. Tolerance (LCY)" * "Cust. Ledger Entry"."Original Currency Factor");
                                AppliedAmount := -DetailedCustLedgEntry1.Amount;
                            end;

                            PmtDiscPmtCurr := Round("Pmt. Disc. Given (LCY)" * "Cust. Ledger Entry"."Original Currency Factor");
                            PmtTolPmtCurr := Round("Pmt. Tolerance (LCY)" * "Cust. Ledger Entry"."Original Currency Factor");

                            RemainingAmount := (RemainingAmount - AppliedAmount) + PmtDiscPmtCurr + PmtTolPmtCurr;
                            IF SalesInvHead.get("Cust. Ledger Entry1"."Document No.") then;
                           // If ManifestHeadRec.get(SalesInvHead."Job File No.") then;
                            if CustomerRec.get("Cust. Ledger Entry"."Customer No.") then;
                            ManifestLineRec.Reset();
                           // ManifestLineRec.SetRange("Job File No.", ManifestHeadRec."Job File No.");
                            ManifestLineRec.SetRange("BL No.", SalesInvHead."BL No.");
                            if ManifestLineRec.FindFirst() then begin
                            end;
                        end;
                    }
                    trigger OnAfterGetRecord()
                    begin
                        // ReportCheck.InitTextVariable();
                        // ReportCheck.FormatNoText(NumberText, ABS("Cust. Ledger Entry".Amount), CurrencyCode("Cust. Ledger Entry"."Currency Code"));
                        // ValueInText := NumberText[1] + '' + NumberText[2];

                        IF SalesInvHead.get("Cust. Ledger Entry1"."Document No.") then;
                        //If ManifestHeadRec.get(SalesInvHead."Job File No.") then;
                        if CustomerRec.get("Cust. Ledger Entry"."Customer No.") then;
                        ManifestLineRec.Reset();
                       // ManifestLineRec.SetRange("Job File No.", ManifestHeadRec."Job File No.");
                        ManifestLineRec.SetRange("BL No.", SalesInvHead."BL No.");
                        if ManifestLineRec.FindFirst() then begin
                        end;
                        GlEntry.Reset();
                        GlEntry.SetRange("Entry No.", "Cust. Ledger Entry"."Entry No.");
                        GlEntry.SetRange("Posting Date", "Cust. Ledger Entry"."Posting Date");
                        GlEntry.SetRange("Document No.", "Cust. Ledger Entry"."Document No.");
                        if GlEntry.FindFirst() then;

                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    ReportCheck.InitTextVariable();
                    ReportCheck.FormatNoText(NumberText, ABS("Cust. Ledger Entry".Amount), CurrencyCode("Cust. Ledger Entry"."Currency Code"));
                    ValueInText := NumberText[1] + '' + NumberText[2];
                end;
            }
            dataitem(DetailedCustLedgEntry2; "Detailed Cust. Ledg. Entry")
            {
                DataItemLink = "Cust. Ledger Entry No." = FIELD("Entry No.");
                DataItemLinkReference = "Cust. Ledger Entry";
                DataItemTableView = SORTING("Cust. Ledger Entry No.", "Entry Type", "Posting Date") WHERE(Unapplied = CONST(false));
                column(Cust__Ledger_Entry_No_Deta; "Cust. Ledger Entry No.")
                {
                }
                dataitem("Cust.LedgerEntry2"; "Cust. Ledger Entry")
                {
                    DataItemLink = "Entry No." = FIELD("Applied Cust. Ledger Entry No.");
                    DataItemLinkReference = DetailedCustLedgEntry2;
                    DataItemTableView = SORTING("Entry No.");
                    column(Description_CustLedgEntry2; Description)
                    {
                    }
                    column(AppliedAmount; AppliedAmount)
                    { }
                    column(DocNo_CustLedgEntry2; "Document No.")
                    {
                    }
                    column(PostingDate_CustLedgEntry2; Format("Posting Date"))
                    {
                    }
                    column(CurrCode_CustLedgEntry2; CurrencyCode("Currency Code"))
                    {
                    }
                    column(PmtDiscInvCurr1; PmtDiscInvCurr)
                    {
                    }
                    column(PmtTolInvCurr1; PmtTolInvCurr)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if "Entry No." = "Cust. Ledger Entry"."Entry No." then
                            CurrReport.Skip();

                        PmtDiscInvCurr := 0;
                        PmtTolInvCurr := 0;
                        PmtDiscPmtCurr := 0;
                        PmtTolPmtCurr := 0;

                        ShowAmount := DetailedCustLedgEntry2.Amount;

                        if "Cust. Ledger Entry"."Currency Code" <> "Currency Code" then begin
                            PmtDiscInvCurr := Round("Pmt. Disc. Given (LCY)" * "Original Currency Factor");
                            PmtTolInvCurr := Round("Pmt. Tolerance (LCY)" * "Original Currency Factor");
                        end else begin
                            PmtDiscInvCurr := Round("Pmt. Disc. Given (LCY)" * "Cust. Ledger Entry"."Original Currency Factor");
                            PmtTolInvCurr := Round("Pmt. Tolerance (LCY)" * "Cust. Ledger Entry"."Original Currency Factor");
                        end;

                        PmtDiscPmtCurr := Round("Pmt. Disc. Given (LCY)" * "Cust. Ledger Entry"."Original Currency Factor");
                        PmtTolPmtCurr := Round("Pmt. Tolerance (LCY)" * "Cust. Ledger Entry"."Original Currency Factor");

                        AppliedAmount := DetailedCustLedgEntry2.Amount;
                        RemainingAmount := (RemainingAmount - AppliedAmount) + PmtDiscPmtCurr + PmtTolPmtCurr;
                    end;
                }
            }
            dataitem(Total; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                //column(RemainingAmount; RemainingAmount) { }
                column(CurrCode_CustLedgEntry; CurrencyCode("Cust. Ledger Entry"."Currency Code"))
                {
                }
                column(OriginalAmt_CustLedgEntry; "Cust. Ledger Entry"."Original Amount")
                {
                }
                column(ExtDocNo_CustLedgEntry; "Cust. Ledger Entry"."External Document No.")
                {
                }
                Dataitem("G/L Entry"; "G/L Entry")
                {
                    DataItemTableView = SORTING("Document No.");

                    DataItemLinkReference = "Cust. Ledger Entry";
                    DataItemLink = "Document No." = field("Document No.");
                    column(G_L_Account_Name; "G/L Account Name")
                    { }
                    column(G_L_Account_No_; "G/L Account No.")
                    { }
                    column(Debit_Amount; GLEntyAmt)
                    { }
                    column(Credit_Amount; "Credit Amount")
                    { }
                    column(GL_Amount; Amount)
                    { }
                    trigger OnAfterGetRecord()
                    begin
                        IF "G/L Entry"."Debit Amount" <> 0 then
                            GLEntyAmt := "G/L Entry"."Debit Amount"
                        Else
                            IF "G/L Entry"."Credit Amount" <> 0 then
                                GLEntyAmt := "G/L Entry"."Credit Amount";
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    // GlEntry.Reset();
                    // GlEntry.SetRange("Entry No.", "Cust. Ledger Entry"."Entry No.");
                    // GlEntry.SetRange("Posting Date", "Cust. Ledger Entry"."Posting Date");
                    // GlEntry.SetRange("Document No.", "Cust. Ledger Entry"."Document No.");
                    // if GlEntry.FindFirst() then;
                    // ReportCheck.InitTextVariable();
                    // ReportCheck.FormatNoText(NumberText, ABS("Cust. Ledger Entry".Amount), GLSetup."LCY Code");
                    // ValueInText := NumberText[1] + '' + NumberText[2];
                    CLEAR(G_GlAccountNo);
                    CLEAR(G_Glname);
                    CLEAR(G_DrAmount);
                    CLEAR(G_CrAmount);
                    CLEAR(G_DrText);
                    CLEAR(G_CrText);
                    CLEAR(G_Amount);

                    GlEntry.Reset();
                    GLEntry.SetCurrentKey("Document No.");
                    GlEntry.SetRange(GlEntry."Document No.", "Cust. Ledger Entry"."Document No.");
                    if GlEntry.FindFirst() then begin
                        repeat
                            GlEntry.CalcFields("G/L Account Name");

                            G_GlAccountNo := GlEntry."G/L Account No.";
                            G_Glname := GlEntry."G/L Account Name";
                            G_Amount := GlEntry.Amount;
                            if Glentry.Amount > 0 then begin
                                G_DrAmount := Glentry.Amount;
                                G_DrText := 'Dr';
                            end else begin
                                G_CrAmount := Glentry.Amount;
                                G_DrText := 'Cr';
                            end;
                        until GlEntry.Next = 0;
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                Cust.Get("Customer No.");
                //FormatAddr.Customer(CustAddr, Cust);

                if not Currency.Get("Currency Code") then
                    Currency.InitRoundingPrecision;

                if "Document Type" = "Document Type"::Payment then begin
                    ReportTitle := Text003;
                    PaymentDiscountTitle := Text006;
                end else begin
                    ReportTitle := Text004;
                    PaymentDiscountTitle := Text007;
                end;

                CalcFields("Original Amount");
                RemainingAmount := -"Original Amount";

            end;
        }
    }
    labels
    {
        CurrencyCodeCaption = 'Currency Code';
        PageCaption = 'Page';
        DocDateCaption = 'Document Date';
        EmailCaption = 'Email';
        HomePageCaption = 'Home Page';
    }
    var
        Cust: Record Customer;

        ReportTitle: Text[30];
        PaymentDiscountTitle: Text[30];
        CompanyAddr: array[8] of Text[100];
        VendAddr: array[8] of Text[100];
        AppliedAmount: Decimal;
        OriginalAmount: decimal;
        NegPmtDiscInvCurrVendLedgEntry1: Decimal;
        NegPmtTolInvCurrVendLedgEntry1: Decimal;
        PmtDiscPmtCurr: Decimal;
        Text003: Label 'R E C E I P T';
        Text004: Label 'Payment Voucher';
        Text006: Label 'Payment Discount Given';
        Text007: Label 'Payment Discount Received';
        ShowAmount: Decimal;
        PmtTolPmtCurr: Decimal;
        NegShowAmountVendLedgEntry1: Decimal;
        PinNoCaptionLbl: Label 'Pin No:';
        VatNoCaptionLbl: Label 'Vat No:';
        VesselCaptionLbl: Label 'Vessel:';
        CompanyInfoBankAccNoCaptionLbl: Label 'Account No.';
        RcptNoCaptionLbl: Label 'RECEIPT NO:';
        BLCaptionLbl: Label 'BL Number:';
        PostingDateCaptionLbl: Label 'RECEIPT DATE';
        AmtCaptionLbl: Label 'Amount';
        DocumentNoLbl: Label 'Doc No.';
        AppliedAmtLbl: Label 'Applied Amt';
        RemainingAmtLbl: Label 'Remaining Amt';
        InvoiceAmtlbl: Label 'Invoice Amt';
        CuurecnyCodelbl: Label 'Currency Code';
        ReceivedFromCaptionLbl: Label 'Received from:';
        INvoiceCaptionLbl: Label 'INVOICE NO:';
        ConsigneeCaptionLbl: Label 'Consignee:';
        CheckCaptionLbl: Label 'Cheque/Cash:';
        DesCaptionLbl: Label 'Description:';
        RemarcaptionLbl: Label 'Remarks:';
        AmounwordsCaptionlbl: Label 'Amount In Words:';
        AmountReccaptionlbl: Label 'Amount Received:';
        GlEntry: Record "G/L Entry";
        RepCheck: Report Check;
        NoText: array[2] of Text;
        AmountReceived: Text;
        RemainingAmt: decimal;
        G_GlAccountNo: Code[20];
        G_Glname: text[250];
        G_DrAmount, G_CrAmount, G_Amount : Decimal;
        G_DrText, G_CrText : Text[10];

        NOtoText: text[80];
        No: Decimal;
        //CurrencyCode: Code[10];

        myInt: Integer;
        CustomerRec: Record Customer;
        ManifestLineRec: Record "Manifest Line";
       // ManifestHeadRec: Record "Manifest Header";
        CompanyInfo: Record "Company Information";
        Currency: Record Currency;
        RemainingAmount: Decimal;
        AppliedAmoiunt: Decimal;
        GLsetup: Record "General Ledger Setup";
        ReportCheck: Report Check;
        AmountInWords: array[2] of Text[80];
        NumberText: array[2] of Text[80];
        ValueInText: text[1024];
        AmountText1: text[40];
        AmountText2: text[40];
        GLAccount: Record "G/L Account";
        PmtDiscInvCurr: Decimal;
        PmtTolInvCurr: Decimal;
        GLEntyAmt: Decimal;
        SalesInvHead: Record "Sales Invoice Header";
        CustLedgEntry: Record "Cust. Ledger Entry";


    trigger OnInitReport()

    begin
        CompanyInfo.get;
        CompanyInfo.CalcFields(Picture)
    end;

    local procedure CurrencyCode(SrcCurrCode: Code[10]): Code[10]
    begin

        if SrcCurrCode = '' then begin
            GLsetup.get();
            exit(GLsetup."LCY Code")
        end else
            exit(SrcCurrCode);
    end;

    procedure GetBankAccNo(BankAccCode: Code[20]) BankAccountNo1: Code[20]
    var
        BankAccRec: Record "Bank Account";
    begin
        If BankAccRec.get(BankAccCode) then
            BankAccountNo1 := BankAccRec."Bank Account No."
        else
            BankAccountNo1 := BankAccCode;
    end;


}