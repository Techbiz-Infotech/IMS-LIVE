page 50297 Approvalentry
{
    ApplicationArea = All;
    Caption = 'Approvalentry';
    PageType = List;
    SourceTable = "Approval Entry";
    UsageCategory = Lists;
    Permissions = tabledata "Approval Entry" = rimd;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ID of the table where the record that is subject to approval is stored.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of document that an approval entry has been created for. Approval entries can be created for six different types of sales or purchase documents:';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document number copied from the relevant sales or purchase document, such as a purchase order or a sales quote.';
                }
                field("Sequence No."; Rec."Sequence No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the order of approvers when an approval workflow involves more than one approver.';
                }
                field("Approval Code"; Rec."Approval Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approval Code field.';
                }
                field("Sender ID"; Rec."Sender ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ID of the user who sent the approval request for the document to be approved.';
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for the salesperson or purchaser that was in the document to be approved. It is not a mandatory field, but is useful if a salesperson or a purchaser responsible for the customer/vendor needs to approve the document before it is processed.';
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ID of the user who must approve the document.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the approval status for the entry:';
                }
                field("Date-Time Sent for Approval"; Rec."Date-Time Sent for Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date and the time that the document was sent for approval.';
                }
                field("Last Date-Time Modified"; Rec."Last Date-Time Modified")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the approval entry was last modified. If, for example, the document approval is canceled, this field will be updated accordingly.';
                }
                field("Last Modified By User ID"; Rec."Last Modified By User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ID of the user who last modified the approval entry. If, for example, the document approval is canceled, this field will be updated accordingly.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether there are comments relating to the approval of the record. If you want to read the comments, choose the field to open the Approval Comment Sheet window.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the record must be approved, by one or more approvers.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount (excl. VAT) on the document awaiting approval.';
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount (excl. VAT) on the document awaiting approval. The amount is stated in the local currency.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the currency of the amounts on the sales or purchase lines.';
                }
                field("Approval Type"; Rec."Approval Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies which approvers apply to this approval template:';
                }
                field("Limit Type"; Rec."Limit Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of limit that applies to the approval template:';
                }
                field("Available Credit Limit (LCY)"; Rec."Available Credit Limit (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the remaining credit (in LCY) that exists for the customer.';
                }
                field("Pending Approvals"; Rec."Pending Approvals")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pending Approvals field.';
                }
                field("Record ID to Approve"; Rec."Record ID to Approve")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Record ID to Approve field.';
                }
                field("Delegation Date Formula"; Rec."Delegation Date Formula")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Delegation Date Formula field.';
                }
                field("Number of Approved Requests"; Rec."Number of Approved Requests")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Number of Approved Requests field.';
                }
                field("Number of Rejected Requests"; Rec."Number of Rejected Requests")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Number of Rejected Requests field.';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Workflow Step Instance ID"; Rec."Workflow Step Instance ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Workflow Step Instance ID field.';
                }
                field("Related to Change"; Rec."Related to Change")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Related to Change field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {

                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        IF (UserId <> 'GROUP.AUDIT') and (UserId <> 'TECHBIZINFOTECH') then
            error('You are not Authorized to view this area. Please contact Group Audit');
    end;
}
