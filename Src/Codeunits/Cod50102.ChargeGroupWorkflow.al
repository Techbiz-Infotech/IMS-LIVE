codeunit 50102 ChargeGroupWorkflow
{
    Permissions = TableData "Approval Entry" = ird;
    trigger OnRun()
    var
        lrec_AppEntry: Record "Approval Entry";
    begin

    end;

    var
        WFMngt: Codeunit "Workflow Management";
        AppMgmt: Codeunit "Approvals Mgmt.";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        SendChargeGroupHeaderReq: TextConst ENU = 'Approval Request for Charge Group is requested', ENG = 'Approval Request for Charge Group is requested';
        AppReqChargeGroupHeader: TextConst ENU = 'Approval Request for Charge Group is approved', ENG = 'Approval Request for Charge Group is approved';
        RejReqChargeGroupHeader: TextConst ENU = 'Approval Request for Charge Group is rejected', ENG = 'Approval Request for Charge Group is rejected';
        DelReqChargeGroupHeader: TextConst ENU = 'Approval Request for ChargeGroup is delegated', ENG = 'Approval Request for Charge Group is delegated';
        CanReqChargeGroupHeader: TextConst ENU = 'Approval Request for Charge Group is cancelled', ENG = 'Approval Request for Charge Group is cancelled';
        SendForPendAppTxt: TextConst ENU = 'Status of Charge Group changed to Pending approval', ENG = 'Status of Charge Group changed to Pending approval';
        ReleaseChargeGroupHeaderTxt: TextConst ENU = 'Release Charge Group', ENG = 'Release Charge Group';
        ReOpenChargeGroupHeaderTxt: TextConst ENU = 'ReOpen Charge Group', ENG = 'ReOpen Charge Group';

    procedure RunWorkflowOnCancelChargeGroupHeaderApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelChargeGroupHeaderApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::Events, 'OnSendChargeGroupforCancel', '', false, false)]
    procedure RunWorkflowOnSendChargeGroupHeaderCancel(var ChargeGroupHeader: Record "Charge ID Group Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelChargeGroupHeaderApprovalCode(), ChargeGroupHeader);
    end;


    procedure RunWorkflowOnSendChargeGroupHeaderApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendChargeGroupHeaderApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::Events, 'OnSendChargeGroupforApproval', '', false, false)]
    procedure RunWorkflowOnSendChargeGroupHeaderApproval(var ChargeGroupHeader: Record "Charge ID Group Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendChargeGroupHeaderApprovalCode(), ChargeGroupHeader);
    end;

    procedure RunWorkflowOnApproveChargeGroupHeaderApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveChargeGroupHeaderApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveChargeGroupHeaderApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveChargeGroupHeaderApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnRejectChargeGroupHeaderApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectChargeGroupHeaderApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectChargeGroupHeaderApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectChargeGroupHeaderApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnDelegateChargeGroupHeaderApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateChargeGroupHeaderApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateChargeGroupHeaderApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateChargeGroupHeaderApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure SetStatusToPendingApprovalCodeChargeGroupHeader(): Code[128]
    begin
        exit(UpperCase('SetStatusToPendingApprovalChargeGroupHeader'));
    end;

    procedure SetStatusToPendingApprovalChargeGroupHeader(var Variant: Variant)
    var
        RecRef: RecordRef;
        ChargeGroupHeader: Record "Charge ID Group Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Charge ID Group Header":
                begin
                    RecRef.SetTable(ChargeGroupHeader);
                    ChargeGroupHeader.Validate(Status, ChargeGroupHeader.Status::"Pending Approval");
                    ChargeGroupHeader.Modify();
                    Variant := ChargeGroupHeader;
                end;
        end;
    end;

    procedure ReleaseChargeGroupHeaderCode(): Code[128]
    begin
        exit(UpperCase('ReleaseChargeGroupHeader'));
    end;

    procedure ReleaseChargeGroupHeader(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        ChargeGroupHeader: Record "Charge ID Group Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReleaseChargeGroupHeader(Variant);
                end;
            DATABASE::"Charge ID Group Header":
                begin
                    RecRef.SetTable(ChargeGroupHeader);
                    ChargeGroupHeader.Validate(Status, ChargeGroupHeader.Status::Released);
                    ChargeGroupHeader.Modify();
                    Variant := ChargeGroupHeader;
                end;
        end;
    end;

    procedure ReOpenChargeGroupHeaderCode(): Code[128]
    begin
        exit(UpperCase('ReOpenChargeGroupHeader'));
    end;

    procedure ReOpenChargeGroupHeader(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        ChargeGroupHeader: Record "Charge ID Group Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpenChargeGroupHeader(Variant);
                end;
            DATABASE::"Charge ID Group Header":
                begin
                    RecRef.SetTable(ChargeGroupHeader);
                    ChargeGroupHeader.Validate(Status, ChargeGroupHeader.Status::Open);
                    ChargeGroupHeader.Modify();
                    Variant := ChargeGroupHeader;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure AddChargeGroupHeaderEventToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendChargeGroupHeaderApprovalCode(), Database::"Charge ID Group Header", SendChargeGroupHeaderReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveChargeGroupHeaderApprovalCode(), Database::"Approval Entry", AppReqChargeGroupHeader, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectChargeGroupHeaderApprovalCode(), Database::"Approval Entry", RejReqChargeGroupHeader, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateChargeGroupHeaderApprovalCode(), Database::"Approval Entry", DelReqChargeGroupHeader, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelChargeGroupHeaderApprovalCode(), Database::"Charge ID Group Header", CanReqChargeGroupHeader, 0, false);

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    procedure AddChargeGroupHeaderRespToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCodeChargeGroupHeader(), 0, SendForPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReleaseChargeGroupHeaderCode(), 0, ReleaseChargeGroupHeaderTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpenChargeGroupHeaderCode(), 0, ReOpenChargeGroupHeaderTxt, 'GROUP 0');

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForChargeGroupHeader(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            case WorkflowResponse."Function Name" of
                SetStatusToPendingApprovalCodeChargeGroupHeader():
                    begin
                        SetStatusToPendingApprovalChargeGroupHeader(Variant);
                        ResponseExecuted := true;
                    end;
                ReleaseChargeGroupHeaderCode():
                    begin
                        ReleaseChargeGroupHeader(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpenChargeGroupHeaderCode():
                    begin
                        ReOpenChargeGroupHeader(Variant);
                        ResponseExecuted := true;
                    end;
            end;
    end;
}