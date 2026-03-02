page 50112 "Manifest Line Subform"
{
    Caption = 'Manifest Line Subform';
    PageType = ListPart;
    SourceTable = "Manifest Line";
    DelayedInsert = true;
    AutoSplitKey = true;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Job File No."; Rec."Job File No.")
                {
                    ToolTip = 'Specifies the value of the Job File No. field.';
                    ApplicationArea = All;
                    Visible = true;
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                    Visible = true;
                    Editable = false;
                }
                field("Charge ID"; Rec."Charge ID")
                {
                    ToolTip = 'Specifies the value of the Charge ID field.';
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field(Manifested; Rec.Manifested)
                {
                    ToolTip = 'Specifies the value of the Manifested field.';
                    ApplicationArea = All;

                }
                field("Consignee No."; rec."Consignee No.")
                {
                    ApplicationArea = all;
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                    ToolTip = 'Specifies the value of the Consignee Name field.';
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Invoicing Party No."; rec."Invoicing Party No.")
                {
                    ApplicationArea = All;
                }

                field("Clearing Agent"; Rec."Clearing Agent")
                {
                    ToolTip = 'Specifies the value of the Clearing Agent field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    Editable = SPEditable;
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

                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Editable = ContainerEdit;
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

                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Unit Of Measure field.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        MarksEdiatable();
                        ParentEdiatable();
                    end;
                }
                field("Landing Date"; rec."Landing Date")
                {
                    ToolTip = 'Specifies the value of the Landing date field.';
                    ApplicationArea = All;
                    Editable = LandingEdit;
                }
                field("Landing Time"; rec."Landing Time")
                {
                    ToolTip = 'Specifies the value of the Landing Time field.';
                    ApplicationArea = All;
                    Editable = LandingEdit;
                }
                field(Marks; Rec.Marks)
                {
                    ToolTip = 'Specifies the value of the Marks field.';
                    ApplicationArea = All;
                    Editable = MarksEdit;
                }
                field("Parent Container ID"; Rec."Parent Container ID")
                {
                    ApplicationArea = All;
                    Editable = ParentEdit;

                    trigger onvalidate()
                    var
                        myInt: Integer;
                    begin

                    end;
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
                field("Container lock"; Rec."Container lock")
                {
                    ToolTip = 'Specifies the value of the Container lock field.';
                    ApplicationArea = All;
                    Editable = ContainerLockEdit;
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
                field("Allocated Position"; rec."Allocated Position")
                {
                    ToolTip = 'Specifies the value of the Allocated Position';
                    ApplicationArea = All;
                }
                field(Received; rec.Received)
                {
                    ApplicationArea = all;
                    Editable = ContainerEdit;
                }
                field("Received Time"; rec."Received Time")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("Date Received"; Rec."Date Received")
                {
                    ToolTip = 'Specifies the value of the Date Received field.';
                    ApplicationArea = All;
                    Editable = ContainerEdit;
                }
                field(Transporter; Rec.Transporter)
                {
                    ToolTip = 'Specifies the value of the Transporter field.';
                    ApplicationArea = All;
                    //Editable = false;
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
                field(Verified; rec.Verified)
                {
                    ApplicationArea = all;
                    Editable = ContainerEdit;
                }
                field("Verification Type"; Rec."Verification Type")
                {
                    ToolTip = 'Specifies the value of the Verification Type field.';
                    ApplicationArea = All;
                }
                field("Verification Print Date"; Rec."Verification Print Date")
                {
                    ToolTip = 'Specifies the value of the Verification Print Date field.';
                    ApplicationArea = All;
                    //Editable = false;
                    Visible = false;

                }
                field("Verification Time"; rec."Verification Time")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Verification Notes"; rec."Verification Notes")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Released; rec.Released)
                {
                    ApplicationArea = All;
                    Editable = ContainerEdit;
                }

                field("Date Released"; Rec."Date Released")
                {
                    ToolTip = 'Specifies the value of the Date Released field.';
                    ApplicationArea = All;
                    Editable = ContainerEdit;
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
                    Editable = false;
                }
                field("Custom Entry No."; rec."Custom Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Discharge Date"; rec."Discharge Date")
                {
                    ApplicationArea = All;
                }
                field("ICDN In-Date"; rec."ICDN In-Date")
                {
                    ApplicationArea = All;
                }
                field("Railed Date"; rec."Railed Date")
                {
                    ApplicationArea = All;
                }
                field("SICD In-Date"; rec."SICD In-Date")
                {
                    ApplicationArea = All;
                }
                field("Docs Received Date"; rec."Docs Received Date")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 6 Code"; rec."Shortcut Dimension 6 Code")
                {
                    ApplicationArea = All;
                }
                field("Sales Quote No."; rec."Sales Quote No.")
                {
                    ApplicationArea = All;
                    LookupPageId = "Sales Quotes";
                }
                field("Oppertunity No."; rec."Oppertunity No.")
                {
                    ApplicationArea = All;
                }
                field("Client Reference No."; rec."Client Reference No.")
                {
                    ApplicationArea = All;
                }
                field("Seal Tagged?"; rec."Seal Tagged?")
                {
                    ApplicationArea = All;
                }
                field("Seal Locked?"; rec."Seal Locked?")
                {
                    ApplicationArea = All;
                }
                field("Lock No."; rec."Lock No.")
                {
                    ApplicationArea = All;
                }
                field("Other remarks"; rec."Other remarks")
                {
                    ApplicationArea = All;
                }
                field(Stripped; Rec.Stripped)
                {
                    ApplicationArea = All;
                }
                field("Stripping Date"; Rec."Stripping Date")
                {
                    ApplicationArea = All;
                }
                field("Stripping Time"; Rec."Stripping Time")
                {
                    ApplicationArea = All;
                }
                field("Stripping Notes"; Rec."Stripping Notes")
                {
                    ApplicationArea = All;
                }

                field("User ID"; rec."User ID")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("KPA Charges Calculated"; rec."KPA Charges Calculated")
                {
                    ToolTip = 'Specifies the value of the KPA Charges Calculated field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    Var
        SPEditable, ContainerLockEdit, LandingEdit, ContainerEdit, ParentEdit, MarksEdit : Boolean;
    trigger onopenpage()
    var
        myInt: Integer;
    begin
        MarksEdiatable();
        ParentEdiatable();
        LandingEdiatable();
        //Rec.GetHeadDetails();
        ContainerEdiatable();
        SalesPersonEditable();
        ContainerLockEditable();
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        MarksEdiatable();
        SalesPersonEditable();
        LandingEdiatable();
        ContainerLockEditable();
        //Rec.GetHeadDetails();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        MarksEdiatable();
        ParentEdiatable();
        SalesPersonEditable();
        LandingEdiatable();
        ContainerLockEditable();
        //Rec.GetHeadDetails();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        MarksEdiatable;
        ParentEdiatable();
        SalesPersonEditable();
        LandingEdiatable();
        ContainerLockEditable();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Error('You can not Create new records Manually. Please use Import Worksheet to create the Manifest Lines');
        CurrPage.Update(false);
    end;

    local procedure MarksEdiatable()
    var
        myInt: Integer;
    begin
        IF Rec."Shortcut Dimension 4 Code" = 'LOOSE' then
            MarksEdit := true
        else
            MarksEdit := false;
        //CurrPage.Update(false);
    end;

    local procedure ParentEdiatable()
    begin
        IF (Rec."Shortcut Dimension 4 Code" = 'UNIT') OR (Rec."Shortcut Dimension 4 Code" = 'LOOSE') or (Rec."Shortcut Dimension 4 Code" = 'STRIPPED UNIT') then
            ParentEdit := true
        else
            ParentEdit := false;
        //CurrPage.Update(false);
    end;

    local procedure LandingEdiatable()
    begin
        IF rec."Container Type" = rec."Container Type"::Reefer then
            LandingEdit := true
        else
            LandingEdit := false;
        //CurrPage.Update(false);
    end;

    local procedure ContainerEdiatable()
    begin
        if (UserId = 'GROUP.AUDIT') or (UserId = 'TECHBIZINFOTECH') then
            ContainerEdit := true
        else
            ContainerEdit := false;
        //CurrPage.Update(false);
    end;

    local procedure ContainerLockEditable()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.get(UserId);
        if UserSetup."Container lock Edit" then
            ContainerLockEdit := true
        else
            ContainerLockEdit := false;
        //CurrPage.Update(false);
    end;

    procedure SalesPersonEditable()
    var
        Usersetup: Record "User Setup";
    begin
        UserSetup.get(UserId);
        if not UserSetup."Sales Person Edit" then
            SPEditable := false
        else
            SPEditable := true;
    end;
}
