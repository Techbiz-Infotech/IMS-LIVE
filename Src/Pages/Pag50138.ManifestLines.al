page 50138 "Manifest Lines"
{
    //ApplicationArea = All;
    Caption = 'Manifest Lines';
    PageType = List;
    SourceTable = "Manifest Line";
    UsageCategory = Lists;
    SourceTableView = sorting("Job File No.", "Line No.") order(descending);
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    Editable =false;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                }
                field("Charge ID"; Rec."Charge ID")
                {
                    ToolTip = 'Specifies the value of the Charge ID field.';
                    ApplicationArea = All;
                }
                field(Manifested; Rec.Manifested)
                {
                    ToolTip = 'Specifies the value of the Manifested field.';
                    ApplicationArea = All;
                }
                field("BL No."; Rec."BL No.")
                {
                    ToolTip = 'Specifies the value of the BL No. field.';
                    ApplicationArea = All;
                }
                field("TBL/MH"; Rec."TBL/MH")
                {
                    ToolTip = 'Specifies the value of the TBL/MH field.';
                    ApplicationArea = All;
                }
                field("Container/Chassis No."; Rec."Container/Chassis No.")
                {
                    ToolTip = 'Specifies the value of the Container/Chassis No. field.';
                    ApplicationArea = All;
                }
                field("Seal/Engine No."; Rec."Seal/Engine No.")
                {
                    ToolTip = 'Specifies the value of the Seal/Engine No. field.';
                    ApplicationArea = All;
                }
                field("Customs Seal No."; Rec."Customs Seal No.")
                {
                    ToolTip = 'Specifies the value of the Customs Seal No. field.';
                    ApplicationArea = All;
                }
                field(Marks; Rec.Marks)
                {
                    ToolTip = 'Specifies the value of the Marks field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Unit Of Measure field.';
                    ApplicationArea = All;
                }
                field("Container Type"; Rec."Container Type")
                {
                    ToolTip = 'Specifies the value of the Container Type field.';
                    ApplicationArea = All;
                }
                field("Landing Date"; Rec."Landing Date")
                {
                    ToolTip = 'Specifies the value of the Landing Date field.';
                    ApplicationArea = All;
                }
                field("Landing Time"; Rec."Landing Time")
                {
                    ToolTip = 'Specifies the value of the Landing Time field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the value of the Container Size field.';
                    ApplicationArea = All;
                }
                field("Container lock"; Rec."Container lock")
                {
                    ToolTip = 'Specifies the value of the Container lock field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("CBM Tonage"; Rec."CBM Tonage")
                {
                    ToolTip = 'Specifies the value of the CBM Tonage field.';
                    ApplicationArea = All;
                }
                field(Weight; Rec.Weight)
                {
                    ToolTip = 'Specifies the value of the Weight field.';
                    ApplicationArea = All;
                }
                field("CBM-Wt Difference"; Rec."CBM-Wt Difference")
                {
                    ToolTip = 'Specifies the value of the CBM-Wt Difference field.';
                    ApplicationArea = All;
                }
                field("No. of Bags"; Rec."No. of Bags")
                {
                    ToolTip = 'Specifies the value of the No. of Bags field.';
                    ApplicationArea = All;
                }
                field("No. of Bags Released"; Rec."No. of Bags Released")
                {
                    ToolTip = 'Specifies the value of the No. of Bags Released field.';
                    ApplicationArea = All;
                }
                field("Remaining Bags"; Rec."Remaining Bags")
                {
                    ToolTip = 'Specifies the value of the Remaining Bags field.';
                    ApplicationArea = All;
                }
                field("Port of Shipment"; Rec."Port of Shipment")
                {
                    ToolTip = 'Specifies the value of the Port of Shipment field.';
                    ApplicationArea = All;
                }
                field("Port of Discharge"; Rec."Port of Discharge")
                {
                    ToolTip = 'Specifies the value of the Port of Discharge field.';
                    ApplicationArea = All;
                }
                field("Destination Type"; Rec."Destination Type")
                {
                    ToolTip = 'Specifies the value of the Destination Type field.';
                    ApplicationArea = All;
                }
                field("Final Destination"; Rec."Final Destination")
                {
                    ToolTip = 'Specifies the value of the Final Destination field.';
                    ApplicationArea = All;
                }
                field("Container Status"; Rec."Container Status")
                {
                    ToolTip = 'Specifies the value of the Container Status field.';
                    ApplicationArea = All;
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                    ToolTip = 'Specifies the value of the Consignee Name field.';
                    ApplicationArea = All;
                }
                field("Clearing Agent"; Rec."Clearing Agent")
                {
                    ToolTip = 'Specifies the value of the Clearing Agent field.';
                    ApplicationArea = All;
                }
                field("ICDN In-Date"; Rec."ICDN In-Date")
                {
                    ToolTip = 'Specifies the value of the ICDN In-Date field.';
                    ApplicationArea = All;
                }
                field("Verification Print Date"; Rec."Verification Print Date")
                {
                    ToolTip = 'Specifies the value of the Verification Print Date field.';
                    ApplicationArea = All;
                }
                field("Verification Type"; Rec."Verification Type")
                {
                    ToolTip = 'Specifies the value of the Verification Type field.';
                    ApplicationArea = All;
                }
                field("Allocated Position"; Rec."Allocated Position")
                {
                    ToolTip = 'Specifies the value of the Allocated Position';
                    ApplicationArea = All;
                }
                field("Date Received"; Rec."Date Received")
                {
                    ToolTip = 'Specifies the value of the Date Received field.';
                    ApplicationArea = All;
                }
                field(Transporter; Rec.Transporter)
                {
                    ToolTip = 'Specifies the value of the Transporter field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Transporter Name"; Rec."Transporter Name")
                {
                    ToolTip = 'Specifies the value of the Transporter Name field.';
                    ApplicationArea = All;
                }
                field("Date Released"; Rec."Date Released")
                {
                    ToolTip = 'Specifies the value of the Date Released field.';
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
                field(Vehicle; Rec.Vehicle)
                {
                    ToolTip = 'Specifies the value of the Vehicle field.';
                    ApplicationArea = All;
                }
                field("Delivery Order No."; Rec."Delivery Order No.")
                {
                    ToolTip = 'Specifies the value of the Delivery Order No. field.';
                    ApplicationArea = All;
                }
                field("Received By"; Rec."Received By")
                {
                    ToolTip = 'Specifies the value of the Received By field.';
                    ApplicationArea = All;
                }
                field(Verified; Rec.Verified)
                {
                    ToolTip = 'Specifies the value of the Verified field.';
                    ApplicationArea = All;
                }
                field("Verification Time"; Rec."Verification Time")
                {
                    ToolTip = 'Specifies the value of the Verification Time field.';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                }
                field("Custom Entry No."; Rec."Custom Entry No.")
                {
                    ToolTip = 'Specifies the value of the Custom Entry No. field.';
                    ApplicationArea = All;
                }
                field(Received; Rec.Received)
                {
                    ToolTip = 'Specifies the value of the Received field.';
                    ApplicationArea = All;
                }
                field("Received Time"; Rec."Received Time")
                {
                    ToolTip = 'Specifies the value of the Received Time field.';
                    ApplicationArea = All;
                }
                field("Verification Notes"; Rec."Verification Notes")
                {
                    ToolTip = 'Specifies the value of the Verification Notes field.';
                    ApplicationArea = All;
                }
                field(Released; Rec.Released)
                {
                    ToolTip = 'Specifies the value of the Released field.';
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
                field("Job File Date"; Rec."Job File Date")
                {
                    ToolTip = 'Specifies the value of the Job File Date field.';
                    ApplicationArea = All;
                }
                field("Discharge Date"; Rec."Discharge Date")
                {
                    ToolTip = 'Specifies the value of the Discharge Date field.';
                    ApplicationArea = All;
                }
                field("Railed Date"; Rec."Railed Date")
                {
                    ToolTip = 'Specifies the value of the Railed Date field.';
                    ApplicationArea = All;
                }
                field("SICD In-Date"; Rec."SICD In-Date")
                {
                    ToolTip = 'Specifies the value of the SICD In-Date field.';
                    ApplicationArea = All;
                }
                field("Other remarks"; Rec."Other remarks")
                {
                    ToolTip = 'Specifies the value of the Other remarks field.';
                    ApplicationArea = All;
                }
                field("Client Reference No."; Rec."Client Reference No.")
                {
                    ToolTip = 'Specifies the value of the Client Reference No. field.';
                    ApplicationArea = All;
                }
                field("Invoicing Party No."; Rec."Invoicing Party No.")
                {
                    ToolTip = 'Specifies the value of the Invoicing Party No. field.';
                    ApplicationArea = All;
                }
                field("Seal Locked?"; Rec."Seal Locked?")
                {
                    ToolTip = 'Specifies the value of the Seal Locked? field.';
                    ApplicationArea = All;
                }
                field("Seal Tagged?"; Rec."Seal Tagged?")
                {
                    ToolTip = 'Specifies the value of the Seal Tagged? field.';
                    ApplicationArea = All;
                }
                field("Lock No."; Rec."Lock No.")
                {
                    ToolTip = 'Specifies the value of the Lock No. field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                    ApplicationArea = All;
                }
                field("Sales Quote No."; Rec."Sales Quote No.")
                {
                    ToolTip = 'Specifies the value of the Sales Quote No. field.';
                    ApplicationArea = All;
                }
                field("Oppertunity No."; Rec."Oppertunity No.")
                {
                    ToolTip = 'Specifies the value of the  Oppertunity No. field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 6 Code field.';
                    ApplicationArea = All;
                }
                field("Stripping Date"; Rec."Stripping Date")
                {
                    ToolTip = 'Specifies the value of the Stripping Date field.';
                    ApplicationArea = All;
                }

                field(Stripped; Rec.Stripped)
                {
                    ToolTip = 'Specifies the value of the Stripped field.';
                    ApplicationArea = All;
                }
                field("Stripping Time"; Rec."Stripping Time")
                {
                    ToolTip = 'Specifies the value of the Stripping Time field.';
                    ApplicationArea = All;
                }
                field("Stripping Notes"; Rec."Stripping Notes")
                {
                    ToolTip = 'Specifies the value of the Stripping Notes field.';
                    ApplicationArea = All;
                }
                field("Parent Container ID"; Rec."Parent Container ID")
                {
                    ToolTip = 'Specifies the value of the Parent Container ID field.';
                    ApplicationArea = All;
                }
                field("Empty Container"; Rec."Empty Container")
                {
                    ToolTip = 'Specifies the value of the Empty Container field.';
                    ApplicationArea = All;
                }
                field("GP Delivery Order No."; Rec."GP Delivery Order No.")
                {
                    ToolTip = 'Specifies the value of the Delivery Order No. field.';
                    ApplicationArea = All;
                }
                field("Job File No."; Rec."Job File No.")
                {
                    ToolTip = 'Specifies the value of the Job File No. field.';
                    ApplicationArea = All;
                }
                field(Invoices; Rec.Invoices)
                {
                    ToolTip = 'Specifies the value of the Invoices field.';
                    ApplicationArea = All;
                }
                field("Credit Memos"; Rec."Credit Memos")
                {
                    ToolTip = 'Specifies the value of the Credit Memos field.';
                    ApplicationArea = All;
                }
                field("KPA Charges Calculated"; rec."KPA Charges Calculated")
                {
                    ToolTip = 'Specifies the value of the KPA Charges Calculated field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            // action("Manifest Card")
            // {
            //     ApplicationArea = all;
            //     trigger OnAction()

            //     var
            //         ManifestHead: Record "Manifest Header";
            //     begin
            //         ManifestHead.Reset();
            //         ManifestHead.SetRange("Job File No.", rec."Job File No.");
            //         page.Run(50113, ManifestHead);
            //     end;
            // }


            // action("Manifest Line Details")
            // {
            //     ApplicationArea = all;
            //     trigger OnAction()

            //     var
            //         ManifestLine: Record "Manifest Line";
            //     begin
            //         ManifestLine.Reset();
            //         ManifestLine.SetRange("Job File No.", rec."Job File No.");
            //         ManifestLine.SetRange("Line No.", rec."Line No.");
            //         page.Run(50169, ManifestLine);
            //     end;
            // }
            // action("Additional Charges")
            // {
            //     Caption = 'Additional Charges';
            //     ApplicationArea = All;
            //     RunObject = page "Additional Charges";
            //     RunPageLink = "Container ID" = field("Global Dimension 1 Code");
            // }
        }
    }
}
