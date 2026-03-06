page 50104 "proforma Invoice"
{
    Caption = 'Proforma Invoice';
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Order,Request Approval,History,Print/Send,Navigate';
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    //Editable = Pageeditab;
    DeleteAllowed = false;
    SourceTableView = where("Document Type" = filter(Order), Warehouse = const(false));
    AboutTitle = 'About sales order details';
    AboutText = 'Choose the order details and fill in order lines with quantities of what you are selling. Post the order when you are ready to ship or invoice. This creates posted sales shipments and posted sales invoices.';


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    Visible = DocNoVisible;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;


                }
                field("Sell-to Customer No."; rec."Sell-to Customer No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer No.';
                    Importance = Additional;
                    NotBlank = true;
                    ToolTip = 'Specifies the number of the customer who will receive the products and be billed by default.';

                    trigger OnValidate()
                    var
                        UserSetup: record "User Setup";
                    begin
                        usersetup.get(userid);
                        IF xRec."Sell-to Customer No." <> '' then begin
                            if Rec."Sell-to Customer No." <> xRec."Sell-to Customer No." then begin
                                if not UserSetup."Change Customer on PFI" then
                                    Error('You can not change the Customer. Please Contact Audit Team.');
                            end;
                        end;
                        Rec.SelltoCustomerNoOnAfterValidate(Rec, xRec);
                        CurrPage.Update();
                    end;
                }
                field("Sell-to Customer Name"; rec."Sell-to Customer Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer Name';
                    ShowMandatory = true;
                    ToolTip = 'Specifies the name of the customer who will receive the products and be billed by default.';

                    AboutTitle = 'Who are you selling to?';
                    AboutText = 'You can choose existing customers, or add new customers when you create orders. Orders can automatically choose special prices and discounts that you have set for each customer.';

                    trigger OnValidate()
                    begin
                        Rec.SelltoCustomerNoOnAfterValidate(Rec, xRec);

                        if ApplicationAreaMgmtFacade.IsFoundationEnabled then
                            SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0, Rec);

                        CurrPage.Update();
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        exit(Rec.LookupSellToCustomerName(Text));
                    end;
                }
                group(Control114)
                {
                    ShowCaption = false;
                    Visible = ShowQuoteNo;
                    field("Quote No."; Rec."Quote No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the number of the sales quote that the sales order was created from. You can track the number to sales quote documents that you have printed, saved, or emailed.';
                    }
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies additional posting information for the document. After you post the document, the description can add detail to vendor and customer ledger entries.';
                    Visible = false;
                }
                group("Sell-to")
                {
                    Caption = 'Sell-to';
                    field("Sell-to Address"; Rec."Sell-to Address")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Address';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the address where the customer is located.';
                    }
                    field("Sell-to Address 2"; Rec."Sell-to Address 2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Address 2';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies additional address information.';
                    }
                    field("Sell-to City"; Rec."Sell-to City")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'City';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the city of the customer on the sales document.';
                    }
                    group(Control123)
                    {
                        ShowCaption = false;
                        Visible = IsSellToCountyVisible;
                        field("Sell-to County"; Rec."Sell-to County")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'County';
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Specifies the state, province or county of the address.';
                        }
                    }
                    field("Sell-to Post Code"; Rec."Sell-to Post Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Post Code';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Country/Region Code';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the country or region of the address.';

                        trigger OnValidate()
                        begin
                            IsSellToCountyVisible := FormatAddress.UseCounty(Rec."Sell-to Country/Region Code");
                        end;
                    }
                    field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Contact No.';
                        Importance = Additional;
                        ToolTip = 'Specifies the number of the contact person that the sales document will be sent to.';

                        trigger OnValidate()
                        begin
                            if Rec.GetFilter("Sell-to Contact No.") = xRec."Sell-to Contact No." then
                                if Rec."Sell-to Contact No." <> xRec."Sell-to Contact No." then
                                    Rec.SetRange("Sell-to Contact No.");
                        end;
                    }
                    field("Sell-to Phone No."; Rec."Sell-to Phone No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Phone No.';
                        Importance = Additional;
                        ToolTip = 'Specifies the telephone number of the contact person that the sales document will be sent to.';
                    }
                    field(SellToMobilePhoneNo; SellToContact."Mobile Phone No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Mobile Phone No.';
                        Importance = Additional;
                        Editable = false;
                        ExtendedDatatype = PhoneNo;
                        ToolTip = 'Specifies the mobile telephone number of the contact person that the sales document will be sent to.';
                    }
                    field("Sell-to E-Mail"; Rec."Sell-to E-Mail")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Email';
                        Importance = Additional;
                        ToolTip = 'Specifies the email address of the contact person that the sales document will be sent to.';
                    }
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Contact';
                    Editable = Rec."Sell-to Customer No." <> '';
                    ToolTip = 'Specifies the name of the person to contact at the customer.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the date when the posting of the sales document will be recorded.';

                    trigger OnValidate()
                    begin
                        SaveInvoiceDiscountAmount;
                    end;
                }
                group("BL Details")
                {
                    Caption = 'Container Details';
                    field("Currency Code"; Rec."Currency Code")
                    {
                        ApplicationArea = Suite;
                        Importance = Promoted;
                        ToolTip = 'Specifies the currency of amounts on the sales document.';

                        trigger OnAssistEdit()
                        begin
                            Clear(ChangeExchangeRate);
                            if Rec."Posting Date" <> 0D then
                                ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date")
                            else
                                ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WorkDate);
                            if ChangeExchangeRate.RunModal = ACTION::OK then begin
                                Rec.Validate("Currency Factor", ChangeExchangeRate.GetParameter);
                                SaveInvoiceDiscountAmount;
                            end;
                            Clear(ChangeExchangeRate);
                        end;

                        trigger OnValidate()
                        begin
                            CurrPage.SaveRecord;
                            SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0, Rec);
                        end;
                    }

                    field("BL No."; rec."BL No.")
                    {
                        ApplicationArea = All;
                        trigger OnLookup(var text: text): Boolean
                        var
                            ManiLine: Record "Manifest Line";
                            SalesHead: Record "Sales Header";
                        begin
                            ManiLine.Reset();
                            //ManiLine.SetRange(Received, true);
                            //ManiLine.SetRange(Verified, true);
                            ManiLine.SetRange("Invoicing Party No.", Rec."Sell-to Customer No.");
                            ManiLine.SetRange(Released, false);
                            ManiLine.FindFirst();
                            if page.RunModal(50122, ManiLine) = Action::LookupOK then begin
                                if ManiLine."BL No." <> '' then begin
                                    SalesHead.Reset();
                                    SalesHead.SetRange("Document Type", SalesHead."Document Type"::Order);
                                    //SalesHead.SetRange(Status, SalesHead.Status::Open);
                                    SalesHead.SetRange(Closed, false);
                                    SalesHead.SetRange("BL No.", ManiLine."BL No.");
                                    if SalesHead.FindFirst() then
                                        Error('Proforma Invoice already created with same BL')
                                    else
                                        rec.validate("BL No.", ManiLine."BL No.");
                                end;

                                //rec.validate("BL No.", ManiLine."BL No.");
                                rec.GetManifestDetails();
                                CurrPage.Update(false);
                            end;
                        end;

                        trigger OnValidate()
                        var
                            SalesHead: Record "Sales Header";
                        begin
                            if Rec."BL No." <> '' then begin
                                SalesHead.Reset();
                                SalesHead.SetRange("Document Type", SalesHead."Document Type"::Order);
                                //SalesHead.SetRange(Status, SalesHead.Status::Open);
                                SalesHead.SetRange(Closed, false);
                                SalesHead.SetRange("BL No.", Rec."BL No.");
                                if SalesHead.FindFirst() then
                                    Error('Proforma Invoice already created with same BL');
                            end;
                        end;
                    }
                    field("Reefer Hours Upto"; rec."Reefer Hours Upto")
                    {
                        ApplicationArea = All;
                    }
                    field("Payment Terms Code"; Rec."Payment Terms Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Promoted;
                        ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount.';
                        Editable = false;
                    }

                    field("Job File No."; Rec."Job File No.")
                    {
                        ApplicationArea = All;

                    }
                    field("Job File Date"; Rec."Job File Date")
                    {
                        ApplicationArea = All;
                    }
                }


                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ShowMandatory = ExternalDocNoMandatory;
                    ToolTip = 'Specifies a document number that refers to the customer''s or vendor''s numbering system.';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Specifies the name of the salesperson who is assigned to the customer.';
                    Visible = false;
                    trigger OnValidate()
                    begin
                        SalespersonCodeOnAfterValidate;
                    end;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = Suite;
                    Importance = Promoted;
                    StyleExpr = StatusStyleTxt;
                    QuickEntry = false;
                    ToolTip = 'Specifies whether the document is open, waiting to be approved, has been invoiced for prepayment, or has been released to the next stage of processing.';
                }
                group("Work Description")
                {
                    Caption = 'Work Description';
                    field(WorkDescription; WorkDescription)
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                        ToolTip = 'Specifies the products or service being offered.';

                        trigger OnValidate()
                        begin
                            Rec.SetWorkDescription(WorkDescription);
                        end;
                    }
                }
            }
            part(SalesLines1; "Sales Order Subform Group")
            {
                ApplicationArea = Basic, Suite;
                Editable = DynamicEditable;
                Enabled = Rec."Sell-to Customer No." <> '';
                SubPageLink = "Document No." = FIELD("No.");
                //UpdatePropagation = Both;
            }
            part(SalesLines; "Proforma SubForm")
            {
                ApplicationArea = Basic, Suite;
                Editable = DynamicEditable;
                Enabled = Rec."Sell-to Customer No." <> '';
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }
            group("Invoice Details")
            {
                Caption = 'Invoice Details';

                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ApplicationArea = VAT;
                    ToolTip = 'Specifies if the Unit Price and Line Amount fields on document lines should be shown with or without VAT.';

                    trigger OnValidate()
                    begin
                        PricesIncludingVATOnAfterValid;
                    end;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the VAT specification of the involved customer or vendor to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';

                    trigger OnValidate()
                    begin
                        if ApplicationAreaMgmtFacade.IsFoundationEnabled then
                            SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0, Rec);

                        CurrPage.Update();
                    end;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies how to make payment, such as with bank transfer, cash, or check.';

                    trigger OnValidate()
                    begin
                        UpdatePaymentService();
                    end;
                }
            }


        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(36),
                              "No." = FIELD("No."),
                              "Document Type" = FIELD("Document Type");
            }
            part(Control35; "Pending Approval FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Table ID" = CONST(36),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = OpenApprovalEntriesExistForCurrUser;
            }
            part(Control1903720907; "Sales Hist. Sell-to FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("Sell-to Customer No."),
                              "Date Filter" = FIELD("Date Filter");
                Visible = false;
            }
            part(Control1902018507; "Customer Statistics FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("Bill-to Customer No."),
                              "Date Filter" = field("Date Filter");
                Visible = false;
            }
            part(Control1900316107; "Customer Details FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("Sell-to Customer No."),
                              "Date Filter" = field("Date Filter");
            }
            part(Control1906127307; "Sales Line FactBox")
            {
                ApplicationArea = Suite;
                Provider = SalesLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
                Visible = false;
            }
            part(Control1901314507; "Item Invoicing FactBox")
            {
                ApplicationArea = Basic, Suite;
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
                Visible = false;
            }
            part(Control1907234507; "Sales Hist. Bill-to FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("Bill-to Customer No."),
                              "Date Filter" = field("Date Filter");
                Visible = false;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = All;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                action(Statistics)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
                    Visible = false;

                    trigger OnAction()
                    var
                        Handled: Boolean;
                    begin
                        Handled := false;
                        OnBeforeStatisticsAction(Rec, Handled);
                        if Handled then
                            exit;

                        Rec.OpenSalesOrderStatistics();
                    end;
                }
                action(Customer)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer';
                    Enabled = IsCustomerOrContactNotEmpty;
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Category12;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("Sell-to Customer No."),
                                  "Date Filter" = FIELD("Date Filter");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or edit detailed information about the customer on the sales document.';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Enabled = Rec."No." <> '';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SaveRecord;
                    end;
                }
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category8;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalsSales(Rec);
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category8;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    ToolTip = 'View or add comments for the record.';
                }

                action(DocAttach)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Category8;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal;
                    end;
                }
            }
            group(ActionGroupCRM)
            {
                Caption = 'Dynamics 365 Sales';
                Visible = false;
                action(CRMGoToSalesOrder)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Order';
                    Enabled = CRMIntegrationEnabled AND CRMIsCoupledToRecord;
                    Image = CoupledOrder;
                    ToolTip = 'View the selected sales order.';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowCRMEntityFromRecordID(Rec.RecordId);
                    end;
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                visible = FAlse;

                action("S&hipments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'S&hipments';
                    Image = Shipment;
                    Promoted = true;
                    PromotedCategory = Category12;
                    RunObject = Page "Posted Sales Shipments";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ToolTip = 'View related posted sales shipments.';
                    visible = false;
                }
                action(Invoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Invoices';
                    Image = Invoice;
                    Promoted = true;
                    PromotedCategory = Category12;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ToolTip = 'View a list of ongoing sales invoices for the order.';
                    visible = false;
                }
            }


            group(History)
            {
                Caption = 'History';
                action(PageInteractionLogEntries)
                {
                    ApplicationArea = Suite;
                    Caption = 'Interaction Log E&ntries';
                    Image = InteractionLog;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category10;
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View a list of interaction log entries related to this document.';
                    Visible = false;
                    trigger OnAction()
                    begin
                        Rec.ShowInteractionLogEntries;
                    end;
                }
                action(PagePositionLogs)
                {
                    ApplicationArea = Suite;
                    Caption = 'Position Log';
                    Image = InteractionLog;
                    ToolTip = 'View a list of Position log entries related to this document.';
                    Visible = true;
                    RunObject = Page "Position Log List";
                    RunPageLink = "Position Code" = FIELD("Position ID");
                }
                action(PageReceivingLogs)
                {
                    ApplicationArea = Suite;
                    Caption = 'Receiving Log';
                    Image = InteractionLog;
                    ToolTip = 'View a list of Receiving log entries related to this document.';
                    Visible = true;
                    RunObject = Page ReceivingLogs;
                    RunPageLink = "Global Dimension 1 Code" = FIELD("Shortcut Dimension 1 Code");
                }
                action(PageVerificationLogs)
                {
                    ApplicationArea = Suite;
                    Caption = 'Verification Log';
                    Image = InteractionLog;
                    ToolTip = 'View a list of Verification log entries related to this document.';
                    Visible = true;
                    RunObject = Page VerificationLogs;
                    RunPageLink = "Global Dimension 1 Code" = FIELD("Shortcut Dimension 1 Code");
                }
            }
        }
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
            group(Action21)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Release the document to the next stage of processing. When a document is released, it will be included in all availability calculations from the expected receipt date of the items. You must reopen the document before you can make changes to it.';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                        CurrPage.SalesLines.PAGE.ClearTotalSalesHeader();
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Re&open';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedOnly = true;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                        CurrPage.SalesLines.PAGE.ClearTotalSalesHeader();
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(CalculateInvoiceDiscount)
                {
                    AccessByPermission = TableData "Cust. Invoice Disc." = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;
                    ToolTip = 'Calculate the invoice discount that applies to the sales order.';

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                        SalesCalcDiscountByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }

                action(CopyDocument)
                {
                    ApplicationArea = Suite;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Enabled = Rec."No." <> '';
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    ToolTip = 'Copy document lines and header information from another sales document to this document. You can copy a posted sales invoice into a new sales invoice to quickly create a similar document.';

                    trigger OnAction()
                    begin
                        Rec.CopyDocument();
                        if Rec.Get(Rec."Document Type", Rec."No.") then;
                    end;
                }
                action("Calculate Charges")
                {
                    ApplicationArea = Suite;
                    Caption = 'Calculate Charges';
                    Ellipsis = true;
                    Enabled = Rec."No." <> '';
                    Image = Calculate;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    ToolTip = 'Calculate the charges';

                    trigger OnAction()
                    begin
                        CalculateLineCharges();
                    end;
                }


                action("Manifest Lines")
                {
                    Caption = 'Related Manifest Lines';
                    ApplicationArea = All;
                    Image = Navigate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = page "Manifest Lines";
                    RunPageLink = "BL No." = field("BL No.");
                    // RunObject = page "Manifests New";
                    // RunPageLink = "BL No." = field("BL No.");
                }

                // action("Additional Charges")
                // {
                //     ApplicationArea = Suite;
                //     Caption = 'Additional Charges';
                //     Ellipsis = true;
                //     Enabled = Rec."No." <> '';
                //     Image = Calculate;
                //     Promoted = true;
                //     PromotedCategory = Category7;
                //     PromotedIsBig = true;
                //     visible = false;
                //     ToolTip = 'Additional Charges';

                //     trigger OnAction()
                //     begin
                //         CalculateAdditionalCharges();
                //     end;
                // }not using

            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.CheckSalesApprovalPossible(Rec) then
                            ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }

            }

            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';
                    visible = false;

                    AboutTitle = 'Posting the order';
                    AboutText = 'Posting will ship or invoice the quantities on the order, or both. Post and Send can save the order as a file, print it, or attach it to an email, all in one go.';

                    trigger OnAction()
                    begin
                        PostSalesOrder(CODEUNIT::"Sales-Post (Yes/No)", "Navigate After Posting"::"Posted Document");
                    end;
                }
                action(PostAndNew)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post and New';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ShortCutKey = 'Alt+F9';
                    ToolTip = 'Post the sales document and create a new, empty one.';
                    Visible = false;

                    trigger OnAction()
                    begin
                        PostSalesOrder(CODEUNIT::"Sales-Post (Yes/No)", "Navigate After Posting"::"New Document");
                    end;
                }
                action(PostAndSend)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post and Send';
                    Ellipsis = true;
                    Image = PostMail;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'Finalize and prepare to send the document according to the customer''s sending profile, such as attached to an email. The Send document to window opens first so you can confirm or select a sending profile.';
                    Visible = false;
                    trigger OnAction()
                    begin
                        PostSalesOrder(CODEUNIT::"Sales-Post and Send", "Navigate After Posting"::"Do Nothing");
                    end;
                }
                action("Test Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }

                action(PreviewPosting)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ShortCutKey = 'Ctrl+Alt+F9';
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                    trigger OnAction()
                    begin
                        ShowPreview;
                    end;
                }
                action(ProformaInvoice)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pro Forma Invoice';
                    Ellipsis = true;
                    Image = ViewPostedOrder;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category5;
                    ToolTip = 'View or print the pro forma sales invoice.';

                    trigger OnAction()
                    begin
                        DocPrint.PrintProformaSalesInvoice(Rec);
                    end;
                }

            }

            group("&Order Confirmation")
            {
                Caption = '&Order Confirmation';
                Image = Email;
                action(SendEmailConfirmation)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Email Confirmation';
                    Ellipsis = true;
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Category11;
                    PromotedIsBig = true;
                    ToolTip = 'Send a sales order confirmation by email. The attachment is sent as a .pdf.';
                    Visible = false;
                    trigger OnAction()
                    begin
                        DocPrint.EmailSalesHeader(Rec);
                    end;
                }
                group(Action96)
                {
                    Visible = false;
                    action(ProformaInvoice1)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Print Proforma Invoice';
                        Ellipsis = true;
                        Image = Print;
                        Promoted = true;
                        PromotedCategory = Category11;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Category5;
                        ToolTip = 'View or print the pro forma sales invoice.';

                        trigger OnAction()
                        begin
                            DocPrint.PrintProformaSalesInvoice(Rec);
                        end;
                    }
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    var
        SalesHeader: Record "Sales Header";
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
        CustCheckCrLimit: Codeunit "Cust-Check Cr. Limit";
    begin
        DynamicEditable := CurrPage.Editable;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(Rec.RecordId);
        CRMIsCoupledToRecord := CRMIntegrationEnabled;
        if CRMIsCoupledToRecord then
            CRMIsCoupledToRecord := CRMCouplingManagement.IsRecordCoupledToCRM(Rec.RecordId);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RecordId);
        UpdatePaymentService();
        if CallNotificationCheck then begin
            SalesHeader := Rec;
            SalesHeader.CalcFields("Amount Including VAT");
            CustCheckCrLimit.SalesHeaderCheck(SalesHeader);
            Rec.CheckItemAvailabilityInLines;
            CallNotificationCheck := false;
        end;
        StatusStyleTxt := Rec.GetStatusStyleText();
        SetControlVisibility();

        IF rec.Closed = false then
            currpage.Editable := true
        else
            currpage.Editable := false;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlVisibility;
        UpdateShipToBillToGroupVisibility;
        WorkDescription := Rec.GetWorkDescription;
        BillToContact.GetOrClear(Rec."Bill-to Contact No.");
        SellToContact.GetOrClear(Rec."Sell-to Contact No.");
        CurrPage.SalesLines1.PAGE.SetDocNo(Rec."No.");

        IF rec.Closed = false then
            currpage.Editable := true
        else
            currpage.Editable := false;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SaveRecord;
        exit(Rec.ConfirmDeletion);
    end;

    trigger OnInit()
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        JobQueuesUsed := SalesReceivablesSetup.JobQueueActive;
        SetExtDocNoMandatoryCondition;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if DocNoVisible then
            Rec.CheckCreditMaxBeforeInsert;

        if (Rec."Sell-to Customer No." = '') and (Rec.GetFilter("Sell-to Customer No.") <> '') then
            CurrPage.Update(false);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        xRec.Init();
        Rec."Responsibility Center" := UserMgt.GetSalesFilter;
        if (not DocNoVisible) and (Rec."No." = '') then
            Rec.SetSellToCustomerFromFilter;

        Rec.SetDefaultPaymentServices;
        UpdateShipToBillToGroupVisibility;
    end;

    trigger OnOpenPage()
    var
        PaymentServiceSetup: Record "Payment Service Setup";
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        OfficeMgt: Codeunit "Office Management";
        EnvironmentInfo: Codeunit "Environment Information";
    begin
        Rec.SetSecurityFilterOnRespCenter();

        Rec.SetRange("Date Filter", 0D, WorkDate());

        ActivateFields();

        SetDocNoVisible();

        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
        IsOfficeHost := OfficeMgt.IsAvailable;
        IsSaas := EnvironmentInfo.IsSaaS;

        if (Rec."No." <> '') and (Rec."Sell-to Customer No." = '') then
            DocumentIsPosted := (not Rec.Get(Rec."Document Type", Rec."No."));
        PaymentServiceVisible := PaymentServiceSetup.IsPaymentServiceVisible;

        SetPageEditable();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        if not DocumentIsScheduledForPosting and ShowReleaseNotification then
            if not InstructionMgt.ShowConfirmUnreleased then
                exit(false);
        if not DocumentIsPosted then
            exit(Rec.ConfirmCloseUnposted);
    end;

    var
        BillToContact: Record Contact;
        SellToContact: Record Contact;
        MoveNegSalesLines: Report "Move Negative Sales Lines";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        ArchiveManagement: Codeunit ArchiveManagement;
        SalesCalcDiscountByType: Codeunit "Sales - Calc Discount By Type";
        UserMgt: Codeunit "User Setup Management";
        CustomerMgt: Codeunit "Customer Mgt.";
        FormatAddress: Codeunit "Format Address";
        ChangeExchangeRate: Page "Change Exchange Rate";
        Usage: Option "Order Confirmation","Work Order","Pick Instruction";
        [InDataSet]
        JobQueueVisible: Boolean;
        Text001: Label 'Do you want to change %1 in all related records in the warehouse?';
        Text002: Label 'The update has been interrupted to respect the warning.';
        DynamicEditable: Boolean;
        HasIncomingDocument: Boolean;
        DocNoVisible, Pageeditab : Boolean;
        ExternalDocNoMandatory: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        ShowWorkflowStatus: Boolean;
        IsOfficeHost: Boolean;
        CanCancelApprovalForRecord: Boolean;
        JobQueuesUsed: Boolean;
        ShowQuoteNo: Boolean;
        DocumentIsPosted: Boolean;
        DocumentIsScheduledForPosting: Boolean;
        OpenPostedSalesOrderQst: Label 'The order is posted as number %1 and moved to the Posted Sales Invoices window.\\Do you want to open the posted invoice?', Comment = '%1 = posted document number';
        PaymentServiceVisible: Boolean;
        PaymentServiceEnabled: Boolean;
        CallNotificationCheck: Boolean;
        EmptyShipToCodeErr: Label 'The Code field can only be empty if you select Custom Address in the Ship-to field.';
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        IsCustomerOrContactNotEmpty: Boolean;
        WorkDescription: Text;
        [InDataSet]
        StatusStyleTxt: Text;
        IsSaas: Boolean;
        IsBillToCountyVisible: Boolean;
        IsSellToCountyVisible: Boolean;
        IsShipToCountyVisible: Boolean;

    protected var
        ShipToOptions: Enum "Sales Ship-to Options";
        BillToOptions: Enum "Sales Bill-to Options";

    local procedure ActivateFields()
    begin
        IsBillToCountyVisible := FormatAddress.UseCounty(Rec."Bill-to Country/Region Code");
        IsSellToCountyVisible := FormatAddress.UseCounty(Rec."Sell-to Country/Region Code");
        IsShipToCountyVisible := FormatAddress.UseCounty(Rec."Ship-to Country/Region Code");
    end;

    [Obsolete('Replaced by PostSalesOrder().', '18.0')]
    procedure PostDocument(PostingCodeunitID: Integer; Navigate: Option)
    begin
        PostSalesOrder(PostingCodeunitID, "Navigate After Posting".FromInteger(Navigate));
    end;

    protected procedure PostSalesOrder(PostingCodeunitID: Integer; Navigate: Enum "Navigate After Posting")
    var
        SalesHeader: Record "Sales Header";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        InstructionMgt: Codeunit "Instruction Mgt.";
        IsHandled: Boolean;
    begin
        OnBeforePostSalesOrder(Rec, PostingCodeunitID, Navigate);
        if ApplicationAreaMgmtFacade.IsFoundationEnabled then
            LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);

        Rec.SendToPosting(PostingCodeunitID);

        DocumentIsScheduledForPosting := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        DocumentIsPosted := (not SalesHeader.Get(Rec."Document Type", Rec."No.")) or DocumentIsScheduledForPosting;
        OnPostOnAfterSetDocumentIsPosted(SalesHeader, DocumentIsScheduledForPosting, DocumentIsPosted);

        CurrPage.Update(false);

        IsHandled := false;
        OnPostDocumentBeforeNavigateAfterPosting(Rec, PostingCodeunitID, Navigate, DocumentIsPosted, IsHandled);
        if IsHandled then
            exit;

        if PostingCodeunitID <> CODEUNIT::"Sales-Post (Yes/No)" then
            exit;

        case Navigate of
            "Navigate After Posting"::"Posted Document":
                begin
                    if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode) then
                        ShowPostedConfirmationMessage();

                    if DocumentIsScheduledForPosting or DocumentIsPosted then
                        CurrPage.Close();
                end;
            "Navigate After Posting"::"New Document":
                if DocumentIsPosted then begin
                    Clear(SalesHeader);
                    SalesHeader.Init();
                    SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Order);
                    OnPostOnBeforeSalesHeaderInsert(SalesHeader);
                    SalesHeader.Insert(true);
                    PAGE.Run(PAGE::"Sales Order", SalesHeader);
                end;
        end;
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure SaveInvoiceDiscountAmount()
    var
        DocumentTotals: Codeunit "Document Totals";
    begin
        CurrPage.SaveRecord;
        DocumentTotals.SalesRedistributeInvoiceDiscountAmountsOnDocument(Rec);
        CurrPage.Update(false);
    end;

    local procedure SalespersonCodeOnAfterValidate()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(true);
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.Update();
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.Update();
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.SalesLines.Page.ForceTotalsCalculation();
        CurrPage.Update();
    end;

    local procedure Prepayment37OnAfterValidate()
    begin
        CurrPage.Update();
    end;

    local procedure SetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.SalesDocumentNoIsVisible(DocType::Order, Rec."No.");
    end;

    local procedure SetExtDocNoMandatoryCondition()
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        SalesReceivablesSetup.Get();
        ExternalDocNoMandatory := SalesReceivablesSetup."Ext. Doc. No. Mandatory"
    end;

    local procedure ShowPreview()
    var
        SalesPostYesNo: Codeunit "Sales-Post (Yes/No)";
    begin
        SalesPostYesNo.Preview(Rec);
    end;

    local procedure ShowPrepmtInvoicePreview()
    var
        SalesPostPrepaymentYesNo: Codeunit "Sales-Post Prepayment (Yes/No)";
    begin
        SalesPostPrepaymentYesNo.Preview(Rec, 2);
    end;

    local procedure ShowPrepmtCrMemoPreview()
    var
        SalesPostPrepaymentYesNo: Codeunit "Sales-Post Prepayment (Yes/No)";
    begin
        SalesPostPrepaymentYesNo.Preview(Rec, 3);
    end;

    local procedure SetControlVisibility()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        JobQueueVisible := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        ShowQuoteNo := Rec."Quote No." <> '';
        SetExtDocNoMandatoryCondition;

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
        IsCustomerOrContactNotEmpty := (Rec."Sell-to Customer No." <> '') or (Rec."Sell-to Contact No." <> '');
    end;

    local procedure ShowPostedConfirmationMessage()
    var
        OrderSalesHeader: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        if not OrderSalesHeader.Get(Rec."Document Type", Rec."No.") then begin
            SalesInvoiceHeader.SetRange("No.", Rec."Last Posting No.");
            if SalesInvoiceHeader.FindFirst then
                if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedSalesOrderQst, SalesInvoiceHeader."No."),
                     InstructionMgt.ShowPostedConfirmationMessageCode)
                then
                    PAGE.Run(PAGE::"Posted Sales Invoice", SalesInvoiceHeader);
        end;
    end;

    protected procedure UpdatePaymentService()
    var
        PaymentServiceSetup: Record "Payment Service Setup";
    begin
        PaymentServiceVisible := PaymentServiceSetup.IsPaymentServiceVisible;
        PaymentServiceEnabled := PaymentServiceSetup.CanChangePaymentService(Rec);
    end;

    procedure UpdateShipToBillToGroupVisibility()
    begin
        CustomerMgt.CalculateShipBillToOptions(ShipToOptions, BillToOptions, Rec);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeStatisticsAction(var SalesHeader: Record "Sales Header"; var Handled: Boolean)
    begin
    end;

    procedure CheckNotificationsOnce()
    begin
        CallNotificationCheck := true;
    end;

    local procedure ShowReleaseNotification() Result: Boolean
    var
        LocationsQuery: Query "Locations from items Sales";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeShowReleaseNotification(Rec, Result, IsHandled);
        if IsHandled then
            exit;

        if Rec.TestStatusIsNotReleased then begin
            LocationsQuery.SetRange(Document_No, Rec."No.");
            LocationsQuery.SetRange(Require_Pick, true);
            LocationsQuery.Open;
            if LocationsQuery.Read then
                exit(true);
            LocationsQuery.SetRange(Require_Pick);
            LocationsQuery.SetRange(Require_Shipment, true);
            LocationsQuery.Open;
            exit(LocationsQuery.Read);
        end;
        exit(false);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterValidateShippingOptions(var SalesHeader: Record "Sales Header"; ShipToOptions: Option "Default (Sell-to Address)","Alternate Shipping Address","Custom Address")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePostSalesOrder(var SalesHeader: Record "Sales Header"; PostingCodeunitID: Integer; Navigate: Enum "Navigate After Posting")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeShowReleaseNotification(var SalesHeader: Record "Sales Header"; var Result: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateShipToOptions(var SalesHeader: Record "Sales Header"; ShipToOptions: Option "Default (Sell-to Address)","Alternate Shipping Address","Custom Address"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPostOnAfterSetDocumentIsPosted(SalesHeader: Record "Sales Header"; var IsScheduledPosting: Boolean; var DocumentIsPosted: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPostOnBeforeSalesHeaderInsert(var SalesHeader: Record "Sales Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnValidateShipToOptionsOnAfterShipToAddressListGetRecord(var ShipToAddress: Record "Ship-to Address"; var SalesHeader: Record "Sales Header")
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnPostDocumentBeforeNavigateAfterPosting(var SalesHeader: Record "Sales Header"; var PostingCodeunitID: Integer; var Navigate: Enum "Navigate After Posting"; DocumentIsPosted: Boolean; var IsHandled: Boolean)
    begin
    end;

    procedure CalculateLineCharges()
    var
        ManifestLine, MFLine : Record "Manifest Line";
        TempManifestLine: Record "Manifest Line" temporary;
        PageContainerList: page ContainerListForProforma;
        Invoicable: Boolean;
    begin
        ManifestLine.Reset();
        ManifestLine.SetRange("BL No.", rec."BL No.");
        ManifestLine.SetRange("Container lock", false);
        ManifestLine.SetRange(Received, true);
        ManifestLine.SetRange(Manifested, true);
        //ManifestLine.SetRange(Verified, true);
        ManifestLine.SetRange(Released, false);


        clear(PageContainerList);
        PageContainerList.SetTableView(ManifestLine);
        PageContainerList.SetRecord(ManifestLine);
        PageContainerList.LookupMode(true);
        PageContainerList.GetSalesOrderNo(rec."No.", rec."Sell-to Customer No.");
        if PageContainerList.RunModal = ACTION::LookupOK then begin
            //Message('Calculated Successfully');
        end;
    end;

    procedure CalculateAdditionalCharges()
    var
        ManifestLine: Record "Manifest Line";
        TempManifestLine: Record "Manifest Line" temporary;
        PageContainerList: page ProformaContainersAddChrg;
    begin
        ManifestLine.Reset();
        ManifestLine.SetRange("BL No.", rec."BL No.");
        ManifestLine.SetRange("Container lock", false);
        ManifestLine.SetRange(Manifested, true);
        ManifestLine.SetRange(Released, false);
        ManifestLine.CalcFields(Invoices, "Credit Memos");
        ManifestLine.SetRange(Invoices, true);
        clear(PageContainerList);
        PageContainerList.SetTableView(ManifestLine);
        PageContainerList.SetRecord(ManifestLine);
        PageContainerList.LookupMode(true);
        PageContainerList.GetSalesOrderNo(rec."No.", rec."Sell-to Customer No.");
        if PageContainerList.RunModal = ACTION::LookupOK then begin

        end;
    end;

    procedure SetPageEditable()

    begin
        IF rec.Closed = false then begin
            currpage.Editable := true
        end else begin
            currpage.Editable := false;
        end;
    end;
}


