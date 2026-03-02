page 50169 "Manifest Line Details"
{
    Caption = 'Manifest Line Details';
    PageType = Card;
    SourceTable = "Manifest Line";
    //Editable = false;
    InsertAllowed = false;
    //DeleteAllowed = false;
    //ApplicationArea = all;
    //UsageCategory = History;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Job File No."; Rec."Job File No.")
                {
                    ToolTip = 'Specifies the value of the Job File No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                    Editable = false;
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
                    Editable = CanEditManifested;
                }
                field("Container lock"; Rec."Container lock")
                {
                    ToolTip = 'Specifies the value of the Container lock field.';
                    ApplicationArea = All;
                    Editable = CanEditContainerLock;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                    Editable = CanEditDESCRIPTION;
                }
                field("Port of Shipment"; Rec."Port of Shipment")
                {
                    ToolTip = 'Specifies the value of the Port of Shipment field.';
                    ApplicationArea = All;
                    Editable = CanEditPORTOFSHIPMENT;
                }
                field("Port of Discharge"; Rec."Port of Discharge")
                {
                    ToolTip = 'Specifies the value of the Port of Discharge field.';
                    ApplicationArea = All;
                    Editable = CanEditPORTOFDISCHARGE;
                }
                field("Destination Type"; Rec."Destination Type")
                {
                    ToolTip = 'Specifies the value of the Destination Type field.';
                    ApplicationArea = All;
                    Editable = CanEditDESTINATION;
                }
                field("Final Destination"; Rec."Final Destination")
                {
                    ToolTip = 'Specifies the value of the Final Destination field.';
                    ApplicationArea = All;
                    Editable = CanEditFINALDESTINATION;
                }
                field("Consignee No."; Rec."Consignee No.")
                {
                    ToolTip = 'Specifies the value of the Consignee No. field.';
                    ApplicationArea = All;
                    Editable = CanEditCONSIGNEENO;
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                    ToolTip = 'Specifies the value of the Consignee Name field.';
                    ApplicationArea = All;
                    Editable = CanEditCONSIGNEENO;
                }
                field("Clearing Agent"; Rec."Clearing Agent")
                {
                    ToolTip = 'Specifies the value of the Clearing Agent field.';
                    ApplicationArea = All;
                    Editable = CanEditCLEARINGAGENT;
                }
                field("Invoicing Party No."; Rec."Invoicing Party No.")
                {
                    ToolTip = 'Specifies the value of the Invoicing Party No. field.';
                    ApplicationArea = All;
                    Editable = CanEditINVOICINGPARTY;
                }
                field("Allocated Position"; Rec."Allocated Position")
                {
                    ToolTip = 'Specifies the value of the Allocated Position';
                    ApplicationArea = All;
                }
                field("Job File Date"; Rec."Job File Date")
                {
                    ToolTip = 'Specifies the value of the Job File Date field.';
                    ApplicationArea = All;
                }
            }
            group("Container Details")
            {
                field("BL No."; Rec."BL No.")
                {
                    ToolTip = 'Specifies the value of the BL No. field.';
                    ApplicationArea = All;
                    Editable = CanEditBLNO;
                }
                field("Container/Chassis No."; Rec."Container/Chassis No.")
                {
                    ToolTip = 'Specifies the value of the Container/Chassis No. field.';
                    ApplicationArea = All;
                    Editable = caneditContainerChassisNo;
                }
                field("Seal/Engine No."; Rec."Seal/Engine No.")
                {
                    ToolTip = 'Specifies the value of the Seal/Engine No. field.';
                    ApplicationArea = All;
                    Editable = CanEditSEAL;
                }
                field("Customs Seal No."; Rec."Customs Seal No.")
                {
                    ToolTip = 'Specifies the value of the Customs Seal No. field.';
                    ApplicationArea = All;
                    Editable = CanEditSEAL;
                }
                field(Marks; Rec.Marks)
                {
                    ToolTip = 'Specifies the value of the Marks field.';
                    ApplicationArea = All;
                    Editable = CanEditMarks;

                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Unit Of Measure field.';
                    ApplicationArea = All;
                    Editable = CanEditCARGOTYPE;
                }
                field("Container Type"; Rec."Container Type")
                {
                    ToolTip = 'Specifies the value of the Container Type field.';
                    ApplicationArea = All;
                    Editable = CanEditCONTAINERTYPE;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the value of the Container Size field.';
                    ApplicationArea = All;
                    Editable = CanEditCONTAINERSIZE;
                }
                field("CBM Tonage"; Rec."CBM Tonage")
                {
                    ToolTip = 'Specifies the value of the CBM Tonage field.';
                    ApplicationArea = All;
                    Editable = CanEditCBMTONAGE;
                }
                field(Weight; Rec.Weight)
                {
                    ToolTip = 'Specifies the value of the Weight field.';
                    ApplicationArea = All;
                    Editable = CanEditWEIGHT;
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
                    Editable = CanEditNoofBags;
                }
                field("Shipping Agent Name"; Rec."Shipping Agent Name")
                {
                    ToolTip = 'Specifies the value of the Shipping Agent Name field.';
                    ApplicationArea = All;
                }
                field("Vessel Name"; Rec."Vessel Name")
                {
                    ToolTip = 'Specifies the value of the Vessel Name field.';
                    ApplicationArea = All;
                    Editable = CanEditVesselName;
                }
                field("Voyage No."; Rec."Voyage No.")
                {
                    ToolTip = 'Specifies the value of the Voyage No. field.';
                    ApplicationArea = All;
                    Editable = CanEditVoyageNo;
                }
                field("Expected Arrival Date"; Rec."Expected Arrival Date")
                {
                    ToolTip = 'Specifies the value of the Expected Arrival Date field.';
                    ApplicationArea = All;
                    Editable = CanEditExpectedArrivalDate;
                }
                field("Vessel Arrival Date"; Rec."Vessel Arrival Date")
                {
                    ToolTip = 'Specifies the value of the Vessel Arrival Date field.';
                    ApplicationArea = All;
                    Editable = CanEditVesselArrivalDate;
                }
                field("Last Sling Date"; Rec."Last Sling Date")
                {
                    ToolTip = 'Specifies the value of the Last Sling Date field.';
                    ApplicationArea = All;
                    Editable = CanEditLastSlingDate;
                }
                field("Vessel Arrival Time"; Rec."Vessel Arrival Time")
                {
                    ToolTip = 'Specifies the value of the Vessel Arrival Time field.';
                    ApplicationArea = All;
                    Editable = CanEditVesselArrivalTime;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                    ApplicationArea = All;
                    Editable = FALSE;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                    ApplicationArea = All;
                    Editable = caneditglobaldimension2code;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                    ApplicationArea = All;
                    Editable = CanEditSALESPERSON;
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 6 Code field.';
                    ApplicationArea = All;
                    Editable = caneditglobaldimension6code;
                }
            }
            group(Receiving)
            {
                field("Date Received"; Rec."Date Received")
                {
                    ToolTip = 'Specifies the value of the Date Received field.';
                    ApplicationArea = All;
                    Editable = CanEditDateReceived;
                }
                field("Landing Date"; Rec."Landing Date")
                {
                    ToolTip = 'Specifies the value of the Landing Date field.';
                    ApplicationArea = All;
                    Editable = CanEditLANDINGDATE;
                }
                field("Landing Time"; Rec."Landing Time")
                {
                    ToolTip = 'Specifies the value of the Landing Time field.';
                    ApplicationArea = All;
                    Editable = CanEditLANDINGTIME;
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
                field(Received; Rec.Received)
                {
                    ToolTip = 'Specifies the value of the Received field.';
                    ApplicationArea = All;
                    Editable = CanEditReceivedBool;
                }
                field("Received Time"; Rec."Received Time")
                {
                    ToolTip = 'Specifies the value of the Received Time field.';
                    ApplicationArea = All;
                    Editable = CanEditReceivedTime;
                }
            }
            group(Verification)
            {
                field("Verification Print Date"; Rec."Verification Print Date")
                {
                    ToolTip = 'Specifies the value of the Verification Print Date field.';
                    ApplicationArea = All;
                    Editable = CanEditVerified;
                }
                field("Verification Type"; Rec."Verification Type")
                {
                    ToolTip = 'Specifies the value of the Verification Type field.';
                    ApplicationArea = All;

                }
                field(Verified; Rec.Verified)
                {
                    ToolTip = 'Specifies the value of the Verified field.';
                    Editable = CanEditVerified;
                    ApplicationArea = All;
                }
                field("Verification Time"; Rec."Verification Time")
                {
                    ToolTip = 'Specifies the value of the Verification Time field.';
                    ApplicationArea = All;

                }
                field("Verification Notes"; Rec."Verification Notes")
                {
                    ToolTip = 'Specifies the value of the Verification Notes field.';
                    Editable = CanEditVerified;
                    ApplicationArea = All;
                }
            }
            group(Releasing)
            {
                field("No. of Bags Released"; Rec."No. of Bags Released")
                {
                    ToolTip = 'Specifies the value of the No. of Bags Released field.';
                    ApplicationArea = All;
                }
                field("Remaining Bags"; Rec."Remaining Bags")
                {
                    ToolTip = 'Specifies the value of the Remaining Bags field.';
                    ApplicationArea = All;
                    Editable = CanEditRemainingBags;
                }
                field("Date Released"; Rec."Date Released")
                {
                    ToolTip = 'Specifies the value of the Date Released field.';
                    ApplicationArea = All;
                    Editable = CanEditDateReleased;
                }
                field("Custom Entry No."; Rec."Custom Entry No.")
                {
                    ToolTip = 'Specifies the value of the Custom Entry No. field.';
                    ApplicationArea = All;
                }
                field(Released; Rec.Released)
                {
                    ToolTip = 'Specifies the value of the Released field.';
                    ApplicationArea = All;
                    Editable = CanEditReleasedBool;
                }
                field("GP Delivery Order No."; Rec."GP Delivery Order No.")
                {
                    ToolTip = 'Specifies the value of the Delivery Order No. field.';
                    ApplicationArea = All;
                }
                field("KPA Charges Calculated"; rec."KPA Charges Calculated")
                {
                    ToolTip = 'Specifies the value of the KPA Charges Calculated field.';
                    ApplicationArea = All;
                }
            }
            group(Stripping)
            {
                field("Stripping Date"; Rec."Stripping Date")
                {
                    ToolTip = 'Specifies the value of the Stripping Date field.';
                    ApplicationArea = All;
                    Editable = CanEditStrippingDate;
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
                    Editable = CanEditStrippingNotes;
                }
                field("Parent Container ID"; Rec."Parent Container ID")
                {
                    ToolTip = 'Specifies the value of the Parent Container ID field.';
                    ApplicationArea = All;
                    Editable = CanEditParentContainerID;

                }
                field("Empty Container"; Rec."Empty Container")
                {
                    ToolTip = 'Specifies the value of the Empty Container field.';
                    ApplicationArea = All;
                    Editable = CanEditEmptyContainer;
                }
            }
            group(Others)
            {
                field("ICDN In-Date"; Rec."ICDN In-Date")
                {
                    ToolTip = 'Specifies the value of the ICDN In-Date field.';
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
                    Editable = CanEditOTHERREMARKS;
                }
                field("Client Reference No."; Rec."Client Reference No.")
                {
                    ToolTip = 'Specifies the value of the Client Reference No. field.';
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
                field("Docs Received Date"; Rec."Docs Received Date")
                {
                    ToolTip = 'Specifies the value of the Docs Received Date field.';
                    ApplicationArea = All;
                    Visible = false;
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
                field("TBL/MH"; Rec."TBL/MH")
                {
                    ToolTip = 'Specifies the value of the TBL/MH field.';
                    ApplicationArea = All;
                }
                field("Container Status"; Rec."Container Status")
                {
                    ToolTip = 'Specifies the value of the Container Status field.';
                    ApplicationArea = All;
                }
                field("Shipping Agent"; Rec."Shipping Agent")
                {
                    ToolTip = 'Specifies the value of the Shipping Agent field.';
                    ApplicationArea = All;
                    Editable = caneditShippingAgent;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(SystemCreatedBy; GetUserNameFromSecurityId(Rec.SystemCreatedBy))
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                    Visible = false;
                    Caption = 'Created By';
                    ApplicationArea = All;
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                    Visible = false;
                    ApplicationArea = All;
                }
                field(SystemModifiedBy; GetUserNameFromSecurityId(Rec.SystemModifiedBy))
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                    ApplicationArea = All;
                    Caption = 'Modified By';
                    Visible = false;
                }
            }
        }
    }
    var
        caneditContainerChassisNo, caneditShippingAgent, caneditglobaldimension6code, caneditglobaldimension2code,
    CanEditBLNO, CanEditCONSIGNEENO, CanEditINVOICINGPARTY, CanEditCLEARINGAGENT, CanEditSALESPERSON,
    CanEditSEAL, CanEditCARGOTYPE, CanEditLANDINGDATE, CanEditLANDINGTIME, CanEditCONTAINERTYPE,
    CanEditCONTAINERSIZE, CanEditDESCRIPTION, CanEditCBMTONAGE, CanEditWEIGHT,
    CanEditPORTOFSHIPMENT, CanEditPORTOFDISCHARGE, CanEditDESTINATION, CanEditFINALDESTINATION,
    CanEditOTHERREMARKS, CanEditManifested, CanEditContainerLock, CanEditSealEngineNo, CanEditMarks,
    CanEditNoofBags, CanEditVesselName, CanEditVoyageNo, CanEditExpectedArrivalDate, CanEditVesselArrivalDate,
    CanEditLastSlingDate, CanEditVesselArrivalTime, CanEditDateReceived, CanEditReceivedBool, CanEditReceivedTime,
    CanEditVerified, CanEditReleasedBool, CanEditDateReleased, CanEditRemainingBags, CanEditStrippingDate,
    CanEditSrippedBool, CanEditStrippingNotes, CanEditParentContainerID, CanEditEmptyContainer : Boolean;
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        CanMFFieldsEditable();
    end;

    trigger OnDeleteRecord(): Boolean
    var
        myInt: Integer;
    begin
        IF (UserId <> 'GROUP.AUDIT') and (UserId <> 'TECHBIZINFOTECH') then
            error('You are not Authorized to delete the record. Please contact Group Audit');
    end;

    procedure GetUserNameFromSecurityId(UserSecurityID: Guid): Code[50]
    var
        User: Record User;
    begin
        User.Get(UserSecurityID);
        exit(User."User Name");
    end;

    procedure CanEditField(FieldName: Integer): Boolean
    var
        Helper: Codeunit "Field Permission Helper";
    begin
        if UserId <> 'GROUP.AUDIT' then
            exit(Helper.CanUserEditField(UserId(), Page::"Manifests New", Database::"Manifest Line", FieldName))
        else
            exit(true);
    end;

    procedure CanMFFieldsEditable()
    var
        myInt: Integer;
    begin
        caneditContainerChassisNo := CanEditField(Rec.FieldNo("Container/Chassis No."));
        caneditShippingAgent := CanEditField(Rec.FieldNo("Shipping Agent"));
        CanEditBLNO := CanEditField(Rec.FieldNo("BL No."));
        caneditglobaldimension2code := CanEditField(Rec.FieldNo("Global Dimension 2 Code"));
        caneditglobaldimension6code := CanEditField(Rec.FieldNo("Shortcut Dimension 6 Code"));
        CanEditCONSIGNEENO := CanEditField(Rec.FieldNo("Consignee No."));
        CanEditINVOICINGPARTY := CanEditField(Rec.FieldNo("Invoicing Party No."));
        CanEditCLEARINGAGENT := CanEditField(Rec.FieldNo("Clearing Agent"));
        CanEditSALESPERSON := CanEditField(Rec.FieldNo("Shortcut Dimension 3 Code"));
        CanEditSEAL := CanEditField(Rec.FieldNo("Customs Seal No."));
        CanEditCARGOTYPE := CanEditField(Rec.FieldNo("Shortcut Dimension 4 Code"));
        CanEditLANDINGDATE := CanEditField(Rec.FieldNo("Landing Date"));
        CanEditLANDINGTIME := CanEditField(Rec.FieldNo("Landing Time"));
        CanEditCONTAINERTYPE := CanEditField(Rec.FieldNo("Container Type"));
        CanEditCONTAINERSIZE := CanEditField(Rec.FieldNo("Shortcut Dimension 5 Code"));
        CanEditCONTAINERLOCK := CanEditField(Rec.FieldNo("Container lock"));
        CanEditDESCRIPTION := CanEditField(Rec.FieldNo(Description));
        CanEditCBMTONAGE := CanEditField(Rec.FieldNo("CBM Tonage"));
        CanEditWEIGHT := CanEditField(Rec.FieldNo(Weight));
        CanEditPORTOFSHIPMENT := CanEditField(Rec.FieldNo("Port of Shipment"));
        CanEditPORTOFDISCHARGE := CanEditField(Rec.FieldNo("Port of Discharge"));
        CanEditDESTINATION := CanEditField(Rec.FieldNo("Destination Type"));
        CanEditFINALDESTINATION := CanEditField(Rec.FieldNo("Final Destination"));
        CanEditOTHERREMARKS := CanEditField(Rec.FieldNo("Other remarks"));
        CanEditManifested := CanEditField(Rec.FieldNo(Manifested));
        CanEditContainerLock := CanEditField(Rec.FieldNo("Container lock"));
        CanEditSealEngineNo := CanEditField(Rec.FieldNo("Seal/Engine No."));
        CanEditMarks := CanEditField(Rec.FieldNo(Marks));
        CanEditNoofBags := CanEditField(Rec.FieldNo("No. of Bags"));
        CanEditVesselName := CanEditField(Rec.FieldNo("Vessel Name"));
        CanEditVoyageNo := CanEditField(Rec.FieldNo("Voyage No."));
        CanEditExpectedArrivalDate := CanEditField(Rec.FieldNo("Expected Arrival Date"));
        CanEditVesselArrivalDate := CanEditField(Rec.FieldNo("Vessel Arrival Date"));
        CanEditLastSlingDate := CanEditField(Rec.FieldNo("Last Sling Date"));
        CanEditVesselArrivalTime := CanEditField(Rec.FieldNo("Vessel Arrival Time"));
        CanEditDateReceived := CanEditField(Rec.FieldNo("Date Received"));
        CanEditReceivedBool := CanEditField(Rec.FieldNo(Received));
        CanEditReceivedTime := CanEditField(Rec.FieldNo("Received Time"));
        CanEditVerified := CanEditField(Rec.FieldNo(Verified));
        CanEditReleasedBool := CanEditField(Rec.FieldNo(Released));
        CanEditDateReleased := CanEditField(Rec.FieldNo("Date Released"));
        CanEditRemainingBags := CanEditField(Rec.FieldNo("Remaining Bags"));
        CanEditStrippingDate := CanEditField(Rec.FieldNo("Stripping Date"));
        CanEditSrippedBool := CanEditField(Rec.FieldNo(Stripped));
        CanEditStrippingNotes := CanEditField(Rec.FieldNo("Stripping Notes"));
        CanEditParentContainerID := CanEditField(Rec.FieldNo("Parent Container ID"));
        CanEditEmptyContainer := CanEditField(Rec.FieldNo("Empty Container"));
    end;
}
