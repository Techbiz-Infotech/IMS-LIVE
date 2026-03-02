page 50158 "Released Gate Pass Out"
{
    Caption = 'Released Gate Pass Out';
    PageType = Document;
    SourceTable = "Posted Gate Pass Out";
    SourceTableView = where(Released = const(true));
    //Editable = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Gate Pass No."; Rec."Gate Pass No.")
                {
                    ToolTip = 'Specifies the value of the Gate Pass No. field.';
                    ApplicationArea = All;
                }
                field("Released Date"; Rec."Released Date")
                {
                    ToolTip = 'Specifies the value of the Released Date field.';
                    ApplicationArea = All;
                }
                field("Released Time"; rec."Released Time")
                {
                    ApplicationArea = all;
                }
                field("BL No."; Rec."BL No.")
                {
                    ToolTip = 'Specifies the value of the BL No. field.';
                    ApplicationArea = All;
                }
                field("Job File No."; Rec."Job File No.")
                {
                    ToolTip = 'Specifies the value of the Job File No. field.';
                    ApplicationArea = All;
                }

                field("Gate Pass Status"; Rec."Gate Pass Status")
                {
                    ApplicationArea = all;
                }
            }
            part(GatePassLines; 50166)
            {
                ApplicationArea = all;
                SubPageLink = "Gate Pass No." = field("Gate Pass No.");
                UpdatePropagation = Both;
            }
            group(Others)
            {
                field(Released; Rec.Released)
                {
                    ToolTip = 'Specifies the value of the Released field.';
                    ApplicationArea = All;
                }
                field("Activity Date"; Rec."Activity Date")
                {
                    ToolTip = 'Specifies the value of the Activity Date field.';
                    ApplicationArea = All;
                }
                field("Activity Time"; rec."Activity Time")
                {
                    ToolTip = 'Specifies the value of the Gate Pass Out Time field.';
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
                    GatePass: Record "Posted Gate Pass Out";
                    GatepassLine: Record "Posted Gate Pass Out Line";
                    CustRec: Record customer;
                begin
                    GatePass.Reset();
                    GatePass.SetRange("Gate Pass No.", Rec."Gate Pass No.");
                    IF GatePass.FindFirst() then begin
                        report.RunModal(report::"Released Gate Pass", true, true, GatePass);
                    end;
                end;

            }
        }
    }
}
