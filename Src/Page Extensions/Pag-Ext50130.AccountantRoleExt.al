pageextension 50130 AccountantRoleExt extends "Accountant Role Center"
{
    layout
    {
        modify(Control100)
        {
            Visible = false;
        }
        modify(Control123)
        {
            Visible = false;
        }
        modify("User Tasks Activities")
        {
            Visible = false;
        }
        modify(Emails)
        {
            Visible = false;
        }
    }
    actions
    {
        modify("VAT E&xceptions")
        {
            Visible = false;
        }
        modify("EC Sales &List")
        {
            Visible = false;
        }
        modify("EC Sales List")
        {
            Visible = false;
        }
        modify("VAT Statements")
        {
            Visible = false;
        }
        modify("Direct Debit Collections")
        {
            Visible = false;
        }
        modify("Cash Flow")
        {
            Visible = false;
        }
        modify("Cost Accounting")
        {
            Visible = false;
        }
        modify("Import Co&nsolidation from Database")
        {
            Visible = false;
        }
        modify("P&ost Inventory Cost to G/L")
        {
            Visible = false;
        }
        modify("Calc. and Pos&t VAT Settlement")
        {
            Visible = false;
        }
        modify(Create)
        {
            Visible = false;
        }
        modify("Excel Reports")
        {
            Visible = false;
        }
        modify("Run Consolidation")
        {
            Visible = false;
        }
        modify("VAT Returns")
        {
            Visible = false;
        }
        modify("VAT Reports")
        {
            Visible = false;
        }
        modify("Incoming Documents")
        {
            Visible = false;
        }
        addafter("Statement of Retained Earnings")
        {
            action("Aged Accounts Receivable")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Aged Accounts Receivable';
                Image = "Report";
                // Promoted = true;
                // PromotedCategory = "Report";
                // PromotedIsBig = true;
                RunObject = Report "Aged Accounts Receivable";
                ToolTip = 'View a report that shows your company''s financial statements.';
            }
            action("Aged Accounts Payable")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Aged Accounts Payable';
                Image = "Report";
                // Promoted = true;
                // PromotedCategory = "Report";
                // PromotedIsBig = true;
                RunObject = Report "Aged Accounts Payable";
                ToolTip = 'View a report that shows your company''s financial statements.';
            }
            action("Trial Balance")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Trial Balance';
                Image = "Report";
                // Promoted = true;
                // PromotedCategory = "Report";
                // PromotedIsBig = true;
                RunObject = Report "Trial Balance";
                ToolTip = 'View a report that shows your company''s financial statements.';
            }
            action("Trial Balance By Period")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Trial Balance By Period';
                Image = "Report";
                // Promoted = true;
                // PromotedCategory = "Report";
                // PromotedIsBig = true;
                RunObject = Report "Trial Balance by Period";
                ToolTip = 'View a report that shows your company''s financial statements.';
            }
            action("Trial Balance/Previous Year")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Trial Balance/Previous Year';
                Image = "Report";
                // Promoted = true;
                // PromotedCategory = "Report";
                // PromotedIsBig = true;
                RunObject = Report "Trial Balance/Previous Year";
                ToolTip = 'View a report that shows your company''s financial statements.';
            }
        }
        addafter("G/L Reports")
        {
            group("IMS Reports")
            {
                Caption = 'IMS Reports';
                action("Customer Sales")
                {
                    ApplicationArea = BasicEU;
                    Caption = 'Customer Sales';
                    Image = "Report";
                    RunObject = Report "IMS Customer Sales";
                    ToolTip = '';
                }
                action("CFS Cargo Volume")
                {
                    ApplicationArea = BasicEU;
                    Caption = 'CFS Cargo Volume';
                    Image = "Report";
                    RunObject = Report "CFS Cargo Volume";
                    ToolTip = 'View all the information';
                }
                action("Summary P&L")
                {
                    ApplicationArea = BasicEU;
                    Caption = 'Summary P&L';
                    Image = "Report";
                    RunObject = Report "Summary P&L";
                    ToolTip = 'View all the information';
                }
            }
        }

    }
}
