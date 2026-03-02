page 50300 "Manifests New"
{
    ApplicationArea = All;
    Caption = 'Manifests Lines';
    PageType = List;
    SourceTable = "Manifest Line";
    UsageCategory = Lists;
    DelayedInsert = true;
    AutoSplitKey = true;
    InsertAllowed = false;
    //Editable = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    SourceTableView = sorting("Job File Date") order(descending);
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
                    // trigger OnAssistEdit()
                    // varparent
                    //     myInt: Integer;
                    // begin
                    //     if rec.OnAssistEdit(xRec) then
                    //         CurrPage.Update();
                    // end;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                    Visible = true;
                    Editable = false;
                }
                field("Job File Date"; rec."Job File Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job File Date field.';
                }
                field("BL No."; Rec."BL No.")
                {
                    ToolTip = 'Specifies the value of the BL No. field.';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Editable = ContainerEdit;
                }
                field(Received; rec.Received)
                {
                    ApplicationArea = all;
                    Editable = ContainerEdit;
                }
                field("Date Received"; Rec."Date Received")
                {
                    ToolTip = 'Specifies the value of the Date Received field.';
                    ApplicationArea = All;
                    Editable = ContainerEdit;
                }
                field("Received Time"; rec."Received Time")
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
                field("Container Status"; rec."Container Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the container Status field.';
                    //Editable = SPEditable;
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
                field("Shipping Agent"; Rec."Shipping Agent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipping Agent field.';

                }
                field("Shipping Agent Name"; rec."Shipping Agent Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipping Agent Name field.';

                }
                field("Vessel Name"; rec."Vessel Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Vessel Name field.';
                }
                field("Vessel Arrival Date"; rec."Vessel Arrival Date")
                {
                    ApplicationArea = all;

                    ToolTip = 'Specifies the value of the Vessel Arrival Date field.';
                }
                field("Vessel Arrival Time"; rec."Vessel Arrival Time")
                {
                    ApplicationArea = all;

                    ToolTip = 'Specifies the value of the Vessel Arrival Time field.';
                }
                field("Voyage No."; rec."Voyage No.")
                {
                    ApplicationArea = all;

                    ToolTip = 'Specifies the value of the Voyage No. field.';
                }
                field("Last Sling Date"; rec."Last Sling Date")
                {
                    ApplicationArea = all;

                    ToolTip = 'Specifies the value of the Last Sling Date field.';
                }
                field("Expected Arrival Date"; rec."Expected Arrival Date")
                {
                    ApplicationArea = all;

                    ToolTip = 'Specifies the value of the Expected Arrival Date field.';
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
                field("Cargo Nomination No."; rec."Cargo Nomination No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Cargo Nomination No. field.';
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            // action("Import Manifest Lines")
            // {
            //     Caption = 'Import Manifest Lines';
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     Image = Import;
            //     ApplicationArea = All;
            //     trigger OnAction()
            //     var
            //         ManifestLineImport: XmlPort "Manifest Line Import";
            //     begin
            //         ManifestLineImport.GetJobfileNo(rec."Job File No.");
            //         ManifestLineImport.Run();
            //     end;
            // }
            // action("&Import")
            // {
            //     Caption = '&Import Manifest lines';
            //     Image = ImportExcel;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     ApplicationArea = All;
            //     ToolTip = 'Import data from excel.';
            //     Visible = false;
            //     trigger OnAction()
            //     var
            //     begin
            //         ReadExcelSheet();
            //         ImportExcelData();
            //     end;
            // }
            action("&Import Worksheet")
            {
                Caption = '&Import Worksheet';
                ApplicationArea = All;
                Image = Navigate;
                //RunObject = page "Import worksheet";
                // RunPageLink = "Job File No." = field("Job File No.");
                trigger OnAction()
                var
                    Importworksheet: Page "Import Manifest";
                    ImportWS: Record ImportManifest;
                begin
                    //ImportWS.Reset();
                    //ImportWS.SetRange("Job File No.", Rec."Job File No.");
                    Clear(Importworksheet);
                    Importworksheet.SetTableView(ImportWS);
                    Importworksheet.SetRecord(ImportWS);
                    Importworksheet.LookupMode(true);
                    //Importworksheet.GetJobfileNo(Rec."Job File No.");
                    if Importworksheet.RunModal() = Action::LookupOK then begin
                    end;
                end;
            }

            action("Manifest Line Details")
            {
                ApplicationArea = all;
                trigger OnAction()

                var
                    ManifestLine: Record "Manifest Line";
                begin
                    ManifestLine.Reset();
                    ManifestLine.SetRange("Job File No.", rec."Job File No.");
                    ManifestLine.SetRange("Line No.", rec."Line No.");
                    page.Run(50169, ManifestLine);
                end;
            }
            action("Additional Charges")
            {
                Caption = 'Additional Charges';
                ApplicationArea = All;
                RunObject = page "Additional Charges";
                RunPageLink = "Container ID" = field("Global Dimension 1 Code");
            }
        }
    }

    var
        BatchName: Code[10];
        FileName: Text[100];
        SheetName: Text[100];

        TempExcelBuffer: Record "Excel Buffer" temporary;
        UploadExcelMsg: Label 'Please Choose the Excel file.';
        NoFileFoundMsg: Label 'No Excel file found!';
        BatchISBlankMsg: Label 'Batch name is blank';
        ExcelImportSucess: Label 'Excel is successfully imported.';
        JobfileNo: Code[20];


    // local procedure ReadExcelSheet()
    // var
    //     FileMgt: Codeunit "File Management";
    //     IStream: InStream;
    //     FromFile: Text[100];
    // begin
    //     UploadIntoStream(UploadExcelMsg, '', '', FromFile, IStream);
    //     if FromFile <> '' then begin
    //         FileName := FileMgt.GetFileName(FromFile);
    //         SheetName := TempExcelBuffer.SelectSheetsNameStream(IStream);
    //     end else
    //         Error(NoFileFoundMsg);
    //     TempExcelBuffer.Reset();
    //     TempExcelBuffer.DeleteAll();
    //     TempExcelBuffer.OpenBookStream(IStream, SheetName);
    //     TempExcelBuffer.ReadSheet();
    // end;

    // local procedure ImportExcelData()
    // var
    //     ManifestLine: Record "Manifest Line";
    //     RowNo: Integer;
    //     ColNo: Integer;
    //     LineNo: Integer;
    //     MaxRowNo: Integer;
    //     ShortcutDimCode: array[8] of Code[20];
    //     IMSSetup: Record "IMS Setup";
    //     NoSeriesMgt: Codeunit "No. Series";

    // begin
    //     RowNo := 0;
    //     ColNo := 0;
    //     MaxRowNo := 0;
    //     LineNo := 0;

    //     if ManifestLine.FindLast() then
    //         LineNo := ManifestLine."Line No." + 10000
    //     else
    //         LineNo := 10000;

    //     TempExcelBuffer.Reset();
    //     if TempExcelBuffer.FindLast() then begin
    //         MaxRowNo := TempExcelBuffer."Row No.";
    //     end;

    //     for RowNo := 2 to MaxRowNo do begin
    //         LineNo := LineNo + 10000;
    //         // IMSSetup.Get();
    //         // JobFileNo := NoSeriesMgt.GetNextNo(IMSSetup."Job File Nos", WorkDate(), true);
    //         ManifestLine.Init();
    //         ManifestLine."Job File No." := JobfileNo;
    //         //ManifestLine.validate("Job File No.", JobfileNo);
    //         ManifestLine.Validate("Line No.", LineNo);
    //         ManifestLine.Insert();
    //         //ManifestLine.validate("Job File Date", rec."Date File Opened");
    //         Evaluate(ManifestLine."BL No.", GetValueAtCell(RowNo, 1));
    //         ManifestLine.Validate(ManifestLine."BL No.");
    //         Evaluate(ManifestLine."Container/Chassis No.", GetValueAtCell(RowNo, 2));
    //         Evaluate(ManifestLine."Seal/Engine No.", GetValueAtCell(RowNo, 3));
    //         Evaluate(ManifestLine."Shortcut Dimension 4 Code", GetValueAtCell(RowNo, 4));
    //         Evaluate(ManifestLine.Marks, GetValueAtCell(RowNo, 5));
    //         Evaluate(ManifestLine."Container Type", GetValueAtCell(RowNo, 6));
    //         Evaluate(ManifestLine."Shortcut Dimension 5 Code", GetValueAtCell(RowNo, 7));
    //         Evaluate(ManifestLine.Description, GetValueAtCell(RowNo, 8));
    //         Evaluate(ManifestLine."CBM Tonage", GetValueAtCell(RowNo, 9));
    //         Evaluate(ManifestLine.Weight, GetValueAtCell(RowNo, 10));
    //         Evaluate(ManifestLine."Port of Shipment", GetValueAtCell(RowNo, 11));
    //         Evaluate(ManifestLine."Port of Discharge", GetValueAtCell(RowNo, 12));
    //         Evaluate(ManifestLine."Destination Type", GetValueAtCell(RowNo, 13));
    //         Evaluate(ManifestLine."Clearing Agent", GetValueAtCell(RowNo, 14));
    //         Evaluate(ManifestLine."Consignee No.", GetValueAtCell(RowNo, 15));
    //         Evaluate(ManifestLine."Invoicing Party No.", GetValueAtCell(RowNo, 16));
    //         Evaluate(ManifestLine."Shipping Agent", GetValueAtCell(RowNo, 17));
    //         Evaluate(ManifestLine."Vessel Name", GetValueAtCell(RowNo, 18));
    //         Evaluate(ManifestLine."Vessel Arrival Date", GetValueAtCell(RowNo, 19));
    //         Evaluate(ManifestLine."Vessel Arrival Time", GetValueAtCell(RowNo, 20));
    //         Evaluate(ManifestLine."Voyage No.", GetValueAtCell(RowNo, 21));
    //         Evaluate(ManifestLine."Expected Arrival Date", GetValueAtCell(RowNo, 22));
    //         Evaluate(ManifestLine."Last Sling Date", GetValueAtCell(RowNo, 23));
    //         Evaluate(ManifestLine."Job File Date", GetValueAtCell(RowNo, 24));
    //         ManifestLine.Validate("Container/Chassis No.");
    //         ManifestLine.Validate("Seal/Engine No.");
    //         ManifestLine.Validate("Shortcut Dimension 4 Code");
    //         ManifestLine.Validate(Marks);
    //         ManifestLine.Validate("Container Type");
    //         ManifestLine.Validate("Shortcut Dimension 5 Code");
    //         ManifestLine.Validate(Description);
    //         ManifestLine.Validate("CBM Tonage");
    //         ManifestLine.Validate(Weight);
    //         ManifestLine.Validate("Port of Shipment");
    //         ManifestLine.Validate("Port of Discharge");
    //         ManifestLine.Validate("Destination Type");
    //         ManifestLine.Validate("Clearing Agent");
    //         ManifestLine.Validate("Consignee No.");
    //         ManifestLine.Validate("Invoicing Party No.");
    //         ManifestLine.Validate("Shipping Agent");
    //         ManifestLine.Validate("Vessel Name");
    //         ManifestLine.Validate("Voyage No.");
    //         ManifestLine.Validate("Expected Arrival Date");
    //         ManifestLine.Validate("Vessel Arrival Date");
    //         ManifestLine.Validate("Vessel Arrival Time");
    //         ManifestLine.Validate("Last Sling Date");
    //         ManifestLine.Validate("Job File Date");
    //         ManifestLine.Modify();
    //     end;
    //     Message(ExcelImportSucess);
    // end;

    // local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    // begin

    //     TempExcelBuffer.Reset();
    //     If TempExcelBuffer.Get(RowNo, ColNo) then
    //         exit(TempExcelBuffer."Cell Value as Text")
    //     else
    //         exit('');
    // end;

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

    procedure OnAssistEdit(ManifestRec: Record "Manifest Line"): Boolean
    var
        ManiRec: Record "Manifest Line";
        ImsSetup: Record "IMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    begin
        ManiRec := Rec;
        ImsSetup.Get;
        ImsSetup.TestField("Job File Nos");
        if NoSeriesMgt.SelectSeries(ImsSetup."Job File Nos", ManifestRec."No.Series", "No.Series") then begin
            NoSeriesMgt.SetSeries("Job File No.");
            Rec := ManiRec;
            exit(true);
        end;
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


