page 50113 Manifest
{
    Caption = 'Old Manifests';
    PageType = Document;
    SourceTable = "Manifest Header";
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Job File No."; rec."Job File No.")
                {
                    ToolTip = 'Specifies the value of the JobFileNumber field.';
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                    begin
                        if rec.OnAssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }

                field("Date File Opened"; rec."Date File Opened")
                {
                    ToolTip = 'Specifies the value of the DateFileOpened field.';
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the ClientType field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ToolTip = 'Specifies the value of the ProcessType field.';
                    ApplicationArea = All;
                }
                group(Others)
                {
                    field("Shipping Agent"; Rec."Shipping Agent")
                    {
                        ToolTip = 'Specifies the value of the ShippingAgent field.';
                        ApplicationArea = All;
                    }
                    field("Shipping Agent Name"; Rec."Shipping Agent Name")
                    {
                        ToolTip = 'Specifies the value of the Shipping Agent Name field.';
                        ApplicationArea = All;
                    }

                    field("VesselName"; Rec."Vessel Name")
                    {
                        ToolTip = 'Specifies the value of the VesselName field.';
                        ApplicationArea = All;
                    }
                    field("VoyageNo"; Rec."Voyage No.")
                    {
                        ToolTip = 'Specifies the value of the VoyageNo field.';
                        ApplicationArea = All;
                    }
                    field("Expected Arrival Date"; Rec."Expected Arrival Date")
                    {
                        ToolTip = 'Specifies the value of the Expected Arrival Date field.';
                        ApplicationArea = All;
                    }
                    field("Vessel Arrival Date"; Rec."Vessel Arrival Date")
                    {
                        ToolTip = 'Specifies the value of the Vessel Arrival Date field.';
                        ApplicationArea = All;
                    }
                    field("Vessel Arrival Time"; Rec."Vessel Arrival Time")
                    {
                        ToolTip = 'Specifies the value of the Vessel Arrival Time field.';
                        ApplicationArea = All;
                    }
                    field("Last Sling Date"; Rec."Last Sling Date")
                    {
                        ToolTip = 'Specifies the value of the LastSlingDate field.';
                        ApplicationArea = All;
                    }

                    field("User ID"; rec."User ID")
                    {
                        ToolTip = 'Specifies the value of the Status field.';
                        ApplicationArea = All;
                        Visible = false;
                    }
                }
            }
            part(ManifestLine; "Manifest Line Subform")
            {
                Caption = 'Manifest Line';
                ApplicationArea = all;
                SubPageLink = "Job File No." = field("Job File No.");
                UpdatePropagation = Both;
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
                Visible = false;
                //RunObject = page "Import worksheet";
                // RunPageLink = "Job File No." = field("Job File No.");
                // trigger OnAction()
                // var
                //     Importworksheet: Page "Import Manifest";
                //     ImportWS: Record ImportManifest;
                // begin
                //     ImportWS.Reset();
                //     ImportWS.SetRange("Job File No.", Rec."Job File No.");
                //     Clear(Importworksheet);
                //     Importworksheet.SetTableView(ImportWS);
                //     Importworksheet.SetRecord(ImportWS);
                //     Importworksheet.LookupMode(true);
                //     Importworksheet.GetJobfileNo(Rec."Job File No.");
                //     if Importworksheet.RunModal() = Action::LookupOK then begin
                //     end;
                // end;
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


    local procedure ReadExcelSheet()
    var
        FileMgt: Codeunit "File Management";
        IStream: InStream;
        FromFile: Text[100];
    begin
        UploadIntoStream(UploadExcelMsg, '', '', FromFile, IStream);
        if FromFile <> '' then begin
            FileName := FileMgt.GetFileName(FromFile);
            SheetName := TempExcelBuffer.SelectSheetsNameStream(IStream);
        end else
            Error(NoFileFoundMsg);
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.OpenBookStream(IStream, SheetName);
        TempExcelBuffer.ReadSheet();
    end;

    local procedure ImportExcelData()
    var
        ManifestLine: Record "Manifest Line";
        RowNo: Integer;
        ColNo: Integer;
        LineNo: Integer;
        MaxRowNo: Integer;
        ShortcutDimCode: array[8] of Code[20];
    begin
        RowNo := 0;
        ColNo := 0;
        MaxRowNo := 0;
        LineNo := 0;

        if ManifestLine.FindLast() then
            LineNo := ManifestLine."Line No." + 10000
        else
            LineNo := 10000;

        TempExcelBuffer.Reset();
        if TempExcelBuffer.FindLast() then begin
            MaxRowNo := TempExcelBuffer."Row No.";
        end;

        for RowNo := 2 to MaxRowNo do begin
            LineNo := LineNo + 10000;

            ManifestLine.Init();
            ManifestLine.validate("Job File No.", rec."Job File No.");
            ManifestLine.Validate("Line No.", LineNo);
            ManifestLine.Insert();
            ManifestLine.validate("Job File Date", rec."Date File Opened");
            Evaluate(ManifestLine."BL No.", GetValueAtCell(RowNo, 1));
            ManifestLine.Validate(ManifestLine."BL No.");
            Evaluate(ManifestLine."Container/Chassis No.", GetValueAtCell(RowNo, 2));
            Evaluate(ManifestLine."Seal/Engine No.", GetValueAtCell(RowNo, 3));
            Evaluate(ManifestLine."Shortcut Dimension 4 Code", GetValueAtCell(RowNo, 4));
            Evaluate(ManifestLine.Marks, GetValueAtCell(RowNo, 5));
            Evaluate(ManifestLine."Container Type", GetValueAtCell(RowNo, 6));
            Evaluate(ManifestLine."Shortcut Dimension 5 Code", GetValueAtCell(RowNo, 7));
            Evaluate(ManifestLine.Description, GetValueAtCell(RowNo, 8));
            Evaluate(ManifestLine."CBM Tonage", GetValueAtCell(RowNo, 9));
            Evaluate(ManifestLine.Weight, GetValueAtCell(RowNo, 10));
            Evaluate(ManifestLine."Port of Shipment", GetValueAtCell(RowNo, 11));
            Evaluate(ManifestLine."Port of Discharge", GetValueAtCell(RowNo, 12));
            Evaluate(ManifestLine."Destination Type", GetValueAtCell(RowNo, 13));
            Evaluate(ManifestLine."Clearing Agent", GetValueAtCell(RowNo, 14));
            Evaluate(ManifestLine."Consignee No.", GetValueAtCell(RowNo, 15));
            Evaluate(ManifestLine."Invoicing Party No.", GetValueAtCell(RowNo, 16));
            ManifestLine.Validate("Container/Chassis No.");
            ManifestLine.Validate("Seal/Engine No.");
            ManifestLine.Validate("Shortcut Dimension 4 Code");
            ManifestLine.Validate(Marks);
            ManifestLine.Validate("Container Type");
            ManifestLine.Validate("Shortcut Dimension 5 Code");
            ManifestLine.Validate(Description);
            ManifestLine.Validate("CBM Tonage");
            ManifestLine.Validate(Weight);
            ManifestLine.Validate("Port of Shipment");
            ManifestLine.Validate("Port of Discharge");
            ManifestLine.Validate("Destination Type");
            ManifestLine.Validate("Clearing Agent");
            ManifestLine.Validate("Consignee No.");
            ManifestLine.Validate("Invoicing Party No.");
            ManifestLine.Modify();
        end;
        Message(ExcelImportSucess);
    end;

    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    begin

        TempExcelBuffer.Reset();
        If TempExcelBuffer.Get(RowNo, ColNo) then
            exit(TempExcelBuffer."Cell Value as Text")
        else
            exit('');
    end;

}
