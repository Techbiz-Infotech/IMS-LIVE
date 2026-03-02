page 50052 "Manifest line test"
{
    ApplicationArea = All;
    Caption = 'Manifest line test';
    PageType = List;
    SourceTable = "Manifest Line";
    UsageCategory = Administration;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Job File No."; Rec."Job File No.")
                {
                    ToolTip = 'Specifies the value of the Job File No. field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Charge ID"; Rec."Charge ID")
                {
                    ToolTip = 'Specifies the value of the Charge ID field.';
                }
                field(Manifested; Rec.Manifested)
                {
                    ToolTip = 'Specifies the value of the Manifested field.';
                }
                field("BL No."; Rec."BL No.")
                {
                    ToolTip = 'Specifies the value of the BL No. field.';
                }
                field("Container/Chassis No."; Rec."Container/Chassis No.")
                {
                    ToolTip = 'Specifies the value of the Container/Chassis No. field.';
                }
                field("Seal/Engine No."; Rec."Seal/Engine No.")
                {
                    ToolTip = 'Specifies the value of the Seal/Engine No. field.';
                }
                field("Customs Seal No."; Rec."Customs Seal No.")
                {
                    ToolTip = 'Specifies the value of the Customs Seal No. field.';
                }
                field(Marks; Rec.Marks)
                {
                    ToolTip = 'Specifies the value of the Marks field.';
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Unit Of Measure field.';
                }
                field("Container Type"; Rec."Container Type")
                {
                    ToolTip = 'Specifies the value of the Container Type field.';
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the value of the Container Size field.';
                }
                field("Container lock"; Rec."Container lock")
                {
                    ToolTip = 'Specifies the value of the Container lock field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("CBM Tonage"; Rec."CBM Tonage")
                {
                    ToolTip = 'Specifies the value of the CBM Tonage field.';
                }
                field(Weight; Rec.Weight)
                {
                    ToolTip = 'Specifies the value of the Weight field.';
                }
                field("CBM-Wt Difference"; Rec."CBM-Wt Difference")
                {
                    ToolTip = 'Specifies the value of the CBM-Wt Difference field.';
                }
                field("No. of Bags"; Rec."No. of Bags")
                {
                    ToolTip = 'Specifies the value of the No. of Bags field.';
                }
                field("No. of Bags Released"; Rec."No. of Bags Released")
                {
                    ToolTip = 'Specifies the value of the No. of Bags Released field.';
                }
                field("Remaining Bags"; Rec."Remaining Bags")
                {
                    ToolTip = 'Specifies the value of the Remaining Bags field.';
                }
                field("Port of Shipment"; Rec."Port of Shipment")
                {
                    ToolTip = 'Specifies the value of the Port of Shipment field.';
                }
                field("Port of Discharge"; Rec."Port of Discharge")
                {
                    ToolTip = 'Specifies the value of the Port of Discharge field.';
                }
                field("Destination Type"; Rec."Destination Type")
                {
                    ToolTip = 'Specifies the value of the Destination Type field.';
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                    ToolTip = 'Specifies the value of the Consignee Name field.';
                }
                field("Clearing Agent"; Rec."Clearing Agent")
                {
                    ToolTip = 'Specifies the value of the Clearing Agent field.';
                }
                field("ICDN In-Date"; Rec."ICDN In-Date")
                {
                    ToolTip = 'Specifies the value of the ICDN In-Date field.';
                }
                field("Verification Print Date"; Rec."Verification Print Date")
                {
                    ToolTip = 'Specifies the value of the Verification Print Date field.';
                }
                field("Verification Type"; Rec."Verification Type")
                {
                    ToolTip = 'Specifies the value of the Verification Type field.';
                }
                field("Allocated Position"; Rec."Allocated Position")
                {
                    ToolTip = 'Specifies the value of the Allocated Position';
                }
                field("Date Received"; Rec."Date Received")
                {
                    ToolTip = 'Specifies the value of the Date Received field.';
                }
                field("Date Released"; Rec."Date Released")
                {
                    ToolTip = 'Specifies the value of the Date Released field.';
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ToolTip = 'Specifies the value of the Driver Name field.';
                }
                field("Driver ID"; Rec."Driver ID")
                {
                    ToolTip = 'Specifies the value of the Driver ID field.';
                }
                field(Vehicle; Rec.Vehicle)
                {
                    ToolTip = 'Specifies the value of the Vehicle field.';
                }
                field("Delivery Order No."; Rec."Delivery Order No.")
                {
                    ToolTip = 'Specifies the value of the Delivery Order No. field.';
                }
                field("Received By"; Rec."Received By")
                {
                    ToolTip = 'Specifies the value of the Received By field.';
                }
                field(Verified; Rec.Verified)
                {
                    ToolTip = 'Specifies the value of the Verified field.';
                }
                field("Verification Time"; Rec."Verification Time")
                {
                    ToolTip = 'Specifies the value of the Verification Time field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Final Destination"; Rec."Final Destination")
                {
                    ToolTip = 'Specifies the value of the Final Destination field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Custom Entry No."; Rec."Custom Entry No.")
                {
                    ToolTip = 'Specifies the value of the Custom Entry No. field.';
                }
                field(Received; Rec.Received)
                {
                    ToolTip = 'Specifies the value of the Received field.';
                }
                field("Received Time"; Rec."Received Time")
                {
                    ToolTip = 'Specifies the value of the Received Time field.';
                }
                field("Verification Notes"; Rec."Verification Notes")
                {
                    ToolTip = 'Specifies the value of the Verification Notes field.';
                }
                field(Released; Rec.Released)
                {
                    ToolTip = 'Specifies the value of the Released field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field("Consignee No."; Rec."Consignee No.")
                {
                    ToolTip = 'Specifies the value of the Consignee No. field.';
                }
                field("Job File Date"; Rec."Job File Date")
                {
                    ToolTip = 'Specifies the value of the Job File Date field.';
                }
                field("Discharge Date"; Rec."Discharge Date")
                {
                    ToolTip = 'Specifies the value of the Discharge Date field.';
                }
                field("Railed Date"; Rec."Railed Date")
                {
                    ToolTip = 'Specifies the value of the Railed Date field.';
                }
                field("SICD In-Date"; Rec."SICD In-Date")
                {
                    ToolTip = 'Specifies the value of the SICD In-Date field.';
                }
                field("Other remarks"; Rec."Other remarks")
                {
                    ToolTip = 'Specifies the value of the Other remarks field.';
                }
                field("Client Reference No."; Rec."Client Reference No.")
                {
                    ToolTip = 'Specifies the value of the Client Reference No. field.';
                }
                field("Invoicing Party No."; Rec."Invoicing Party No.")
                {
                    ToolTip = 'Specifies the value of the Invoicing Party No. field.';
                }
                field("Seal Locked?"; Rec."Seal Locked?")
                {
                    ToolTip = 'Specifies the value of the Seal Locked? field.';
                }
                field("Seal Tagged?"; Rec."Seal Tagged?")
                {
                    ToolTip = 'Specifies the value of the Seal Tagged? field.';
                }
                field("Lock No."; Rec."Lock No.")
                {
                    ToolTip = 'Specifies the value of the Lock No. field.';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                }
                field("Sales Quote No."; Rec."Sales Quote No.")
                {
                    ToolTip = 'Specifies the value of the Sales Quote No. field.';
                }
                field("Oppertunity No."; Rec."Oppertunity No.")
                {
                    ToolTip = 'Specifies the value of the  Oppertunity No. field.';
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 6 Code field.';
                }
                field("Stripping Date"; Rec."Stripping Date")
                {
                    ToolTip = 'Specifies the value of the Stripping Date field.';
                }
                field(Stripped; Rec.Stripped)
                {
                    ToolTip = 'Specifies the value of the Stripped field.';
                }
                field("Stripping Time"; Rec."Stripping Time")
                {
                    ToolTip = 'Specifies the value of the Stripping Time field.';
                }
                field("Stripping Notes"; Rec."Stripping Notes")
                {
                    ToolTip = 'Specifies the value of the Stripping Notes field.';
                }
                field("Parent Container ID"; Rec."Parent Container ID")
                {
                    ToolTip = 'Specifies the value of the Parent Container ID field.';
                }
                field("Empty Container"; Rec."Empty Container")
                {
                    ToolTip = 'Specifies the value of the Empty Container field.';
                }
                field("GP Delivery Order No."; Rec."GP Delivery Order No.")
                {
                    ToolTip = 'Specifies the value of the Delivery Order No. field.';
                }
                field("Landing Date"; Rec."Landing Date")
                {
                    ToolTip = 'Specifies the value of the Landing date field.';
                }
                field("Landing Time"; Rec."Landing Time")
                {
                    ToolTip = 'Specifies the value of the Landing Time field.';
                }
                field("Docs Received Date"; Rec."Docs Received Date")
                {
                    ToolTip = 'Specifies the value of the Docs Received Date field.';
                }
                field(Invoices; Rec.Invoices)
                {
                    ToolTip = 'Specifies the value of the Invoices field.';
                }
                field("Credit Memos"; Rec."Credit Memos")
                {
                    ToolTip = 'Specifies the value of the Credit Memos field.';
                }
                field("TBL/MH"; Rec."TBL/MH")
                {
                    ToolTip = 'Specifies the value of the TBL/MH field.';
                }
                field(Transporter; Rec.Transporter)
                {
                    ToolTip = 'Specifies the value of the Transporter field.';
                }
                field("Transporter Name"; Rec."Transporter Name")
                {
                    ToolTip = 'Specifies the value of the Transporter Name field.';
                }
                field("Container Status"; Rec."Container Status")
                {
                    ToolTip = 'Specifies the value of the Container Status field.';
                }
                field("KPA Charges Calculated"; Rec."KPA Charges Calculated")
                {
                    ToolTip = 'Specifies the value of the KPA Charges Calculated field.';
                }
                field("Shipping Agent"; Rec."Shipping Agent")
                {
                    ToolTip = 'Specifies the value of the Shipping Agent field.';
                }
                field("Shipping Agent Name"; Rec."Shipping Agent Name")
                {
                    ToolTip = 'Specifies the value of the Shipping Agent Name field.';
                }
                field("Vessel Name"; Rec."Vessel Name")
                {
                    ToolTip = 'Specifies the value of the Vessel Name field.';
                }
                field("Voyage No."; Rec."Voyage No.")
                {
                    ToolTip = 'Specifies the value of the Voyage No. field.';
                }
                field("Expected Arrival Date"; Rec."Expected Arrival Date")
                {
                    ToolTip = 'Specifies the value of the Expected Arrival Date field.';
                }
                field("Vessel Arrival Date"; Rec."Vessel Arrival Date")
                {
                    ToolTip = 'Specifies the value of the Vessel Arrival Date field.';
                }
                field("Last Sling Date"; Rec."Last Sling Date")
                {
                    ToolTip = 'Specifies the value of the Last Sling Date field.';
                }
                field("Vessel Arrival Time"; Rec."Vessel Arrival Time")
                {
                    ToolTip = 'Specifies the value of the Vessel Arrival Time field.';
                }
                field("No.Series"; Rec."No.Series")
                {
                    ToolTip = 'Specifies the value of the No.Series field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if UserId <> 'TECHBIZINFOTECH' then
        Error('You do not have permission to view this page');
    end;
}
