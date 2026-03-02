page 50145 "Terminal Role Center"
{
    Caption = 'Terminal', Comment = 'Use same translation as ''Profile Description'' (if applicable)';
    PageType = RoleCenter;
    ApplicationArea = all;
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
            part(Control3; "Team Member Activities")
            {
                ApplicationArea = Suite;
            }
            part(Control7; "User Tasks Activities")
            {
                ApplicationArea = Suite;
            }
            // part("Emails"; "Email Activities")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
            // part(ApprovalsActivities; "Approvals Activities")
            // {
            //     ApplicationArea = Suite;
            // }
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
            // group(Manifest)
            // {
            //     Caption = 'Manifests';
            //     Image = AdministrationSalesPurchases;
            //     ToolTip = 'Manage Manifests';
            //     action(Manifests)
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'Manifests';
            //         Promoted = true;
            //         PromotedCategory = Process;
            //         RunObject = Page "Manifest List";
            //     }
            // }
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

            // group("IMS Billing")
            // {
            //     Caption = 'IMS Billing';
            //     Image = AdministrationSalesPurchases;
            //     //ToolTip = 'Manage purchase invoices and credit memos. Maintain vendors and their history.';
            //     action(ProformaInvoice)
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'Proforma Invoices';
            //         Promoted = true;
            //         PromotedCategory = Process;
            //         RunObject = Page "proforma Invoice List";
            //     }
            //     action(SalesInvoice)
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'Sales Invoices';
            //         Promoted = true;
            //         PromotedCategory = Process;
            //         RunObject = Page "Sales Invoice List";
            //     }
            //     action(ClosedProformaInvoices)
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'Closed Proforma Invoices';
            //         Promoted = true;
            //         PromotedCategory = Process;
            //         RunObject = Page "Closed proforma Invoice List";
            //     }
            // }
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
                // action(ChargeIDGroups)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Charge ID Groups';
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     RunObject = Page "ChargeID Groups";
                // }
                action(Positions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Positions';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    RunObject = Page "Position List";
                    //ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
                }
                // action(Items)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Items';
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     RunObject = Page "Item List";
                //     //ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
                // }
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
                // action(ClearingAgents)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Clearing Agents';
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     RunObject = Page "Clearing Agent List";
                // }
                // action(IMSSetup)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'IMS Setup';
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     RunObject = Page "IMS Setup";
                // }
            }
        }
    }
}


