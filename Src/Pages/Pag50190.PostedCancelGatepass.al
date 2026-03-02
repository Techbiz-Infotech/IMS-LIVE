page 50190 "Posted Cancel Gatepass"

{
    Caption = 'Posted Cancel Gatepass';
    PageType = Card;
    SourceTable = "Cancel Gatepass";
    SourceTableView = where(Posted = filter(true));
    Editable = false;
    DeleteAllowed = false;
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
                field("Job File No."; Rec."Job File No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job File No. field.';
                }
                field("Container /Chasis No."; Rec."Container /Chasis No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Container /Chasis No. field.';
                }
                field("Cancel GatePass Status"; Rec."Cancel GatePass Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cancel GatePass Status field.';
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
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
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
                field("Posted Date"; Rec."Posted Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Activity Date field.';
                }
                field("Posted Time"; Rec."Posted Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Activity Time field.';
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            // action(Approve)
            // {
            //     ApplicationArea = All;
            //     Caption = 'Approve';
            //     //Visible = PageEdit;
            //     trigger OnAction()
            //     var
            //         Usersetup: Record "User Setup";
            //     begin
            //         if Rec.approved then
            //             error('The document is aleady approved');
            //         Usersetup.Get(UserId);
            //         if not Usersetup."Gatepass Approval" then
            //             error('You do not have permission')
            //         else begin
            //             Rec.Approved := true;
            //             Rec."Approved By" := UserId;
            //             Rec."Approved Date Time" := CurrentDateTime;
            //             Rec.Modify();
            //         end;
            //           end;
        }
        // action("Print GatePass")
        // {
        //     Caption = 'Print Gatepass';
        //     ApplicationArea = All;
        //     Visible = PageEdit;
        //     trigger OnAction()
        //     var
        //         GatePass: Record "Gate Pass Out";
        //         GatepassLine: Record "Gate Pass Out Line";
        //         CustRec: Record customer;
        //     begin

        //         GatepassLine.Reset();
        //         GatePassLine.SetRange("Gate Pass No.", Rec."Gate Pass No.");
        //         gatepassline.setrange("Payment Terms", 'COD');
        //         GatepassLine.SetRange("Receipt No.", '');
        //         IF GatepassLine.FindFirst() then begin
        //             if not rec.Approved then
        //                 Error('Payment not been made')
        //         end;

        //         GatePass.Reset();
        //         GatePass.SetRange("Gate Pass No.", Rec."Gate Pass No.");
        //         IF GatePass.FindFirst() then begin
        //             report.RunModal(report::"Gate Pass Test Report", true, true, GatePass);
        //             Rec."Gate Pass Printed" := true;
        //             rec.Modify();
        //         end;

        //     end;
        // }
        // action(Post)
        // {
        //     ApplicationArea = All;
        //     Caption = 'Post';
        //     //Visible = PageEdit;
        //     trigger OnAction()
        //     var
        //         myInt: Integer;

        //     begin
        //         Rec."Activity Time" := time;
        //         if not rec.Approved then
        //             error('Approval is mandatory. Please contact Group Audit');
        //         IF Confirm('Do you want Cancel the Gatepass?', true) then begin
        //             Rec.Posted := true;
        //             Rec."Posted Date" := Today;
        //             Rec."Posted Time" := Time;
        //             Rec.UpdateRelasedDetails();
        //             Currpage.Close();
        //             Rec.Modify();
        //         end else
        //             exit;
        //     end;
        // }
    }
}

