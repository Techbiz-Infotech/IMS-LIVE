report 50178 "Cash Flow Report"
{
    ApplicationArea = All;
    Caption = 'IMS Cash Flow';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            DataItemTableView = SORTING("Bank Account No.", "Posting Date") ORDER(Ascending) ;
            RequestFilterFields = "Bank Account No.", "Posting Date";
            trigger OnAfterGetRecord()
            begin
                AppliedCDocNo := '';
                Paymentmethod := '';
                Runningbalance := 0;
                PaymentRef := '';
                if "Bank Account Ledger Entry"."Bal. Account Type" = "Bank Account Ledger Entry"."Bal. Account Type"::Customer then begin
                    CustLedgEntry.Reset();
                    CustLedgEntry.SetRange("Document No.", "Document No.");
                    CustLedgEntry.SetRange("Posting Date", "Posting Date");
                    CustLedgEntry.SetRange("Transaction No.", "Transaction No.");
                    if CustLedgEntry.FindFirst() then begin
                        Paymentmethod := CustLedgEntry."Payment Method Code";
                        PaymentRef := CustLedgEntry."Payment Reference";
                        repeat
                            if CustLedgEntry."Closed by Entry No." <> 0 then
                                ClosingEntryNo := CustLedgEntry."Closed by Entry No."
                            else begin
                                AppliedCLE.Reset();
                                AppliedCLE.SetRange("Closed by Entry No.", CustLedgEntry."Entry No.");
                                if AppliedCLE.Findset() then
                                    ClosingEntryNo := AppliedCLE."Entry No.";
                            end;

                            AppliedCustLedgEntry.Reset();
                            AppliedCustLedgEntry.SetRange("Entry No.", ClosingEntryNo);
                            if AppliedCustLedgEntry.FindFirst() then begin
                                repeat
                                    AppliedCDocNo := AppliedCustLedgEntry."Document No.";
                                until AppliedCustLedgEntry.Next() = 0;
                            end;
                        until CustLedgEntry.Next() = 0;
                    end;
                end;
                if "Bank Account Ledger Entry"."Bal. Account Type" = "Bank Account Ledger Entry"."Bal. Account Type"::Vendor then begin
                    VendLedgEntry.Reset();
                    VendLedgEntry.SetRange("Document No.", "Document No.");
                    VendLedgEntry.SetRange("Posting Date", "Posting Date");
                    VendLedgEntry.SetRange("Transaction No.", "Transaction No.");
                    if VendLedgEntry.FindFirst() then begin
                        Paymentmethod := VendLedgEntry."Payment Method Code";
                        PaymentRef := VendLedgEntry."Payment Reference";
                        repeat
                            if VendLedgEntry."Closed by Entry No." <> 0 then
                                ClosingEntryNo := VendLedgEntry."Closed by Entry No."
                            else begin
                                AppliedVLE.Reset();
                                AppliedVLE.SetRange("Closed by Entry No.", VendLedgEntry."Entry No.");
                                if AppliedVLE.Findset() then
                                    ClosingEntryNo := AppliedVLE."Entry No.";
                            end;
                            AppliedVendLedgEntry.Reset();
                            AppliedVendLedgEntry.SetRange("Entry No.", ClosingEntryNo);
                            if AppliedVendLedgEntry.FindFirst() then begin
                                repeat
                                    AppliedCDocNo := AppliedVendLedgEntry."Document No.";
                                until AppliedVendLedgEntry.Next() = 0;
                            end;
                        until VendLedgEntry.Next() = 0;
                    end;
                end;

                if Bank.get("Bank Account Ledger Entry"."Bank Account No.") then
                    BankName := Bank.Name;
                // Paymentmethod.Reset();
                // Paymentmethod.SetRange("Bal. Account Type", "Bank Account Ledger Entry"."Bal. Account Type"::"G/L Account");
                // if Paymentmethod.FindFirst() then;
                Clear(CrAmount);
                Clear(DrAmount);
                if Amount > 0 then
                    DrAmount := Amount;
                if Amount < 0 then
                    CrAmount := Amount;



                Runningbalance := CalcRunningAccBalance.GetBankAccBalance("Bank Account Ledger Entry");
                CreateExcelbody();
            end;
        }
    }

    trigger OnPreReport()
    begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        CreateExcelHeader();
    end;

    trigger OnPostReport()
    begin
        CreateExcelSheet();
    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        Paymentmethod, PaymentRef : Code[50];
        Runningbalance: Decimal;
        CalcRunningAccBalance: Codeunit "Calc. Running Acc. Balance";
        Bank: Record "Bank Account";
        CrAmount, DrAmount : Decimal;
        AppliedCLE, CustLedgEntry, AppliedCustLedgEntry : Record "Cust. Ledger Entry";
        BankName: Text[30];
        ClosingEntryNo: Integer;
        AppliedCDocNo, AppliedVDocNo : text[500];
        AppliedVLE, VendLedgEntry, AppliedVendLedgEntry : Record "Vendor Ledger Entry";


    procedure CreateExcelHeader()
    begin
        TempExcelBuffer.AddColumn('Bank Name', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Date', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Details', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Description ', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Receipt No.', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Mode of Payment', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Reference', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Dr Amount', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Cr Amount', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Balance', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
    end;

    procedure CreateExcelBody()
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(BankName, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Bank Account Ledger Entry"."Posting Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn("Bank Account Ledger Entry".Description, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(AppliedCDocNo, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Bank Account Ledger Entry"."Document No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Paymentmethod, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Bank Account Ledger Entry"."External Document No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(DrAmount, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(-CrAmount, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(Runningbalance, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
    end;

    procedure CreateExcelSheet()
    begin
        TempExcelBuffer.CreateNewBook('Cash Flow');
        TempExcelBuffer.WriteSheet('Cash Flow', CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename('Cash Flow');
        TempExcelBuffer.OpenExcel();
    end;

}
