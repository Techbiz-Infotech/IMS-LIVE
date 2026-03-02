report 50161 "ReceivedConatinersBy period"
{
    ApplicationArea = All;
    Caption = 'Monthly Customer-wise Received Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Src/Reports/Layouts/ReceivedConatinersByPeriod.rdlc';
    dataset
    {
        dataitem(ReceivedManifestLine; "Manifest Line")
        {
            DataItemTableView = sorting("Invoicing Party No.", "Date Received") order(ascending);
            column(Companylogo; CompanyInfo.Picture) { }
             column(CutomerName; CutomerName) { }
            column(Invoicing_Party_No_; "Invoicing Party No.") { }
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
            column(ReceivedCustContCount1; ReceivedCustContCount[1])
            {
            }
            column(ReceivedCustContCount2; ReceivedCustContCount[2])
            {
            }
            column(ReceivedCustContCount3; ReceivedCustContCount[3])
            {
            }
            column(ReceivedCustContCount4; ReceivedCustContCount[4])
            {
            }
            column(ReceivedCustContCount5; ReceivedCustContCount[5])
            {
            }
            column(ReceivedCustContCount6; ReceivedCustContCount[6])
            {
            }
            column(ReceivedCustContCount7; ReceivedCustContCount[7])
            {
            }
            column(ReceivedCustContCount8; ReceivedCustContCount[8])
            {
            }
            column(ReceivedCustContCount9; ReceivedCustContCount[9])
            {
            }
            column(ReceivedCustContCount10; ReceivedCustContCount[10])
            {
            }
            column(ReceivedCustContCount11; ReceivedCustContCount[11])
            {
            }
            column(ReceivedCustContCount12; ReceivedCustContCount[12])
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
                if Custrec.get(ReceivedManifestLine."Invoicing Party No.") then
                    CutomerName := Custrec.Name;
                Clear(ReceivedCustContCount);
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
        //ReceivedCustContCount: array[20] of Integer;
        ReceivedCustContCount: array[20] of decimal;

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
                ManifestLine1.SetRange("Date Received", StartDate_gDat[i], EndDate_gDat[i]);
                ManifestLine1.SetFilter("Global Dimension 1 Code", '<>%1', '');
                ManifestLine1.SetFilter("Invoicing Party No.", '%1', DimCode);
                if ManifestLine1.FindFirst() then;
                CASE i OF
                    1:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReceivedCustContCount[1] := GetCustManifestLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReceivedCustContCount[1] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0

                        end;
                    2:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReceivedCustContCount[2] := GetCustManifestLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReceivedCustContCount[2] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;
                        end;
                    3:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReceivedCustContCount[3] := GetCustManifestLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReceivedCustContCount[3] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;

                        end;
                    4:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReceivedCustContCount[4] := GetCustManifestLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReceivedCustContCount[4] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0

                        end;
                    5:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReceivedCustContCount[5] := GetCustManifestLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReceivedCustContCount[5] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;

                        end;
                    6:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReceivedCustContCount[6] := GetCustManifestLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReceivedCustContCount[6] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;

                        end;
                    7:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReceivedCustContCount[7] := GetCustManifestLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReceivedCustContCount[7] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;
                        end;
                    8:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReceivedCustContCount[8] := GetCustManifestLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReceivedCustContCount[8] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;
                        end;
                    9:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReceivedCustContCount[9] := GetCustManifestLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReceivedCustContCount[9] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;
                        end;
                    10:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReceivedCustContCount[10] := GetCustManifestLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReceivedCustContCount[10] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;
                        end;
                    11:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReceivedCustContCount[11] := GetCustManifestLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReceivedCustContCount[11] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;
                        end;
                    12:
                        begin
                            if CargoType <> 'LOOSE' then
                                ReceivedCustContCount[12] := GetCustManifestLinesCount(DimCode, ManifestLine1."Shortcut Dimension 4 Code", i)
                            else
                                if ManifestLine1.FindSet() then
                                    repeat
                                        ReceivedCustContCount[12] += ManifestLine1."CBM Tonage";
                                    until ManifestLine1.Next() = 0;
                        end;
                end;

                CustTotalCont := ReceivedCustContCount[1] + ReceivedCustContCount[2] + ReceivedCustContCount[3] + ReceivedCustContCount[4] + ReceivedCustContCount[5]
+ ReceivedCustContCount[6] + ReceivedCustContCount[7] + ReceivedCustContCount[8] + ReceivedCustContCount[9] + ReceivedCustContCount[10] + ReceivedCustContCount[11] + ReceivedCustContCount[12];
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
        ManifestLine.SetRange("Date Received", StartDate_gDat[j], EndDate_gDat[j]);
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

