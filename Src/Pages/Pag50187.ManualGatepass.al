page 50187 "Parent Gatepass"
{
    Caption = 'Manual Gatepass';
    PageType = Card;
    SourceTable = "Parent Gatepass";
    SourceTableView = where(Posted = filter(false));
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Parent Gatepass No."; Rec."Parent Gatepass No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Parent Gatepass No. field.';
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
            part(ManualGatepassLine; "Manual Gatepass Subform")
            {
                Caption = 'Manual Gatepass Line';
                ApplicationArea = all;
                SubPageLink = "Parent Gatepass No." = field("Parent Gatepass No.");
                UpdatePropagation = Both;
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
                //Visible = PageEdit;
                trigger OnAction()
                var
                    myInt: Integer;

                begin
                    Rec."Activity Time" := time;
                    Rec.GetLines();
                end;
            }
            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Approve';
                //Visible = PageEdit;
                trigger OnAction()
                var
                    Usersetup: Record "User Setup";
                    MGPOline: Record "Parent Gatepass Line";
                begin
                    rec.TestField(Remarks);
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
                        MGPOline.Reset();
                        MGPOline.SetRange("Parent Gatepass No.", Rec."Parent Gatepass No.");
                        if MGPOline.FindFirst() then
                            repeat
                                MGPOline.Approved := true;
                                MGPOline."Approved By" := UserId;
                                MGPOline."Approved Date Time" := CurrentDateTime;
                                MGPOline.Modify();
                            until MGPOline.Next() = 0;
                    end;
                end;
            }
            action("Print GatePass")
            {
                Caption = 'Print Gatepass';
                ApplicationArea = All;
                //Visible = PageEdit;
                trigger OnAction()
                var
                    GatePass: Record "Parent Gatepass Line";
                begin
                    rec.TestField(Approved);
                    if rec.Approved then begin
                        GatePass.Reset();
                        GatePass.SetRange("Parent Gatepass No.", Rec."Parent Gatepass No.");
                        IF GatePass.FindFirst() then begin
                            report.RunModal(report::"Manual Gatepass", true, true, GatePass);
                            Rec."Parent GatePass Printed" := true;
                            rec.Modify();
                        end;
                    end;
                end;
            }
            // action("Print Outward")
            // {
            //     Caption = 'Print Outward Interchange';
            //     ApplicationArea = All;
            //     //Visible = PageEdit;
            //     trigger OnAction()
            //     var
            //         GatePass: Record "Parent Gatepass";
            //     begin
            //         rec.TestField(Approved);
            //         if rec.Approved then begin
            //             GatePass.Reset();
            //             GatePass.SetRange("Parent Gatepass No.", Rec."Parent Gatepass No.");
            //             IF GatePass.FindFirst() then begin
            //                 report.RunModal(report::"Outward Interchange for Manual", true, true, GatePass);
            //                 //Rec."Parent GatePass Printed" := true;
            //                 rec.Modify();
            //             end;
            //         end;
            //     end;
            // }
            action(Post)
            {
                ApplicationArea = All;
                Caption = 'Post';
                //Visible = PageEdit;
                trigger OnAction()
                var
                    myInt: Integer;
                    MGPOLine: Record "Parent Gatepass Line";
                begin
                    Rec."Activity Time" := time;
                    if not rec.Approved then
                        error('Approval is mandatory. Please contact Group Audit');
                    Rec.TestField("Parent GatePass Printed");
                    IF Confirm('Do you want Post the Gatepass?', true) then begin
                        Rec.Posted := true;
                        Rec."Posted Date" := Today;
                        Rec."Posted Time" := Time;
                        Rec.UpdateRelasedDetails();
                        Rec.Modify();
                        Currpage.Close()
                    end else
                        exit;
                end;
            }
        }
    }
}
