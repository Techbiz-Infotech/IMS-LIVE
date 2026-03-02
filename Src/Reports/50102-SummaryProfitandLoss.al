report 50102 "Summary Profit and Loss"
{
    //ApplicationArea = All;
    Caption = 'Summary Profit and Loss';
    //UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Src/Reports/Layouts/Summary Profit and Loss.rdlc';

    dataset
    {
        dataitem(ReceivedMFL; "Manifest Line")
        {
            DataItemTableView = sorting("Shortcut Dimension 5 Code") where(Received = filter(true));

            column(Shortcut_Dimension_4_Code; "Shortcut Dimension 4 Code")
            {
            }
            column(Shortcut_Dimension_5_Code; "Shortcut Dimension 5 Code")
            {
            }
            column(Received; Received)
            {
            }
            column(Released; Released)
            { }
            column(TotalRecContCount; TotalRecContCount)
            { }
            column(MonthNameTxt1; MonthNameTxt[1])
            {
            }
            column(MonthNameTxt2; MonthNameTxt[2])
            {
            }
            column(MonthNameTxt3; MonthNameTxt[3])
            {
            }
            column(MonthNameTxt4; MonthNameTxt[4])
            {
            }
            column(MonthNameTxt5; MonthNameTxt[5])
            {
            }
            column(MonthNameTxt6; MonthNameTxt[6])
            {
            }
            column(MonthNameTxt7; MonthNameTxt[7])
            {
            }
            column(MonthNameTxt8; MonthNameTxt[8])
            {
            }
            column(MonthNameTxt9; MonthNameTxt[9])
            {
            }
            column(MonthNameTxt10; MonthNameTxt[10])
            {
            }
            column(MonthNameTxt11; MonthNameTxt[11])
            {
            }
            column(MonthNameTxt12; MonthNameTxt[12])
            {
            }
            column(ReceivedContainerCount1; ReceivedContainerCount[1])
            {
            }
            column(ReceivedContainerCount2; ReceivedContainerCount[2])
            {
            }
            column(ReceivedContainerCount3; ReceivedContainerCount[3])
            {
            }
            column(ReceivedContainerCount4; ReceivedContainerCount[4])
            {
            }
            column(ReceivedContainerCount5; ReceivedContainerCount[5])
            {
            }
            column(ReceivedContainerCount6; ReceivedContainerCount[6])
            {
            }
            column(ReceivedContainerCount7; ReceivedContainerCount[7])
            {
            }
            column(ReceivedContainerCount8; ReceivedContainerCount[8])
            {
            }
            column(ReceivedContainerCount9; ReceivedContainerCount[9])
            {
            }
            column(ReceivedContainerCount10; ReceivedContainerCount[10])
            {
            }
            column(ReceivedContainerCount11; ReceivedContainerCount[11])
            {
            }
            column(ReceivedContainerCount12; ReceivedContainerCount[12])
            {
            }

            trigger OnPreDataItem()
            begin
                ReceivedMFL.SetRange(Received, true);
                ReceivedMFL.SetRange("Date Received", StartDate[1], EndDate[12]);
                StartDateFilter := FORMAT(StartDate[1], 0, '<Year4>');
                EndDateFilter := FORMAT(StartDate[12], 0, '<Year4>');
                DatePeriodFilter := 'Financial Year ' + StartDateFilter + ' To ' + EndDateFilter;
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                CLEAR(ReceivedContainerCount);
                Period := GetPeriod(ReceivedMFL."Date Received");
                ReceivedContainerCount[Period] := ReceivedMFL.Count;
                TotalRecContCount := ReceivedContainerCount[Period];
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)

                {
                    Caption = 'Options';
                    field(StartingDate; StartingDate)
                    {
                        Caption = 'Fiscal Year from';
                        ApplicationArea = Basic, Suite;
                        TableRelation = "Accounting Period" where("New Fiscal Year" = filter(true));
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
    var
        myInt: Integer;
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);

        IF StartingDate > TODAY THEN
            ERROR('Starting date is greater than today');

        AccountingPeriod.RESET;
        IF NOT AccountingPeriod.GET(StartingDate) THEN
            ERROR('Please enter correct date');
        IF NOT AccountingPeriod."New Fiscal Year" THEN
            ERROR('Please enter Starting date of Financial year');

        StartDate[1] := StartingDate;
        EndDate[1] := AccPeriodEndDate(StartDate[1]);
        MonthNameTxt[1] := FORMAT(StartDate[1], 0, Text50011);

        FOR i := 2 TO 12 DO BEGIN
            AccountingPeriod.NEXT;
            StartDate[i] := AccountingPeriod."Starting Date";
            EndDate[i] := AccPeriodEndDate(StartDate[i]);
            MonthNameTxt[i] := FORMAT(StartDate[i], 0, Text50011);
        END;
    end;

    var
        CompanyInfo: Record "Company Information";
        AccountingPeriod: Record "Accounting Period";
        StartDate, EndDate : array[20] of date;
        DatePeriodFilter, StartDateFilter, EndDateFilter : Text;
        TotalRecContCount, i, Period, CrPeriod : Integer;
        ReceivedContainerCount: array[20] of Integer;
        StartingDate: Date;
        MonthNameTxt: array[20] of text;
        Text50011: textConst ENU = '<Month Text>';

    LOCAL Procedure AccPeriodEndDate(UseStartDate: Date): Date
    var
        AccountingPeriod2: Record "Accounting Period";

    begin
        AccountingPeriod2."Starting Date" := UseStartDate;
        IF AccountingPeriod2.FIND('>') THEN
            EXIT(AccountingPeriod2."Starting Date" - 1);
        EXIT(DMY2DATE(31, 12, 9999));
    end;

    LOCAL Procedure GetPeriod(p_Date: Date): Integer

    begin
        IF p_Date IN [StartDate[1] .. EndDate[1]] THEN
            EXIT(1);
        IF p_Date IN [StartDate[2] .. EndDate[2]] THEN
            EXIT(2);
        IF p_Date IN [StartDate[3] .. EndDate[3]] THEN
            EXIT(3);
        IF p_Date IN [StartDate[4] .. EndDate[4]] THEN
            EXIT(4);
        IF p_Date IN [StartDate[5] .. EndDate[5]] THEN
            EXIT(5);
        IF p_Date IN [StartDate[6] .. EndDate[6]] THEN
            EXIT(6);
        IF p_Date IN [StartDate[7] .. EndDate[7]] THEN
            EXIT(7);
        IF p_Date IN [StartDate[8] .. EndDate[8]] THEN
            EXIT(8);
        IF p_Date IN [StartDate[9] .. EndDate[9]] THEN
            EXIT(9);
        IF p_Date IN [StartDate[10] .. EndDate[10]] THEN
            EXIT(10);
        IF p_Date IN [StartDate[11] .. EndDate[11]] THEN
            EXIT(11);
        IF p_Date IN [StartDate[12] .. EndDate[12]] THEN
            EXIT(12);
    end;


}
