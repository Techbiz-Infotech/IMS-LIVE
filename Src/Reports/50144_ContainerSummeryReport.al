report 50144 "Container Summary Report"
{
    UsageCategory = Administration;
    Caption = 'Container Summary Report';
    ProcessingOnly = true;
    ApplicationArea = all;
    dataset
    {
        dataitem(Date; Date)
        {
            DataItemTableView = sorting("Period Type") where("Period Type" = filter(date));

            trigger OnPreDataItem()
            begin
                SetFilter("Period Start", '%1..%2', StartDate, EndDate);
                i := 1;
            end;

            trigger OnAfterGetRecord()
            begin
                Clear(ReceivedDate20FT);
                Clear(ReceivedDate40FT);
                Clear(ReleasedDate20FT);
                Clear(ReleasedDate40FT);
                Clear(OpeningBalance20FT);
                Clear(OpeningBalance40FT);

                TempExcelBuffer.NewRow();
                ManifestLineRec.Reset();
                ManifestLineRec.SetRange(Received, true);
                ManifestLineRec.SetRange("Date Received", "Period Start");
                ManifestLineRec.SetRange("Shortcut Dimension 5 Code", '20FT');
                ManifestLineRec.SetRange("Shortcut Dimension 4 Code", 'Container');
                if ManifestLineRec.Findset() then
                    ReceivedDate20FT := ManifestLineRec.Count;

                ManifestLineRec.Reset();
                ManifestLineRec.SetRange(Received, true);
                ManifestLineRec.SetRange("Date Received", "Period Start");
                ManifestLineRec.SetRange("Shortcut Dimension 5 Code", '40FT');
                ManifestLineRec.SetRange("Shortcut Dimension 4 Code", 'Container');
                if ManifestLineRec.Findset() then
                    ReceivedDate40FT := ManifestLineRec.Count;

                ManifestLineRec.Reset();
                ManifestLineRec.SetRange(Released, true);
                ManifestLineRec.SetRange("Date Released", "Period Start");
                ManifestLineRec.SetRange("Shortcut Dimension 5 Code", '20FT');
                ManifestLineRec.SetRange("Shortcut Dimension 4 Code", 'Container');
                IF ManifestLineRec.FindSet() then
                    ReleasedDate20FT := ManifestLineRec.Count;

                ManifestLineRec.Reset();
                ManifestLineRec.SetRange(Released, true);
                ManifestLineRec.SetRange("Date Released", "Period Start");
                ManifestLineRec.SetRange("Shortcut Dimension 4 Code", 'Container');
                ManifestLineRec.SetRange("Shortcut Dimension 5 Code", '40FT');
                IF ManifestLineRec.FindSet() then
                    ReleasedDate40FT := ManifestLineRec.Count;

                ManifestLineRec.Reset();
                ManifestLineRec.SetRange(Received, true);
                ManifestLineRec.SetRange("Date Received", 20000101D, CalcDate('<-1D>', "Period Start"));
                ManifestLineRec.SetFilter("Date Released", '<%1|>%2', 19700101D, CalcDate('<-1D>', "Period Start"));
                ManifestLineRec.SetRange("Shortcut Dimension 5 Code", '20FT');
                ManifestLineRec.SetRange("Shortcut Dimension 4 Code", 'Container');
                if ManifestLineRec.FindSet() then
                    OpeningBalance20FT := ManifestLineRec.Count;
                //Message(Format(ManifestLineRec.GetFilters));

                ManifestLineRec.Reset();
                ManifestLineRec.SetRange(Received, true);
                ManifestLineRec.SetRange("Date Received", 20000101D, CalcDate('<-1D>', "Period Start"));
                ManifestLineRec.SetFilter("Date Released", '<%1|>%2', 19700101D, CalcDate('<-1D>', "Period Start"));
                ManifestLineRec.SetRange("Shortcut Dimension 5 Code", '40FT');
                ManifestLineRec.SetRange("Shortcut Dimension 4 Code", 'Container');
                if ManifestLineRec.FindSet() then
                    OpeningBalance40FT := ManifestLineRec.Count;

                IF Not OpeningBln then
                    ClosingBalance20FT := OpeningBalance20FT + ReceivedDate20FT - ReleasedDate20FT
                Else
                    ClosingBalance20FT := ClosingBalance20FT + ReceivedDate20FT - ReleasedDate20FT;
                if not OpeningBln then
                    ClosingBalance40FT := OpeningBalance40FT + ReceivedDate40FT - ReleasedDate40FT
                else
                    ClosingBalance40FT := ClosingBalance40FT + ReceivedDate40FT - ReleasedDate40FT;
                OpeningBln := true;

                //Opening Stock Count start
                IF i = 1 then begin
                    //TempExcelBuffer.NewRow();
                    TempExcelBuffer.AddColumn('Opening Stock', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(OpeningBalance20FT, false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(OpeningBalance40FT, false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(OpeningBalance20FT + OpeningBalance40FT, false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(OpeningBalance20FT + (OpeningBalance40FT * 2), false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.NewRow();
                End;
                //opening stock Count End
                //
                TempExcelBuffer.AddColumn("Period Start", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
                TempExcelBuffer.AddColumn(ReceivedDate20FT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(ReceivedDate40FT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(ReceivedDate20FT + ReceivedDate40FT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(ReceivedDate20FT + (ReceivedDate40FT * 2), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(ReleasedDate20FT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(ReleasedDate40FT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(ReleasedDate20FT + ReleasedDate40FT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(ReleasedDate40FT + (ReleasedDate40FT * 2), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(ClosingBalance20FT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(ClosingBalance40FT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(ClosingBalance20FT + ClosingBalance40FT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(ClosingBalance20FT + (ClosingBalance40FT * 2), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                i := 0;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(options)
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = all;
                        Caption = 'Start Date';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = all;
                        Caption = 'End Date';
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnPreReport()

    begin
        //StartDate := Today;
        //EndDate := Today;
        TempExcelBuffer.Reset();
        TempExcelBuffer.DELETEALL();

        MakeHeader;
        MakeBody;
    end;

    trigger OnPostReport()
    begin
        CreateExcelBook; // Create Excel Book
    end;

    var
        StartDate: Date;
        EndDate: Date;
        TempExcelBuffer: Record "Excel Buffer" temporary;
        ManifestLineRec: Record "Manifest Line";
        ReceivedDate20FT: Integer;
        ReceivedDate40FT: Integer;
        ReleasedDate20FT: Integer;
        ReleasedDate40FT: Integer;
        ClosingBalance20FT: Integer;
        ClosingBalance40FT: Integer;
        OpeningBalance20FT: Integer;
        OpeningBalance40FT: Integer;
        i: Integer;
        OpeningBln: Boolean;

    local procedure MakeHeader()

    var
        MyInt: Integer;
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Container summary Report', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Received', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Delivered out', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Balance', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);

        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Date', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('20FT', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('40FT', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Total', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('TEUs', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('20FT', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('40FT', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Total', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('TEUs', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('20FT', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('40FT', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Total', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('TEUs', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
    end;

    local procedure MakeBody()
    begin

    end;



    Local procedure CreateExcelBook();
    begin
        TempExcelBuffer.CreateNewBook('Container Summary Report');
        TempExcelBuffer.WriteSheet('Container Summary Report', CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename('Container Summary Report');
        TempExcelBuffer.OpenExcel();
    end;

}
