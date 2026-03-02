page 50134 "CS Role Center"
{
    Caption = 'Customer Service', Comment = 'Use same translation as ''Profile Description'' (if applicable)';
    PageType = RoleCenter;
    //ApplicationArea = all;
    UsageCategory = Administration;

    layout
    {
        area(rolecenter)
        {
            part(Control11; "Headline RC Team Member")
            {
                ApplicationArea = Suite;
            }
            part(Control311; "Container Activities")
            {
                ApplicationArea = Suite;
            }
            // part(Control3; "Team Member Activities")
            // {
            //     ApplicationArea = Suite;
            // }
            // part(Control7; "User Tasks Activities")
            // {
            //     ApplicationArea = Suite;
            // }
            // part("Emails"; "Email Activities")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }
            // part(Control4; "My Time Sheets")
            // {
            //     ApplicationArea = Suite;
            // }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Container Stock Report")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Container Stock Report';
                Image = "Report";
                RunObject = Report "Container Stock";
                ToolTip = '';
            }
            action("Unit Stock Report")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Unit Stock Report';
                Image = "Report";
                RunObject = Report "Units Stock";
                ToolTip = '';
            }
            action("Loose Cargo Stock Report")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Loose Cargo Stock Report';
                Image = "Report";
                RunObject = Report "Loose Cargo Stock";
                ToolTip = '';
            }
            action("Consolidated Stock Report")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Consolidated Stock Report';
                Image = "Report";
                RunObject = Report "Consolidated Stock ";
                ToolTip = '';
            }
            // action("Container Report")
            // {
            //     ApplicationArea = RelationshipMgmt;
            //     Caption = 'Container Report';
            //     Image = "Report";
            //     RunObject = Report "Container-Import";
            //     ToolTip = '';
            // }
            action("Container Received")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Container Received';
                Image = "Report";
                RunObject = Report "Container Received";
                ToolTip = '';
            }
            action("Container Released")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Container Released';
                Image = "Report";
                RunObject = Report "Container Released";
                ToolTip = '';
            }
            action("Customer Listing")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Container Listing';
                Image = "Report";
                RunObject = Report "Customer Listing";
                ToolTip = 'View the quantity not yet shipped for each customer in three periods of 30 days each, starting from a selected date. There are also columns with orders to be shipped before and after the three periods and a column with the total order detail for each customer. The report can be used to analyze a company''s expected sales volume.';
            }
            action("SSR Activity")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'SSR Activity';
                Image = "Report";
                RunObject = Report "SSR Activity";
                ToolTip = '';
            }
            // action("Docs Flow")
            // {
            //     ApplicationArea = RelationshipMgmt;
            //     Caption = 'Docs Flow';
            //     Image = "Report";
            //     RunObject = Report "Docs Flow Report";
            //     ToolTip = '';
            // }
            // action("Client Production")
            // {
            //     ApplicationArea = RelationshipMgmt;
            //     Caption = 'Client Production';
            //     Image = "Report";
            //     RunObject = Report "Client Production";
            //     ToolTip = '';
            // }
            action("RORO Receieved")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Unit Received';
                Image = "Report";
                RunObject = Report "Unit Received";
                ToolTip = '';
            }
            action("RORO Released")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Unit Released';
                Image = "Report";
                RunObject = Report "Unit Released";
                ToolTip = '';
            }
        }
        area(embedding)
        {

        }
        area(sections)
        {
            group(Finance)
            {
                Caption = 'Finance';
                Image = Journals;
                ToolTip = 'Collect and make payments, prepare statements, and reconcile bank accounts.';
                action(GeneralJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Journals';
                    Image = Journal;
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(false));
                    ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
                }
                // action("Chart of Accounts")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Chart of Accounts';
                //     RunObject = Page "Chart of Accounts";
                //     ToolTip = 'View the chart of accounts.';
                // }
                // action("Account Schedules")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Account Schedules';
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     RunObject = Page "Account Schedule Names";
                //     ToolTip = 'Get insight into the financial data stored in your chart of accounts. Account schedules analyze figures in G/L accounts, and compare general ledger entries with general ledger budget entries. For example, you can view the general ledger entries as percentages of the budget entries. Account schedules provide the data for core financial statements and views, such as the Cash Flow chart.';
                // }
                // action("G/L Account Categories")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'G/L Account Categories';
                //     RunObject = Page "G/L Account Categories";
                //     ToolTip = 'Personalize the structure of your financial statements by mapping general ledger accounts to account categories. You can create category groups by indenting subcategories under them. Each grouping shows a total balance. When you choose the Generate Account Schedules action, the account schedules for the underlying financial reports are updated. The next time you run one of these reports, such as the balance statement, new totals and subentries are added, based on your changes.';
                // }
                action(CashReceiptJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Receipt Journals';
                    Image = Journals;
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST("Cash Receipts"),
                                        Recurring = CONST(false));
                    ToolTip = 'Register received payments by manually applying them to the related customer, vendor, or bank ledger entries. Then, post the payments to G/L accounts and thereby close the related ledger entries.';
                }
                action(PaymentJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Journals';
                    Image = Journals;
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Payments),
                                        Recurring = CONST(false));
                    ToolTip = 'Register payments to vendors. A payment journal is a type of general journal that is used to post outgoing payment transactions to G/L, bank, customer, vendor, employee, and fixed assets accounts. The Suggest Vendor Payments functions automatically fills the journal with payments that are due. When payments are posted, you can export the payments to a bank file for upload to your bank if your system is set up for electronic banking. You can also issue computer checks from the payment journal.';
                }
                action("Bank Accounts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Accounts';
                    Image = BankAccount;
                    RunObject = Page "Bank Account List";
                    ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
                }

            }
            group(Sales)
            {
                Caption = 'Sales';
                Image = Sales;
                ToolTip = 'Make quotes, orders, and credit memos. See customers and transaction history.';
                action(Sales_CustomerList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customers';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "Customer List";
                    ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
                }
                action("Sales Quotes")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Quotes';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "Sales Quotes";
                    ToolTip = 'Make offers to customers to sell certain products on certain delivery and payment terms. While you negotiate with a customer, you can change and resend the sales quote as much as needed. When the customer accepts the offer, you convert the sales quote to a sales invoice or a sales order in which you process the sale.';
                }

                action("Sales Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Credit Memos';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "Sales Credit Memos";
                    ToolTip = 'Revert the financial transactions involved when your customers want to cancel a purchase or return incorrect or damaged items that you sent to them and received payment for. To include the correct information, you can create the sales credit memo from the related posted sales invoice or you can create a new sales credit memo with copied invoice information. If you need more control of the sales return process, such as warehouse documents for the physical handling, use sales return orders, in which sales credit memos are integrated. Note: If an erroneous sale has not been paid yet, you can simply cancel the posted sales invoice to automatically revert the financial transaction.';
                }

                action("Posted Sales Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    RunObject = Page "Posted Sales Invoices";
                    ToolTip = 'Open the list of posted sales invoices.';
                }
                action("Posted Sales Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos';
                    RunObject = Page "Posted Sales Credit Memos";
                    ToolTip = 'Open the list of posted sales credit memos.';
                }

            }
            group(Purchasing)
            {
                Caption = 'Purchasing';
                Image = AdministrationSalesPurchases;
                ToolTip = 'Manage purchase invoices and credit memos. Maintain vendors and their history.';
                action(Purchase_VendorList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendors';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "Vendor List";
                    ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
                }

                action("Purchase Quotes")
                {
                    ApplicationArea = Suite;
                    Caption = 'Purchase Quotes';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "Purchase Quotes";
                    ToolTip = 'Opens a list of purchase quotes.';
                }
                action("<Page Purchase Orders>")
                {
                    ApplicationArea = Suite;
                    Caption = 'Purchase Orders';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "Purchase Order List";
                    ToolTip = 'Create purchase orders to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase orders dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase orders allow partial receipts, unlike with purchase invoices, and enable drop shipment directly from your vendor to your customer. Purchase orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
                }

                action("<Page Purchase Invoices>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Invoices';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "Purchase Invoices";
                    ToolTip = 'Create purchase invoices to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase invoices dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase invoices can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
                }
                action("<Page Posted Purchase Invoices>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ToolTip = 'Open the list of posted purchase invoices.';
                }
                action("<Page Purchase Credit Memos>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Credit Memos';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "Purchase Credit Memos";
                    ToolTip = 'Create purchase credit memos to mirror sales credit memos that vendors send to you for incorrect or damaged items that you have paid for and then returned to the vendor. If you need more control of the purchase return process, such as warehouse documents for the physical handling, use purchase return orders, in which purchase credit memos are integrated. Purchase credit memos can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature. Note: If you have not yet paid for an erroneous purchase, you can simply cancel the posted purchase invoice to automatically revert the financial transaction.';
                }
                action("<Page Posted Purchase Credit Memos>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                    ToolTip = 'Open the list of posted purchase credit memos.';
                }
                action("<Page Posted Purchase Receipts>")
                {
                    ApplicationArea = Suite;
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page "Posted Purchase Receipts";
                    ToolTip = 'Open the list of posted purchase receipts.';
                }
            }
            group(Manifest)
            {
                Caption = 'Manifests';
                Image = AdministrationSalesPurchases;
                ToolTip = 'Manage Manifests';
                action(Manifests)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Old Manifests';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "Manifest List";
                    
                }
                action(ManifestLines)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Manifest Lines';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "Manifests New";
                   // RunObject = Page "Manifest Lines";
                }
            }
            group(Receiving)
            {
                Caption = 'Receiving';
                Image = AdministrationSalesPurchases;
                ToolTip = 'Manage purchase invoices and credit memos. Maintain vendors and their history.';
                action(IMSReceiving)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Receiving';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "Receiving Journal";
                    //ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
                }
                action(IMSReceivingLog)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Receiving Log';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page ReceivingLogs;
                    //ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
                }
            }
            group("Yard/Position")
            {
                Caption = 'Positions';
                Image = AdministrationSalesPurchases;
                //ToolTip = 'Manage purchase invoices and credit memos. Maintain vendors and their history.';
                action("Position Allocation")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Position Allocation';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page YardAllocationList;
                    //ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
                }
                action(PositionMovement)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Position Movement';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page PositionMovementList;
                    //ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
                }
                action(Positionslog)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Position Log';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "Position Log List";
                    ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
                }
            }
            group(Stripping)
            {
                Caption = 'Stripping';
                Image = AdministrationSalesPurchases;
                //ToolTip = 'Manage purchase invoices and credit memos. Maintain vendors and their history.';
                action(Strippings)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Stripping';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page StrippingJournal;
                    //ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
                }
                action(StrippingLog)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Stripping Log';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page StrippingLogs;
                }
            }
            group(Verification)
            {
                Caption = 'Verification';
                Image = AdministrationSalesPurchases;
                //ToolTip = 'Manage purchase invoices and credit memos. Maintain vendors and their history.';
                action(Verifications)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Verification';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page VerificationList;
                    //ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
                }
                action(VerificationLog)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Verification Log';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page VerificationLogs;
                    //ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
                }
            }

            group("IMS Billing")
            {
                Caption = 'IMS Billing';
                Image = AdministrationSalesPurchases;
                //ToolTip = 'Manage purchase invoices and credit memos. Maintain vendors and their history.';
                action(ProformaInvoice)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Proforma Invoices';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "proforma Invoice List";
                }
                action(SalesInvoice)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Invoices';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "Sales Invoice List";
                }
                action(ClosedProformaInvoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Closed Proforma Invoices';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "Closed proforma Invoice List";
                }
            }
            group("Gate Pass Out")
            {
                Caption = 'Gate Pass Out';
                Image = AdministrationSalesPurchases;
                //ToolTip = 'Manage purchase invoices and credit memos. Maintain vendors and their history.';
                action(GatePassOut)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Gate Pass Outs';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "Gate Pass Outs";
                }
                action(PendingGPO)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Gate Pass Outs';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "PendingContainers for Gatepass";
                }
                action(ReleasedGPO)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Released Gate Pass Outs';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page ReleasedGatepassOutslist;
                }
            }
            group("IMS Masters")
            {
                Caption = 'Masters';
                Image = AdministrationSalesPurchases;
                action(ChargeIDGroups)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Charge ID Groups';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "ChargeID Groups";
                }
                action(Positions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Positions';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "Position List";
                    //ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
                }
                action(Items)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Items';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "Item List";
                    //ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
                }
                action(Machine)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Machines';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "Machine List";
                }
                action(MachineOperator)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Machine Operator';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "Machine Operator List";
                }
                action(Ports)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ports';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "Port List";
                }
                action(Containers)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Containers';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "Container List";
                }
                action(ClearingAgents)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Clearing Agents';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "Clearing Agent List";
                }
                action(IMSSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'IMS Setup';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "IMS Setup";
                }
            }
        }
    }
}


