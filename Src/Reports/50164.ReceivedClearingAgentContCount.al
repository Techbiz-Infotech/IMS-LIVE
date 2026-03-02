report 50164 ReceivedClearingAgentCount
{
    ApplicationArea = All;
    Caption = 'Monthly Clearing Agent-wise Received Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Src/Reports/Layouts/ReceivedContbyclearingagent.rdlc';
    dataset
    {
        dataitem(ManifestLine; "Manifest Line")
        {
            DataItemTableView = sorting("Clearing Agent", "Date Received") order(ascending);
            column(Companylogo; CompanyInfo.Picture) { }
            column(CompanyName; CompanyInfo.Name) { }
            column(CustTotalCont; CustTotalCont) { }
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

            column(ReceivedAgentConCount1; ReceivedAgentConCount[1])
            {
            }
            column(ReceivedAgentConCount2; ReceivedAgentConCount[2])
            {
            }
            column(ReceivedAgentConCount3; ReceivedAgentConCount[3])
            {
            }
            column(ReceivedAgentConCount4; ReceivedAgentConCount[4])
            {
            }
            column(ReceivedAgentConCount5; ReceivedAgentConCount[5])
            {
            }
            column(ReceivedAgentConCount6; ReceivedAgentConCount[6])
            {
            }
            column(ReceivedAgentConCount7; ReceivedAgentConCount[7])
            {
            }
            column(ReceivedAgentConCount8; ReceivedAgentConCount[8])
            {
            }
            column(ReceivedAgentConCount9; ReceivedAgentConCount[9])
            {
            }
            column(ReceivedAgentConCount10; ReceivedAgentConCount[10])
            {
            }
            column(ReceivedAgentConCount11; ReceivedAgentConCount[11])
            {
            }
            column(ReceivedAgentConCount12; ReceivedAgentConCount[12])
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
                Clear(ReceivedAgentConCount);
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
        ReceivedAgentConCount: array[20] of decimal;

        TotalReleasedUnit: Integer;
        TotalRecContCount, i, Period, ReleasedPeriod : Integer;
        SalesPersonCode: code[30];
        CargoType: Code[30];
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
                ManifestLine1.SetRange("Shortcut Dimension 4 Code", CargoType);
                ManifestLine1.SetRange("Date Released", StartDate_gDat[i], EndDate_gDat[i]);
                ManifestLine1.SetFilter("Global Dimension 1 Code", '<>%1', '');
                ManifestLine1.SetFilter("Clearing Agent", '%1', DimCode);
                if ManifestLine1.FindFirst() then;
                CASE i OF
                    1:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReceivedAgentConCount[1] := GetCLearingagentLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReceivedAgentConCount[1] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;

                        end;
                    2:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReceivedAgentConCount[2] := GetCLearingagentLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReceivedAgentConCount[2] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;
                        end;
                    3:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReceivedAgentConCount[3] := GetCLearingagentLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReceivedAgentConCount[3] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;

                        end;
                    4:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReceivedAgentConCount[4] := GetCLearingagentLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReceivedAgentConCount[4] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;

                        end;
                    5:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReceivedAgentConCount[5] := GetCLearingagentLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReceivedAgentConCount[5] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;

                        end;
                    6:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReceivedAgentConCount[6] := GetCLearingagentLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReceivedAgentConCount[6] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;

                        end;
                    7:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReceivedAgentConCount[7] := GetCLearingagentLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReceivedAgentConCount[7] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;
                        end;
                    8:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReceivedAgentConCount[8] := GetCLearingagentLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReceivedAgentConCount[8] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;
                        end;
                    9:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReceivedAgentConCount[9] := GetCLearingagentLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReceivedAgentConCount[9] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;
                        end;
                    10:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReceivedAgentConCount[10] := GetCLearingagentLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReceivedAgentConCount[10] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;
                        end;
                    11:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReceivedAgentConCount[11] := GetCLearingagentLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReceivedAgentConCount[11] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;
                        end;
                    12:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReceivedAgentConCount[12] := GetCLearingagentLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReceivedAgentConCount[12] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;
                        end;
                end;

                CustTotalCont := ReceivedAgentConCount[1] + ReceivedAgentConCount[2] + ReceivedAgentConCount[3] + ReceivedAgentConCount[4] + ReceivedAgentConCount[5]
+ ReceivedAgentConCount[6] + ReceivedAgentConCount[7] + ReceivedAgentConCount[8] + ReceivedAgentConCount[9] + ReceivedAgentConCount[10] + ReceivedAgentConCount[11] + ReceivedAgentConCount[12];
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
        ManifestLine.SetRange("Date Received", StartDate_gDat[j], EndDate_gDat[j]);
        if CargoType <> '' then
            ManifestLine.SetFilter("Shortcut Dimension 4 Code", '%1', CargoType);
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

