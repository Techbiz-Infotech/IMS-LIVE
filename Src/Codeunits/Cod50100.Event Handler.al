codeunit 50100 Events
{
    Permissions = tabledata "G/L Entry" = rmid;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesLine', '', true, true)]
    local procedure OnAfterPostSalesLine(var SalesHeader: record "Sales Header"; var SalesLine: Record "Sales Line")
    var
        GLSetup: Record "General Ledger Setup";
        GLEntry: Record "G/L Entry";
        TempJnlLine: Record "Gen. Journal Line" temporary;
        TmpDimSetEntry: Record "Dimension Set Entry" temporary;
        DimValue: Record "Dimension Value";
        DimMgmt: Codeunit DimensionManagement;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        IMSSetup: record "IMS Setup";
        GLAccount: Record "G/L Account";
        ManifestLine: Record "Manifest Line";
        SalesHead: Record "Sales Header";
        VerificationLog: Record VerificationLog;
        EntryNo: Integer;
        Dimension: Record Dimension;
        DimensionValue: Record "Dimension Value";
        MnaifestLine: Record "Manifest Line";
    begin
        if (SalesLine."Document Type" = SalesLine."Document Type"::Invoice) AND (SalesLine."Shortcut Dimension 1 Code" <> '') then begin
            GLSetup.Get();
            IMSSetup.Get();
            if not IMSSetup."Skip KPA Charges on Invoice" then begin
                DimValue.Reset();
                DimValue.SetRange("Dimension Code", GLSetup."Shortcut Dimension 6 Code");
                DimValue.SetRange("Code", SalesLine."Shortcut Dimension 6 Code");
                if DimValue.FindFirst() then begin
                    if not DimValue."Skip KPA Charges" then begin
                        ManifestLine.Reset();
                        ManifestLine.SetRange("Global Dimension 1 Code", SalesLine."Shortcut Dimension 1 Code");
                        ManifestLine.Setrange("Parent Container ID", '');
                        if ManifestLine.FindFirst() then begin
                            if SalesLine."Shortcut Dimension 4 Code" <> 'UNIT' then begin
                                GLEntry.Reset();
                                GLEntry.SetFilter("G/L Account No.", IMSSetup."Purchase Prepayment Transport");
                                GLEntry.SetRange("Global Dimension 1 Code", SalesLine."Shortcut Dimension 1 Code");
                                GLEntry.SetRange(Reversed, false);
                                if not GLEntry.FindSet() then
                                    Error('Prepayment Transport not found for %1', SalesLine."Shortcut Dimension 1 Code");
                            end;
                            GLEntry.Reset();
                            GLEntry.SetRange("G/L Account No.", IMSSetup."Purchase Prepayment Wharfage");
                            GLEntry.SetRange("Global Dimension 1 Code", SalesLine."Shortcut Dimension 1 Code");
                            GLEntry.SetRange(Reversed, false);
                            if not GLEntry.FindSet() then
                                Error('Prepayment Wharfage not found for %1', SalesLine."Shortcut Dimension 1 Code");


                            GLEntry.Reset();
                            GLEntry.SetRange("G/L Account No.", IMSSetup."Purchase Prepayment From", IMSSetup."Purchase Prepayment To");
                            GLEntry.SetRange("Global Dimension 1 Code", SalesLine."Shortcut Dimension 1 Code");
                            //GLEntry.SetRange("Document Type", GLEntry."Document Type"::Invoice);
                            GLEntry.SetRange("Prepayment Reversed", false);
                            if GLEntry.FindSet() then begin
                                repeat
                                    TempJnlLine.Reset();
                                    TempJnlLine.Init();
                                    TempJnlLine.VALIDATE("Journal Template Name", 'GENERAL');
                                    TempJnlLine.VALIDATE("Journal Batch Name", 'DEFAULT');
                                    TempJnlLine.VALIDATE("Line No.", 10000 * (TempJnlLine.COUNT + 1));
                                    TempJnlLine.validate("Source Code", 'SALES');
                                    SalesLine.CalcFields("Posting Date");
                                    TempJnlLine.VALIDATE("Posting Date", SalesLine."Posting Date");
                                    TempJnlLine.VALIDATE("Document Type", 0);
                                    TempJnlLine.VALIDATE("Document No.", GLEntry."Document No.");
                                    TempJnlLine.VALIDATE("Account Type", TempJnlLine."Account Type"::"G/L Account");
                                    GLAccount.Get(GLEntry."G/L Account No.");
                                    TempJnlLine.VALIDATE("Account No.", GLAccount."Prepayment Reversal Account");
                                    TempJnlLine.VALIDATE(Description, SalesLine."Document No." + '-Reversal-' + GLEntry."Global Dimension 1 Code" + ' ' + GLEntry."G/L Account Name");
                                    TempJnlLine.VALIDATE(Amount, GLEntry.Amount);
                                    TempJnlLine.VALIDATE("Bal. Account Type", TempJnlLine."Bal. Account Type"::"G/L Account");
                                    TempJnlLine.VALIDATE("Bal. Account No.", GLEntry."G/L Account No.");
                                    TempJnlLine.validate("Prepayment Reversed", true);

                                    TmpDimSetEntry.DELETEALL;
                                    DimValue.GET(GLSetup."Global Dimension 1 Code", SalesLine."Shortcut Dimension 1 Code");
                                    TmpDimSetEntry.INIT;
                                    TmpDimSetEntry.VALIDATE("Dimension Code", GLSetup."Global Dimension 1 Code");
                                    TmpDimSetEntry.VALIDATE("Dimension Value Code", SalesLine."Shortcut Dimension 1 Code");
                                    TmpDimSetEntry.INSERT;

                                    DimValue.GET(GLSetup."Global Dimension 2 Code", SalesLine."Shortcut Dimension 2 Code");
                                    TmpDimSetEntry.INIT;
                                    TmpDimSetEntry.VALIDATE("Dimension Code", GLSetup."Global Dimension 2 Code");
                                    TmpDimSetEntry.VALIDATE("Dimension Value Code", SalesLine."Shortcut Dimension 2 Code");
                                    TmpDimSetEntry.INSERT;

                                    DimValue.GET(GLSetup."Shortcut Dimension 3 Code", SalesLine."Shortcut Dimension 3 Code");
                                    TmpDimSetEntry.INIT;
                                    TmpDimSetEntry.VALIDATE("Dimension Code", GLSetup."Shortcut Dimension 3 Code");
                                    TmpDimSetEntry.VALIDATE("Dimension Value Code", SalesLine."Shortcut Dimension 3 Code");
                                    TmpDimSetEntry.INSERT;

                                    DimValue.GET(GLSetup."Shortcut Dimension 4 Code", SalesLine."Shortcut Dimension 4 Code");
                                    TmpDimSetEntry.INIT;
                                    TmpDimSetEntry.VALIDATE("Dimension Code", GLSetup."Shortcut Dimension 4 Code");
                                    TmpDimSetEntry.VALIDATE("Dimension Value Code", SalesLine."Shortcut Dimension 4 Code");
                                    TmpDimSetEntry.INSERT;

                                    DimValue.GET(GLSetup."Shortcut Dimension 5 Code", SalesLine."Shortcut Dimension 5 Code");
                                    TmpDimSetEntry.INIT;
                                    TmpDimSetEntry.VALIDATE("Dimension Code", GLSetup."Shortcut Dimension 5 Code");
                                    TmpDimSetEntry.VALIDATE("Dimension Value Code", SalesLine."Shortcut Dimension 5 Code");
                                    TmpDimSetEntry.INSERT;

                                    DimValue.GET(GLSetup."Shortcut Dimension 6 Code", SalesLine."Shortcut Dimension 6 Code");
                                    TmpDimSetEntry.INIT;
                                    TmpDimSetEntry.VALIDATE("Dimension Code", GLSetup."Shortcut Dimension 6 Code");
                                    TmpDimSetEntry.VALIDATE("Dimension Value Code", SalesLine."Shortcut Dimension 6 Code");
                                    TmpDimSetEntry.INSERT;
                                    TempJnlLine.validate("Dimension Set ID", DimMgmt.GetDimensionSetID(TmpDimSetEntry));
                                    TempJnlLine.insert(true);
                                    GenJnlPostLine.RunWithCheck(TempJnlLine);
                                    GLEntry."Prepayment Reversed" := true;
                                    GLEntry.Modify(true);
                                until GLEntry.Next() = 0;
                            end;
                        end;
                    end;
                end;
            end;
            SalesHead.Reset();
            SalesHead.SetRange("Document Type", SalesHead."Document Type"::Order);
            SalesHead.SetRange("No.", SalesHeader."Proforma No.");
            if SalesHead.FindFirst() then begin
                SalesHead.Closed := true;
                SalesHead.Modify();
            end;
            If VerificationLog.Get(SalesLine."Verification Log No.") then begin
                VerificationLog.Invoiced := true;
                VerificationLog.Modify();
            end;
        end;
    end;

    //    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforePostGLAcc, '', false, false)]
    // local procedure "Gen. Jnl.-Post Line_OnBeforePostGLAcc"(var Sender: Codeunit "Gen. Jnl.-Post Line"; GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry"; var GLEntryNo: Integer; var IsHandled: Boolean; var TempGLEntryBuf: Record "G/L Entry" temporary)
    // var
    //     GLSetup: Record "General Ledger Setup";
    //     GLEntry1: Record "G/L Entry";
    //     IMSSetup: record "IMS Setup";
    //     GLAccount: Record "G/L Account";
    //     GPSetup: Record "General Posting Setup";
    // begin
    //     if GenJournalLine."Source Code" = 'GENJNL' then begin
    //         IMSSetup.Get();
    //         if (GenJournalLine."Account No." > IMSSetup."Purchase Prepayment From") and (GenJournalLine."Account No." < IMSSetup."Purchase Prepayment To") then begin
    //             GLEntry1.Reset();
    //             GLEntry1.SetRange("G/L Account No.", IMSSetup."Purchase Prepayment From", IMSSetup."Purchase Prepayment To");
    //             GLEntry1.SetRange("Global Dimension 1 Code", GenJournalLine."Shortcut Dimension 1 Code");
    //             GLEntry1.SetRange("Prepayment Reversed", true);
    //             GLEntry1.SetFilter(Amount, '>%1', 0);
    //             if GLEntry1.FindFirst() then
    //                 Error('The container ID %1  Prepayment already reversed', GenJournalLine."Shortcut Dimension 1 Code")
    //         end;
    //         if (GenJournalLine."Bal. Account No." > IMSSetup."Purchase Prepayment From") and (GenJournalLine."Bal. Account No." < IMSSetup."Purchase Prepayment To") then begin
    //             GLEntry1.Reset();
    //             GLEntry1.SetRange("G/L Account No.", IMSSetup."Purchase Prepayment From", IMSSetup."Purchase Prepayment To");
    //             GLEntry1.SetRange("Global Dimension 1 Code", GenJournalLine."Shortcut Dimension 1 Code");
    //             GLEntry1.SetRange("Prepayment Reversed", true);
    //             GLEntry1.SetFilter(Amount, '>%1', 0);
    //             if GLEntry1.FindFirst() then
    //                 Error('The container ID %1  Prepayment already reversed', GenJournalLine."Shortcut Dimension 1 Code")
    //         end;
    //     end;
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchLine', '', false, false)]
    local procedure OnAfterPostPurchLine(var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; CommitIsSupressed: Boolean; var PurchInvLine: Record "Purch. Inv. Line"; var PurchCrMemoLine: Record "Purch. Cr. Memo Line"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var PurchLineACY: Record "Purchase Line"; GenJnlLineDocType: Enum "Gen. Journal Document Type"; GenJnlLineDocNo: Code[20];
                                                                                                                                                                                                                                                                                                                                                                                                                                   GenJnlLineExtDocNo: Code[35];
                                                                                                                                                                                                                                                                                                                                                                                                                                   SrcCode: Code[10];
                                                                                                                                                                                                                                                                                                                                                                                               xPurchaseLine: Record "Purchase Line");
    var
        GLSetup: Record "General Ledger Setup";
        GLEntry: Record "G/L Entry";
        IMSSetup: record "IMS Setup";
        GLAccount: Record "G/L Account";
        PurchaseAccount: Code[20];
        GPSetup: Record "General Posting Setup";
    begin
        if (PurchaseLine."Document Type" = PurchaseLine."Document Type"::Invoice) AND (PurchaseLine."Shortcut Dimension 1 Code" <> '') then begin
            if GPSetup.get(PurchaseHeader."Gen. Bus. Posting Group", PurchaseLine."Gen. Prod. Posting Group") then
                PurchaseAccount := GPSetup."Purch. Account"
            else
                PurchaseAccount := '';
            //Message(PurchaseAccount);
            IMSSetup.Get();
            if (PurchaseAccount > IMSSetup."Purchase Prepayment From") and (PurchaseAccount < IMSSetup."Purchase Prepayment To") then begin
                GLEntry.Reset();
                GLEntry.SetRange("G/L Account No.", IMSSetup."Purchase Prepayment From", IMSSetup."Purchase Prepayment To");
                GLEntry.SetRange("Global Dimension 1 Code", PurchaseLine."Shortcut Dimension 1 Code");
                GLEntry.SetRange("Prepayment Reversed", true);
                GLEntry.SetFilter(Amount, '>%1', 0);
                if GLEntry.FindFirst() then
                    Error('The container ID %1  Prepayment already reversed', PurchaseLine."Shortcut Dimension 1 Code")
            end;
        end;
        if (PurchaseLine."Document Type" = PurchaseLine."Document Type"::"Credit Memo") AND (PurchaseLine."Shortcut Dimension 1 Code" <> '') then begin
            if GPSetup.get(PurchaseHeader."Gen. Bus. Posting Group", PurchaseLine."Gen. Prod. Posting Group") then
                PurchaseAccount := GPSetup."Purch. Account"
            else
                PurchaseAccount := '';
            //Message(PurchaseAccount);
            IMSSetup.Get();
            if (PurchaseAccount > IMSSetup."Purchase Prepayment From") and (PurchaseAccount < IMSSetup."Purchase Prepayment To") then begin
                GLEntry.Reset();
                GLEntry.SetRange("G/L Account No.", IMSSetup."Purchase Prepayment From", IMSSetup."Purchase Prepayment To");
                GLEntry.SetRange("Global Dimension 1 Code", PurchaseLine."Shortcut Dimension 1 Code");
                GLEntry.SetRange("Prepayment Reversed", true);
                GLEntry.SetFilter(Amount, '>%1', 0);
                if GLEntry.FindFirst() then
                    Error('The container ID %1  Prepayment already reversed', PurchaseLine."Shortcut Dimension 1 Code")
            end;
        end;
    end;
    //change purchase description(fixed asset)
    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", 'OnAfterInsertEvent', '', true, true)]
    local procedure UpdateGLEntryDescriptionFromPostedLine(var Rec: Record "G/L Entry")
    var
        PurchInvLine: Record "Purch. Inv. Line";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";

    begin

        if Rec."Source Type" <> Rec."Source Type"::"Fixed Asset" then
            exit;

        PurchInvLine.SetRange("Document No.", Rec."Document No.");
        PurchInvLine.SetRange(Type, PurchInvLine.Type::"Fixed Asset");
        PurchInvLine.SetRange("No.", Rec."Source No.");

        if PurchInvLine.FindFirst() then begin
            Rec.Description := PurchInvLine.Description;
            Rec.Modify();
            exit;
        end;

        PurchCrMemoLine.SetRange("Document No.", Rec."Document No.");
        PurchCrMemoLine.SetRange(Type, PurchCrMemoLine.Type::"Fixed Asset");
        PurchCrMemoLine.SetRange("No.", Rec."Source No.");

        if PurchCrMemoLine.FindFirst() then begin
            Rec.Description := PurchCrMemoLine.Description;
            Rec.Modify();
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", 'OnAfterCopyGLEntryFromGenJnlLine', '', true, true)]
    local procedure OnAfterCopyGLEntryFromGenJnlLine(var GLEntry: Record "G/L Entry"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GLEntry."Prepayment Reversed" := GenJournalLine."Prepayment Reversed";
        GLEntry."IMS Document Type" := GenJournalLine."IMS Document Type";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', true, true)]
    local procedure OnAfterCopyCustLedgerEntryFromGenJnlLine(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgerEntry."IMS Document Type" := GenJournalLine."IMS Document Type";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Invoice Subform", 'OnAfterValidateShortcutDimCode', '', true, true)]
    local procedure OnAfterValidateShortcutDimCode(var SalesLine: Record "Sales Line"; var ShortcutDimCode: array[8] of Code[20]; DimIndex: Integer)
    begin
        SalesLine.validate("Shortcut Dimension 3 Code", ShortcutDimCode[3]);
        SalesLine.validate("Shortcut Dimension 4 Code", ShortcutDimCode[4]);
        SalesLine.Validate("Shortcut Dimension 5 Code", ShortcutDimCode[5]);
        SalesLine.validate("Shortcut Dimension 6 Code", ShortcutDimCode[6]);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterSelltoCustomerNoOnAfterValidate', '', true, true)]
    local procedure OnAfterSelltoCustomerNoOnAfterValidate(var SalesHeader: Record "Sales Header"; var xSalesHeader: Record "Sales Header")
    var
        Cust: Record customer;
    begin

        Cust.reset;
        Cust.SetRange("No.", SalesHeader."Sell-to Customer No.");
        Cust.SetFilter("Salesperson Code", '<>%1', '');
        if not Cust.FindFirst() then
            Error('Customer must have Sales Person code on Customer Card. Please check');

        Cust.reset;
        Cust.SetRange("No.", SalesHeader."Sell-to Customer No.");
        Cust.SetFilter("VAT Registration No.", '<>%1', '');
        if not Cust.FindFirst() then
            Error('Customer must have KRA PIN on Customer Card. Please check');

        // Cust.reset;
        // Cust.SetRange("No.", SalesHeader."Sell-to Customer No.");
        // if Cust.FindFirst() then begin
        //     Cust.CalcFields("Balance (LCY)");
        //     if cust."Balance (LCY)" > cust."Credit Limit (LCY)" then
        //         Error('Customer Exceeded Credit limit. Please contact Audit');
        // end;

        // if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then
        //     SalesHeader."Proforma No." := SalesHeader."No.";//commented on 02-19-2026
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnCodeOnBeforeSetStatusReleased, '', false, false)]
    local procedure "Release Sales Document_OnCodeOnBeforeSetStatusReleased"(var SalesHeader: Record "Sales Header")
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then
            SalesHeader."Proforma No." := SalesHeader."No.";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeIsApprovedForPosting', '', false, false)]
    local procedure OnBeforeIsApprovedForPosting(var SalesHeader: Record "Sales Header"; var Approved: Boolean; var IsHandled: Boolean);
    begin
        If SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" then begin
            if SalesHeader."Credit Note Reason Type" = SalesHeader."Credit Note Reason Type"::" " then
                Error('Please select the credit note Reason Type');
        end;
    end;


    /****ChargeGroup ***********/
    [IntegrationEvent(false, false)]
    PROCEDURE OnSendChargeGroupforApproval(VAR ChargeGroupHeader: Record "Charge ID Group Header");
    begin
    end;

    [IntegrationEvent(false, false)]
    PROCEDURE OnSendChargeGroupforCancel(VAR ChargeGroupHeader: Record "Charge ID Group Header");
    begin
    end;

    procedure IsChargeGroupEnabled(var Invitation: Record "Charge ID Group Header"): Boolean
    var
        WFMngt: Codeunit "Workflow Management";
        WFCode: Codeunit ChargeGroupWorkflow;
    begin
        exit(WFMngt.CanExecuteWorkflow(Invitation, WFCode.RunWorkflowOnSendChargeGroupHeaderApprovalCode()));

    end;

    local procedure CheckChargeGroupWorkflowEnabled(): Boolean
    var
        Invitation: Record "Charge ID Group Header";
        NoWorkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type', ENG = 'No workflow Enabled for this Record type';
    begin
        if not IsChargeGroupEnabled(Invitation) then
            Error(NoWorkflowEnb);
    end;
    /****ChargeGroup end************/

    /****ChargeIDAssignment ***********/
    [IntegrationEvent(false, false)]
    PROCEDURE OnSendChargeAssignmentforApproval(VAR ChargeAssignment: Record "Charge ID Assignment");
    begin
    end;

    [IntegrationEvent(false, false)]
    PROCEDURE OnSendChargeAssignmentforCancel(VAR ChargeAssignment: Record "Charge ID Assignment");
    begin
    end;

    procedure IsChargeAssignmentEnabled(var ChargeAssignemnt: Record "Charge ID Assignment"): Boolean
    var
        WFMngt: Codeunit "Workflow Management";
        WFCode: Codeunit ChargeIDAssignmentWorkflow;
    begin
        exit(WFMngt.CanExecuteWorkflow(ChargeAssignemnt, WFCode.RunWorkflowOnSendChargeAssignmentApprovalCode()));

    end;

    local procedure CheckChargeAssignmentWorkflowEnabled(): Boolean
    var
        ChargeAssignemnt: Record "Charge ID Assignment";
        NoWorkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type', ENG = 'No workflow Enabled for this Record type';
    begin
        if not IsChargeAssignmentEnabled(ChargeAssignemnt) then
            Error(NoWorkflowEnb);
    end;
    /****ChargeIDAssignment end************/
    procedure GetConsigneeInfo(consigneeno: Code[20]) ReturnValue: Text;
    Var
        Customer: Record Customer;
        VJsonObjectCust: JsonObject;
        VJsonArray: JsonArray;
        VJsonArrayCust: JsonArray;
    begin
        Customer.reset();
        Customer.SetRange("No.", consigneeno);
        Customer.FindFirst();
        VJsonObjectCust.Add('Name', '');
        VJsonObjectCust.Add('Email', '');
        VJsonObjectCust.Add('Address', '');
        repeat
            VJsonObjectCust.Replace('Name', Customer.Name);
            VJsonObjectCust.Replace('Email', Customer."E-Mail");
            VJsonObjectCust.Replace('Address', Customer.Address);
            VJsonArrayCust.add(VJsonObjectCust.Clone());
        until Customer.Next() = 0;
        VJsonArray.Add(VJsonArrayCust);
        VJsonArray.WriteTo(ReturnValue);
    end;

    procedure GetClearingAgentInfo(clearingAgentCode: Code[20]) ReturnValue: Text;
    Var
        ClearingAgent: Record "Clearing Agent";
        VJsonObjectAgent: JsonObject;
        VJsonArray1: JsonArray;
        VJsonArrayAgent: JsonArray;
    begin
        ClearingAgent.reset();
        ClearingAgent.SetRange("Clearing Agent Code", clearingAgentCode);
        ClearingAgent.FindFirst();
        VJsonObjectAgent.Add('Name', '');
        VJsonObjectAgent.Add('Email', '');
        VJsonObjectAgent.Add('Contact-Person Email', '');
        VJsonObjectAgent.Add('Address', '');
        repeat
            VJsonObjectAgent.Replace('Name', ClearingAgent."Clearing Agent Name");
            VJsonObjectAgent.Replace('Email', ClearingAgent."E-mail");
            VJsonObjectAgent.Replace('Contact-Person Email', ClearingAgent."Contact-Person Email");
            VJsonObjectAgent.Replace('Address', ClearingAgent.Address);
            VJsonArrayAgent.add(VJsonObjectAgent.Clone());
        until ClearingAgent.Next() = 0;
        VJsonArray1.Add(VJsonArrayAgent);
        VJsonArray1.WriteTo(ReturnValue);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
    local procedure OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef);
    var
        ChargGroup: Record "Charge ID Group Header";
    //PettyCash: Record "Petty Cash Expenses Detail";
    begin
        case DocumentAttachment."Table ID" of
            DATABASE::"Charge ID Group Header":
                begin
                    RecRef.Open(DATABASE::"Charge ID Group Header");
                    if ChargGroup.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(ChargGroup);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
    local procedure OnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef);
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of
            DATABASE::"Charge ID Group Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of
            DATABASE::"Charge ID Group Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
        end;
    end;
}
