report 50163 Trends
{
    ApplicationArea = All;
    Caption = 'Customer Trends';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Src/Reports/Layouts/Trends.rdlc';
    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(TodayFormatted; Format(Today))
            {
            }
            column(PeriodCustDatetFilter; SPCode)
            {
            }
            column(currentperiodstartdate; StrSubstNo('%1 to %2', CurrentStartDate, CurrentEndDate)) { }
            column(Previousstartdate; StrSubstNo('%1 to %2', PreviouMonthStartDate, PreviouMonthEndDate)) { }
            column(yearenddate; StrSubstNo('%1 to %2', PreviousYearStartDate, Previousyearenddate)) { }
            column(CompanyName; CompanyInfo.Name) { }
            column(CompanyPicture; CompanyInfo.Picture) { }
            column(periodstartdate; periodstartdate) { }
            column(periodenddate; periodenddate) { }
            column(CurrentMonthContCount; CurrentMonthContCount) { }
            column(PreviousMonthContCount; PreviousMonthContCount) { }
            column(PreviouYearContcount; PreviouYearContcount) { }
            column(Shortcut_Dimension_3_Code; ManifestLineRec."Shortcut Dimension 3 Code") { }
            column(No_; "No.") { }
            column(Name; Name) { }
            trigger OnPreDataItem()
            var
            begin
                calcdates();
                monthscalculation();
            end;

            trigger OnAfterGetRecord()
            var
            begin
                Clear(CurrentMonthContCount);
                Clear(PreviousMonthContCount);
                Clear(PreviouYearContcount);
                if Type = Type::Received then
                    Processtype := 1;
                if Type = Type::Released then
                    Processtype := 2;
                CurrentMonthContCount := MFLGetCount(CurrentStartDate, CurrentEndDate, Customer."No.", Processtype);
                PreviousMonthContCount := MFLGetCount(PreviouMonthStartDate, PreviouMonthEndDate, Customer."No.", Processtype);
                PreviouYearContcount := MFLGetCount(PreviousYearStartDate, PreviousYearEnddate, Customer."No.", Processtype);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(Year; Year)
                    {
                        Caption = 'Year';
                        ApplicationArea = all;
                    }
                    field(Month; Month)
                    {
                        Caption = 'Month';
                        ApplicationArea = all;
                    }
                    field(Type; Type)
                    {
                        Caption = 'Type';
                        ApplicationArea = all;

                    }
                    field(SPCode; SPCode)
                    {
                        Caption = 'Sales Pearson';
                        TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(3));
                        ApplicationArea = all;
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

    var
        CompanyInfo: Record "Company Information";
        cust: Record Customer;
        Text000: Label 'Sales Person';
        Processtype: Integer;
        StartDate: Date;
        EndDate: Date;
        PreviouMonthStartDate: Date;
        PreviouMonthEndDate: Date;
        DateRec: Record Date;
        CurrentStartDate: Date;
        CurrentEndDate: date;
        Year: integer;
        periodstartdate: Date;
        periodenddate: date;
        Type: Enum Type;
        Month: Enum Month;
        PreviousYearStartDate: date;
        PreviousYearEnddate: date;
        CurrentMonthContCount: Integer;
        PreviousMonthContCount: Integer;
        PreviouYearContcount: Integer;
        ManifestLineRec: Record "Manifest Line";
        SPCode: code[20];

    procedure calcdates()
    var
    begin
        year := Year;
        DateRec.RESET;
        DateRec.SETRANGE("Period No.", Year);
        IF DateRec.FINDFIRST THEN BEGIN
            StartDate := DateRec."Period Start";
            EndDate := DateRec."Period End";
        END;
    end;

    procedure monthscalculation()
    var
    begin
        if Month = Month::Jan then begin
            CurrentStartDate := CALCDATE('-CM', StartDate);
            CurrentEndDate := CALCDATE('CM', StartDate);

            PreviouMonthStartDate := CalcDate('-CM', StartDate - 1);
            PreviouMonthEndDate := CalcDate('CM', StartDate - 1);
            PreviousYearStartDate := CalcDate('-CY', StartDate - 1);
            Previousyearenddate := CalcDate('-CY+CM', StartDate - 1);

        end;
        if Month = Month::Feb then begin
            CurrentStartDate := CALCDATE('-CM+1M', StartDate);
            CurrentEndDate := CALCDATE('CM+1M', StartDate);
            PreviouMonthStartDate := CalcDate('-CM+1M', StartDate - 1);
            PreviouMonthEndDate := CalcDate('CM+1M', StartDate - 1);
            PreviousYearStartDate := CalcDate('-CY+1M', StartDate - 1);
            Previousyearenddate := CalcDate('-CY+1M+CM', StartDate - 1);

        end;
        if Month = Month::Mar then begin
            CurrentStartDate := CALCDATE('-CM+2M', StartDate);
            CurrentEndDate := CALCDATE('CM+2M', StartDate);
            PreviouMonthStartDate := CalcDate('-CM+2M', StartDate - 1);
            PreviouMonthEndDate := CalcDate('CM+2M', StartDate - 1);
            PreviousYearStartDate := CalcDate('-CY+2M', StartDate - 1);
            Previousyearenddate := CalcDate('-CY+2M+CM', StartDate - 1);

        end;

        if Month = Month::Apr then begin
            CurrentStartDate := CALCDATE('-CM+3M', StartDate);
            CurrentEndDate := CALCDATE('CM+3M', StartDate);
            PreviouMonthStartDate := CalcDate('-CM+3M', StartDate - 1);
            PreviouMonthEndDate := CalcDate('CM+3M', StartDate - 1);
            PreviousYearStartDate := CalcDate('-CY+3M', StartDate - 1);
            Previousyearenddate := CalcDate('-CY+3M+CM', StartDate - 1);

        end;
        if Month = Month::May then begin
            CurrentStartDate := CALCDATE('-CM+4M', StartDate);
            CurrentEndDate := CALCDATE('CM+4M', StartDate);
            PreviouMonthStartDate := CalcDate('-CM+4M', StartDate - 1);
            PreviouMonthEndDate := CalcDate('CM+4M', StartDate - 1);
            PreviousYearStartDate := CalcDate('-CY+4M', StartDate - 1);
            Previousyearenddate := CalcDate('-CY+4M+CM', StartDate - 1);

        end;
        if Month = Month::Jun then begin
            CurrentStartDate := CALCDATE('-CM+5M', StartDate);
            CurrentEndDate := CALCDATE('CM+5M', StartDate);
            PreviouMonthStartDate := CalcDate('-CM+5M', StartDate - 1);
            PreviouMonthEndDate := CalcDate('CM+5M', StartDate - 1);
            PreviousYearStartDate := CalcDate('-CY+5M', StartDate - 1);
            Previousyearenddate := CalcDate('-CY+5M+CM', StartDate - 1);

        end;
        if Month = Month::Jul then begin
            CurrentStartDate := CALCDATE('-CM+6M', StartDate);
            CurrentEndDate := CALCDATE('CM+6M', StartDate);
            PreviouMonthStartDate := CalcDate('-CM+6M', StartDate - 1);
            PreviouMonthEndDate := CalcDate('CM+6M', StartDate - 1);
            PreviousYearStartDate := CalcDate('-CY+6M', StartDate - 1);
            Previousyearenddate := CalcDate('-CY+6M+CM', StartDate - 1);

        end;
        if Month = Month::Aug then begin
            CurrentStartDate := CALCDATE('-CM+7M', StartDate);
            CurrentEndDate := CALCDATE('CM+7M', StartDate);
            PreviouMonthStartDate := CalcDate('-CM+7M', StartDate - 1);
            PreviouMonthEndDate := CalcDate('CM+7M', StartDate - 1);
            PreviousYearStartDate := CalcDate('-CY+7M', StartDate - 1);
            Previousyearenddate := CalcDate('-CY+7M+CM', StartDate - 1);

        end;
        if Month = Month::Sep then begin
            CurrentStartDate := CALCDATE('-CM+8M', StartDate);
            CurrentEndDate := CALCDATE('CM+8M', StartDate);
            PreviouMonthStartDate := CalcDate('-CM+8M', StartDate - 1);
            PreviouMonthEndDate := CalcDate('CM+8M', StartDate - 1);
            PreviousYearStartDate := CalcDate('-CY+8M', StartDate - 1);
            Previousyearenddate := CalcDate('-CY+8M+CM', StartDate - 1);

        end;
        if Month = Month::Oct then begin
            CurrentStartDate := CALCDATE('-CM+9M', StartDate);
            CurrentEndDate := CALCDATE('CM+9M', StartDate);
            PreviouMonthStartDate := CalcDate('-CM+9M', StartDate - 1);
            PreviouMonthEndDate := CalcDate('CM+9M', StartDate - 1);
            PreviousYearStartDate := CalcDate('-CY+9M', StartDate - 1);
            Previousyearenddate := CalcDate('-CY+9M+CM', StartDate - 1);

        end;
        if Month = Month::Nov then begin
            CurrentStartDate := CALCDATE('-CM+10M', StartDate);
            CurrentEndDate := CALCDATE('CM+10M', StartDate);
            PreviouMonthStartDate := CalcDate('-CM+10M', StartDate - 1);
            PreviouMonthEndDate := CalcDate('CM+10M', StartDate - 1);
            PreviousYearStartDate := CalcDate('-CY+10M', StartDate - 1);
            Previousyearenddate := CalcDate('-CY+10M+CM', StartDate - 1);

        end;
        if Month = Month::Dec then begin
            CurrentStartDate := CALCDATE('-CM+11M', StartDate);
            CurrentEndDate := CALCDATE('CM+11M', StartDate);
            PreviouMonthStartDate := CalcDate('-CM+11M', StartDate - 1);
            PreviouMonthEndDate := CalcDate('CM+11M', StartDate - 1);
            PreviousYearStartDate := CalcDate('-CY+11M', StartDate - 1);
            Previousyearenddate := CalcDate('-CY+11M+CM', StartDate - 1);
        end;
    end;

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    // procedure GetCount(Startdate: Date; Enddate: Date; Value: Integer) Contcount: integer;
    // var
    //     CustRec: Record Customer;
    // begin
    //     Clear(Contcount);
    //     CustRec.Reset();
    //     CustRec.SetRange("No.", Customer."No.");
    //     CustRec.SetRange("Salesperson Code", Customer."Salesperson Code");
    //     CustRec.SetRange("Date Filter", Startdate, Enddate);
    //     if CustRec.FindFirst() then begin
    //         CustRec.CalcFields("Total received", "Total released");
    //         if Value = 1 then
    //             Contcount := CustRec."Total received";
    //         if Value = 2 then
    //             Contcount := CustRec."Total released";
    //         exit(Contcount);
    //     end;
    // end;

    procedure MFLGetCount(Startdate: Date; Enddate: Date; CustNo: code[20]; Value: Integer) Contcount: integer;
    var
        MFL: Record "Manifest Line";
    begin
        Clear(Contcount);
        if Value = 1 then begin
            MFL.Reset();
            MFL.SetRange("Invoicing Party No.", CustNo);
            if SPCode <> '' then
                MFL.SetRange("Shortcut Dimension 3 Code", SPCode);
            MFL.SetRange("Date Received", Startdate, Enddate);
            MFL.SetRange(Received, true);
            if MFL.FindSet() then
                Contcount := MFL.Count;
        end;
        if Value = 2 then begin
            MFL.Reset();
            MFL.SetRange("Invoicing Party No.", CustNo);
            if SPCode <> '' then
                MFL.SetRange("Shortcut Dimension 3 Code", SPCode);
            MFL.SetRange("Date Released", Startdate, Enddate);
            MFL.SetRange(Released, true);
            if MFL.FindSet() then
                Contcount := MFL.Count;
        end;
        exit(Contcount);
    end;







}






