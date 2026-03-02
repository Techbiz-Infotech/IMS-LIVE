codeunit 50103 ChargeIDAssignmentWorkflow
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
        SendChargeAssignmentReq: TextConst ENU = 'Approval Request for Charge Assignment is requested', ENG = 'Approval Request for Charge Assignment is requested';
        AppReqChargeAssignment: TextConst ENU = 'Approval Request for Charge Assignment is approved', ENG = 'Approval Request for Charge Assignment is approved';
        RejReqChargeAssignment: TextConst ENU = 'Approval Request for Charge Assignment is rejected', ENG = 'Approval Request for Charge Assignment is rejected';
        DelReqChargeAssignment: TextConst ENU = 'Approval Request for Charge Assignment is delegated', ENG = 'Approval Request for Charge Assignment is delegated';
        CanReqChargeAssignment: TextConst ENU = 'Approval Request for Charge Assignment is cancelled', ENG = 'Approval Request for Charge Assignment is cancelled';
        SendForPendAppTxt: TextConst ENU = 'Status of Charge Assignment changed to Pending approval', ENG = 'Status of Charge Assignment changed to Pending approval';
        ReleaseChargeAssignmentTxt: TextConst ENU = 'Release Charge Assignment', ENG = 'Release Charge Assignment';
        ReOpenChargeAssignmentTxt: TextConst ENU = 'ReOpen Charge Assignment', ENG = 'ReOpen Charge Assignment';

    procedure RunWorkflowOnCancelChargeAssignmentApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelChargeAssignmentApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::Events, 'OnSendChargeAssignmentforCancel', '', false, false)]
    procedure RunWorkflowOnSendChargeAssignmentCancel(var ChargeAssignment: Record "Charge ID Assignment")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelChargeAssignmentApprovalCode(), ChargeAssignment);
    end;


    procedure RunWorkflowOnSendChargeAssignmentApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendChargeAssignmentApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::Events, 'OnSendChargeAssignmentforApproval', '', false, false)]
    procedure RunWorkflowOnSendChargeAssignmentApproval(var ChargeAssignment: Record "Charge ID Assignment")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendChargeAssignmentApprovalCode(), ChargeAssignment);
    end;

    procedure RunWorkflowOnApproveChargeAssignmentApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveChargeAssignmentApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveChargeAssignmentApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveChargeAssignmentApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnRejectChargeAssignmentApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectChargeAssignmentApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectChargeAssignmentApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectChargeAssignmentApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnDelegateChargeAssignmentApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateChargeAssignmentApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateChargeAssignmentApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateChargeAssignmentApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure SetStatusToPendingApprovalCodeChargeAssignment(): Code[128]
    begin
        exit(UpperCase('SetStatusToPendingApprovalChargeAssignment'));
    end;

    procedure SetStatusToPendingApprovalChargeAssignment(var Variant: Variant)
    var
        RecRef: RecordRef;
        ChargeAssignment: Record "Charge ID Assignment";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Charge ID Assignment":
                begin
                    RecRef.SetTable(ChargeAssignment);
                    ChargeAssignment.Validate("Assignment Status", ChargeAssignment."Assignment Status"::"Pending Approval");
                    ChargeAssignment.Modify();
                    Variant := ChargeAssignment;
                end;
        end;
    end;

    procedure ReleaseChargeAssignmentCode(): Code[128]
    begin
        exit(UpperCase('ReleaseChargeAssignment'));
    end;

    procedure ReleaseChargeAssignment(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        ChargeAssignment: Record "Charge ID Assignment";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReleaseChargeAssignment(Variant);
                end;
            DATABASE::"Charge ID Assignment":
                begin
                    RecRef.SetTable(ChargeAssignment);
                    ChargeAssignment.Validate("Assignment Status", ChargeAssignment."Assignment Status"::Released);
                    ChargeAssignment.Modify();
                    Variant := ChargeAssignment;
                end;
        end;
    end;

    procedure ReOpenChargeAssignmentCode(): Code[128]
    begin
        exit(UpperCase('ReOpenChargeAssignment'));
    end;

    procedure ReOpenChargeAssignment(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        ChargeAssignment: Record "Charge ID Assignment";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpenChargeAssignment(Variant);
                end;
            DATABASE::"Charge ID Assignment":
                begin
                    RecRef.SetTable(ChargeAssignment);
                    ChargeAssignment.Validate("Assignment Status", ChargeAssignment."Assignment Status"::Open);
                    ChargeAssignment.Modify();
                    Variant := ChargeAssignment;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure AddChargeAssignmentEventToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendChargeAssignmentApprovalCode(), Database::"Charge ID Assignment", SendChargeAssignmentReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveChargeAssignmentApprovalCode(), Database::"Approval Entry", AppReqChargeAssignment, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectChargeAssignmentApprovalCode(), Database::"Approval Entry", RejReqChargeAssignment, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateChargeAssignmentApprovalCode(), Database::"Approval Entry", DelReqChargeAssignment, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelChargeAssignmentApprovalCode(), Database::"Charge ID Assignment", CanReqChargeAssignment, 0, false);

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    procedure AddChargeAssignmentRespToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCodeChargeAssignment(), 0, SendForPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReleaseChargeAssignmentCode(), 0, ReleaseChargeAssignmentTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpenChargeAssignmentCode(), 0, ReOpenChargeAssignmentTxt, 'GROUP 0');

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForChargeAssignment(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            case WorkflowResponse."Function Name" of
                SetStatusToPendingApprovalCodeChargeAssignment():
                    begin
                        SetStatusToPendingApprovalChargeAssignment(Variant);
                        ResponseExecuted := true;
                    end;
                ReleaseChargeAssignmentCode():
                    begin
                        ReleaseChargeAssignment(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpenChargeAssignmentCode():
                    begin
                        ReOpenChargeAssignment(Variant);
                        ResponseExecuted := true;
                    end;
            end;
    end;
}