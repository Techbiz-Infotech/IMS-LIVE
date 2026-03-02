report 50140 ReleasedContbyclearingagent
{
    ApplicationArea = All;
    Caption = 'Monthly Clearing Agent-wise Released Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Src/Reports/Layouts/ReleasedContbyclearingagent.rdlc';
    dataset
    {
        dataitem(ManifestLine; "Manifest Line")
        {
            DataItemTableView = sorting("Clearing Agent", "Date Released") order(ascending);
           
            
            column(Companylogo; CompanyInfo.Picture) { }
            column(CompanyName; CompanyInfo.Name) { }
            column(CustTotalCont;CustTotalCont){}
            column(Clearing_Agent; "Clearing Agent") { }
            column(MonthNameTxt1; StrSubstNo('Jan - %1', YearFilter))
            {
            }
            column(MonthNameTxt2; StrSubstNo('Feb - %1', YearFilter))
            {
            }
            column(MonthNameTxt3; StrSubstNo('Mar - %1', YearFilter))
            {
            }
            column(MonthNameTxt4; StrSubstNo('Apr - %1', YearFilter))
            {
            }
            column(MonthNameTxt5; StrSubstNo('May - %1', YearFilter))
            {
            }
            column(MonthNameTxt6; StrSubstNo('Jun - %1', YearFilter))
            {
            }
            column(MonthNameTxt7; StrSubstNo('Jul - %1', YearFilter))
            {
            }
            column(MonthNameTxt8; StrSubstNo('Aug - %1', YearFilter))
            {
            }
            column(MonthNameTxt9; StrSubstNo('Sep - %1', YearFilter))
            {
            }
            column(MonthNameTxt10; StrSubstNo('Oct - %1', YearFilter))
            {
            }
            column(MonthNameTxt11; StrSubstNo('Nov - %1', YearFilter))
            {
            }
            column(MonthNameTxt12; StrSubstNo('Dec - %1', YearFilter))
            {
            }
            column(Shortcut_Dimension_4_Code1; "Shortcut Dimension 4 Code")
            {
            }
            column(Shortcut_Dimension_5_Code1; "Shortcut Dimension 5 Code")
            {
            }
            column(TotalReleasedUnit; TotalReleasedUnit)
            { }
            column(TotalRecContCount1; TotalRecContCount)
            { }
            column(ReleasedCargotypeCount1; ReleasedCargotypeCount[1])
            {
            }
            column(ReleasedCargotypeCount2; ReleasedCargotypeCount[2])
            {
            }
            column(ReleasedCargotypeCount3; ReleasedCargotypeCount[3])
            {
            }
            column(ReleasedCargotypeCount4; ReleasedCargotypeCount[4])
            {
            }
            column(ReleasedCargotypeCount5; ReleasedCargotypeCount[5])
            {
            }
            column(ReleasedCargotypeCount6; ReleasedCargotypeCount[6])
            {
            }
            column(ReleasedCargotypeCount7; ReleasedCargotypeCount[7])
            {
            }
            column(ReleasedCargotypeCount8; ReleasedCargotypeCount[8])
            {
            }
            column(ReleasedCargotypeCount9; ReleasedCargotypeCount[9])
            {
            }
            column(ReleasedCargotypeCount10; ReleasedCargotypeCount[10])
            {
            }
            column(ReleasedCargotypeCount11; ReleasedCargotypeCount[11])
            {
            }
            column(ReleasedCargotypeCount12; ReleasedCargotypeCount[12])
            {
            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin

            end;

            trigger OnAfterGetRecord()
            var
                Custrec: Record Customer;
            begin
                // if Custrec.get(ReleasedManifestLine."Invoicing Party No.") then
                //     CutomerName := Custrec.Name;
                Clear(ReleasedCargotypeCount);
                GetCustomerContCount1("Clearing Agent");
                If CustTotalCont = 0 then
                    CurrReport.Skip();

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
                        Visible = false;
                        ApplicationArea = Basic, Suite;
                        TableRelation = "Accounting Period" where("New Fiscal Year" = filter(true));
                    }
                    field(YearFilter; YearFilter)
                    {
                        Caption = 'Enter Year';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            IF YearFilter <> '' THEN BEGIN
                                IF STRLEN(YearFilter) <> 4 THEN
                                    ERROR(Text50002_gCtx);
                            END;
                            IF NOT EVALUATE(Year_Int, YearFilter) THEN
                                ERROR(Text50002_gCtx);
                        end;
                    }
                    field(cARGOtYPE; cARGOtYPE)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cargo Type';
                        TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(4));
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
        StartingDate: Date;
        MonthNameTxt: array[20] of text;
        Text50011: textConst ENU = '<Month Text>';
        StartDate_gDat: array[12] of Date;
        EndDate_gDat: array[12] of Date;
        ContainerId_gCode: Code[20];
        Year_Int: Integer;
        j: Integer;
        CutomerName: text[100];
        DimReleased_gcode: Code[20];
        Text50002_gCtx: Label 'Please select proper Year';
        //ReleasedUnitsCount: array[20] of Integer;
        ReleasedCargotypeCount: array[20] of decimal;

        TotalReleasedUnit: Integer;
        TotalRecContCount, i, Period, ReleasedPeriod : Integer;
        SalesPersonCode: code[30];
        cARGOtYPE: Code[30];
        CountOfContainer: Integer;
        YearFilter: Text[10];
        CustTotalCont: Integer;
        DimCont_gcode: code[20];

    procedure GetCustomerContCount1(DimCode: Code[20]): Integer;
    var
        ManifestLine1: Record "Manifest Line";
    begin
        CreateDateFilters_lFnc;
        IF (DimCont_gcode <> DimCode) then begin
            FOR i := 1 TO 12 DO BEGIN
                ManifestLine1.Reset();
                ManifestLine1.SetRange("Shortcut Dimension 4 Code", cARGOtYPE);
                ManifestLine1.SetRange("Date Released", StartDate_gDat[i], EndDate_gDat[i]);
                // if SalesPersonCode <> '' then
                //     ManifestLine1.SetFilter("Shortcut Dimension 3 Code", '%1', Salespersoncode);
                ManifestLine1.SetFilter("Global Dimension 1 Code", '<>%1', '');
                ManifestLine1.SetFilter("Clearing Agent", '%1', DimCode);
                if ManifestLine1.FindFirst() then;
                CASE i OF
                    1:
                        begin
                            if cARGOtYPE <> 'LOOSE' then
                                ReleasedCargotypeCount[1] := GetCLearingagentLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReleasedCargotypeCount[1] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;

                        end;
                    2:
                        begin
                            if cARGOtYPE <> 'LOOSE' then
                                ReleasedCargotypeCount[2] := GetCLearingagentLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReleasedCargotypeCount[2] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;
                        end;
                    3:
                        begin
                            if cARGOtYPE <> 'LOOSE' then
                                ReleasedCargotypeCount[3] := GetCLearingagentLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReleasedCargotypeCount[3] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;

                        end;
                    4:
                        begin
                            if cARGOtYPE <> 'LOOSE' then
                                ReleasedCargotypeCount[4] := GetCLearingagentLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReleasedCargotypeCount[4] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;

                        end;
                    5:
                        begin
                            if cARGOtYPE <> 'LOOSE' then
                                ReleasedCargotypeCount[5] := GetCLearingagentLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReleasedCargotypeCount[5] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;

                        end;
                    6:
                        begin
                            if cARGOtYPE <> 'LOOSE' then
                                ReleasedCargotypeCount[6] := GetCLearingagentLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReleasedCargotypeCount[6] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;

                        end;
                    7:
                        begin
                            if cARGOtYPE <> 'LOOSE' then
                                ReleasedCargotypeCount[7] := GetCLearingagentLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReleasedCargotypeCount[7] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;
                        end;
                    8:
                        begin
                            if cARGOtYPE <> 'LOOSE' then
                                ReleasedCargotypeCount[8] := GetCLearingagentLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReleasedCargotypeCount[8] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;
                        end;
                    9:
                        begin
                            if cARGOtYPE <> 'LOOSE' then
                                ReleasedCargotypeCount[9] := GetCLearingagentLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReleasedCargotypeCount[9] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;
                        end;
                    10:
                        begin
                            if cARGOtYPE <> 'LOOSE' then
                                ReleasedCargotypeCount[10] := GetCLearingagentLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReleasedCargotypeCount[10] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;
                        end;
                    11:
                        begin
                            if cARGOtYPE <> 'LOOSE' then
                                ReleasedCargotypeCount[11] := GetCLearingagentLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReleasedCargotypeCount[11] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;
                        end;
                    12:
                        begin
                            if cARGOtYPE <> 'LOOSE' then
                                ReleasedCargotypeCount[12] := GetCLearingagentLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReleasedCargotypeCount[12] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;
                        end;
                end;

                CustTotalCont := ReleasedCargotypeCount[1] + ReleasedCargotypeCount[2] + ReleasedCargotypeCount[3] + ReleasedCargotypeCount[4] + ReleasedCargotypeCount[5]
+ ReleasedCargotypeCount[6] + ReleasedCargotypeCount[7] + ReleasedCargotypeCount[8] + ReleasedCargotypeCount[9] + ReleasedCargotypeCount[10] + ReleasedCargotypeCount[11] + ReleasedCargotypeCount[12];
                //Message('%1', CustTotalCont);
            end;
            DimCont_gcode := DimCode;
        end;
    END;


    local procedure GetCLearingagentLinesCount(Clearingagent: Code[20]; CagoType: Code[20]; j: Integer): Integer;
    var
        SalesInvoiceLine2: Record "Sales Invoice Line";
        ManifestLine: Record "Manifest Line";
    begin
        clear(CountOfContainer);
        ManifestLine.Reset();
        ManifestLine.SetCurrentKey("Global Dimension 1 Code");
        ManifestLine.SetAscending("Global Dimension 1 Code", true);
        ManifestLine.SetRange("Date Released", StartDate_gDat[j], EndDate_gDat[j]);
        if cARGOtYPE <> '' then
            ManifestLine.SetFilter("Shortcut Dimension 4 Code", '%1', cARGOtYPE);
        ManifestLine.SetRange("Clearing Agent", Clearingagent);
        if ManifestLine.FindSet() then //begin
            repeat
                IF ContainerId_gCode <> ManifestLine."Global Dimension 1 Code" then begin
                    CountOfContainer += 1;
                End;
                ContainerId_gCode := ManifestLine."Global Dimension 1 Code";
            until ManifestLine.Next() = 0;
        exit(CountOfContainer);
    end;

    LOCAL procedure CreateDateFilters_lFnc();
    begin
        StartDate_gDat[1] := DMY2DATE(1, 1, Year_Int);
        EndDate_gDat[1] := CALCDATE('1M', StartDate_gDat[1]) - 1;
        FOR i := 2 TO 12 DO BEGIN
            StartDate_gDat[i] := CALCDATE('1M', StartDate_gDat[i - 1]);
            EndDate_gDat[i] := CALCDATE('1M', StartDate_gDat[i]) - 1;
        END;
    end;

    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;
}
