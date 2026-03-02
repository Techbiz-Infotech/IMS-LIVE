page 50111 ReceivingLogs
{
    ApplicationArea = All;
    Caption = 'Receiving Logs';
    PageType = List;
    SourceTableView = SORTING("Entry No.") ORDER(Descending);
    SourceTable = ReceivingLog;
    UsageCategory = History;
    //Permissions = tabledata "Sales Invoice Line" = rimd;
    InsertAllowed = false;
    ModifyAllowed = true;
    DeleteAllowed = false;
    //Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No field.';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Job File No."; Rec."Job File No.")
                {
                    ToolTip = 'Specifies the value of the Job File No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("BL No."; Rec."BL No.")
                {
                    ToolTip = 'Specifies the value of the BL No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Container No./Chassis No."; REC."Container No./Chassis No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field("Container Type"; Rec."Container Type")
                {
                    ToolTip = 'Specifies the value of the Container Type field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the value of the Container Size field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Position; rec.Position)
                {
                    ToolTip = 'Specifies the value of the Position field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Vehicle; Rec.Vehicle)
                {
                    ToolTip = 'Specifies the value of the Vehicle field.';
                    ApplicationArea = All;
                }
                field("Driver ID"; Rec."Driver ID")
                {
                    ToolTip = 'Specifies the value of the Driver ID field.';
                    ApplicationArea = All;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ToolTip = 'Specifies the value of the Driver Name field.';
                    ApplicationArea = All;
                }
                field("DO No."; Rec."DO No.")
                {
                    ToolTip = 'Specifies the value of the DO No. field.';
                    ApplicationArea = All;
                }

                field(Recieived; Rec.Recieived)
                {
                    ToolTip = 'Specifies the value of the Recieived field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Received Date"; Rec."Received Date")
                {
                    ToolTip = 'Specifies the value of the Received Date field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Time In"; Rec."Time In")
                {
                    ToolTip = 'Specifies the value of the Time In field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Transporter; Rec.Transporter)
                {
                    ToolTip = 'Specifies the value of the Transporter field.';
                    ApplicationArea = All;
                }
                field("Transporter Name"; Rec."Transporter Name")
                {
                    ToolTip = 'Specifies the value of the Transporter Name field.';
                    ApplicationArea = All;
                }
                field("Vehicle Type"; Rec."Vehicle Type")
                {
                    ToolTip = 'Specifies the value of the Vehicle Type field.';
                    ApplicationArea = All;
                }
                field("Truck /Wagon No."; Rec."Truck /Wagon No.")
                {
                    ToolTip = 'Specifies the value of the Truck /Wagon No. field.';
                    ApplicationArea = All;
                }
                field("Trailer No."; Rec."Trailer No.")
                {
                    ToolTip = 'Specifies the value of the Trailer No. field.';
                    ApplicationArea = All;
                }
                field("Shipper Seal No."; Rec."Shipper Seal No.")
                {
                    ToolTip = 'Specifies the value of the Shipper Seal No. field.';
                    ApplicationArea = All;
                }
                field("Container Structural Status"; Rec."Container Structural Status")
                {
                    ToolTip = 'Specifies the value of the Container Structural Status field.';
                    ApplicationArea = All;
                }
                field("Releasing Clerk Details"; Rec."Releasing Clerk Details")
                {
                    ToolTip = 'Specifies the value of the Releasing Clerk Details field.';
                    ApplicationArea = All;
                }
                field("Manifest Line No."; rec."Manifest Line No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("User ID"; rec."User ID")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Seal No. 1"; Rec."Seal No. 1")
                {
                    ApplicationArea = All;
                }
                field("Seal No. 2"; Rec."Seal No. 2")
                {
                    ApplicationArea = All;
                }

                field(Modified; Rec.Modified)
                {
                    ApplicationArea = All;
                }

            }
        }
        // area(FactBoxes)
        // {
        //     part(control11; "Receiving Container Log")
        //     {
        //         ApplicationArea = all;
        //         //SubPageLink = "Entry No." = FIELD("Entry No.");
        //         //Visible = NOT IsOfficeAddin;

        //     }
        // }
    }

    actions
    {
        area(Navigation)
        {
            action("Modification Log")
            {
                Caption = 'Modification Log';
                ApplicationArea = All;
                RunObject = page "ReceivingLog Modification Log";
                RunPageLink = "Global Dimension 1 Code" = field("Global Dimension 1 Code");
                Visible = false;
            }
            action(Print)
            {
                ApplicationArea = all;
                Caption = 'Print';
                Image = Print;
                ToolTip = 'View or print the receiving';
                trigger OnAction()
                var
                    ReceivingLogRec: Record ReceivingLog;
                begin
                    ReceivingLogRec.Reset();
                    ReceivingLogRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                    IF ReceivingLogRec.FindFirst() then
                        report.RunModal(report::"Receiving Log", true, true, ReceivingLogRec)

                end;


            }
            action(Inward)
            {
                Caption = 'Inward';
                ApplicationArea = All;
                Image = Print;
                 Visible = InwardVisible;
                ToolTip = 'View or print the Equipment Interchange Report';
                trigger OnAction()
                var
                    ReceivingLogRec: Record ReceivingLog;
                begin
                    ReceivingLogRec.Reset();
                    ReceivingLogRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                    IF ReceivingLogRec.FindFirst() then
                        report.RunModal(report::"Equipment Interchange report", true, true, ReceivingLogRec)
                end;
            }
        }
    }
     trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if CompanyName <> 'SICD' then
            InwardVisible := false
        else
            InwardVisible := true;
    end;

    var
        InwardVisible: Boolean;
}


