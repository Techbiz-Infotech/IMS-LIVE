page 50184 "Cancel Gatepass"
{
    Caption = 'Cancel Gatepass';
    PageType = Card;
    SourceTable = "Cancel Gatepass";
    SourceTableView = where(Posted = filter(false));
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Cancel Gatepass No."; Rec."Cancel Gatepass No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cancel Gatepass No. field.';
                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                    begin
                        if rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Activity Date"; Rec."Activity Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Activity Date field.';
                }
                field("Activity Time"; Rec."Activity Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Activity Time field.';
                }
                field("BL No."; Rec."BL No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BL No. field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Container /Chasis No."; Rec."Container /Chasis No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Container /Chasis No. field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(Approved; Rec.Approved)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved field.';
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved By field.';
                }
                field("Approved Date Time"; Rec."Approved Date Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved Date Time field.';
                }
            }
            group(Details)
            {
                field("Job File No."; Rec."Job File No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job File No. field.';
                }

                field("Cancel GatePass Status"; Rec."Cancel GatePass Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cancel GatePass Status field.';
                    Visible = false;
                }
                field("Agent Name"; Rec."Agent Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Agent Name field.';
                }

                field("Clearing Agent"; Rec."Clearing Agent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Clearing Agent field.';
                }
                field("Clearing Agent Name"; Rec."Clearing Agent Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Clearing Agent Name field.';
                }

                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field("Consignee No."; Rec."Consignee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consignee No. field.';
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consignee Name field.';
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Approve';
                //Visible = PageEdit;
                trigger OnAction()
                var
                    Usersetup: Record "User Setup";
                begin
                    Rec.TestField(Remarks);
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
            action(Post)
            {
                ApplicationArea = All;
                Caption = 'Post';
                //Visible = PageEdit;
                trigger OnAction()
                var
                    myInt: Integer;

                begin
                    Rec."Activity Time" := time;
                    if not rec.Approved then
                        error('Approval is mandatory. Please contact Group Audit');
                    IF Confirm('Do you want Cancel the Gatepass?', true) then begin
                        Rec.Posted := true;
                        Rec."Posted Date" := Today;
                        Rec."Posted Time" := Time;
                        Rec.UpdateRelasedDetails();
                        Rec.Modify();
                        Currpage.Close();

                    end else
                        exit;
                end;
            }
        }
    }
}
