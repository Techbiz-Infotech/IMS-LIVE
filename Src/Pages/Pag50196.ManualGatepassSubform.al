page 50196 "Manual Gatepass Subform"
{
    Caption = 'Manual Gatepass Subform';
    PageType = ListPart;
    SourceTable = "Parent Gatepass Line";
    DelayedInsert = true;
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Parent Gatepass No."; Rec."Parent Gatepass No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Manual Gatepass No. field.';
                    Visible = false;
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
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.';
                    Visible = false;
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
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
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
                field("Parent GatePass Printed"; Rec."Parent GatePass Printed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Manual GatePass Printed field.';
                }
                field(Approved; Rec.Approved)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved field.';
                    Visible = false;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved By field.';
                    Visible = false;
                }
                field("Approved Date Time"; Rec."Approved Date Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved Date Time field.';
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Print Outward")
            {
                Caption = 'Print Outward Interchange';
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
                        GatePass.SetRange("Line No.", Rec."Line No.");
                        IF GatePass.FindFirst() then begin
                            report.RunModal(report::"Outward Interchange for Manual", true, true, GatePass);
                            //Rec."Parent GatePass Printed" := true;
                            rec.Modify();
                        end;
                    end;
                end;
            }
        }
    }
}