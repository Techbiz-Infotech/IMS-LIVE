page 50144 "Gate Pass Out Subform"
{
    Caption = 'Gate Pass Out Lines';
    PageType = ListPart;
    SourceTable = "Gate Pass Out Line";
    DelayedInsert = true;
    AutoSplitKey = true;
    MultipleNewLines = true;
    //    SourceTableView

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Gate Pass No."; Rec."Gate Pass No.")
                {
                    ToolTip = 'Specifies the value of the Gate Pass No. field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Invoice No."; Rec."Invoice No.")
                {
                    ToolTip = 'Specifies the value of the Invoice No. field.';

                    ApplicationArea = All;
                }
                field("BL No"; Rec."BL No")
                {
                    ApplicationArea = all;
                }
                field("Job File No"; Rec."Job File No")
                {
                    ApplicationArea = all;
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 5 Code"; rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the value of the Container Size field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Container Size field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 4 Code"; rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Container Size field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 6 Code"; rec."Shortcut Dimension 6 Code")
                {
                    ToolTip = 'Specifies the value of the Container Size field.';
                    ApplicationArea = All;
                }
                field("Container /Chasis No."; Rec."Container /Chasis No.")
                {
                    ToolTip = 'Specifies the value of the Container /Chasis No. field.';
                    ApplicationArea = All;
                }
                field("Position ID"; Rec."Position ID")
                {
                    ToolTip = 'Specifies the value of the Position ID field.';
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
                field("Payment Method"; rec."Payment Method")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Payment method field.';
                    Editable = false;
                }
                field("Agent Port Pass"; Rec."Agent Port Pass")
                {
                    ToolTip = 'Specifies the value of the Agent Port Pass field.';
                    ApplicationArea = All;
                }
                field("Tranporter/Driver Name"; Rec."Tranporter/Driver Name")
                {
                    ToolTip = 'Specifies the value of the Tranporter/Driver Name field.';
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                    ApplicationArea = All;
                }
                field("Trailer No."; Rec."Trailer No.")
                {
                    ToolTip = 'Specifies the value of the Trailer No. field.';
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
                field("Custom Entry No."; Rec."Custom Entry No.")
                {
                    ToolTip = 'Specifies the value of the Custom Entry No. field.';
                    ApplicationArea = All;
                }
                field("Delivery Order No."; Rec."Delivery Order No.")
                {
                    ToolTip = 'Specifies the value of the Delivery Order No. field.';
                    ApplicationArea = All;
                }
                field("DO No. Expiry date";Rec."DO No. Expiry date")
                {
                    ToolTip = 'Specifies the value of the Do no expiry date field.';
                    ApplicationArea = All;
                }
                
                field("Payment Terms"; Rec."Payment Terms")
                {
                    ToolTip = 'Payment terms';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action("Print Loading Slip")
            {
                Caption = 'Print Loading Slip';
                ApplicationArea = All;
                Visible = LoadingVisible;
                trigger OnAction()
                var
                    GatePassLine: Record "Gate Pass Out Line";
                begin
                    CurrPage.SetSelectionFilter(GatePassLine);
                    currpage.SetTableView(GatePassLine);
                    IF GatePassLine.FindSet() then
                        report.RunModal(report::"Loading Slip", true, true, GatePassLine);
                    rec.Reset();
                    rec.SetRange("Gate Pass No.", GatePassLine."Gate Pass No.");
                    CurrPage.Update(false);
                end;
            }
            action("Print Outward Interchange")
            {
                Caption = 'Print Outward Interchange';
                ApplicationArea = All;
                trigger OnAction()
                var
                    GatePassLine: Record "Gate Pass Out Line";
                begin
                    CurrPage.SetSelectionFilter(GatePassLine);
                    currpage.SetTableView(GatePassLine);
                    IF GatePassLine.FindSet() then
                        report.RunModal(report::"OutWard Interchange Report", true, true, GatePassLine);
                    Rec.Reset();
                    rec.SetRange("Gate Pass No.", GatePassLine."Gate Pass No.");
                    CurrPage.Update(false);
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if CompanyName <> 'MICT' then
            LoadingVisible := true
        else
            LoadingVisible := false;
    end;

    var
        LoadingVisible: Boolean;
}
