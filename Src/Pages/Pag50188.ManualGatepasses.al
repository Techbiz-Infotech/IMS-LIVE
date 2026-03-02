page 50188 "Parent Gatepasses"
{
    ApplicationArea = All;
    Caption = 'Manual Gatepasses';
    PageType = List;
    SourceTable = "Parent Gatepass";
    SourceTableView = where(Posted = filter(false), "Parent GatePass Status" = const(Active));
    UsageCategory = Lists;
    CardPageId = "Parent Gatepass";
    InsertAllowed = false;
    DeleteAllowed = false;
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Parent Gatepass No."; Rec."Parent Gatepass No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Parent Gatepass No. field.';
                }

                field("Job File No."; Rec."Job File No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job File No. field.';
                }
                field("BL No."; Rec."BL No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BL No. field.';
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

                field("Parent GatePass Status"; Rec."Parent GatePass Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Parent GatePass Status field.';
                }


                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field("Parent GatePass Printed"; Rec."Parent GatePass Printed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Parent GatePass Printed field.';
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
                    GatepassHead: Record "Parent Gatepass";
                begin
                    if Rec.approved then
                        error('The document is aleady approved');
                    Usersetup.Get(UserId);
                    if not Usersetup."Gatepass Approval" then
                        error('You do not have permission')
                    else begin
                        CurrPage.SetSelectionFilter(GatepassHead);
                        if GatepassHead.FindFirst() then
                            repeat
                                GatepassHead.Approved := true;
                                GatepassHead."Approved By" := UserId;
                                GatepassHead."Approved Date Time" := CurrentDateTime;
                                GatepassHead.Modify();
                            until GatepassHead.Next() = 0;
                        CurrPage.Update();
                    end;
                end;
            }
        }
    }
}
