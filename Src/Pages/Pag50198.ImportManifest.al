page 50198 "Import Manifest"
{
    Caption = 'Import Manifest';
    PageType = Worksheet;
    SourceTable = ImportManifest;
    //SourceTableView = sorting("Job File No.", "Line No.");
    // ApplicationArea = all;
    UsageCategory = Lists;
    AutoSplitKey = true;
    // DelayedInsert=true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job File No."; rec."Job File No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Job File No. field.';
                    Visible = false;

                }
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = all;
                    ToolTip = ' Specifies the value of theLine No. field';
                    Visible = false;
                }
                field("Job File Date"; rec."Job File Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job File Date field.';
                }
                field("BL No."; Rec."BL No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BL No. field.';

                }
                field("Container/Chassis No."; Rec."Container/Chassis No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Container/Chassis No. field.';
                }
                field("CBM Tonage"; Rec."CBM Tonage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CBM Tonage field.';
                }
                field("COntainer ID"; Rec."COntainer ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Container Id field.';
                }
                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.';
                    StyleExpr = StyleExprTxtRemarks;
                }
                field("Clearing Agent"; Rec."Clearing Agent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Clearing Agent field.';
                }
                field("Consignee No."; rec."Consignee No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Consignee No. field.';
                    StyleExpr = StyleExprTxt;
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consignee Name field.';
                    Editable = false;
                }
                field("Container Type"; Rec."Container Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Container Type field.';
                }
                field("Container size"; Rec."Container size")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Container Size field.';
                    StyleExpr = StyleExprTxtContainersize;
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
                field("Invoicing Party No."; Rec."Invoicing Party No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invoicing Party No. field.';
                    StyleExpr = StyleExprTxtInvoiceNo;
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
                field("Seal/Engine No."; Rec."Seal/Engine No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seal/Engine No. field.';
                }
                field(Weight; Rec.Weight)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Weight field.';
                }
                field("Cargo Type"; Rec."Cargo Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cargo Type field.';
                    StyleExpr = StyleExprTxtcargotype;
                }
                field("Client Type"; rec."Client Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Client Type field.';
                    StyleExpr = StyleExprTxtcargotype;
                }
                field("Shipping Agent"; Rec."Shipping Agent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipping Agent field.';
                    StyleExpr = StyleExprTxtcargotype;
                }
                field("Vessel Name"; rec."Vessel Name")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleExprTxtcargotype;
                    ToolTip = 'Specifies the value of the Vessel Name field.';
                }
                field("Vessel Arrival Date"; rec."Vessel Arrival Date")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleExprTxtcargotype;
                    ToolTip = 'Specifies the value of the Vessel Arrival Date field.';
                }
                field("Vessel Arrival Time"; rec."Vessel Arrival Time")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleExprTxtcargotype;
                    ToolTip = 'Specifies the value of the Vessel Arrival Time field.';
                }

                field("Process Type"; rec."Process Type")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleExprTxtProcesstype;
                    ToolTip = 'Specifies the value of the Process Type field.';
                }
                field("Parent Container ID"; Rec."Parent Container ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Process Type field.';
                }
                field("TBL/MH"; rec."TBL/MH")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the TBL/MH field.';
                }


            }
        }
    }
    actions
    {
        area(Processing)
        {

            action("&Import")
            {
                Caption = '&Import Lines';
                Image = ImportExcel;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                ToolTip = 'Import data from excel.';
                //Visible = false;
                trigger OnAction()
                var
                begin
                    ReadExcelSheet();
                    ImportExcelData();
                end;
            }
            // action(Process)
            // {
            //     ApplicationArea = all;
            //     Image = Process;
            //     Caption = 'Process Lines';
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     ToolTip = 'Process data.';
            //     Visible = false;
            //     trigger OnAction()
            //     var
            //     begin
            //         Rec.ImportManifestProcess(JobfileNo);
            //         CurrPage.Update(false);
            //     end;

            //}
            action(Validate)
            {
                ApplicationArea = all;
                Image = ValidateEmailLoggingSetup;
                Caption = 'Validate Lines';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Validate data.';
                trigger OnAction()
                var
                begin
                    Rec.ImportManifestValidate();
                    CurrPage.Update(false);
                end;

            }
            action("Create")
            {
                Caption = 'Create Manifest Lines';
                Image = Create;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                ToolTip = 'Create data.';
                trigger OnAction()
                begin
                    rec.Createmanifest();
                end;
            }

        }

    }
    var
        ImportManifest: Record ImportManifest;
        // JobfileNo: Code[20];
        BatchName: Code[10];
        NoSeriesMgt: Codeunit "No. Series";
        FileName: Text[100];
        SheetName: Text[100];
        StyleExprTxt: Text;
        TempExcelBuffer: Record "Excel Buffer" temporary;
        UploadExcelMsg: Label 'Please Choose the Excel file.';
        NoFileFoundMsg: Label 'No Excel file found!';
        BatchISBlankMsg: Label 'Batch name is blank';
        ExcelImportSucess: Label 'Excel is successfully imported.';
        NewJobfileNo: Code[20];
        StyleExprTxtInvoiceNo: text;
        StyleExprTxtcargotype: Text;
        StyleExprTxtRemarks: Text;
        StyleExprTxtContainersize: Text;
        StyleExprTxtProcesstype: Text;
        StyleExprShippingagent: Text;

    procedure updatemanifest()
    var
        importmanifest: Record ImportManifest;
        manifestline: Record "Manifest Line";
    begin
        importmanifest.Reset();
        importmanifest.SetRange("Job File No.", manifestline."Job File No.");
        if importmanifest.FindFirst() then
            repeat
                manifestline.Reset();
                manifestline.SetRange("Job File No.", importmanifest."Job File No.");
                //manifestline.SetRange("Line No.", VerRec."Manifest Line No.");
                if manifestline.FindFirst() then begin
                    manifestline."BL No." := importmanifest."BL No.";
                    manifestline."Global Dimension 1 Code" := importmanifest."COntainer ID";
                    manifestline."CBM Tonage" := importmanifest."CBM Tonage";
                    manifestline.Modify;
                end;
            until importmanifest.next = 0;
    end;

    trigger OnAfterGetRecord()

    begin
        StyleExprTxt := Rec.ColourChangeCustomerNo();
        StyleExprTxtRemarks := Rec.ColourChangeRemarks();
        StyleExprTxtcargotype := Rec.ColourCargoType();
        StyleExprTxtContainersize := Rec.ColourChangeContainerSize();
        StyleExprTxtInvoiceNo := Rec.ColourChangeInvoicingNo();
        StyleExprTxtProcesstype := Rec.ColourProcessType();
        StyleExprShippingagent := rec.ColourChangeShippingagentNo();
    end;

    // procedure GetJobfileNo(var NewJobfileNo: Code[20])
    // begin
    //     JobfileNo := NewJobfileNo;
    // end;

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
        ImportManifestLine, IWS : Record ImportManifest;
        RowNo: Integer;
        ColNo: Integer;
        LineNo: Integer;
        MaxRowNo: Integer;
        JFileNo: Code[20];
        IMSSetup: Record "IMS Setup";
        ShortcutDimCode: array[8] of Code[20];
        Blno: Code[20];

    begin
        IMSSetup.Get();
        RowNo := 0;
        ColNo := 0;
        MaxRowNo := 0;
        LineNo := 0;
        ImportManifestLine.Reset();
        // ImportManifestLine.SetRange("Job File No.", JobfileNo);
        if ImportManifestLine.FindFirst() then
            ImportManifestLine.DeleteAll();
        LineNo := 10000;
        TempExcelBuffer.Reset();
        if TempExcelBuffer.FindLast() then begin
            MaxRowNo := TempExcelBuffer."Row No.";
        end;
        IMSSetup.TestField("Job File Nos");
        for RowNo := 2 to MaxRowNo do begin
            LineNo := LineNo + 10000;
            Blno := GetValueAtCell(RowNo, 3);
            IWS.Reset();
            IWS.SetRange("BL No.", Blno);
            if IWS.FindFirst() then
                JFileNo := IWS."Job File No."
            else
                JFileNo := NoSeriesMgt.GetNextNo(IMSSetup."Job File Nos", WorkDate(), true);
            ImportManifestLine.Init();
            ImportManifestLine.validate("Job File No.", JFileNo);
            ImportManifestLine.Validate("Line No.", LineNo);
            ImportManifestLine.Insert();
            Evaluate(ImportManifestLine."Vessel Name", GetValueAtCell(RowNo, 1));
            Evaluate(ImportManifestLine."Vessel Arrival Date", GetValueAtCell(RowNo, 2));
            Evaluate(ImportManifestLine."BL No.", GetValueAtCell(RowNo, 3));
            Evaluate(ImportManifestLine."Container/Chassis No.", GetValueAtCell(RowNo, 4));
            Evaluate(ImportManifestLine."Container size", GetValueAtCell(RowNo, 5));
            Evaluate(ImportManifestLine."Seal/Engine No.", GetValueAtCell(RowNo, 6));
            Evaluate(ImportManifestLine.Weight, GetValueAtCell(RowNo, 7));
            Evaluate(ImportManifestLine."CBM Tonage", GetValueAtCell(RowNo, 8));
            Evaluate(ImportManifestLine.Description, GetValueAtCell(RowNo, 9));
            Evaluate(ImportManifestLine."Cargo Type", GetValueAtCell(RowNo, 10));
            Evaluate(ImportManifestLine."Container Type", GetValueAtCell(RowNo, 11));
            Evaluate(ImportManifestLine."Port of Shipment", GetValueAtCell(RowNo, 12));
            Evaluate(ImportManifestLine."Port of Discharge", GetValueAtCell(RowNo, 13));
            Evaluate(ImportManifestLine."Destination Type", GetValueAtCell(RowNo, 14));
            Evaluate(ImportManifestLine."Clearing Agent", GetValueAtCell(RowNo, 15));
            Evaluate(ImportManifestLine."Consignee No.", GetValueAtCell(RowNo, 16));
            Evaluate(ImportManifestLine."Invoicing Party No.", GetValueAtCell(RowNo, 17));
            Evaluate(ImportManifestLine."Shipping Agent", GetValueAtCell(RowNo, 18));
            //  Evaluate(ImportManifestLine."Job File Date", GetValueAtCell(RowNo, 19));
            Evaluate(ImportManifestLine."Process Type", GetValueAtCell(RowNo, 19));
            Evaluate(ImportManifestLine."Client Type", GetValueAtCell(RowNo, 20));
            Evaluate(ImportManifestLine."Parent Container ID", GetValueAtCell(RowNo, 21));
            Evaluate(ImportManifestLine."TBL/MH", GetValueAtCell(RowNo, 22));
            // Evaluate(ImportManifestLine."Voyage No.", GetValueAtCell(RowNo, 19));
            // Evaluate(ImportManifestLine."Vessel Arrival Time", GetValueAtCell(RowNo, 20));
            // Evaluate(ImportManifestLine."Expected Arrival Date", GetValueAtCell(RowNo, 21));
            // Evaluate(ImportManifestLine."Last Sling Date", GetValueAtCell(RowNo, 22));


            ImportManifestLine.Validate("Vessel Name");
            ImportManifestLine.Validate("Vessel Arrival Date");
            ImportManifestLine.Validate(ImportManifestLine."BL No.");
            ImportManifestLine.Validate("Container/Chassis No.");
            ImportManifestLine.Validate("Container size");
            ImportManifestLine.Validate("Seal/Engine No.");
            ImportManifestLine.Validate(Weight);
            ImportManifestLine.Validate("CBM Tonage");
            ImportManifestLine.Validate(Description);
            ImportManifestLine.Validate("Cargo Type");
            ImportManifestLine.Validate("Container Type");
            ImportManifestLine.Validate("Port of Shipment");
            ImportManifestLine.Validate("Port of Discharge");
            ImportManifestLine.Validate("Destination Type");
            ImportManifestLine.Validate("Clearing Agent");
            ImportManifestLine.Validate("Consignee No.");
            ImportManifestLine.Validate("Invoicing Party No.");
            ImportManifestLine.Validate("Shipping Agent");
            ImportManifestLine.Validate("Job File Date", Today);
            // ImportManifestLine.Validate("Job File Date");
            ImportManifestLine.Validate("Process Type");

            ImportManifestLine.Validate("Client Type");
            ImportManifestLine.Validate("Parent Container ID");
            ImportManifestLine.Validate("TBL/MH");

            //ImportManifestLine.Validate("Vessel Arrival Time");
            // ImportManifestLine.Validate("Expected Arrival Date");
            // ImportManifestLine.Validate("Last Sling Date");


            ImportManifestLine.Modify();
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

    // trigger OnOpenPage();
    // var
    //     LockRec: Record PageLockTable;
    //     MyUserID: Code[50];
    // begin
    //     MyUserID := UserId();

    //     // Check if another user has locked the page
    //     if LockRec.Get(Page::"Import Manifest") then begin
    //         if LockRec."User ID" <> MyUserID then
    //             Error('Page is currently being used by %1. Try again later.', LockRec."User ID");
    //     end;
    //     // Lock the page for this user
    //     LockRec.Init();
    //     LockRec."Page ID" := Page::"Import Manifest";
    //     LockRec."User ID" := MyUserID;
    //     LockRec."Time stamp" := CurrentDateTime;
    //     LockRec.Insert(true);
    // end;

    // trigger OnClosePage();
    // var
    //     LockRec: Record PageLockTable;
    // begin
    //     if LockRec.Get(Page::"Import Manifest") then
    //         if LockRec."User ID" = UserId() then
    //             LockRec.Delete();
    // end;
}


