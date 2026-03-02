page 50168 ReleasedGatepassOutslist
{
    ApplicationArea = All;
    Caption = 'Released Containers for Gatepass';
    PageType = List;
    SourceTable = "Posted Gate Pass out Line";
    SourceTableView = where(Released = const(true), "Gate Pass Status" = const(Active));
    UsageCategory = Tasks;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Released Date"; Rec."Released Date")
                {
                    ApplicationArea = All;
                }
                field("Released Time"; Rec."Released Time")
                {
                    ApplicationArea = all;
                }
                field("Gate Pass No."; Rec."Gate Pass No.")
                {
                    ToolTip = 'Specifies the value of the Gate Pass No. field.';
                    ApplicationArea = All;
                }
                field("Container /Chasis No."; Rec."Container /Chasis No.")
                {
                    ToolTip = 'Specifies the value of the Container /Chasis No. field.';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                    ApplicationArea = All;
                }
                field("Consignee No."; Rec."Consignee No.")
                {
                    ToolTip = 'Specifies the value of the Consignee No. field.';
                    ApplicationArea = All;
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                    ToolTip = 'Specifies the value of the Consignee Name field.';
                    ApplicationArea = All;
                }
                field("BL No."; Rec."BL No.")
                {
                    ToolTip = 'Specifies the value of the BL No. field.';
                    ApplicationArea = All;
                }
                field("Position ID"; Rec."Position ID")
                {
                    ToolTip = 'Specifies the value of the Position ID field.';
                    ApplicationArea = All;
                }
                field("Job File No."; Rec."Job File No.")
                {
                    ToolTip = 'Specifies the value of the Job File No. field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 6 Code field.';
                    ApplicationArea = All;
                }
                field("Tranporter/Driver Name"; Rec."Tranporter/Driver Name")
                {
                    ToolTip = 'Specifies the value of the Tranporter/Driver Name field.';
                    ApplicationArea = All;
                }
                field("Truck No."; Rec."Truck No.")
                {
                    ToolTip = 'Specifies the value of the Truck No. field.';
                    ApplicationArea = All;
                }
                field("Agent Name"; Rec."Agent Name")
                {
                    ToolTip = 'Specifies the value of the Agent Name field.';
                    ApplicationArea = All;
                }
                field("Agent Port Pass"; Rec."Agent Port Pass")
                {
                    ToolTip = 'Specifies the value of the Agent Port Pass field.';
                    ApplicationArea = All;
                }
                field("Trailer No."; Rec."Trailer No.")
                {
                    ToolTip = 'Specifies the value of the Trailer No. field.';
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                    ApplicationArea = All;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ToolTip = 'Specifies the value of the Invoice No. field.';
                    ApplicationArea = All;
                }
                field("Invoice Date"; Rec."Invoice Date")
                {
                    ToolTip = 'Specifies the value of the Invoice Date field.';
                    ApplicationArea = All;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ToolTip = 'Specifies the value of the Receipt No. field.';
                    ApplicationArea = All;
                }
                field("No. Of Bags"; Rec."No. Of Bags")
                {
                    ToolTip = 'Specifies the value of the No. Of Bags field.';
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                }
                field("DO No. Expiry date"; rec."DO No. Expiry date")
                {
                    ToolTip = 'Specifies the value of the DO No. Expiry date field.';
                    ApplicationArea = All;
                }
                field(ActivityDate; ActivityDate)
                {
                    ToolTip = 'Specifies the value of the Activity date field.';
                    ApplicationArea = All;
                }
                field(activityTime; activityTime)
                {
                    ToolTip = 'Specifies the value of the Activity Time field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action("Print GatePass")
            {
                Caption = 'Print Gatepass';
                ApplicationArea = All;
                trigger OnAction()
                var
                    GatePassLine: Record "Posted Gate Pass Out Line";
                begin
                    //GatePassLine.Reset();
                    //GatePassLine.SetRange("Gate Pass No.", Rec."Gate Pass No.");
                    //GatePassLine.SetRange("Line No.", rec."Line No.");
                    CurrPage.SetSelectionFilter(GatePassLine);
                    currpage.SetTableView(GatePassLine);
                    IF GatePassLine.FindSet() then begin
                        report.RunModal(report::"Released Gate Pass", true, true, GatePassLine);
                    end;
                    rec.Reset();
                    CurrPage.Update(false);
                end;
            }

            action("Print Loading Slip")
            {
                Caption = 'Print Loading Slip';
                ApplicationArea = All;
                trigger OnAction()
                var
                    GatePassLine: Record "Posted Gate Pass Out Line";
                begin
                    // GatePassLine.Reset();
                    // GatePassLine.SetRange("Gate Pass No.", Rec."Gate Pass No.");
                    // GatePassLine.SetRange("Line No.", rec."Line No.");
                    CurrPage.SetSelectionFilter(GatePassLine);
                    currpage.SetTableView(GatePassLine);
                    IF GatePassLine.FindSet() then begin
                        report.RunModal(report::"Loading Slip Released", true, true, GatePassLine);
                    end;
                    rec.Reset();
                    CurrPage.Update(false);
                end;
            }
            action("Print Outward")
            {
                Caption = 'Print Outward Interchange';
                ApplicationArea = All;
                trigger OnAction()
                var
                    GatePassLine: Record "Posted Gate Pass Out Line";
                begin
                    //GatePassLine.Reset();
                    //GatePassLine.SetRange("Gate Pass No.", Rec."Gate Pass No.");
                    //GatePassLine.SetRange("Line No.", rec."Line No.");
                    CurrPage.SetSelectionFilter(GatePassLine);
                    currpage.SetTableView(GatePassLine);
                    IF GatePassLine.FindSet() then begin
                        report.RunModal(report::"OutWard Interchange Released", true, true, GatePassLine);
                    end;
                    rec.Reset();
                    CurrPage.Update(false);
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        UpdateActivityDetails();
    end;
    trigger OnAfterGetRecord()
    begin
        UpdateActivityDetails();
    end;
    trigger OnAfterGetCurrRecord()
    begin
        UpdateActivityDetails();
    end;

    procedure UpdateActivityDetails()
    var
        GPHeader: Record "Posted Gate Pass Out";
    begin
        if GPHeader.Get(Rec."Gate Pass No.") then begin
            ActivityDate := GPHeader."Activity Date";
            activityTime := GPHeader."Activity Time";
        end;
    end;

    var
        ActivityDate: Date;
        activityTime: Time;
}
