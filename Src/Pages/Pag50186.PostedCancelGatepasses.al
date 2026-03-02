page 50186 PostedCancelGatepasses
{
    ApplicationArea = All;
    Caption = 'Posted Cancel Gatepasses';
    PageType = List;
    SourceTable = "Cancel Gatepass";
    SourceTableView = where(Posted = filter(true));
    UsageCategory = Lists;
    CardPageId = "Posted Cancel Gatepass";
    InsertAllowed = false;
    DeleteAllowed = false;
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cancel Gatepass No."; Rec."Cancel Gatepass No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cancel Gatepass No. field.';
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
                field("Cancel GatePass Printed"; Rec."Cancel GatePass Printed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cancel GatePass Printed field.';
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
}
