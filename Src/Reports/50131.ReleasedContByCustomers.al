report 50131 ReleasedConatinersByPeriod
{
    ApplicationArea = All;
    Caption = 'Monthly Customer-wise Released Report';
    DefaultLayout = RDLC;
    RDLCLayout = './Src/Reports/Layouts/ReleasedConatinersByPeriod.rdlc';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(ReleasedManifestLine; "Manifest Line")
        {
            DataItemTableView = sorting("Invoicing Party No.", "Date Released") order(ascending);
            column(CutomerName; CutomerName) { }
            column(Invoicing_Party_No_; "Invoicing Party No.") { }
            column(Companylogo; CompanyInfo.Picture) { }
            column(CompanyName; CompanyInfo.Name) { }
            column(CustTotalCont; CustTotalCont) { }
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
            column(ReleasedCustContCount1; ReleasedCustContCount[1])
            {
            }
            column(ReleasedCustContCount2; ReleasedCustContCount[2])
            {
            }
            column(ReleasedCustContCount3; ReleasedCustContCount[3])
            {
            }
            column(ReleasedCustContCount4; ReleasedCustContCount[4])
            {
            }
            column(ReleasedCustContCount5; ReleasedCustContCount[5])
            {
            }
            column(ReleasedCustContCount6; ReleasedCustContCount[6])
            {
            }
            column(ReleasedCustContCount7; ReleasedCustContCount[7])
            {
            }
            column(ReleasedCustContCount8; ReleasedCustContCount[8])
            {
            }
            column(ReleasedCustContCount9; ReleasedCustContCount[9])
            {
            }
            column(ReleasedCustContCount10; ReleasedCustContCount[10])
            {
            }
            column(ReleasedCustContCount11; ReleasedCustContCount[11])
            {
            }
            column(ReleasedCustContCount12; ReleasedCustContCount[12])
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
                if Custrec.get(ReleasedManifestLine."Invoicing Party No.") then
                    CutomerName := Custrec.Name;
                Clear(ReleasedCustContCount);
                GetCustomerContCount1("Invoicing Party No.");
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
                    field(CargoType; CargoType)
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
        //ReleasedCustContCount: array[20] of Integer;
        ReleasedCustContCount: array[20] of decimal;

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
                ManifestLine1.SetFilter("Invoicing Party No.", '%1', DimCode);
                if ManifestLine1.FindFirst() then;
                CASE i OF
                    1:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReleasedCustContCount[1] := GetCustManifestLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReleasedCustContCount[1] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0

                        end;
                    2:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReleasedCustContCount[2] := GetCustManifestLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReleasedCustContCount[2] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;
                        end;
                    3:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReleasedCustContCount[3] := GetCustManifestLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReleasedCustContCount[3] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;

                        end;
                    4:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReleasedCustContCount[4] := GetCustManifestLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReleasedCustContCount[4] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0

                        end;
                    5:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReleasedCustContCount[5] := GetCustManifestLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReleasedCustContCount[5] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;

                        end;
                    6:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReleasedCustContCount[6] := GetCustManifestLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReleasedCustContCount[6] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;

                        end;
                    7:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReleasedCustContCount[7] := GetCustManifestLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReleasedCustContCount[7] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;
                        end;
                    8:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReleasedCustContCount[8] := GetCustManifestLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReleasedCustContCount[8] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;
                        end;
                    9:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReleasedCustContCount[9] := GetCustManifestLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReleasedCustContCount[9] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;
                        end;
                    10:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReleasedCustContCount[10] := GetCustManifestLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReleasedCustContCount[10] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;
                        end;
                    11:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReleasedCustContCount[11] := GetCustManifestLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReleasedCustContCount[11] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;
                        end;
                    12:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReleasedCustContCount[12] := GetCustManifestLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReleasedCustContCount[12] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;
                        end;
                end;

                CustTotalCont := ReleasedCustContCount[1] + ReleasedCustContCount[2] + ReleasedCustContCount[3] + ReleasedCustContCount[4] + ReleasedCustContCount[5]
+ ReleasedCustContCount[6] + ReleasedCustContCount[7] + ReleasedCustContCount[8] + ReleasedCustContCount[9] + ReleasedCustContCount[10] + ReleasedCustContCount[11] + ReleasedCustContCount[12];
                //Message('%1', CustTotalCont);
            end;
            DimCont_gcode := DimCode;
        end;
    END;


    local procedure GetCustManifestLinesCount(CustomerNo: Code[20]; CagoType: Code[20]; j: Integer): Integer;
    var
        SalesInvoiceLine2: Record "Sales Invoice Line";
        ManifestLine: Record "Manifest Line";
    begin
        clear(CountOfContainer);
        ManifestLine.Reset();
        ManifestLine.SetCurrentKey("Global Dimension 1 Code");
        ManifestLine.SetAscending("Global Dimension 1 Code", true);
        ManifestLine.SetRange("Date Released", StartDate_gDat[j], EndDate_gDat[j]);
        if CargoType <> '' then
            ManifestLine.SetFilter("Shortcut Dimension 4 Code", '%1', CargoType);
        ManifestLine.SetRange("Invoicing Party No.", CustomerNo);
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
