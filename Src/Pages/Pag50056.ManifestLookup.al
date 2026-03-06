page 50056 "Manifest lookup"
{
    ApplicationArea = All;
    Caption = 'Manifest lookup';
    PageType = List;
    SourceTable = "Manifest Line";
    DeleteAllowed = false;
    //Editable = False;
    SourceTableTemporary = true;
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
                field(Selected; Rec.Selected)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Job File Date"; rec."Job File Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job File Date field.';
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
                field(Received; rec.Received)
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field("Date Received"; Rec."Date Received")
                {
                    ToolTip = 'Specifies the value of the Date Received field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Received Time"; rec."Received Time")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field(Released; rec.Released)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Date Released"; Rec."Date Released")
                {
                    ToolTip = 'Specifies the value of the Date Released field.';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Charge ID"; Rec."Charge ID")
                {
                    ToolTip = 'Specifies the value of the Charge ID field.';
                    ApplicationArea = All;
                    Editable = false;
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
                    Editable = false;

                }
                field("Consignee No."; rec."Consignee No.")
                {
                    ApplicationArea = all;
                    Editable = false;
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
                    Editable = false;
                }

                field("Clearing Agent"; Rec."Clearing Agent")
                {
                    ToolTip = 'Specifies the value of the Clearing Agent field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 3 Code"; rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Container Status"; rec."Container Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the container Status field.';
                    //Editable = SPEditable;
                    Editable = false;
                }

                field("TBL/MH"; Rec."TBL/MH")
                {
                    ToolTip = 'Specifies the value of the TBL/MH field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Container/Chassis No."; Rec."Container/Chassis No.")
                {
                    ToolTip = 'Specifies the value of the Container/Chassis No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }


                field("Seal/Engine No."; Rec."Seal/Engine No.")
                {
                    ToolTip = 'Specifies the value of the Seal/Engine No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customs Seal No."; Rec."Customs Seal No.")
                {
                    ToolTip = 'Specifies the value of the Customs Seal No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Unit Of Measure field.';
                    ApplicationArea = All;
                    Editable = false;
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
                    Editable = false;
                }
                field("Landing Time"; rec."Landing Time")
                {
                    ToolTip = 'Specifies the value of the Landing Time field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Marks; Rec.Marks)
                {
                    ToolTip = 'Specifies the value of the Marks field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Parent Container ID"; Rec."Parent Container ID")
                {
                    ApplicationArea = All;
                    Editable = false;

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
                    Editable = false;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the value of the Container Size field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Container lock"; Rec."Container lock")
                {
                    ToolTip = 'Specifies the value of the Container lock field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("CBM Tonage"; Rec."CBM Tonage")
                {
                    ToolTip = 'Specifies the value of the CBM Tonage field.';
                    ApplicationArea = All;
                    Editable = false;

                }
                field(Weight; Rec.Weight)
                {
                    ToolTip = 'Specifies the value of the Weight field.';
                    ApplicationArea = All;
                    Editable = false;

                }
                field("CBM-Wt Difference"; Rec."CBM-Wt Difference")
                {
                    ToolTip = 'Specifies the value of the CBM-Wt Difference field.';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Port of Shipment"; Rec."Port of Shipment")
                {
                    ToolTip = 'Specifies the value of the Port of Shipment field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Port of Discharge"; Rec."Port of Discharge")
                {
                    ToolTip = 'Specifies the value of the Port of Discharge field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Destination Type"; Rec."Destination Type")
                {
                    ToolTip = 'Specifies the value of the Destination Type field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Final Destination"; Rec."Final Destination")
                {
                    ToolTip = 'Specifies the value of the Final Destination field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Allocated Position"; rec."Allocated Position")
                {
                    ToolTip = 'Specifies the value of the Allocated Position';
                    ApplicationArea = All;
                    Editable = false;
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
                    Editable = false;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ToolTip = 'Specifies the value of the Driver Name field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Driver ID"; Rec."Driver ID")
                {
                    ToolTip = 'Specifies the value of the Driver ID field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Vehicle; Rec.Vehicle)
                {
                    ToolTip = 'Specifies the value of the Vehicle field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Delivery Order No."; Rec."Delivery Order No.")
                {
                    ToolTip = 'Specifies the value of the Delivery Order No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Received By"; Rec."Received By")
                {
                    ToolTip = 'Specifies the value of the Received By field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Verified; rec.Verified)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Verification Type"; Rec."Verification Type")
                {
                    ToolTip = 'Specifies the value of the Verification Type field.';
                    ApplicationArea = All;
                    Editable = false;
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
                    Editable = false;
                }
                field("No. of Bags Released"; Rec."No. of Bags Released")
                {
                    ToolTip = 'Specifies the value of the No. of Bags Released field.';
                    ApplicationArea = All;
                    Editable = false;
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
                    Editable = false;
                }
                field("Discharge Date"; rec."Discharge Date")
                {
                    ApplicationArea = All;
                    Editable = false;
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


                field("Other remarks"; rec."Other remarks")
                {
                    ApplicationArea = All;
                }
                field(Stripped; Rec.Stripped)
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
        GPNo: code[20];
        GatePass: Record "Gate Pass Out";

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
        CheckPayments();
    end;
    //added for stripped units 24/02/26
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        TempCLE: Record "Manifest Line" temporary;
    begin
        if CloseAction in [action::OK, action::LookupOK] then begin
            if Rec.FINDSET then
                repeat
                    TempCLE := Rec;
                    TempCLE.INSERT;
                    TempCLE.Modify();

                until Rec.NEXT = 0;

            GPHead.Reset();
            GPHead.SetRange("Gate Pass No.", GPNo);
            if GPHead.FindFirst() then begin
                GPLine.Reset();
                GPLine.SetRange("Gate Pass No.", GPHead."Gate Pass No.");
                if GPLine.FindSet() then begin
                    if Confirm('Do you want to delete the existing lines?', true) then
                        GPLine.DeleteAll()
                    else
                        exit;
                end;
            end;


            If TempCLE.FindSet() then
                repeat
                    if GPHead.get(GPNo) then
                        if GPHead.Approved THEN
                            GPHead.InsertEmptyContainerGatePassLine(TempCLE)
                        else
                            if (TempCLE."Parent Container ID" <> '') and (GPHead.Approved = FALSE) then
                                InsertStrippedGatePassLines(TempCLE);
                until TempCLE.Next = 0;



        end;
    end;
    //end for stripped units

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
        if (UserId = 'GROUP.AUDIT') or (UserId = 'TECHBIZINFOTECH') or (UserId = 'SHILLAH') then
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
        NoSeriesMgt: Codeunit "No. Series";

    begin
        ManiRec := Rec;
        ImsSetup.Get;
        ImsSetup.TestField("Job File Nos");
        if NoSeriesMgt.LookupRelatedNoSeries(ImsSetup."Job File Nos", ManifestRec."No.Series", Rec."No.Series") then begin
            NoSeriesMgt.GetNextNo(Rec."Job File No.");
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
    //for stripped units


    procedure GetGPNo(var NewGPNo: Code[20])
    begin
        GPNo := NewGPNo;
    end;

    procedure InsertStrippedGatePassLines(Manifest: record "Manifest Line")
    var
        SalesInvHead: Record "Sales Invoice Header";
        LSalesInvLine, GSalesInvLine, SalesInvLine : Record "Sales Invoice Line";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        ContainerInvLine: Record "Sales Invoice Line";
        ContainerRec: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        GPHead: Record "Gate Pass Out";
        GPLine, GatePassLine : Record "Gate Pass Out Line";
        PostedGateOutHead: Record "Posted Gate Pass Out";
        PostedGateOutLine: Record "Posted Gate Pass out Line";
        PaymentTerms, PaymentMethod : Code[20];
        Cust: Record Customer;
        BaseOn: Enum "Base On Enum";
        ChargeGroupHead: Record "Charge ID Group Header";
        ChargeGroupLine: Record "Charge ID Group Line";
        BilledStorageDays, RemainingDays, CurrentStorageDays, FreeDays, LineNo : Integer;
        InvoiceCount: Integer;
        //ManifestHead: Record "Manifest Header";
        GManifestLine, TestManifestLine : Record "Manifest Line";
        ClosedCont: Integer;
        GPCancelled: Boolean;
        CancelGatePass: Record "Cancel Gatepass";

        StorageStartDate: Date;
        PrevDocNo, PrevContainerNo : Code[20];
    begin
        GPHead.Reset();
        GPHead.SetRange("Gate Pass No.", GPNo);

        if GPHead.FindFirst() then begin
            LineNo := 0;
            InvoiceCount := 0;
            ClosedCont := 0;



            // Check if Parent Invoice was paid.
            SalesInvLine.Reset();
            SalesInvLine.SetRange("BL No.", GPHead."BL No.");
            SalesInvLine.CalcFields(Cancelled);
            SalesInvLine.SetRange(Cancelled, false);
            if SalesInvLine.FindSet() then begin
                CustLedgerEntry.Reset();
                CustLedgerEntry.SetRange("Document No.", SalesInvLine."Document No.");
                CustLedgerEntry.CalcFields("Remaining Amount");
                CustLedgerEntry.SetFilter("Remaining Amount", '=%1', 0);
                if CustLedgerEntry.FindFirst() then begin

                    GPCancelled := false;

                    PostedGateOutLine.Reset();
                    PostedGateOutLine.SetRange("BL No.", GPHead."BL No.");
                    PostedGateOutLine.SetRange("Invoice No.", SalesInvLine."Document No.");
                    PostedGateOutLine.SetRange("Global Dimension 1 Code", Manifest."Global Dimension 1 Code");
                    PostedGateOutLine.SetRange("Gate Pass Status", PostedGateOutLine."Gate Pass Status"::Active);

                    if PostedGateOutLine.FindFirst() then begin
                        CancelGatePass.Reset();
                        CancelGatePass.SetRange("BL No.", GPHead."BL No.");
                        CancelGatePass.SetRange("Global Dimension 1 Code", Manifest."Global Dimension 1 Code");

                        if CancelGatePass.FindFirst() then
                            GPCancelled := true
                        else
                            GPCancelled := false;
                    end else
                        GPCancelled := true;
                    if GPCancelled then begin
                        SalesInvHead.Reset();
                        SalesInvHead.SetRange("No.", SalesInvLine."Document No.");
                        IF SalesInvHead.FindFirst() then begin
                            PaymentMethod := SalesInvHead."Payment Method Code";
                            PaymentTerms := SalesInvHead."Payment Terms Code";
                            SalesInvHead.CalcFields(Closed);
                            if not GPHead.Approved then begin
                                if SalesInvHead.Closed <> true then
                                    Error('Invoice %1 is not paid. Please check and try again', SalesInvHead."No.");
                            end;
                        end else begin
                            PaymentMethod := '';
                            PaymentTerms := '';
                        end;

                        GLSetup.Get();

                        ContainerRec.Reset();
                        ContainerRec.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
                        ContainerRec.SetRange(Code, Manifest."Parent Container ID");
                        ContainerRec.SetRange("Container Status", ContainerRec."Container Status"::"In Stock");

                        if ContainerRec.FindFirst() then begin

                            // ===== Extra Storage Calculation =====
                            LSalesInvLine.Reset();
                            LSalesInvLine.SetRange("BL No.", GPHead."BL No.");

                            if LSalesInvLine.FindLast() then
                                if LSalesInvLine."Posting Date" <> Today then begin

                                    GSalesInvLine.Reset();
                                    GSalesInvLine.SetCurrentKey("Document No.");
                                    GSalesInvLine.SetRange("Shortcut Dimension 1 Code", Manifest."Parent Container ID");
                                    GSalesInvLine.SetFilter("Chargable Storage Days", '<>%1', 0);

                                    if GSalesInvLine.FindFirst() then
                                        repeat
                                            if PrevDocNo <> GSalesInvLine."Document No." then
                                                BilledStorageDays +=
                                                  GSalesInvLine."Storage Days" -
                                                  GSalesInvLine."Free Days";

                                            PrevDocNo := GSalesInvLine."Document No.";
                                        until GSalesInvLine.Next() = 0;

                                    GSalesInvLine.Reset();
                                    GSalesInvLine.SetRange("Shortcut Dimension 1 Code", manifest."Parent Container ID");

                                    if GSalesInvLine.FindFirst() then begin
                                        if ChargeGroupHead.Get(GSalesInvLine."Charge ID") then begin
                                            BaseOn := ChargeGroupHead."Base On";

                                            ChargeGroupLine.Reset();
                                            ChargeGroupLine.SetRange("Charge ID Group Code",
                                                                     ChargeGroupHead."Charge ID Group Code");
                                            ChargeGroupLine.SetFilter("Free Days", '<>%1', 0);

                                            if ChargeGroupLine.FindFirst() then
                                                FreeDays := ChargeGroupLine."Free Days"
                                            else
                                                FreeDays := 0;
                                        end;

                                        case BaseOn of
                                            BaseOn::"Received Date":
                                                StorageStartDate := Manifest."Date Received";
                                            BaseOn::"ETA Date":
                                                StorageStartDate := Manifest."Expected Arrival Date";
                                            BaseOn::"Last Sling Date":
                                                StorageStartDate := Manifest."Last Sling Date";
                                            BaseOn::ActualDate:
                                                StorageStartDate := Manifest."Vessel Arrival Date";
                                        end;

                                        if StorageStartDate <> 0D then
                                            CurrentStorageDays := Today - StorageStartDate;
                                    end;

                                    if CurrentStorageDays > FreeDays then begin
                                        RemainingDays :=
                                          CurrentStorageDays - FreeDays - BilledStorageDays;

                                        Error(
                                          'Extra storage days to be billed: Please Contact Audit \' +
                                          'Total Storage Days %1, Free Days %2, ' +
                                          'Billed Storage Days %3, Remaining Days %4',
                                          CurrentStorageDays,
                                          FreeDays,
                                          BilledStorageDays,
                                          RemainingDays);
                                    end;
                                end;

                            // ===== Additional Checks =====
                            CheckVerificationCharges(Manifest."Global Dimension 1 Code");
                            CheckAdditionalCharges(Manifest."Global Dimension 1 Code");

                            // ===== Insert Gate Pass Line =====
                            GatePassLine.Reset();
                            GatePassLine.SetRange("Gate Pass No.", GPHead."Gate Pass No.");

                            if GatePassLine.FindLast() then
                                LineNo := GatePassLine."Line No." + 10000;

                            GatePassLine.Init();
                            GatePassLine."Gate Pass No." := GPHead."Gate Pass No.";
                            GatePassLine."Line No." := LineNo;
                            GatePassLine.Insert();

                            GatePassLine."Invoice No." := SalesInvLine."Document No.";
                            GatePassLine."Global Dimension 1 Code" := Manifest."Global Dimension 1 Code";
                            GatePassLine."Global Dimension 2 Code" := Manifest."Global Dimension 2 Code";
                            GatePassLine."Shortcut Dimension 3 Code" := Manifest."Shortcut Dimension 3 Code";
                            GatePassLine."Shortcut Dimension 4 Code" := Manifest."Shortcut Dimension 4 Code";
                            GatePassLine."Shortcut Dimension 5 Code" := Manifest."Shortcut Dimension 5 Code";
                            GatePassLine."Shortcut Dimension 6 Code" := Manifest."Shortcut Dimension 6 Code";
                            GatePassLine."Job File No" := Manifest."Job File No.";
                            GatePassLine."Container /Chasis No." := Manifest."Container/Chassis No.";
                            GatePassLine."Position ID" := SalesInvLine."Position ID";
                            GatePassLine."BL No" := Manifest."BL No.";
                            GatePassLine."Invoice Date" := SalesInvLine."Posting Date";
                            GatePassLine."Consignee No." := SalesInvLine."Sell-to Customer No.";
                            GatePassLine."Gen. Bus. Posting Group" := SalesInvLine."Gen. Bus. Posting Group";
                            GatePassLine."Gen. Prod. Posting Group" := SalesInvLine."Gen. Prod. Posting Group";
                            GatePassLine."Activity Date" := GPHead."Activity Date";
                            GatePassLine."Activity Time" := GPHead."Activity Time";

                            if Cust.Get(SalesInvLine."Sell-to Customer No.") then
                                GatePassLine."Consignee Name" := Cust.Name;

                            GatePassLine.Modify();

                            InvoiceCount += 1;
                            PrevContainerNo := SalesInvLine."Shortcut Dimension 1 Code";
                        end;
                    end;
                    GetReceiptNo();
                end else
                    Error('Parent Invoice has not been Paid.');
            end else
                Message('Invoice does not found');
        end;

    end;

    procedure CheckVerificationCharges(l_ContID: code[20])
    var
        VerificationLog: Record VerificationLog;
    begin
        VerificationLog.Reset();
        VerificationLog.SetRange("Global Dimension 1 Code", l_ContID);
        VerificationLog.SetRange(Invoiced, false);
        if VerificationLog.FindFirst() then begin
            if VerificationLog."Verification Type" <> VerificationLog."Verification Type"::Sighting then
                Error('Unbilled verification Charges found. Please check and try again');
        end;
    end;

    procedure CheckAdditionalCharges(l_ContID: code[20])
    var
        SalesInvHead: Record "Sales Invoice Header";
        LSalesInvLine, GSalesInvLine, SalesInvLine : Record "Sales Invoice Line";
        ContainerInvLine: Record "Sales Invoice Line";
        ContainerRec: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        Cust: Record Customer;
        AddCharge: Record "Additional Charges - Receiving";
        InvoiceCount: Integer;
        // ManifestHead: Record "Manifest Header";
        GManifestLine, TestManifestLine : Record "Manifest Line";
        ClosedCont: Integer;
        PrevDocNo, PrevContainerNo : Code[20];
    begin

        InvoiceCount := 0;
        ClosedCont := 0;
        AddCharge.Reset();
        AddCharge.SetRange(AddCharge."Container ID", l_ContID);
        AddCharge.SetFilter("Charges Code", '<>%1', '');
        if AddCharge.FindFirst() then begin
            repeat
                SalesInvLine.Reset();
                SalesInvLine.SetCurrentKey("Shortcut Dimension 1 Code");
                SalesInvLine.SetAscending("Shortcut Dimension 1 Code", true);
                SalesInvLine.SetRange("Shortcut Dimension 1 Code", AddCharge."Container ID");
                SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
                SalesInvLine.SetRange("No.", AddCharge."Charges Code");
                SalesInvLine.CalcFields(Cancelled);
                SalesInvLine.SetRange(Cancelled, false);
                if not SalesInvLine.FindFirst() then
                    Error('Additional charges not billed for the Container ID %1. Please check and try again', AddCharge."Container ID");
            until AddCharge.Next() = 0;
        end;
    end;


    procedure SetTempManifest(var TempManifest: Record "Manifest Line" temporary)
    begin
        Rec.DeleteAll();
        Rec.Copy(TempManifest, true);

    end;

    procedure CheckPayments()
    var

        SalesInvLine: Record "Sales Invoice Line";
        EntryNo, LineNo : Integer;
        TempCustLedgEntry: Record "Cust. Ledger Entry" temporary;
        RecCustLedgEntry: Record "Cust. Ledger Entry";
        PageInvoiceStatus: Page InvoiceStatusList;
        PrevDocNo, PrevContainerNo : Code[20];
        ManifestLine: Record "Manifest Line";
        ManifestLookup: Page "Manifest lookup";
        TempSelectedContainers: record "Manifest Line" temporary;

    begin

        If GatePass.get(GPNo) then begin
            if GatePass."Shortcut Dimension 6 Code" <> 'EMPTY CONTAINER' then begin
                // ManifestLine.Reset();
                // ManifestLine.SetRange("Shortcut Dimension 6 Code", GatePass."Shortcut Dimension 6 Code");
                // if ManifestLine.FindSet() then begin
                //     repeat
                //         LineNo := GetLastTempLineNo(Rec);
                //         Rec.init();
                //         Rec."Line No." := LineNo + 1000;
                //         Rec."Global Dimension 1 Code" := ManifestLine."Global Dimension 1 Code";
                //         Rec."Global Dimension 2 Code" := ManifestLine."Global Dimension 2 Code";
                //         Rec."Shortcut Dimension 3 Code" := ManifestLine."Shortcut Dimension 3 Code";
                //         Rec."Shortcut Dimension 4 Code" := ManifestLine."Shortcut Dimension 4 Code";
                //         Rec."Shortcut Dimension 5 Code" := ManifestLine."Shortcut Dimension 5 Code";
                //         Rec."Shortcut Dimension 6 Code" := ManifestLine."Shortcut Dimension 6 Code";
                //         Rec."Job File No." := ManifestLine."Job File No.";
                //         Rec."BL No." := ManifestLine."BL No.";
                //         Rec."Parent Container ID" := ManifestLine."Parent Container ID";
                //         Rec."Container/Chassis No." := ManifestLine."Container/Chassis No.";

                //         Rec.Insert();
                //     until ManifestLine.Next() = 0;
                // end;
                //end;

                SalesInvLine.Reset();
                SalesInvLine.SetRange("BL No.", GatePass."BL No.");
                SalesInvLine.CalcFields(Cancelled);
                SalesInvLine.SetRange(Cancelled, false);
                if SalesInvLine.FindSet() then begin
                    //Adding the stripped units flow for ones with the parent id
                    ManifestLine.Reset();
                    ManifestLine.SetRange("BL No.", SalesInvLine."BL No.");
                    ManifestLine.SetFilter("Parent Container ID", '<>%1', '');
                    ManifestLine.SetRange(Released, false);
                    if ManifestLine.FindSet() then begin
                        repeat
                            Rec.init();
                            Rec."Global Dimension 1 Code" := ManifestLine."Global Dimension 1 Code";
                            Rec."Global Dimension 2 Code" := ManifestLine."Global Dimension 2 Code";
                            Rec."Shortcut Dimension 3 Code" := ManifestLine."Shortcut Dimension 3 Code";
                            Rec."Shortcut Dimension 4 Code" := ManifestLine."Shortcut Dimension 4 Code";
                            Rec."Shortcut Dimension 5 Code" := ManifestLine."Shortcut Dimension 5 Code";
                            Rec."Shortcut Dimension 6 Code" := ManifestLine."Shortcut Dimension 6 Code";
                            Rec."Job File No." := ManifestLine."Job File No.";
                            Rec."BL No." := ManifestLine."BL No.";
                            Rec."Parent Container ID" := ManifestLine."Parent Container ID";
                            Rec."Consignee No." := ManifestLine."Consignee No.";
                            Rec."Consignee Name" := ManifestLine."Consignee Name";
                            Rec."Container/Chassis No." := ManifestLine."Container/Chassis No.";
                            Rec."Line No." := ManifestLine."Line No.";
                            Rec.Insert();
                        until ManifestLine.Next() = 0;
                    end;
                end else
                    Message('Invoice  not found');

            End;
        end;
    End;


    procedure GetLastTempLineNo(var TempTable: Record "Manifest Line" temporary) LineNo: Integer
    begin
        // Set the current key so FindLast() sorts by Line No
        TempTable.SetCurrentKey("Line No.");

        if TempTable.FindLast() then
            exit(TempTable."Line No.")
        else
            exit(0);
    end;

    procedure GetReceiptNo()
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        ApplyCustLedgEntry: Record "Cust. Ledger Entry";
        GatePassLineRec: Record "Gate Pass Out Line";
    begin
        GatePassLineRec.Reset();
        GatePassLineRec.SetRange("Gate Pass No.", GPNo);
        if GatePassLineRec.FindSet() then begin
            repeat
                CustLedgEntry.Reset();
                CustLedgEntry.SetRange("Document No.", GatePassLineRec."Invoice No.");
                CustLedgEntry.SetRange(Open, false);
                IF CustLedgEntry.FindFirst() then begin
                    ApplyCustLedgEntry.Reset();
                    ApplyCustLedgEntry.SetRange("Entry No.", CustLedgEntry."Closed by Entry No.");
                    if ApplyCustLedgEntry.FindFirst() then begin
                        GatePassLineRec."Receipt No." := ApplyCustLedgEntry."Document No.";
                        GatePassLineRec.Modify();
                    end;
                end else begin
                    Message('receipt not found');
                    exit;
                end;
            //exit;
            until GatePassLineRec.next = 0;
        end;
    end;

    var
        GPHead: Record "Gate Pass Out";
        GPLine, GatePassLine : Record "Gate Pass Out Line";




}

