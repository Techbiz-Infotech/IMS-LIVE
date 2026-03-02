page 50200 InvoiceStatusList
{
    //ApplicationArea = All;
    Caption = 'Invoice Status';
    PageType = List;
    SourceTable = "Cust. Ledger Entry";
    //UsageCategory = Documents;
    Editable = false;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remaining Amount field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //  CurrPage.SetTableView(TempCustLedgEntry);
        CheckPayments();
        //Message(GPNo);

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        TempCLE: Record "Cust. Ledger Entry" temporary;
    begin
        if CloseAction in [action::OK, action::LookupOK] then begin
            if Rec.FINDSET then
                repeat
                    TempCLE := Rec;
                    TempCLE.INSERT;
                    TempCLE.Modify();

                until Rec.NEXT = 0;

            TempCLE.Reset();
            TempCLE.CalcFields("Remaining Amount");
            TempCLE.SetFilter("Remaining Amount", '<>%1', 0);
            if TempCLE.FindFirst() then begin
                if GatePass.Get(GPNo) then;
                if GatePass.Approved then
                    InsertGatePassLines()
                else
                    error('You have unpaid invoices. Please check and try again')
            end else
                InsertGatePassLines();
        end;
    end;

    procedure GetGPNo(var NewGPNo: Code[20])
    begin
        GPNo := NewGPNo;
    end;

    procedure CheckPayments()
    var

    begin
        If GatePass.get(GPNo) then;
        SalesInvLine.Reset();
        SalesInvLine.SetRange("BL No.", GatePass."BL No.");
        SalesInvLine.CalcFields(Cancelled);
        SalesInvLine.SetRange(Cancelled, false);
        if SalesInvLine.FindSet() then begin
            repeat
                EntryNo := 0;
                IF PrevDocNo <> SalesInvLine."Document No." then begin
                    RecCustLedgEntry.Reset();
                    RecCustLedgEntry.SetRange("Document No.", SalesInvLine."Document No.");
                    if RecCustLedgEntry.FindFirst() then begin
                        repeat
                            Rec.Init();
                            Rec."Entry No." := RecCustLedgEntry."Entry No.";
                            Rec."Document Type" := RecCustLedgEntry."Document Type";
                            Rec."Document Date" := RecCustLedgEntry."Document Date";
                            Rec."Document No." := RecCustLedgEntry."Document No.";
                            Rec."Posting Date" := RecCustLedgEntry."Posting Date";
                            Rec.Amount := RecCustLedgEntry.Amount;
                            Rec."Customer No." := RecCustLedgEntry."Customer No.";
                            Rec."Customer Name" := RecCustLedgEntry."Customer Name";
                            Rec."Remaining Amount" := RecCustLedgEntry."Remaining Amount";
                            Rec."Currency Code" := RecCustLedgEntry."Currency Code";
                            Rec.Insert();
                        until RecCustLedgEntry.Next() = 0;
                    end;
                    PrevDocNo := SalesInvLine."Document No.";
                end;
            until SalesInvLine.Next() = 0;
        end else
            Message('Invoice does not found');

    End;

    procedure InsertGatePassLines()
    var
        SalesInvHead: Record "Sales Invoice Header";
        LSalesInvLine, GSalesInvLine, SalesInvLine : Record "Sales Invoice Line";
        ContainerInvLine: Record "Sales Invoice Line";
        ContainerRec: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        GPHead: Record "Gate Pass Out";
        GPLine, GatePassLine : Record "Gate Pass Out Line";
        PostedGateOutHead: Record "Posted Gate Pass Out";
        PostedGateOutLine: Record "Posted Gate Pass out Line";
        PaymentTerms, PaymentMethod : Code[20];
        Cust: Record Customer;
        BaseOn: Enum "Base On Enum";
        ChargeGroupHead: Record "Charge ID Group Header";
        ChargeGroupLine: Record "Charge ID Group Line";
        BilledStorageDays, RemainingDays, CurrentStorageDays, FreeDays, LineNo : Integer;
        InvoiceCount: Integer;
        //ManifestHead: Record "Manifest Header";
        GManifestLine, TestManifestLine : Record "Manifest Line";
        ClosedCont: Integer;
        GPCancelled: Boolean;
        CancelGatePass: Record "Cancel Gatepass";

        StorageStartDate: Date;
        PrevDocNo, PrevContainerNo : Code[20];
    begin
        GPHead.Reset();
        GPHead.SetRange("Gate Pass No.", GPNo);
        if GPHead.FindFirst() then begin
            LineNo := 0;
            InvoiceCount := 0;
            ClosedCont := 0;
            GPLine.Reset();
            GPLine.SetRange("Gate Pass No.", GPHead."Gate Pass No.");
            IF GPLine.FindSet() then begin
                IF Confirm('Do you want to delete the existing lines?', true) then
                    GPLine.DeleteAll()
                else
                    exit;
            end;

            SalesInvLine.Reset();
            SalesInvLine.SetCurrentKey("Shortcut Dimension 1 Code");
            SalesInvLine.SetAscending("Shortcut Dimension 1 Code", true);
            SalesInvLine.SetRange("BL No.", GPHead."BL No.");
            SalesInvLine.CalcFields(Cancelled);
            SalesInvLine.SetRange(Cancelled, false);
            if SalesInvLine.FindSet() then begin
                repeat
                    // SalesInvHead.Reset();
                    // SalesInvHead.SetRange("No.", SalesInvLine."Document No.");
                    // if SalesInvHead.FindFirst() then begin
                    //     SalesInvHead.CalcFields(Cancelled);
                    //     if SalesInvHead.Cancelled then
                    //         error('cancelled invoice');
                    // end;

                    IF PrevContainerNo <> SalesInvLine."Shortcut Dimension 1 Code" then begin
                        PrevContainerNo := SalesInvLine."Shortcut Dimension 1 Code";
                        GPCancelled := false;
                        PostedGateOutLine.Reset();
                        PostedGateOutLine.SetRange("BL No.", GPHead."BL No.");
                        PostedGateOutLine.SetRange("Invoice No.", SalesInvLine."Document No.");
                        PostedGateOutLine.SetRange("Global Dimension 1 Code", SalesInvLine."Shortcut Dimension 1 Code");
                        PostedGateOutLine.SetRange("Gate Pass Status", PostedGateOutLine."Gate Pass Status"::Active);
                        IF PostedGateOutLine.FindFirst() then begin
                            CancelGatePass.Reset();
                            CancelGatePass.SetRange("BL No.", GPHead."BL No.");
                            CancelGatePass.SetRange("Global Dimension 1 Code", SalesInvLine."Shortcut Dimension 1 Code");
                            if CancelGatePass.FindFirst() then
                                GPCancelled := true
                            else
                                GPCancelled := false;
                        end else
                            GPCancelled := true;
                        if GPCancelled then begin
                            SalesInvHead.Reset();
                            SalesInvHead.SetRange("No.", SalesInvLine."Document No.");
                            IF SalesInvHead.FindFirst() then begin
                                PaymentMethod := SalesInvHead."Payment Method Code";
                                PaymentTerms := SalesInvHead."Payment Terms Code";
                                SalesInvHead.CalcFields(Closed);
                                if not GPHead.Approved then begin
                                    if SalesInvHead.Closed <> true then
                                        Error('Invoice %1 is not paid. Please check and try again', SalesInvHead."No.");
                                end;
                            end else begin
                                PaymentMethod := '';
                                PaymentTerms := '';
                            end;
                            GLSetup.get();
                            ContainerRec.Reset();
                            ContainerRec.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
                            ContainerRec.SetRange(ContainerRec.Code, SalesInvLine."Shortcut Dimension 1 Code");
                            ContainerRec.SetRange("Container Status", ContainerRec."Container Status"::"In Stock");
                            if ContainerRec.FindFirst() then begin

                                //new code for extra
                                LSalesInvLine.Reset();
                                LSalesInvLine.SetRange("BL No.", GPHead."BL No.");
                                if LSalesInvLine.FindLast() then
                                    If LSalesInvLine."Posting Date" <> Today then begin

                                        GSalesInvLine.Reset();
                                        GSalesInvLine.SetCurrentKey("Document No.");
                                        GSalesInvLine.SetRange("Shortcut Dimension 1 Code", PrevContainerNo);
                                        GSalesInvLine.SetFilter("Chargable Storage Days", '<>%1', 0);
                                        if GSalesInvLine.FindFirst() then begin
                                            repeat
                                                //FreeDays := GSalesInvLine."Free Days";
                                                //BilledStorageDays := GSalesInvLine."Chargable Storage Days";
                                                if PrevDocNo <> GSalesInvLine."Document No." then begin
                                                    BilledStorageDays := GSalesInvLine."Storage Days" - GSalesInvLine."Free Days" + BilledStorageDays;
                                                end;
                                                PrevDocNo := GSalesInvLine."Document No.";
                                            until GSalesInvLine.Next() = 0;
                                        end;
                                        GSalesInvLine.Reset();
                                        GSalesInvLine.SetRange("Shortcut Dimension 1 Code", PrevContainerNo);
                                        if GSalesInvLine.FindFirst() then begin
                                            if ChargeGroupHead.Get(GSalesInvLine."Charge ID") then begin
                                                BaseOn := ChargeGroupHead."Base On";
                                                ChargeGroupLine.Reset();
                                                ChargeGroupLine.SetRange("Charge ID Group Code", ChargeGroupHead."Charge ID Group Code");
                                                ChargeGroupLine.Setfilter("Free Days", '<>%1', 0);
                                                if ChargeGroupLine.FindFirst() then
                                                    FreeDays := ChargeGroupLine."Free Days"
                                                else
                                                    FreeDays := 0;
                                            end;

                                            // ManifestHead.Reset();
                                            // ManifestHead.SetRange("Job File No.", GSalesInvLine."Job File No.");
                                            // IF ManifestHead.FindFirst() then begin
                                                if BaseOn = BaseOn::"Received Date" then begin
                                                    TestManifestLine.Reset();
                                                    TestManifestLine.SetRange("Global Dimension 1 Code", GSalesInvLine."Shortcut Dimension 1 Code");
                                                    IF TestManifestLine.FindFirst() then begin
                                                        StorageStartDate := TestManifestLine."Date Received"
                                                    end;
                                                end;
                                                IF BaseOn = BaseOn::"ETA Date" then
                                                    StorageStartDate := TestManifestLine."Expected Arrival Date";
                                                IF BaseOn = BaseOn::"Last Sling Date" then
                                                    StorageStartDate := TestManifestLine."Last Sling Date";
                                                IF BaseOn = BaseOn::ActualDate then
                                                    StorageStartDate := TestManifestLine."Vessel Arrival Date";
                                            //end;
                                            // IF StorageStartDate <> 0D then begin
                                            //     IF ChargeGroupHead."Start After" > 1 then
                                            //         AfterBaseOnDate := CalcDate(FORMAT(ChargeGroupHead."Start After") + 'D', StorageStartDate)
                                            //     else
                                            //         AfterBaseOnDate := StorageStartDate;
                                            // end;
                                            if StorageStartDate <> 0D then
                                                CurrentStorageDays := Today - StorageStartDate;
                                        end;

                                        if CurrentStorageDays > FreeDays then begin
                                            RemainingDays := CurrentStorageDays - FreeDays - BilledStorageDays;
                                            // if not Approved then
                                            error('Extra storage days to be billed: Please Contact Audit \ Total Storage Days %1,\ Free Days %2,\ Billed Storage Days %3,\ Remaining Days to be billed %4', CurrentStorageDays, FreeDays, BilledStorageDays, RemainingDays);
                                        end;
                                        //      else
                                        //        exit;
                                    end;
                                //new code for extra storage

                                //for additional verification charges
                                CheckVerificationCharges(SalesInvLine."Shortcut Dimension 1 Code");
                                //for additional verification charges
                                //for additional storage
                                CheckAdditionalCharges(SalesInvLine."Shortcut Dimension 1 Code");
                                //for additional storage
                                GatePassLine.Reset();
                                GatePassLine.SetRange(GatePassLine."Gate Pass No.", GPHead."Gate Pass No.");
                                IF GatePassLine.FindLast() then
                                    LineNo := GatePassLine."Line No." + 10000;
                                GatePassLine.Init();
                                GatePassLine."Gate Pass No." := GPHead."Gate Pass No.";
                                GatePassLine."Line No." := LineNo;
                                GatePassLine.Insert();
                                GatePassLine."Invoice No." := SalesInvLine."Document No.";
                                GatePassLine."Global Dimension 1 Code" := SalesInvLine."Shortcut Dimension 1 Code";
                                //
                                GManifestLine.Reset();
                                GManifestLine.SetRange("Global Dimension 1 Code", SalesInvLine."Shortcut Dimension 1 Code");
                                GManifestLine.SetRange("BL No.", SalesInvLine."BL No.");
                                if GManifestLine.FindFirst() then begin
                                    GatePassLine."Global Dimension 2 Code" := GManifestLine."Global Dimension 2 Code";
                                    GatePassLine."Shortcut Dimension 3 Code" := GManifestLine."Shortcut Dimension 3 Code";
                                    GatePassLine."Shortcut Dimension 4 Code" := GManifestLine."Shortcut Dimension 4 Code";
                                    GatePassLine."Shortcut Dimension 5 Code" := GManifestLine."Shortcut Dimension 5 Code";
                                    GatePassLine."Shortcut Dimension 6 Code" := GManifestLine."Shortcut Dimension 6 Code";
                                    GatePassLine."Job File No" := GManifestLine."Job File No.";
                                    GatePassLine."Container /Chasis No." := GManifestLine."Container/Chassis No.";
                                end;

                                GatePassLine."Position ID" := SalesInvLine."Position ID";
                                // GatePassLine."Global Dimension 2 Code" := SalesInvLine."Shortcut Dimension 2 Code";
                                // GatePassLine."Shortcut Dimension 3 Code" := SalesInvLine."Shortcut Dimension 3 Code";
                                // GatePassLine."Shortcut Dimension 4 Code" := SalesInvLine."Shortcut Dimension 4 Code";
                                // GatePassLine."Shortcut Dimension 5 Code" := SalesInvLine."Shortcut Dimension 5 Code";
                                // GatePassLine."Shortcut Dimension 6 Code" := SalesInvLine."Shortcut Dimension 6 Code";
                                // GatePassLine."Job File No" := SalesInvLine."Job File No.";
                                GatePassLine."Position ID" := SalesInvLine."Position ID";
                                //GatePassLine."Container /Chasis No." := SalesInvLine."Container No./Chassis No.";
                                GatePassLine."BL No" := SalesInvLine."BL No.";
                                GatePassLine."Invoice Date" := SalesInvLine."Posting Date";
                                GatePassLine."Consignee No." := SalesInvLine."Sell-to Customer No.";
                                GatePassLine."Gen. Bus. Posting Group" := SalesInvLine."Gen. Bus. Posting Group";
                                GatePassLine."Gen. Prod. Posting Group" := SalesInvLine."Gen. Prod. Posting Group";
                                GatePassLine."Payment Method" := PaymentMethod;
                                GatePassLine."Payment Terms" := PaymentTerms;
                                GatePassLine."Activity Date" := GPHead."Activity Date";
                                GatePassLine."Activity Time" := GPHead."Activity Time";
                                if Cust.get(SalesInvLine."Sell-to Customer No.") then
                                    GatePassLine."Consignee Name" := Cust.Name;
                                GatePassLine.modify;
                                InvoiceCount := InvoiceCount + 1;
                            end else
                                PrevContainerNo := SalesInvLine."Shortcut Dimension 1 Code";
                        end;
                    end;
                until SalesInvLine.Next() = 0;
                GetReceiptNo();
            end else
                Message('Invoice does not found');
        end;
    end;

    procedure GetReceiptNo()
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        ApplyCustLedgEntry: Record "Cust. Ledger Entry";
        GatePassLineRec: Record "Gate Pass Out Line";
    begin
        GatePassLineRec.Reset();
        GatePassLineRec.SetRange("Gate Pass No.", GPNo);
        if GatePassLineRec.FindSet() then begin
            repeat
                CustLedgEntry.Reset();
                CustLedgEntry.SetRange("Document No.", GatePassLineRec."Invoice No.");
                CustLedgEntry.SetRange(Open, false);
                IF CustLedgEntry.FindFirst() then begin
                    ApplyCustLedgEntry.Reset();
                    ApplyCustLedgEntry.SetRange("Entry No.", CustLedgEntry."Closed by Entry No.");
                    if ApplyCustLedgEntry.FindFirst() then begin
                        GatePassLineRec."Receipt No." := ApplyCustLedgEntry."Document No.";
                        GatePassLineRec.Modify();
                    end;
                end else begin
                    Message('receipt not found');
                    exit;
                end;
            //exit;
            until GatePassLineRec.next = 0;
        end;
    end;

    procedure CheckVerificationCharges(l_ContID: code[20])
    var
        VerificationLog: Record VerificationLog;
    begin
        VerificationLog.Reset();
        VerificationLog.SetRange("Global Dimension 1 Code", l_ContID);
        VerificationLog.SetRange(Invoiced, false);
        if VerificationLog.FindFirst() then begin
            if VerificationLog."Verification Type" <> VerificationLog."Verification Type"::Sighting then
                Error('Unbilled verification Charges found. Please check and try again');
        end;
    end;

    procedure CheckAdditionalCharges(l_ContID: code[20])
    var
        SalesInvHead: Record "Sales Invoice Header";
        LSalesInvLine, GSalesInvLine, SalesInvLine : Record "Sales Invoice Line";
        ContainerInvLine: Record "Sales Invoice Line";
        ContainerRec: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        Cust: Record Customer;
        AddCharge: Record "Additional Charges - Receiving";
        InvoiceCount: Integer;
       // ManifestHead: Record "Manifest Header";
        GManifestLine, TestManifestLine : Record "Manifest Line";
        ClosedCont: Integer;
        PrevDocNo, PrevContainerNo : Code[20];
    begin

        InvoiceCount := 0;
        ClosedCont := 0;
        AddCharge.Reset();
        AddCharge.SetRange(AddCharge."Container ID", l_ContID);
        AddCharge.SetFilter("Charges Code", '<>%1', '');
        if AddCharge.FindFirst() then begin
            repeat
                SalesInvLine.Reset();
                SalesInvLine.SetCurrentKey("Shortcut Dimension 1 Code");
                SalesInvLine.SetAscending("Shortcut Dimension 1 Code", true);
                SalesInvLine.SetRange("Shortcut Dimension 1 Code", AddCharge."Container ID");
                SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
                SalesInvLine.SetRange("No.", AddCharge."Charges Code");
                SalesInvLine.CalcFields(Cancelled);
                SalesInvLine.SetRange(Cancelled, false);
                if not SalesInvLine.FindFirst() then
                    Error('Additional charges not billed for the Container ID %1. Please check and try again', AddCharge."Container ID");
            until AddCharge.Next() = 0;
        end;
    end;

    var
        GPNo: code[20];
        GatePass: Record "Gate Pass Out";
        SalesInvLine: Record "Sales Invoice Line";
        EntryNo, LineNo : Integer;
        TempCustLedgEntry: Record "Cust. Ledger Entry" temporary;
        RecCustLedgEntry: Record "Cust. Ledger Entry";
        PageInvoiceStatus: Page InvoiceStatusList;
        PrevDocNo, PrevContainerNo : Code[20];
}
