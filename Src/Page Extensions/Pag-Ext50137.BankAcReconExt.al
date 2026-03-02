pageextension 50137 BankAcReconExt extends "Bank Acc. Reconciliation"
{
    actions
    {
        modify(ImportBankStatement)
        {
            ApplicationArea = all;
            Visible = false;
        }
        addbefore("&Card")
        {
            action("&Import IMS Bank Statement")
            {
                Caption = '&Import IMS Bank Statement';
                Image = ImportExcel;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                ToolTip = 'Import data from excel.';

                trigger OnAction()
                var
                begin
                    //if BatchName = '' then
                    //  Error(BatchISBlankMsg);
                    ReadExcelSheet();
                    ImportExcelData();
                end;
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
        BankAccRecon: Record "Bank Acc. Reconciliation";
        BankAccReconLine: Record "Bank Acc. Reconciliation Line";
        PurchLine: Record "Purchase Line";
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
        BankAccReconLine.Reset();
        BankAccReconLine.SetRange("Statement Type", Rec."Statement Type");
        BankAccReconLine.SetRange("Bank Account No.", Rec."Bank Account No.");
        BankAccReconLine.SetRange("Statement No.", Rec."Statement No.");
        if BankAccReconLine.FindLast() then
            LineNo := BankAccReconLine."Statement Line No." + 10000
        else
            LineNo := 10000;

        TempExcelBuffer.Reset();
        if TempExcelBuffer.FindLast() then begin
            MaxRowNo := TempExcelBuffer."Row No.";
        end;

        for RowNo := 2 to MaxRowNo do begin
            LineNo := LineNo + 10000;

            BankAccReconLine.Init();
            BankAccReconLine.validate("Statement Type", Rec."Statement Type");
            BankAccReconLine.validate("Bank Account No.", Rec."Bank Account No.");
            BankAccReconLine.validate("Statement No.", Rec."Statement No.");
            BankAccReconLine.Validate("Statement Line No.", LineNo);
            Evaluate(BankAccReconLine."Transaction Date", GetValueAtCell(RowNo, 1));
            BankAccReconLine.validate("Transaction Date");
            BankAccReconLine.Validate(Description, GetValueAtCell(RowNo, 2));
            Evaluate(BankAccReconLine."Statement Amount", GetValueAtCell(RowNo, 3));
            BankAccReconLine.validate("Statement Amount");
            BankAccReconLine.Insert(true);
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

