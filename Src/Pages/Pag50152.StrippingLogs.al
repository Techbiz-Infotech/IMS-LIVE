page 50152 StrippingLogs
{
    Caption = 'Stripping Logs';
    PageType = List;
    SourceTable = StrippingLog;
    SourceTableView = SORTING("Entry No.") ORDER(Descending);
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = History;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; rec."Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = all;
                }
                field("BL No."; Rec."BL No.")
                {
                    ToolTip = 'Specifies the value of the BL No. field.';
                    ApplicationArea = All;
                }
                field("Stripping Date"; Rec."Stripping Date")
                {
                    ToolTip = 'Specifies the value of the Stripping Date field.';
                    ApplicationArea = All;
                }
                field("Stripping Time"; Rec."Stripping Time")
                {
                    ToolTip = 'Specifies the value of the Stripping Time field.';
                    ApplicationArea = All;
                }
                field("Job File No."; rec."Job File No.")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Container No./Chassis No."; rec."Container No./Chassis No.")
                {
                    ToolTip = 'Specifies the value of the Container field.';
                    ApplicationArea = All;
                }

                field("Container Type"; Rec."Container Type")
                {
                    ToolTip = 'Specifies the value of the Container Type field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the value of the Container Size field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                
                field("Stripping Notes"; Rec."Stripping Notes")
                {
                    ToolTip = 'Specifies the value of the Stripping Notes field.';
                    ApplicationArea = All;
                }
                field("Shipper Seal"; Rec."Shipper Seal")
                {
                    ToolTip = 'Specifies the value of the Shipper Seal field.';
                    ApplicationArea = All;
                }
                field("User ID"; rec."User ID")
                {

                    ToolTip = 'Specifies the value of the Start After field.';
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action("Additional Charges")
            {
                Caption = 'Additional Charges';
                ApplicationArea = All;
                RunObject = page "Posted AddCharges Stripping";
                RunPageLink = "Container ID" = field("Global Dimension 1 Code");
                trigger OnAction()
                var
                begin

                end;
            }
            // action("Print Stripping")
            // {
            //     Caption = 'Print Stripping';
            //     ApplicationArea = All;
            //     trigger OnAction()
            //     var
            //         StrippingLog: Record StrippingLog;
            //     begin
            //         StrippingLog.Reset();
            //         StrippingLog.SetRange("BL No.", Rec."BL No.");
            //         IF StrippingLog.FindFirst() then
            //             report.RunModal(report::"Custom Stripping Order", true, true, StrippingLog);
            //     end;
            // }

        }
    }
}
