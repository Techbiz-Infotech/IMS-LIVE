page 50117 "ReceivingLog Modification Log"
{
    ApplicationArea = All;
    Caption = 'ReceivingLog Modification Log';
    PageType = List;
    SourceTable = "ReceivingLog ModificationLog";
    UsageCategory = History;
    Editable = false;

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
                }
                field("Receiving Log Entry No."; Rec."Receiving Log Entry No.")
                {
                    ToolTip = 'Specifies the value of the Receiving Log Entry No field.';
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                }
                field("Job File No."; Rec."Job File No.")
                {
                    ToolTip = 'Specifies the value of the Job File No. field.';
                    ApplicationArea = All;
                }
                field("BL No."; Rec."BL No.")
                {
                    ToolTip = 'Specifies the value of the BL No. field.';
                    ApplicationArea = All;
                }
                field("Container No./Chassis No."; Rec."Container No./Chassis No.")
                {
                    ToolTip = 'Specifies the value of the Container No./Chassis No. field.';
                    ApplicationArea = All;
                }
                field("Container Type"; Rec."Container Type")
                {
                    ToolTip = 'Specifies the value of the Container Type field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 5 Code";Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the value of the Container Size field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field(Vehicle; Rec.Vehicle)
                {
                    ToolTip = 'Specifies the value of the Vehicle field.';
                    ApplicationArea = All;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ToolTip = 'Specifies the value of the Driver Name field.';
                    ApplicationArea = All;
                }
                field("Driver ID"; Rec."Driver ID")
                {
                    ToolTip = 'Specifies the value of the Driver ID field.';
                    ApplicationArea = All;
                }
                field("DO No."; Rec."DO No.")
                {
                    ToolTip = 'Specifies the value of the DO No. field.';
                    ApplicationArea = All;
                }
                field("Time In"; Rec."Time In")
                {
                    ToolTip = 'Specifies the value of the Time In field.';
                    ApplicationArea = All;
                }
                field(Recieived; Rec.Recieived)
                {
                    ToolTip = 'Specifies the value of the Recieived field.';
                    ApplicationArea = All;
                }
                field("Received Date"; Rec."Received Date")
                {
                    ToolTip = 'Specifies the value of the Received Date field.';
                    ApplicationArea = All;
                }
                field(Transporter; Rec.Transporter)
                {
                    ToolTip = 'Specifies the value of the Transporter field.';
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
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                    ApplicationArea = All;
                }
                field("Manifest Line No."; Rec."Manifest Line No.")
                {
                    ToolTip = 'Specifies the value of the Manifest Line No. field.';
                    ApplicationArea = All;
                }
                field("Modified User ID"; Rec."Modified User ID")
                {
                    ToolTip = 'Specifies the value of the Modified User ID field.';
                    ApplicationArea = All;
                }
                field("Modified Date"; Rec."Modified Date")
                {
                    ToolTip = 'Specifies the value of the Modified Date field.';
                    ApplicationArea = All;
                }
                field("Modified Time"; Rec."Modified Time")
                {
                    ToolTip = 'Specifies the value of the Modified Time field.';
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
            }
        }
    }
}
