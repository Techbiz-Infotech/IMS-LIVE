page 50182 "PendingContainers for GPTEMP"
{
    //ApplicationArea = All;
    Caption = 'Pending Containers for Gatepass Temp';
    PageType = List;
    SourceTable = "Posted Gate Pass out Line";
    SourceTableView = where(Released = const(false), "Gate Pass Status" = const(InActive));
    //UsageCategory = Tasks;
    //Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Activity Date"; rec."Activity Date")
                {
                    ApplicationArea = All;
                }
                field("Activity Time"; rec."Activity Time")
                {
                    ApplicationArea = all;
                }
                field("Gate Pass No."; Rec."Gate Pass No.")
                {
                    ToolTip = 'Specifies the value of the Gate Pass No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Container /Chasis No."; Rec."Container /Chasis No.")
                {
                    ToolTip = 'Specifies the value of the Container /Chasis No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Consignee No."; Rec."Consignee No.")
                {
                    ToolTip = 'Specifies the value of the Consignee No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                    ToolTip = 'Specifies the value of the Consignee Name field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("BL No."; Rec."BL No.")
                {
                    ToolTip = 'Specifies the value of the BL No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Position ID"; Rec."Position ID")
                {
                    ToolTip = 'Specifies the value of the Position ID field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Job File No."; Rec."Job File No.")
                {
                    ToolTip = 'Specifies the value of the Job File No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 6 Code field.';
                    ApplicationArea = All;
                    Editable = false;
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
                    Editable = false;
                }
                field("Agent Port Pass"; Rec."Agent Port Pass")
                {
                    ToolTip = 'Specifies the value of the Agent Port Pass field.';
                    ApplicationArea = All;
                    Editable = false;
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
                    Editable = false;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ToolTip = 'Specifies the value of the Invoice No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Invoice Date"; Rec."Invoice Date")
                {
                    ToolTip = 'Specifies the value of the Invoice Date field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ToolTip = 'Specifies the value of the Receipt No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No. Of Bags"; Rec."No. Of Bags")
                {
                    ToolTip = 'Specifies the value of the No. Of Bags field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Gate Pass Status";Rec."Gate Pass Status")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                    //Editable = false;
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

            action("Release Container")
            {
                ApplicationArea = All;
                trigger OnAction()
                var

                begin
                    IF Confirm('Do you want to Release the Container %1?', true, Rec."Container /Chasis No.") then begin
                        Rec.Released := true;
                        Rec."Released Date" := today();
                        Rec."Released Time" := Time;
                        Rec.Modify();
                        rec.UpdateManifest();
                        rec.UpdatePositionLog();
                        rec.UpdatePosition();
                        rec.UpdateContainer();
                        CurrPage.Update(false);
                    end;
                end;
            }
        }
    }
}
