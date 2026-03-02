page 50149 "Charge ID Group"
{
    Caption = 'Charge ID Group';
    PageType = Document;
    SourceTable = "Charge ID Group Header";
    DeleteAllowed = true;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Charge ID Group Code"; Rec."Charge ID Group Code")
                {
                    ToolTip = 'Specifies the value of the Charge Group Code field.';
                    ApplicationArea = All;
                }
                field("Charge Description"; rec."Charge Description")
                {
                    ToolTip = 'Specifies the value of the Charge Description field.';
                    ApplicationArea = All;
                }
                field("First Bracket"; Rec."First Bracket")
                {
                    ToolTip = 'Specifies the value of the First Bracket field.';
                    ApplicationArea = All;
                }
                field("Second Bracket"; Rec."Second Bracket")
                {
                    ToolTip = 'Specifies the value of the Second Bracket field.';
                    ApplicationArea = All;
                }
                field("Third Bracket"; Rec."Third Bracket")
                {
                    ToolTip = 'Specifies the value of the Third Bracket field.';
                    ApplicationArea = All;
                }
                field("Include Received Date"; Rec."Include Received Day")
                {
                    ToolTip = 'Specifies the value of the Include Received Day field.';
                    ApplicationArea = All;
                }

                field("Start After"; Rec."Start After")
                {
                    ToolTip = 'Specifies the value of the Start After field.';
                    ApplicationArea = All;
                }
                field("Base On"; Rec."Base On")
                {
                    ToolTip = 'Specifies the value of the Start After field.';
                    ApplicationArea = All;
                }
                field("User ID"; rec."User ID")
                {

                    ToolTip = 'Specifies the value of the Start After field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                }
                field("Charge Type"; rec."Charge Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Charge Type field.';
                }
                field("Total Standard Charges amount"; Rec."Total Standard Charges amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Standard Charges amount field.';
                }
                field("Free Days";Rec."Free Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Free Days field.';
                }
            }
            part(ChargeIDCreation; "Charge ID Group Subform")
            {
                Caption = ' Lines';
                ApplicationArea = all;
                SubPageLink = "Charge ID Group Code" = field("Charge ID Group Code");
                UpdatePropagation = Both;
            }

        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(50146),
                              "No." = FIELD("Charge ID Group Code");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Send Approval Request")
            {
                ApplicationArea = all;
                Caption = 'Send Approval Request';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = SendApprovalRequest;
                trigger OnAction()
                var
                    myInt: Integer;
                    Docattchrec: Record "Document Attachment";
                begin
                    if Rec."Charge Type" = Rec."Charge Type"::" " then
                        Error('Charge Type should not be empty');

                    Docattchrec.Reset();
                    Docattchrec.SetRange("Table ID", 50146);
                    Docattchrec.SetRange("No.", Rec."Charge ID Group Code");
                    if not Docattchrec.FindFirst() then
                        Error('Please attach the signed contract and try again');

                    EventsCU.OnSendChargeGroupforApproval(Rec);
                end;
            }
            // action("Cancel Approval Request")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Cancel Approval Request';
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     PromotedOnly = true;
            //     Image = CancelApprovalRequest;
            //     trigger OnAction()
            //     var
            //         myInt: Integer;
            //     begin
            //         EventsCU.OnSendChargeGroupforCancel(Rec);
            //     end;
            // }
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
                    Visible = true;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Release the document to the next stage of processing. You must reopen the document before you can make changes to it.';

                    trigger OnAction()
                    begin
                        if (UserId <> 'GROUP.AUDIT') and (UserId <> 'TECHBIZINFOTECH') then begin
                            Error('You are not Authorised. Please Contact Group Audit');
                        end else begin
                            Rec.Status := Rec.Status::Released;
                            Rec.Modify();
                        end;
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Re&open';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = ReOpen;
                    Promoted = true;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                    trigger OnAction()
                    begin
                        if rec.Status <> Rec.Status::"Pending Approval" then begin
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify();
                        end;
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        USerSetup: Record "User Setup";
    begin
        USerSetup.get(UserId);
        IF not USerSetup."Charge Groups" then
            Error('You are not authorized to view this section')
        else
            exit;
    end;

    var
        EventsCU: Codeunit Events;
}
