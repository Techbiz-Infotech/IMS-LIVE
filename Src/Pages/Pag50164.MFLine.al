page 50164 MFLine
{
    ApplicationArea = All;
    Caption = 'MFLine';
    PageType = List;
    SourceTable = "Manifest Line";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Allocated Position"; Rec."Allocated Position")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Allocated Position';
                }
                field("BL No."; Rec."BL No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BL No. field.';
                }
                field("CBM Tonage"; Rec."CBM Tonage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CBM Tonage field.';
                }
                field("CBM-Wt Difference"; Rec."CBM-Wt Difference")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CBM-Wt Difference field.';
                }
                field("Charge ID"; Rec."Charge ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Charge ID field.';
                }
                field("Clearing Agent"; Rec."Clearing Agent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Clearing Agent field.';
                }
                field("Client Reference No."; Rec."Client Reference No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Client Reference No. field.';
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consignee Name field.';
                }
                field("Consignee No."; Rec."Consignee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consignee No. field.';
                }
                field("Container Type"; Rec."Container Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Container Type field.';
                }
                field("Container lock"; Rec."Container lock")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Container lock field.';
                }
                field("Container/Chassis No."; Rec."Container/Chassis No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Container/Chassis No. field.';
                }
                field("Credit Memos"; Rec."Credit Memos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Credit Memos field.';
                }
                field("Custom Entry No."; Rec."Custom Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Custom Entry No. field.';
                }
                field("Customs Seal No."; Rec."Customs Seal No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customs Seal No. field.';
                }
                field("Date Received"; Rec."Date Received")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Received field.';
                }
                field("Date Released"; Rec."Date Released")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Released field.';
                }
                field("Delivery Order No."; Rec."Delivery Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Delivery Order No. field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Destination Type"; Rec."Destination Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Destination Type field.';
                }
                field("Discharge Date"; Rec."Discharge Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Discharge Date field.';
                }
                field("Docs Received Date"; Rec."Docs Received Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Docs Received Date field.';
                }
                field("Driver ID"; Rec."Driver ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Driver ID field.';
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Driver Name field.';
                }
                field("Empty Container"; Rec."Empty Container")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Empty Container field.';
                }
                field("Final Destination"; Rec."Final Destination")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Final Destination field.';
                }
                field("GP Delivery Order No."; Rec."GP Delivery Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Delivery Order No. field.';
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
                field("ICDN In-Date"; Rec."ICDN In-Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ICDN In-Date field.';
                }
                field(Invoices; Rec.Invoices)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invoices field.';
                }
                field("Invoicing Party No."; Rec."Invoicing Party No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invoicing Party No. field.';
                }
                field("Job File Date"; Rec."Job File Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job File Date field.';
                }
                field("Job File No."; Rec."Job File No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job File No. field.';
                }
                field("Landing Date"; Rec."Landing Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Landing Date field.';
                }
                field("Landing Time"; Rec."Landing Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Landing Time field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Lock No."; Rec."Lock No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lock No. field.';
                }
                field(Manifested; Rec.Manifested)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Manifested field.';
                }
                field(Marks; Rec.Marks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Marks field.';
                }
                field("No. of Bags"; Rec."No. of Bags")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Bags field.';
                }
                field("No. of Bags Released"; Rec."No. of Bags Released")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Bags Released field.';
                }
                field("Oppertunity No."; Rec."Oppertunity No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the  Oppertunity No. field.';
                }
                field("Other remarks"; Rec."Other remarks")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Other remarks field.';
                }
                field("Parent Container ID"; Rec."Parent Container ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Parent Container ID field.';
                }
                field("Port of Discharge"; Rec."Port of Discharge")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Port of Discharge field.';
                }
                field("Port of Shipment"; Rec."Port of Shipment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Port of Shipment field.';
                }
                field("Railed Date"; Rec."Railed Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Railed Date field.';
                }
                field(Received; Rec.Received)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Received field.';
                }
                field("Received By"; Rec."Received By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Received By field.';
                }
                field("Shipping Agent"; rec."Shipping Agent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipping Agent field.';
                }
                field("Received Time"; Rec."Received Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Received Time field.';
                }
                field(Released; Rec.Released)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Released field.';
                }
                field("Remaining Bags"; Rec."Remaining Bags")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remaining Bags field.';
                }
                field("SICD In-Date"; Rec."SICD In-Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SICD In-Date field.';
                }
                field("Sales Quote No."; Rec."Sales Quote No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Quote No. field.';
                }
                field("Seal Locked?"; Rec."Seal Locked?")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seal Locked? field.';
                }
                field("Seal Tagged?"; Rec."Seal Tagged?")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seal Tagged? field.';
                }
                field("Seal/Engine No."; Rec."Seal/Engine No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seal/Engine No. field.';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Of Measure field.';
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Container Size field.';
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 6 Code field.';
                }
                field(Stripped; Rec.Stripped)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stripped field.';
                }
                field("Stripping Date"; Rec."Stripping Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stripping Date field.';
                }
                field("Stripping Notes"; Rec."Stripping Notes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stripping Notes field.';
                }
                field("Stripping Time"; Rec."Stripping Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stripping Time field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
                field("TBL/MH"; Rec."TBL/MH")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TBL/MH field.';
                }
                field(Transporter; Rec.Transporter)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transporter field.';
                }
                field("Transporter Name"; Rec."Transporter Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transporter Name field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Vehicle; Rec.Vehicle)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle field.';
                }
                field("Verification Notes"; Rec."Verification Notes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Verification Notes field.';
                }
                field("Verification Print Date"; Rec."Verification Print Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Verification Print Date field.';
                }
                field("Verification Time"; Rec."Verification Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Verification Time field.';
                }
                field("Verification Type"; Rec."Verification Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Verification Type field.';
                }
                field(Verified; Rec.Verified)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Verified field.';
                }
                field(Weight; Rec.Weight)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Weight field.';
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if UserId <> 'TECHBIZINFOTECH' then
            Error('You do not have permission to view this');
    end;
}
