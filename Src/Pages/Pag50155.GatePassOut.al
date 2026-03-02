page 50155 "Gate Pass Out Card"
{
    Caption = 'Gate Pass Outs';
    pageType = Document;
    SourceTable = "Gate Pass Out";
    AboutTitle = 'About Gate Pass out details';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Gate Pass No."; Rec."Gate Pass No.")
                {
                    ToolTip = 'Specifies the value of the Gate Pass No. field.';
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                    begin
                        if rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Activity Date"; rec."Activity Date")
                {
                    ToolTip = 'Specifies the value of the Gate Pass Out Date/Activity Date field.';
                    ApplicationArea = All;
                }
                field("Activity Time"; rec."Activity Time")
                {
                    ToolTip = 'Specifies the value of the Gate Pass Out Time field.';
                    ApplicationArea = All;
                }
                field("BL No."; Rec."BL No.")
                {
                    ToolTip = 'Specifies the value of the BL No. field.';
                    ApplicationArea = All;

                }
                field("Job File No."; Rec."Job File No.")
                {
                    ToolTip = 'Specifies the value of the Job File No. field.';
                    ApplicationArea = All;
                }
                field("Clearing Agent"; Rec."Clearing Agent")
                {
                    ToolTip = 'Specifies the value of the Clearing Agent field.';
                    ApplicationArea = All;
                }
                field("Clearing Agent Name"; Rec."Clearing Agent Name")
                {
                    ToolTip = 'Specifies the value of the Clearing Agent field.';
                    ApplicationArea = All;
                }

                field("Consignee No."; Rec."Consignee No.")
                {
                    ToolTip = 'Specifies the value of the Consignee No. field.';
                    ApplicationArea = All;
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                    ToolTip = 'Specifies the value of the Consignee Name. field.';
                    ApplicationArea = All;
                }
                field("Gate Pass Status"; Rec."Gate Pass Status")
                {
                    ApplicationArea = all;
                }
                field(Approved; Rec.Approved)
                {
                    ApplicationArea = all;
                }


            }
            part(GatePassLines; "Gate Pass Out Subform")
            {
                ApplicationArea = all;
                SubPageLink = "Gate Pass No." = field("Gate Pass No.");
                //UpdatePropagation = Both;
            }
        }
        area(factboxes)
        {
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }


    actions
    {
        area(Navigation)
        {
            action(GetLines)
            {
                ApplicationArea = All;
                Caption = 'Get Lines';
                Visible = false;
                trigger OnAction()
                begin
                    Rec.InsertGatePassLines();
                end;
            }
            action(VerifyReceipts)
            {
                ApplicationArea = All;
                Caption = 'Verify Receipts & Get Lines';
                Visible = PageEdit;

                trigger OnAction()
                var
                    InvoiceStatus: page InvoiceStatusList;
                begin
                    // InvoiceStatus.LookupMode(true);
                    // InvoiceStatus.GetGPNo(Rec."Gate Pass No.");
                    // if InvoiceStatus.RunModal() = ACTION::LookupOK then begin

                    // end;
                    Rec.CheckPayments();
                end;
            }
            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Visible = PageEdit;
                trigger OnAction()
                var
                    Usersetup: Record "User Setup";
                begin
                    if Rec.approved then
                        error('The document is aleady approved');
                    Usersetup.Get(UserId);
                    if not Usersetup."Gatepass Approval" then
                        error('You do not have permission')
                    else begin
                        Rec.Approved := true;
                        Rec."Approved By" := UserId;
                        Rec."Approved Date Time" := CurrentDateTime;
                        Rec.Modify();
                    end;
                end;
            }
            action("Print GatePass")
            {
                Caption = 'Print Gatepass';
                ApplicationArea = All;
                Visible = PageEdit;
                trigger OnAction()
                var
                    GatePass: Record "Gate Pass Out";
                    GatepassLine: Record "Gate Pass Out Line";
                    CustRec: Record customer;
                begin
                    GatepassLine.Reset();
                    GatePassLine.SetRange("Gate Pass No.", Rec."Gate Pass No.");
                    if GatepassLine.FindFirst() then
                        repeat
                            if GatepassLine."Custom Entry No." = '' then
                                Error('Custom Entry No. must have a value');
                            if GatepassLine."Shortcut Dimension 4 Code" = 'CONTAINER' then begin
                                if GatepassLine."Delivery Order No." = '' then
                                    Error('Delivery Order No. must have a value');
                                if GatepassLine."DO No. Expiry date" = 0D then
                                    Error('Delivery Order Expiry Date must have a value');
                                if GatepassLine."DO No. Expiry date" < today then
                                    Error('Delivery Order Expiry Date must not less than %1', today);
                            end;
                        until GatepassLine.Next() = 0;
                    GatepassLine.Reset();
                    GatePassLine.SetRange("Gate Pass No.", Rec."Gate Pass No.");
                    gatepassline.setrange("Payment Terms", 'COD');
                    GatepassLine.SetRange("Receipt No.", '');
                    IF GatepassLine.FindFirst() then begin
                        if not rec.Approved then
                            Error('Payment not been made')
                    end;

                    GatePass.Reset();
                    GatePass.SetRange("Gate Pass No.", Rec."Gate Pass No.");
                    IF GatePass.FindFirst() then begin
                        report.RunModal(report::"Gate Pass Test Report", true, true, GatePass);
                        Rec."Gate Pass Printed" := true;
                        rec.Modify();
                    end;

                end;
            }
            action("Print Loading Slip")
            {
                Caption = 'Print Loading Slip';
                ApplicationArea = All;
                Visible = PageEdit2;
                trigger OnAction()
                var
                    GatePass: Record "Gate Pass Out";
                    GatepassLine: Record "Gate Pass Out Line";
                    CustRec: Record customer;
                begin
                    GatePass.Reset();
                    GatePass.SetRange("Gate Pass No.", Rec."Gate Pass No.");
                    GatePass.SetRange("Gate Pass Printed", true);
                    IF GatePass.FindFirst() then begin
                        report.RunModal(report::"Loading Slip MICT", true, true, GatePass);
                    end;
                end;
            }
            action(Post)
            {
                ApplicationArea = All;
                Caption = 'Post';
                Visible = PageEdit;
                trigger OnAction()
                var
                    myInt: Integer;
                    GatepassLine: Record "Gate Pass Out Line";
                begin
                    GatepassLine.Reset();
                    GatePassLine.SetRange("Gate Pass No.", Rec."Gate Pass No.");
                    if GatepassLine.FindFirst() then
                        repeat
                            if GatepassLine."Custom Entry No." = '' then
                                Error('Custom Entry No. must have a value');
                            if GatepassLine."Shortcut Dimension 4 Code" = 'CONTAINER' then begin
                                if GatepassLine."Delivery Order No." = '' then
                                    Error('Delivery Order No. must have a value');
                                if GatepassLine."DO No. Expiry date" = 0D then
                                    Error('Delivery Order Expiry Date must have a value');
                                if GatepassLine."DO No. Expiry date" < today then
                                    Error('Delivery Order Expiry Date must not less than %1', today);
                            end;
                        until GatepassLine.Next() = 0;

                    Rec."Activity Time" := time;
                    if not rec."Gate Pass Printed" then
                        error('Please print the gatepass before posting..!');
                    IF Confirm('Do you want to Post the Gate Pass?', true) then
                        Rec.PendingGateOut()
                    else
                        exit;
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if Rec."Gate Pass Status" = Rec."Gate Pass Status"::InActive then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;

        if Rec."Gate Pass Status" = Rec."Gate Pass Status"::InActive then
            PageEdit := false
        else
            PageEdit := true;
        if (CompanyName <> 'MICT') or (Rec."Gate Pass Status" = Rec."Gate Pass Status"::InActive) then
            PageEdit2 := false
        else
            PageEdit2 := true;


    end;

    trigger OnModifyRecord(): Boolean
    var
        myInt: Integer;
    begin
        PageEditError();
    end;

    local procedure PageEditError()
    var

    begin
        if Rec."Gate Pass Status" = Rec."Gate Pass Status"::InActive then begin
            Error('Gate Pass Status is Inactive');
            PageEdit := false;
        end;
    end;

    var
        PageEdit2, PageEdit : Boolean;

}