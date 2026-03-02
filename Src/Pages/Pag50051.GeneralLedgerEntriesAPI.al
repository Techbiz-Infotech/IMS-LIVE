page 50051 "General Ledger Entries API"
{
    APIGroup = 'apiGroup';
    APIPublisher = 'publisherName';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'GeneralLedgerEntriesAPI';
    DelayedInsert = true;
    EntityName = 'GLEntries';
    EntitySetName = 'GLEntries';
    PageType = API;
    SourceTable = "G/L Account";


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(searchName; Rec."Search Name")
                {
                    Caption = 'Search Name';
                }
                field(accountType; Rec."Account Type")
                {
                    Caption = 'Account Type';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                }
                field(accountCategory; Rec."Account Category")
                {
                    Caption = 'Account Category';
                }
                field(incomeBalance; Rec."Income/Balance")
                {
                    Caption = 'Income/Balance';
                }
                field(debitCredit; Rec."Debit/Credit")
                {
                    Caption = 'Debit/Credit';
                }
                field(no2; Rec."No. 2")
                {
                    Caption = 'No. 2';
                }
                field(comment; Rec.Comment)
                {
                    Caption = 'Comment';
                }
                field(blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                }
                field(directPosting; Rec."Direct Posting")
                {
                    Caption = 'Direct Posting';
                }
                field(reconciliationAccount; Rec."Reconciliation Account")
                {
                    Caption = 'Reconciliation Account';
                }
                field(newPage; Rec."New Page")
                {
                    Caption = 'New Page';
                }
                field(noOfBlankLines; Rec."No. of Blank Lines")
                {
                    Caption = 'No. of Blank Lines';
                }
                field(indentation; Rec.Indentation)
                {
                    Caption = 'Indentation';
                }
                field(sourceCurrencyCode; Rec."Source Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(sourceCurrencyPosting; Rec."Source Currency Posting")
                {
                    Caption = 'Source Currency Posting';
                }
                field(sourceCurrencyRevaluation; Rec."Source Currency Revaluation")
                {
                    Caption = 'Source Currency Revaluation';
                }
                field(unrealizedRevaluation; Rec."Unrealized Revaluation")
                {
                    Caption = 'Unrealized Revaluation';
                }
                field(lastModifiedDateTime; Rec."Last Modified Date Time")
                {
                    Caption = 'Last Modified Date Time';
                }
                field(lastDateModified; Rec."Last Date Modified")
                {
                    Caption = 'Last Date Modified';
                }
                field(balanceAtDate; Rec."Balance at Date")
                {
                    Caption = 'Balance at Date';
                }
                field(netChange; Rec."Net Change")
                {
                    Caption = 'Net Change';
                }
                field(budgetedAmount; Rec."Budgeted Amount")
                {
                    Caption = 'Budgeted Amount';
                }
                field(totaling; Rec.Totaling)
                {
                    Caption = 'Totaling';
                }
                field(balance; Rec.Balance)
                {
                    Caption = 'Balance';
                }
                field(budgetAtDate; Rec."Budget at Date")
                {
                    Caption = 'Budget at Date';
                }
                field(consolTranslationMethod; Rec."Consol. Translation Method")
                {
                    Caption = 'Consol. Translation Method';
                }
                field(consolDebitAcc; Rec."Consol. Debit Acc.")
                {
                    Caption = 'Consol. Debit Acc.';
                }
                field(consolCreditAcc; Rec."Consol. Credit Acc.")
                {
                    Caption = 'Consol. Credit Acc.';
                }
                field(genPostingType; Rec."Gen. Posting Type")
                {
                    Caption = 'Gen. Posting Type';
                }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                    Caption = 'Gen. Bus. Posting Group';
                }
                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
                {
                    Caption = 'Gen. Prod. Posting Group';
                }
                field(picture; Rec.Picture)
                {
                    Caption = 'Picture';
                }
                field(debitAmount; Rec."Debit Amount")
                {
                    Caption = 'Debit Amount';
                }
                field(creditAmount; Rec."Credit Amount")
                {
                    Caption = 'Credit Amount';
                }
                field(automaticExtTexts; Rec."Automatic Ext. Texts")
                {
                    Caption = 'Automatic Ext. Texts';
                }
                field(budgetedDebitAmount; Rec."Budgeted Debit Amount")
                {
                    Caption = 'Budgeted Debit Amount';
                }
                field(budgetedCreditAmount; Rec."Budgeted Credit Amount")
                {
                    Caption = 'Budgeted Credit Amount';
                }
                field(taxAreaCode; Rec."Tax Area Code")
                {
                    Caption = 'Tax Area Code';
                }
                field(taxLiable; Rec."Tax Liable")
                {
                    Caption = 'Tax Liable';
                }
                field(taxGroupCode; Rec."Tax Group Code")
                {
                    Caption = 'Tax Group Code';
                }
                field(vatBusPostingGroup; Rec."VAT Bus. Posting Group")
                {
                    Caption = 'VAT Bus. Posting Group';
                }
                field(vatProdPostingGroup; Rec."VAT Prod. Posting Group")
                {
                    Caption = 'VAT Prod. Posting Group';
                }
                field(vatAmt; Rec."VAT Amt.")
                {
                    Caption = 'VAT Amt.';
                }
                field(additionalCurrencyNetChange; Rec."Additional-Currency Net Change")
                {
                    Caption = 'Additional-Currency Net Change';
                }
                field(addCurrencyBalanceAtDate; Rec."Add.-Currency Balance at Date")
                {
                    Caption = 'Add.-Currency Balance at Date';
                }
                field(additionalCurrencyBalance; Rec."Additional-Currency Balance")
                {
                    Caption = 'Additional-Currency Balance';
                }
                field(exchangeRateAdjustment; Rec."Exchange Rate Adjustment")
                {
                    Caption = 'Exchange Rate Adjustment';
                }
                field(addCurrencyDebitAmount; Rec."Add.-Currency Debit Amount")
                {
                    Caption = 'Add.-Currency Debit Amount';
                }
                field(addCurrencyCreditAmount; Rec."Add.-Currency Credit Amount")
                {
                    Caption = 'Add.-Currency Credit Amount';
                }
                field(defaultICPartnerGLAccNo; Rec."Default IC Partner G/L Acc. No")
                {
                    Caption = 'Default IC Partner G/L Acc. No';
                }
                field(omitDefaultDescrInJnl; Rec."Omit Default Descr. in Jnl.")
                {
                    Caption = 'Omit Default Descr. in Jnl.';
                }
                field(sourceCurrencyNetChange; Rec."Source Currency Net Change")
                {
                    Caption = 'Source Currency Net Change';
                }
                field(sourceCurrBalanceAtDate; Rec."Source Curr. Balance at Date")
                {
                    Caption = 'Source Curr. Balance at Date';
                }
                field(sourceCurrencyBalance; Rec."Source Currency Balance")
                {
                    Caption = 'Source Currency Balance';
                }
                field(accountSubcategoryEntryNo; Rec."Account Subcategory Entry No.")
                {
                    Caption = 'Account Subcategory Entry No.';
                }
                field(accountSubcategoryDescript; Rec."Account Subcategory Descript.")
                {
                    Caption = 'Account Subcategory Descript.';
                }
                field(excludeFromConsolidation; Rec."Exclude From Consolidation")
                {
                    Caption = 'Exclude from Consolidation';
                }
                field(costTypeNo; Rec."Cost Type No.")
                {
                    Caption = 'Cost Type No.';
                }
                field(defaultDeferralTemplateCode; Rec."Default Deferral Template Code")
                {
                    Caption = 'Default Deferral Template Code';
                }
                field(apiAccountType; Rec."API Account Type")
                {
                    Caption = 'API Account Type';
                }
                field(prepaymentReversalAccount; Rec."Prepayment Reversal Account")
                {
                    Caption = 'Prepayment Reversal Account';
                }
            }
        }

    }
    trigger OnOpenPage()
    var
    begin
        Rec.SetFilter("No.", '%1..%2|%3..%4|%5..%6', '16000000', '16999999', '40000000', '40999999', '50000000', '50999999');
    end;

}
