page 50147 "Receiving Journal"
{
    Caption = 'Receiving Journals';
    PageType = Worksheet;
    SourceTable = "Receiving Journal";
    ApplicationArea = all;
    UsageCategory = Lists;
    AutoSplitKey = true;
    DelayedInsert = true;
    layout
    {
        area(content)
        {
            group(Receiving)
            {
                field(ContainerNo; ContainerNo)
                {
                    Caption = 'Container ID';
                    ApplicationArea = all;
                    TableRelation = "Manifest Line";
                    Lookup = true;
                    trigger OnLookup(var text: text): Boolean
                    var
                        ManiLine: Record "Manifest Line";
                    begin

                        ManiLine.Reset();
                        ManiLine.SetRange("Container lock", false);
                        ManiLine.SetRange(Received, false);
                        ManiLine.SetRange(Manifested, true);
                        ManiLine.SetRange(Verified, false);
                        ManiLine.SetRange(Released, false);
                        if page.RunModal(50140, ManiLine) = Action::LookupOK then begin
                            ContainerNo := ManiLine."Global Dimension 1 Code";
                            GetManifestLineInfo();
                            CurrPage.Update(false);
                        end;
                    end;
                }
            }
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
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
                field("Container No./Chassis No."; rec."Container No./Chassis No.")
                {
                    ToolTip = 'Specifies the value of the Container No. field.';
                    ApplicationArea = All;
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
                    trigger OnValidate()
                    var
                    begin
                        rec."Time In" := Time;
                        rec."Received Date" := today();
                    end;
                }
                field("Received Date"; Rec."Received Date")
                {
                    ToolTip = 'Specifies the value of the Received Date field.';
                    ApplicationArea = All;
                    //Editable = false;
                }
                field("Time In"; Rec."Time In")
                {
                    ToolTip = 'Specifies the value of the Time In field.';
                    ApplicationArea = All;
                    //Editable = false;
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
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                    ApplicationArea = All;
                }

                field("Manifest Line No."; Rec."Manifest Line No.")
                {
                    ToolTip = 'Specifies the value of the Manifest Line No. field.';
                    ApplicationArea = All;
                }
                field("Received By"; Rec."Received By")
                {
                    ToolTip = 'Specifies the value of the Received By field.';
                    ApplicationArea = All;
                }
                field("Seal No. 1"; Rec."Seal No. 1")
                {
                    ApplicationArea = All;
                }
                field("Seal No. 2"; Rec."Seal No. 2")
                {
                    ApplicationArea = All;
                }
                field("User ID"; rec."User ID")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Position; rec.Position)
                {
                    ToolTip = 'Specifies the value of the Position field.';
                    ApplicationArea = All;
                }

            }
        }
        // area(FactBoxes)
        // {
        //     part(control11; "Receiving Container Picture")
        //     {
        //         ApplicationArea = all;
        //         //SubPageLink = "Line No." = FIELD("Line No.");
        //         //Visible = NOT IsOfficeAddin;

        //     }
        // }
    }
    actions
    {
        area(Navigation)
        {
            // action("Additional Charges")
            // {
            //     Caption = 'Additional Charges';
            //     ApplicationArea = All;
            //     RunObject = page "Additional Charges - Receiving";
            //     RunPageLink = "Container ID" = field("Global Dimension 1 Code");
            //     trigger OnAction()
            //     var
            //     begin

            //     end;
            // }
            action(Receive)
            {
                ApplicationArea = all;
                caption = 'Receive & Print';
                trigger OnAction()
                var
                    ImsSetupRec: Record "IMS Setup";
                begin
                    rec.TestField("DO No.");
                    rec.TestField("Driver ID");
                    rec.TestField("Driver Name");
                    rec.TestField(Vehicle);
                    rec.TestField("Vehicle Type");
                    rec.TestField("Time In");
                    rec.TestField("Received By");
                    rec.TestField(Recieived);
                    rec.TestField("Received Date");
                    rec.TestField("Manifest Line No.");
                    ImsSetupRec.Get();
                    if ImsSetupRec.Position = true then
                        Rec.TestField(Position);
                    IF Confirm('Do you want to Receive and Print?', true) then begin
                        UpdatePosition;
                        UpdateManifestLineInfo();
                        InsertLog();
                        UpdateContainer();
                        Commit();
                        ReceivingLog.Reset();
                        ReceivingLog.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                        IF ReceivingLog.FindFirst() then
                            report.RunModal(report::"Receiving Log", true, true, ReceivingLog);
                        rec.DeleteAll();
                    end else
                        exit;

                end;
            }
        }
    }

    var
        ContainerNo: code[20];
        ReceivingLog: Record ReceivingLog;
        //ManiHead: Record "Manifest Header";

    procedure GetManifestLineInfo()
    var
        receRec1: Record "Receiving Journal";
        ManifestLineRec: Record "Manifest Line";

        LineNo: Integer;
    begin
        rec.DeleteAll();
        ManifestLineRec.Reset();
        ManifestLineRec.SetRange(ManifestLineRec."Global Dimension 1 Code", ContainerNo);
        ManifestLineRec.SetRange("Container lock", false);
        ManifestLineRec.SetRange(Verified, false);
        ManifestLineRec.SetRange(ManifestLineRec.Manifested, true);
        ManifestLineRec.SetRange(Received, false);
        ManifestLineRec.SetRange(Released, false);
        if ManifestLineRec.FindFirst() then begin
            LineNo := 10000;
            repeat
                rec.Init();
                rec."Line No." := LineNo;
                Rec.Insert();
                rec.validate("BL No.", ManifestLineRec."BL No.");
                rec.validate("Container No./Chassis No.", ManifestLineRec."Container/Chassis No.");
                rec."Container Type" := ManifestLineRec."Container Type";
                rec.validate("Shortcut Dimension 5 Code", ManifestLineRec."Shortcut Dimension 5 Code");
                rec.validate(Description, ManifestLineRec.Description);
                rec.validate("Job File No.", ManifestLineRec."Job File No.");
                rec.validate("Manifest Line No.", ManifestLineRec."Line No.");
                rec.Validate("Global Dimension 1 Code", ManifestLineRec."Global Dimension 1 Code");
                rec.Modify;
                LineNo += 10000;
            until ManifestLineRec.next = 0;
        end;
        rec.Reset();
        CurrPage.Update();
    end;

    procedure UpdateManifestLineInfo()
    var
        ReceiveRec: record "Receiving Journal";
        ManifestLineRec: Record "Manifest Line";
    begin
        ReceiveRec.Reset;
        ReceiveRec.SetRange(Recieived, true);
        IF ReceiveRec.findfirst then
            repeat
                ManifestLineRec.Reset();
                ManifestLineRec.SetRange("Job File No.", Rec."Job File No.");
                ManifestLineRec.setrange("Line No.", ReceiveRec."Manifest Line No.");
                if ManifestLineRec.FindFirst() then begin
                    ManifestLineRec.Validate(Vehicle, ReceiveRec.Vehicle);
                    ManifestLineRec.Validate("Driver ID", ReceiveRec."Driver ID");
                    ManifestLineRec.Validate("Driver Name", ReceiveRec."Driver Name");
                    ManifestLineRec.Validate("Delivery Order No.", ReceiveRec."DO No.");
                    ManifestLineRec.Validate("Allocated Position", ReceiveRec.Position);
                    ManifestLineRec.Validate("Received By", ReceiveRec."Received By");
                    ManifestLineRec.Validate("Date Received", ReceiveRec."Received Date");
                    ManifestLineRec.Received := true;
                    ManifestLineRec.validate("Received Time", ReceiveRec."Time In");
                    //ManifestLineRec.validate(Transporter,ReceiveRec.Transporter);
                    ManifestLineRec.Modify;
                end;
            until ReceiveRec.next = 0;
        CurrPage.update();
    end;

    procedure UpdateContainer()
    var
        DimValRec: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.get();
        DimValRec.Reset();
        DimValRec.setrange("Dimension Code", GLSetup."Global Dimension 1 Code");
        DimValRec.SetRange(code, rec."Global Dimension 1 Code");
        if DimValRec.FindFirst() then begin
            DimValRec."Container Status" := DimValRec."Container Status"::"In Stock";
            DimValRec.Modify();
        end;
    end;

    procedure InsertLog()
    var
        ReceiveJourRec: Record "Receiving Journal";
        ReceiveLogRec: Record ReceivingLog;
        ReceiveLogRec2: Record ReceivingLog;
        AdditionalCharges: Record "Additional Charges - Receiving";
        PostedAdditionalCharges: Record "Posted Add. Charges receiving";
        EntryNo: Integer;
    begin
        ReceiveLogRec2.reset;
        IF ReceiveLogRec2.FindLast() then
            EntryNo := ReceiveLogRec2."Entry No." + 1
        else
            EntryNo := 1;
        ReceiveJourRec := Rec;
        ReceiveJourRec.Reset();
        ReceiveJourRec.SetRange(Recieived, true);
        IF ReceiveJourRec.Findfirst then
            repeat
                ReceiveLogRec.init;
                ReceiveLogRec."Entry No." := EntryNo;
                ReceiveLogRec.validate("Line No.", ReceiveJourRec."Line No.");
                ReceiveLogRec.validate("Job File No.", ReceiveJourRec."Job File No.");
                ReceiveLogRec.validate("BL No.", ReceiveJourRec."BL No.");
                ReceiveLogRec.Validate("Container No./Chassis No.", ReceiveJourRec."Container No./Chassis No.");
                ReceiveLogRec.Validate("Global Dimension 1 Code", ReceiveJourRec."Global Dimension 1 Code");
                ReceiveLogRec.validate("Container Type", ReceiveJourRec."Container Type");
                ReceiveLogRec.validate("Shortcut Dimension 5 Code", ReceiveJourRec."Shortcut Dimension 5 Code");
                ReceiveLogRec.validate(Description, ReceiveJourRec.Description);
                ReceiveLogRec.validate(Vehicle, ReceiveJourRec.Vehicle);
                ReceiveLogRec.validate("Driver Name", ReceiveJourRec."Driver Name");
                ReceiveLogRec.validate("Driver ID", ReceiveJourRec."Driver ID");
                ReceiveLogRec.validate("DO No.", ReceiveJourRec."DO No.");
                ReceiveLogRec.validate("Time In", ReceiveJourRec."Time In");
                ReceiveLogRec.validate(Recieived, ReceiveJourRec.Recieived);
                ReceiveLogRec.validate("Received Date", ReceiveJourRec."Received Date");
                ReceiveLogRec.validate(Transporter, ReceiveJourRec.Transporter);
                ReceiveLogRec.validate("Transporter Name", ReceiveJourRec."Transporter Name");
                ReceiveLogRec.validate("Vehicle Type", ReceiveJourRec."Vehicle Type");
                ReceiveLogRec.validate("Truck /Wagon No.", ReceiveJourRec."Truck /Wagon No.");
                ReceiveLogRec.validate("Trailer No.", ReceiveJourRec."Trailer No.");
                ReceiveLogRec.validate("Shipper Seal No.", ReceiveJourRec."Shipper Seal No.");
                ReceiveLogRec."Container Structural Status" := ReceiveJourRec."Container Structural Status";
                ReceiveLogRec.validate("Releasing Clerk Details", ReceiveJourRec."Releasing Clerk Details");
                ReceiveLogRec.Validate("Manifest Line No.", ReceiveJourRec."Manifest Line No.");
                ReceiveLogRec.Validate(Position, ReceiveJourRec.Position);
                ReceiveLogRec.validate(Remarks, ReceiveJourRec.Remarks);
                ReceiveLogRec.Validate("Seal No. 1", ReceiveJourRec."Seal No. 1");
                ReceiveLogRec.Validate("Seal No. 2", ReceiveJourRec."Seal No. 2");
                ReceiveLogRec.validate(Image, ReceiveJourRec.Image);
                if ReceiveJourRec.Position <> '' then
                    InsertPoslog(EntryNo);
                if ReceiveLogRec.Insert() then begin
                    EntryNo := EntryNo + 1;
                end;
            // AdditionalCharges.Reset();
            // AdditionalCharges.SetRange("Container ID", ReceiveLogRec."Global Dimension 1 Code");
            // IF AdditionalCharges.FindFirst() Then begin
            //     repeat
            //         PostedAdditionalCharges.Init();
            //         PostedAdditionalCharges."Receiving Entry No." := ReceiveLogRec."Entry No.";
            //         PostedAdditionalCharges."Charges Code" := AdditionalCharges."Charges Code";
            //         PostedAdditionalCharges."Container ID" := AdditionalCharges."Container ID";
            //         PostedAdditionalCharges."Line No." := AdditionalCharges."Line No.";
            //         PostedAdditionalCharges.insert;
            //         AdditionalCharges.Delete();
            //     until AdditionalCharges.next = 0;
            // end;

            until ReceiveJourRec.next = 0;
        Message('Receiving Successfully');
    end;

    local procedure UpdatePosition()
    var
        PositionRec: Record Position;
    begin
        IF PositionRec.Get(rec.Position) then begin
            PositionRec.Status := PositionRec.Status::Allocated;
            PositionRec."Global Dimension 1 Code" := rec."Global Dimension 1 Code";
            PositionRec."Container No./Chassis No." := Rec."Container No./Chassis No.";
            PositionRec.Modify();
        end
    end;

    procedure InsertPoslog(EntryNo: Integer)
    var
        myInt: Integer;
        PosRec: Record "Position Log";
        EntryNo1: Integer;
        ReceivingJourRec: Record "Receiving Journal";
        ReceiveLog: Record ReceivingLog;
    begin
        IF PosRec.FindLast() then
            EntryNo1 := PosRec."Entry No." + 1
        else
            EntryNo1 := 1;
        PosRec.Init();
        PosRec."Entry No." := EntryNo1;
        PosRec.Validate("Position Code", Rec.Position);
        PosRec."Entry Type" := PosRec."Entry Type"::"Yard Allocation";
        Evaluate(PosRec."Document No.", Format(EntryNo));
        PosRec.Qunatity := 1;
        PosRec.Validate("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        PosRec.Validate("Container No./Chassis No.", Rec."Container No./Chassis No.");
        PosRec."Acitivity Date" := WorkDate();
        PosRec."Acitivity Time" := "Time";
        PosRec.Insert();

    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        rec.DeleteAll();
    end;
}




