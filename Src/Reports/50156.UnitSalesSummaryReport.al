report 50156 UnitSalesSummaryReport
{
    ApplicationArea = All;
    Caption = 'UnitSalesSummaryReport';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
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
                Clear(ReceivedDate1MT);
                Clear(ReceivedDate2MT);
                Clear(ReceivedDate5MT);
                Clear(ReceivedDate10MT);
                Clear(ReceivedDateOver10MT);

                Clear(ReleasedDate1MT);
                Clear(ReleasedDate2MT);
                Clear(ReleasedDate5MT);
                Clear(ReleasedDate10MT);
                Clear(ReleasedDateOver10MT);

                Clear(OpeningBalance1MT);
                Clear(OpeningBalance2MT);
                Clear(OpeningBalance5MT);
                Clear(OpeningBalance10MT);
                Clear(OpeningBalanceOver10MT);

                ManifestLineRec.Reset();
                ManifestLineRec.SetRange(Received, true);
                ManifestLineRec.SetRange("Date Received", "Period Start");
                ManifestLineRec.SetRange("Shortcut Dimension 5 Code", '1.5MT');
                ManifestLineRec.SetRange("Shortcut Dimension 4 Code", 'unit');
                if ManifestLineRec.Findset() then
                    ReceivedDate1MT := ManifestLineRec.Count;

                ManifestLineRec.Reset();
                ManifestLineRec.SetRange(Received, true);
                ManifestLineRec.SetRange("Date Received", "Period Start");
                ManifestLineRec.SetRange("Shortcut Dimension 5 Code", '2.0MT');
                ManifestLineRec.SetRange("Shortcut Dimension 4 Code", 'Unit');
                if ManifestLineRec.Findset() then
                    ReceivedDate2MT := ManifestLineRec.Count;

                ManifestLineRec.Reset();
                ManifestLineRec.SetRange(Received, true);
                ManifestLineRec.SetRange("Date Received", "Period Start");
                ManifestLineRec.SetRange("Shortcut Dimension 5 Code", '5.0MT');
                ManifestLineRec.SetRange("Shortcut Dimension 4 Code", 'unit');
                if ManifestLineRec.Findset() then
                    ReceivedDate5MT := ManifestLineRec.Count;

                ManifestLineRec.Reset();
                ManifestLineRec.SetRange(Received, true);
                ManifestLineRec.SetRange("Date Received", "Period Start");
                ManifestLineRec.SetRange("Shortcut Dimension 5 Code", '10MT');
                ManifestLineRec.SetRange("Shortcut Dimension 4 Code", 'Unit');
                if ManifestLineRec.Findset() then
                    ReceivedDate10MT := ManifestLineRec.Count;

                ManifestLineRec.Reset();
                ManifestLineRec.SetRange(Received, true);
                ManifestLineRec.SetRange("Date Received", "Period Start");
                ManifestLineRec.SetRange("Shortcut Dimension 5 Code", 'Over 10MT');
                ManifestLineRec.SetRange("Shortcut Dimension 4 Code", 'Unit');
                if ManifestLineRec.Findset() then
                    ReceivedDateOver10MT := ManifestLineRec.Count;

                ManifestLineRec.Reset();
                ManifestLineRec.SetRange(Released, true);
                ManifestLineRec.SetRange("Date Released", "Period Start");
                ManifestLineRec.SetRange("Shortcut Dimension 5 Code", '1.5MT');
                ManifestLineRec.SetRange("Shortcut Dimension 4 Code", 'Unit');
                IF ManifestLineRec.FindSet() then
                    ReleasedDate1MT := ManifestLineRec.Count;

                ManifestLineRec.Reset();
                ManifestLineRec.SetRange(Released, true);
                ManifestLineRec.SetRange("Date Released", "Period Start");
                ManifestLineRec.SetRange("Shortcut Dimension 5 Code", '2.0MT');
                ManifestLineRec.SetRange("Shortcut Dimension 4 Code", 'Unit');
                IF ManifestLineRec.FindSet() then
                    ReleasedDate2MT := ManifestLineRec.Count;

                ManifestLineRec.Reset();
                ManifestLineRec.SetRange(Released, true);
                ManifestLineRec.SetRange("Date Released", "Period Start");
                ManifestLineRec.SetRange("Shortcut Dimension 5 Code", '5MT');
                ManifestLineRec.SetRange("Shortcut Dimension 4 Code", 'Unit');
                IF ManifestLineRec.FindSet() then
                    ReleasedDate5MT := ManifestLineRec.Count;

                ManifestLineRec.Reset();
                ManifestLineRec.SetRange(Released, true);
                ManifestLineRec.SetRange("Date Released", "Period Start");
                ManifestLineRec.SetRange("Shortcut Dimension 5 Code", '10MT');
                ManifestLineRec.SetRange("Shortcut Dimension 4 Code", 'Unit');
                IF ManifestLineRec.FindSet() then
                    ReleasedDate10MT := ManifestLineRec.Count;

                ManifestLineRec.Reset();
                ManifestLineRec.SetRange(Released, true);
                ManifestLineRec.SetRange("Date Released", "Period Start");
                ManifestLineRec.SetRange("Shortcut Dimension 5 Code", 'Over 10MT');
                ManifestLineRec.SetRange("Shortcut Dimension 4 Code", 'Unit');
                IF ManifestLineRec.FindSet() then
                    ReleasedDateOver10MT := ManifestLineRec.Count;


                ManifestLineRec.Reset();
                ManifestLineRec.SetRange(Received, true);
                ManifestLineRec.SetRange("Date Received", 20000101D, CalcDate('<-1D>', "Period Start"));
ManifestLineRec.SetFilter("Date Released", '<%1|>%2', 19700101D, CalcDate('<-1D>', "Period Start"));
                //ManifestLineRec.SetRange("Date Received", 20000101D, CalcDate('<-1M+CM>',"Period Start"));
                //ManifestLineRec.SetRange(Released, false);
                ManifestLineRec.SetRange("Shortcut Dimension 5 Code", '1.5MT');
                ManifestLineRec.SetRange("Shortcut Dimension 4 Code", 'UNIT');
                if ManifestLineRec.FindSet() then
                    //ClosingBalance20FT := ManifestLineRec.Count;
                    OpeningBalance1MT := ManifestLineRec.Count;
                //Message('%1|%2', CalcDate('<-1M+CM>', Today), ClosingBalance20FT);

                ManifestLineRec.Reset();
                ManifestLineRec.SetRange(Received, true);
                ManifestLineRec.SetRange("Date Received", 20000101D, CalcDate('<-1D>', "Period Start"));
ManifestLineRec.SetFilter("Date Released", '<%1|>%2', 19700101D, CalcDate('<-1D>', "Period Start"));
                //ManifestLineRec.SetRange("Date Received", 20000101D, CalcDate('<-1M+CM>',"Period Start"));
                //ManifestLineRec.SetRange(Released, false);
                ManifestLineRec.SetRange("Shortcut Dimension 5 Code", '2.0MT');
                ManifestLineRec.SetRange("Shortcut Dimension 4 Code", 'UNIT');
                if ManifestLineRec.FindSet() then
                    //ClosingBalance40FT := ManifestLineRec.Count;
                    OpeningBalance2MT := ManifestLineRec.Count;



                ManifestLineRec.Reset();
                ManifestLineRec.SetRange(Received, true);
                ManifestLineRec.SetRange("Date Received", 20000101D, CalcDate('<-1D>', "Period Start"));
ManifestLineRec.SetFilter("Date Released", '<%1|>%2', 19700101D, CalcDate('<-1D>', "Period Start"));
                //ManifestLineRec.SetRange("Date Received", 20000101D, CalcDate('<-1M+CM>',"Period Start"));
               // ManifestLineRec.SetRange(Released, false);
                ManifestLineRec.SetRange("Shortcut Dimension 5 Code", '5.0MT');
                ManifestLineRec.SetRange("Shortcut Dimension 4 Code", 'UNIT');
                if ManifestLineRec.FindSet() then
                    OpeningBalance5MT := ManifestLineRec.Count;

                ManifestLineRec.Reset();
                ManifestLineRec.SetRange(Received, true);
                ManifestLineRec.SetRange("Date Received", 20000101D, CalcDate('<-1D>', "Period Start"));
ManifestLineRec.SetFilter("Date Released", '<%1|>%2', 19700101D, CalcDate('<-1D>', "Period Start"));
                //ManifestLineRec.SetRange("Date Received", 20000101D, CalcDate('<-1M+CM>',"Period Start"));
                //ManifestLineRec.SetRange(Released, false);
                ManifestLineRec.SetRange("Shortcut Dimension 5 Code", '10MT');
                ManifestLineRec.SetRange("Shortcut Dimension 4 Code", 'UNIT');
                if ManifestLineRec.FindSet() then
                    OpeningBalance10MT := ManifestLineRec.Count;

                ManifestLineRec.Reset();
                ManifestLineRec.SetRange(Received, true);
                ManifestLineRec.SetRange("Date Received", 20000101D, CalcDate('<-1D>', "Period Start"));
ManifestLineRec.SetFilter("Date Released", '<%1|>%2', 19700101D, CalcDate('<-1D>', "Period Start"));
                //ManifestLineRec.SetRange("Date Received", 20000101D, CalcDate('<-1M+CM>',"Period Start"));
                //ManifestLineRec.SetRange(Released, false);
                ManifestLineRec.SetRange("Shortcut Dimension 5 Code", 'Over 10MT');
                ManifestLineRec.SetRange("Shortcut Dimension 4 Code", 'UNIT');
                if ManifestLineRec.FindSet() then
                    OpeningBalanceOver10MT := ManifestLineRec.Count;

                if not ClosingBln then
                    ClosingBalance1MT := OpeningBalance1MT + ReceivedDate1MT - ReleasedDate1MT
                else
                    ClosingBalance1MT := ClosingBalance1MT + ReceivedDate1MT - ReleasedDate1MT;

                if not ClosingBln then
                    ClosingBalance2MT := OpeningBalance2MT + ReceivedDate2MT - ReleasedDate2MT
                else
                    ClosingBalance2MT := ClosingBalance2MT + ReceivedDate2MT - ReleasedDate2MT;
                if not ClosingBln then
                    ClosingBalance5MT := OpeningBalance5MT + ReceivedDate5MT - ReleasedDate5MT
                else
                    ClosingBalance5MT := ClosingBalance5MT + ReceivedDate5MT - ReleasedDate5MT;
                if not ClosingBln then
                    ClosingBalance10MT := OpeningBalance10MT + ReceivedDate10MT - ReleasedDate10MT
                else
                    ClosingBalance10MT := ClosingBalance10MT + ReceivedDate10MT - ReleasedDate10MT;
                if not ClosingBln then
                    ClosingBalanceOver10MT := OpeningBalanceOver10MT + ReceivedDateOver10MT - ReleasedDateOver10MT
                else
                    ClosingBalanceOver10MT := ClosingBalanceOver10MT + ReceivedDateOver10MT - ReleasedDateOver10MT;

                ClosingBln := true;
                //Opening Stock Count start
                IF i = 1 then begin
                    TempExcelBuffer.NewRow();
                    TempExcelBuffer.AddColumn('Opening Stock', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(OpeningBalance1MT, false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(OpeningBalance2MT, false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(OpeningBalance5MT, false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(OpeningBalance10MT, false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(OpeningBalanceOver10MT, false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.NewRow();
                End;

                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn("Period Start", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
                TempExcelBuffer.AddColumn(ReceivedDate1MT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(ReceivedDate2MT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(ReceivedDate5MT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(ReceivedDate10MT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(ReceivedDateOver10MT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(ReleasedDate1MT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(ReleasedDate2MT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(ReleasedDate5MT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(ReleasedDate10MT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(ReleasedDateOver10MT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(ClosingBalance1MT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(ClosingBalance2MT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(ClosingBalance5MT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(ClosingBalance10MT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(ClosingBalanceOver10MT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                i := 0;


            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
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
            }
        }
    }
    trigger OnPreReport()

    begin
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
        // DateRec: Record Date;
        ManifestLineRec: Record "Manifest Line";
        ReceivedDate1MT: Integer;
        ReceivedDate2MT: Integer;
        ReceivedDate5MT: Integer;
        ReceivedDate10MT: Integer;
        ReceivedDateOver10MT: Integer;
        ReleasedDate1MT: Integer;
        ReleasedDate2MT: Integer;
        ReleasedDate5MT: Integer;
        ReleasedDate10MT: Integer;
        ReleasedDateOver10MT: Integer;

        ClosingBalance1MT: Integer;
        ClosingBalance2MT: Integer;
        ClosingBalance5MT: Integer;
        ClosingBalance10MT: Integer;
        ClosingBalanceOver10MT: Integer;
        OpeningBalance1MT: Integer;
        OpeningBalance2MT: Integer;
        OpeningBalance5MT: Integer;
        OpeningBalance10MT: Integer;
        OpeningBalanceOver10MT: Integer;
        i: Integer;
        j: Integer;
        ClosingBln: Boolean;


    local procedure MakeHeader()

    var
        MyInt: Integer;
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('UNITS SALES REPORTS', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
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
        TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Balance', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);

        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Date', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('1.5MT', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('2.0MT', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('5.0MT', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('10MT', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('OVER 10MT', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('1.5MT', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('2.0MT', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('5.0MT', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('10MT', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('OVER 10MT', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('1.5MT', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('2.0MT', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('5.0MT', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('10MT', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('OVER 10MT', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
    end;

    local procedure MakeBody()
    begin

    end;

    Local procedure CreateExcelBook();
    begin
        TempExcelBuffer.CreateNewBook('Units Sales Summary Reports');
        TempExcelBuffer.WriteSheet('Units Sales Summary Reports', CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename('Units Sales Summary Reports');
        TempExcelBuffer.OpenExcel();
    end;


}
