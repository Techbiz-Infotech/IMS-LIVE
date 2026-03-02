report 50147 "Summary P&L"
{
    ApplicationArea = All;
    Caption = 'Summary P&L';
    UsageCategory = ReportsAndAnalysis;

    DefaultLayout = RDLC;
    RDLCLayout = './Src/Reports/Layouts/Summary P&L.rdlc';

    //RECEIVED Containers
    dataset
    {
        dataitem(ReceivedConMFL; "Manifest Line")
        {
            DataItemTableView = sorting("Shortcut Dimension 5 Code", "Date Received") order(ascending) where("Shortcut Dimension 4 Code" = filter('Container'));
            column(Shortcut_Dimension_4_Code;
            ReceivedConMFL."Shortcut Dimension 4 Code")
            { }
            column(Shortcut_Dimension_5_Code; "Shortcut Dimension 5 Code")
            {
            }
            column(Companylogo; CompanyInfo.Picture)
            { }
            column(CompanyName; CompanyInfo.Name)
            { }

            column(TotalReceivedUnit; TotalReceivedUnit)
            { }
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

            column(ReceivedConCount1; ReceivedConCount[1])
            {
            }
            column(TotalReceivedCont; TotalReceivedCont)
            { }
            column(ReceivedConCount2; ReceivedConCount[2])
            {
            }
            column(ReceivedConCount3; ReceivedConCount[3])
            {
            }
            column(ReceivedConCount4; ReceivedConCount[4])
            {
            }
            column(ReceivedConCount5; ReceivedConCount[5])
            {
            }
            column(ReceivedConCount6; ReceivedConCount[6])
            {
            }
            column(ReceivedConCount7; ReceivedConCount[7])
            {
            }
            column(ReceivedConCount8; ReceivedConCount[8])
            {
            }
            column(ReceivedConCount9; ReceivedConCount[9])
            {
            }
            column(ReceivedConCount10; ReceivedConCount[10])
            {
            }
            column(ReceivedConCount11; ReceivedConCount[11])
            {
            }
            column(ReceivedConCount12; ReceivedConCount[12])
            {
            }
            column(TotalTeusReceived1; TotalTeusReceived[1])
            { }

            column(TotalTeusReceived2; TotalTeusReceived[2])
            { }
            column(TotalTeusReceived3; TotalTeusReceived[3])
            { }
            column(TotalTeusReceived4; TotalTeusReceived[4])
            { }
            column(TotalTeusReceived5; TotalTeusReceived[5])
            { }
            column(TotalTeusReceived6; TotalTeusReceived[6])
            { }
            column(TotalTeusReceived7; TotalTeusReceived[7])
            { }
            column(TotalTeusReceived8; TotalTeusReceived[8])
            { }
            column(TotalTeusReceived9; TotalTeusReceived[9])
            { }
            column(TotalTeusReceived10; TotalTeusReceived[10])
            { }
            column(TotalTeusReceived11; TotalTeusReceived[11])
            { }
            column(TotalTeusReceived12; TotalTeusReceived[12])
            { }

            trigger OnPreDataItem()
            begin
            end;

            trigger OnAfterGetRecord()
            var
            begin
                Clear(ReceivedConCount);
                GetContCountforReceived(ReceivedConMFL."Shortcut Dimension 5 Code", ReceivedConMFL."Date Received");
            end;
        }
        //Container Billed  Count
        dataitem(BilledContMFL; "Manifest Line")

        {
            DataItemTableView = sorting("Shortcut Dimension 5 Code") order(ascending) where("Shortcut Dimension 4 Code" = filter('Container'));

            column(Shortcut_Dimension_4_Code1;
            BilledContMFL."Shortcut Dimension 4 Code")
            { }
            column(Shortcut_Dimension_5_Code1; "Shortcut Dimension 5 Code")
            {
            }
            column(ContainerBillingCount; ContainerBillingCount[1])
            {
            }

            column(ContainerBillingCount2; ContainerBillingCount[2])
            {
            }
            column(ContainerBillingCount3; ContainerBillingCount[3])
            {
            }
            column(ContainerBillingCount4; ContainerBillingCount[4])
            {
            }
            column(ContainerBillingCount5; ContainerBillingCount[5])
            {
            }
            column(ContainerBillingCount6; ContainerBillingCount[6])
            {
            }
            column(ContainerBillingCount7; ContainerBillingCount[7])
            {
            }
            column(ContainerBillingCount8; ContainerBillingCount[8])
            {
            }
            column(ContainerBillingCount9; ContainerBillingCount[9])
            {
            }
            column(ContainerBillingCount10; ContainerBillingCount[10])
            {
            }
            column(ContainerBillingCount11; ContainerBillingCount[11])
            {
            }
            column(ContainerBillingCount12; ContainerBillingCount[12])
            {
            }
            column(TotalBillingLooseCont; TotalBillingLooseCont)
            { }
            column(TotalTeusBilled1; TotalTeusBilled[1])
            { }
            column(TotalTeusBilled2; TotalTeusBilled[2])
            { }
            column(TotalTeusBilled3; TotalTeusBilled[3])
            { }
            column(TotalTeusBilled4; TotalTeusBilled[4])
            { }
            column(TotalTeusBilled5; TotalTeusBilled[5])
            { }
            column(TotalTeusBilled6; TotalTeusBilled[6])
            { }
            column(TotalTeusBilled7; TotalTeusBilled[7])
            { }
            column(TotalTeusBilled8; TotalTeusBilled[8])
            { }
            column(TotalTeusBilled9; TotalTeusBilled[9])
            { }
            column(TotalTeusBilled10; TotalTeusBilled[10])
            { }
            column(TotalTeusBilled11; TotalTeusBilled[11])
            { }
            column(TotalTeusBilled12; TotalTeusBilled[12])
            { }

            trigger OnPreDataItem()
            begin
            end;

            trigger OnAfterGetRecord()
            var
            begin
                Clear(ContainerBillingCount);
                GetBillingContainerCount(BilledContMFL."Shortcut Dimension 5 Code");//SHR
            end;
        }

        dataitem(ReceivedMFL; "Manifest Line")
        {
            DataItemTableView = sorting("Shortcut Dimension 5 Code", "Date Received") order(ascending);

            column(Shortcut_Dimension_4_Code2;
            ReceivedMFL."Shortcut Dimension 4 Code")
            {
            }


            column(TotalReceivedUnit1; TotalReceivedUnit)
            { }
            column(Shortcut_Dimension_5_Code2; ReceivedMFL."Shortcut Dimension 5 Code")
            {
            }
            column(Received; ReceivedMFL.Received)
            {
            }
            column(Released; ReceivedMFL.Released)
            { }
            column(Received_By; ReceivedMFL."Received By")
            { }

            column(ReceivedUnitsCount1; ReceivedUnitsCount[1])
            {
            }
            column(ReceivedUnitsCount2; ReceivedUnitsCount[2])
            {
            }
            column(ReceivedUnitsCount3; ReceivedUnitsCount[3])
            {
            }
            column(ReceivedUnitsCount4; ReceivedUnitsCount[4])
            {
            }
            column(ReceivedUnitsCount5; ReceivedUnitsCount[5])
            {
            }
            column(ReceivedUnitsCount6; ReceivedUnitsCount[6])
            {
            }
            column(ReceivedUnitsCount7; ReceivedUnitsCount[7])
            {
            }
            column(ReceivedUnitsCount8; ReceivedUnitsCount[8])
            {
            }
            column(ReceivedUnitsCount9; ReceivedUnitsCount[9])
            {
            }
            column(ReceivedUnitsCount10; ReceivedUnitsCount[10])
            {
            }
            column(ReceivedUnitsCount11; ReceivedUnitsCount[11])
            {
            }
            column(ReceivedUnitsCount12; ReceivedUnitsCount[12])
            {
            }
            column(Temp20ftcount5; Temp20ftcount[5])
            { }
            trigger OnPreDataItem()
            begin

            end;

            trigger OnAfterGetRecord()
            var
            begin
                Clear(ReceivedUnitsCount);
                GetCountforReceived(ReceivedMFL."Shortcut Dimension 5 Code", ReceivedMFL."Date Received");
            end;
        }
        //RELEASED UNITS
        dataitem(ReleasedMFL; "Manifest Line")
        {
            DataItemTableView = sorting("Shortcut Dimension 5 Code", "Date Released") order(ascending);

            column(Shortcut_Dimension_4_Code3;
            ReleasedMFL."Shortcut Dimension 4 Code")
            {
            }
            column(Shortcut_Dimension_5_Code3; "Shortcut Dimension 5 Code")
            {
            }
            column(TotalReleasedUnit; TotalReleasedUnit)
            { }
            column(TotalRecContCount1; TotalRecContCount)
            { }
            column(ReleasedUnitsCount1; ReleasedUnitsCount[1])
            {
            }
            column(ReleasedUnitsCount2; ReleasedUnitsCount[2])
            {
            }
            column(ReleasedUnitsCount3; ReleasedUnitsCount[3])
            {
            }
            column(ReleasedUnitsCount4; ReleasedUnitsCount[4])
            {
            }
            column(ReleasedUnitsCount5; ReleasedUnitsCount[5])
            {
            }
            column(ReleasedUnitsCount6; ReleasedUnitsCount[6])
            {
            }
            column(ReleasedUnitsCount7; ReleasedUnitsCount[7])
            {
            }
            column(ReleasedUnitsCount8; ReleasedUnitsCount[8])
            {
            }
            column(ReleasedUnitsCount9; ReleasedUnitsCount[9])
            {
            }
            column(ReleasedUnitsCount10; ReleasedUnitsCount[10])
            {
            }
            column(ReleasedUnitsCount11; ReleasedUnitsCount[11])
            {
            }
            column(ReleasedUnitsCount12; ReleasedUnitsCount[12])
            {
            }
            trigger OnPreDataItem()
            begin
            end;

            trigger OnAfterGetRecord()
            begin
                Clear(ReleasedUnitsCount);
                GetCountforReleased(ReleasedMFL."Shortcut Dimension 5 Code", ReleasedMFL."Date Received");
            end;
        }
        //Billed UNIT
        dataitem(BilledUnitMFL; "Manifest Line")

        {
            DataItemTableView = sorting("Shortcut Dimension 5 Code") order(ascending) where("Shortcut Dimension 4 Code" = filter('UNIT'));

            column(Shortcut_Dimension_4_Code5;
            BilledUnitMFL."Shortcut Dimension 4 Code")
            { }
            column(Shortcut_Dimension_5_Code5; "Shortcut Dimension 5 Code")
            {
            }
            column(UnitBillingCount; UnitBillingCount[1])
            {
            }
            column(UnitBillingCount2; UnitBillingCount[2])
            {
            }
            column(UnitBillingCount3; UnitBillingCount[3])
            {
            }
            column(UnitBillingCount4; UnitBillingCount[4])
            {
            }
            column(UnitBillingCount5; UnitBillingCount[5])
            {
            }
            column(UnitBillingCount6; UnitBillingCount[6])
            {
            }
            column(UnitBillingCount7; UnitBillingCount[7])
            {
            }
            column(UnitBillingCount8; UnitBillingCount[8])
            {
            }
            column(UnitBillingCount9; UnitBillingCount[9])
            {
            }
            column(UnitBillingCount10; UnitBillingCount[10])
            {
            }
            column(UnitBillingCount11; UnitBillingCount[11])
            {
            }
            column(UnitBillingCount12; UnitBillingCount[12])
            {
            }

            trigger OnPreDataItem()
            begin
            end;

            trigger OnAfterGetRecord()
            var
            begin
                Clear(UnitBillingCount);
                GetBillingUnitCount(BilledUnitMFL."Shortcut Dimension 5 Code");//SHR
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

                }

            }
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        AccountingPeriod: Record "Accounting Period";
        StartDate, EndDate : array[20] of date;

        DatePeriodFilter, StartDateFilter, EndDateFilter : Text;
        TotalRecContCount, i, Period, ReleasedPeriod : Integer;
        ReceivedUnitsCount: array[20] of Integer;
        ReleasedUnitsCount: array[20] of Integer;
        ReceivedConCount: array[20] of Integer;
        ReleasedConCount: array[20] of Integer;
        LooseBillingroadCount: array[20] of Integer;
        ContBillingRailCount: array[20] of Integer;
        ReceivedContainerCountByRoad: array[20] of Integer;
        TotalReceivedContainerByRoad: Integer;
        TotalReceivedContainerByRail: Integer;
        TotalReceivedUnit: Integer;
        TotalReceivedCont: Integer;
        TotalBillingLooseCont: Integer;
        ReceivedContainerCountByRail: array[20] of Integer;
        ContainerBillingCount: array[20] of Integer;
        UnitBillingCount: array[20] of Integer;
        Temp20ftcount: array[20] of Integer;
        Temp40ftcount: array[20] of Integer;
        TotalTeusBilled: array[20] of Integer;
        TotalTeusReceived: array[20] of Integer;
        FT20: array[20] of Integer;
        FT40: array[20] of Integer;
        StartingDate: Date;
        MonthNameTxt: array[20] of text;
        Text50011: textConst ENU = '<Month Text>';
        CountofContFT: Integer;
        UnitsCount: Integer;
        CountofUnitFT: Integer;
        SalesInvocieLine: Record "Sales Invoice Line";
        ContCountReceived: Integer;
        UnitsCountReleased: Integer;
        TotalReleasedUnit: Integer;
        ContainerId_gCode: Code[20];
        UnitId_gCode: code[20];
        UnitsCount1: Integer;
        StartDate_gDat: array[12] of Date;
        EndDate_gDat: array[12] of Date;
        Year_Int: Integer;
        YearFilter: Text[10];
        DimReceived_gcode: Code[20];
        DimUnitReceived_gcode: code[20];
        DimReleased_gcode: Code[20];
        DimContReceived_gcode: Code[20];
        DimLooseBilling_gcode: code[20];
        DimUnitBilling_gcode: code[20];
        ConatinerID: code[20];


        j: Integer;
        Text50002_gCtx: Label 'Please select proper Year';
        ContainerId_gCode40FT: Code[20];
    //Container Received Count Function 
    procedure GetContCountforReceived(DimCode: Code[20]; RDate: Date): Integer;
    var
        ManifestLine: Record "Manifest Line";
    begin
        Clear(TotalReceivedCont);
        clear(TotalTeusReceived);
        CreateDateFilters_lFnc;
        IF DimContReceived_gcode <> DimCode THEN BEGIN
            FOR i := 1 TO 12 DO BEGIN
                ManifestLine.Reset();
                ManifestLine.SetCurrentKey("Shortcut Dimension 5 Code", "Date Received");
                ManifestLine.SetRange("Date Received", StartDate_gDat[i], EndDate_gDat[i]);
                ManifestLine.SetRange("Shortcut Dimension 4 Code", 'Container');
                ManifestLine.SetRange("Shortcut Dimension 5 Code", DimCode);
                ManifestLine.SetRange(Received, true);
                //TotalReceivedCont += ManifestLine.Count;
                CASE i OF
                    1:
                        BEGIN
                            ReceivedConCount[1] := ManifestLine.COUNT;
                            IF DimCode = '40FT' then
                                TotalTeusReceived[1] := ReceivedConCount[1];
                        END;
                    2:
                        BEGIN
                            ReceivedConCount[2] := ManifestLine.COUNT;
                            IF DimCode = '40FT' then
                                TotalTeusReceived[2] := ReceivedConCount[2];
                        END;
                    3:
                        BEGIN
                            ReceivedConCount[3] := ManifestLine.COUNT;

                            IF DimCode = '40FT' then
                                TotalTeusReceived[3] := ReceivedConCount[3];
                        END;
                    4:
                        BEGIN
                            ReceivedConCount[4] := ManifestLine.COUNT;
                            IF DimCode = '40FT' then
                                TotalTeusReceived[4] := ReceivedConCount[4];
                        END;
                    5:
                        BEGIN
                            ReceivedConCount[5] := ManifestLine.COUNT;
                            IF DimCode = '40FT' then
                                TotalTeusReceived[5] := ReceivedConCount[5];
                        END;
                    6:
                        BEGIN
                            ReceivedConCount[6] := ManifestLine.COUNT;
                            IF DimCode = '40FT' then
                                TotalTeusReceived[6] := ReceivedConCount[6];
                        END;
                    7:
                        BEGIN
                            ReceivedConCount[7] := ManifestLine.COUNT;
                            IF DimCode = '40FT' then
                                TotalTeusReceived[7] := ReceivedConCount[7];
                        END;
                    8:
                        BEGIN
                            ReceivedConCount[8] := ManifestLine.COUNT;
                            IF DimCode = '40FT' then
                                TotalTeusReceived[8] := ReceivedConCount[8];
                        END;
                    9:
                        BEGIN
                            ReceivedConCount[9] := ManifestLine.COUNT;
                            IF DimCode = '40FT' then
                                TotalTeusReceived[9] := ReceivedConCount[9];
                        END;
                    10:
                        BEGIN
                            ReceivedConCount[10] := ManifestLine.COUNT;

                            IF DimCode = '40FT' then
                                TotalTeusReceived[10] := ReceivedConCount[10];
                        END;
                    11:
                        BEGIN
                            ReceivedConCount[11] := ManifestLine.COUNT;
                            IF DimCode = '40FT' then
                                TotalTeusReceived[11] := ReceivedConCount[11];
                        END;
                    12:
                        BEGIN
                            ReceivedConCount[12] := ManifestLine.COUNT;
                            IF DimCode = '40FT' then
                                TotalTeusReceived[12] := ReceivedConCount[12];
                        END;
                END;
                DimContReceived_gcode := DimCode;
            END;
        End;
    end;

    //Container Billed Count function 1
    procedure GetBillingContainerCount(InvDimCode: Code[20]);
    var
        Saleinv_Lrec: Record "Sales Invoice Line";
    begin
        CreateDateFilters_lFnc;
        clear(TotalTeusBilled);
        Clear(TotalBillingLooseCont);
        IF (DimLooseBilling_gcode <> InvDimCode) THEN BEGIN
            FOR i := 1 TO 12 DO BEGIN
                SalesInvocieLine.Reset();
                SalesInvocieLine.SetFilter("Shortcut Dimension 4 Code", '%1', 'Container');
                SalesInvocieLine.SetRange("Posting Date", StartDate_gDat[i], EndDate_gDat[i]);
                SalesInvocieLine.SetFilter("Shortcut Dimension 5 Code", '%1', InvDimCode);
                SalesInvocieLine.SetFilter("Shortcut Dimension 1 Code", '<>%1', '');
                IF SalesInvocieLine.FindFirst() then;
                CASE i OF
                    1:
                        begin
                            ContainerBillingCount[1] := GetInvoiceLinesCount(InvDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                            IF InvDimCode = '40FT' then
                                TotalTeusBilled[1] := ContainerBillingCount[1];
                        End;
                    2:
                        begin
                            ContainerBillingCount[2] := GetInvoiceLinesCount(InvDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                            IF InvDimCode = '40FT' then
                                TotalTeusBilled[2] := ContainerBillingCount[2];
                        end;
                    3:
                        begin
                            ContainerBillingCount[3] := GetInvoiceLinesCount(InvDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                            IF InvDimCode = '40FT' then
                                TotalTeusBilled[3] := ContainerBillingCount[3];
                        end;
                    4:
                        begin
                            ContainerBillingCount[4] := GetInvoiceLinesCount(InvDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                            IF InvDimCode = '40FT' then
                                TotalTeusBilled[4] := ContainerBillingCount[4];
                        end;
                    5:
                        begin
                            ContainerBillingCount[5] := GetInvoiceLinesCount(InvDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                            IF InvDimCode = '40FT' then
                                TotalTeusBilled[5] := ContainerBillingCount[5];
                        end;
                    6:
                        begin
                            ContainerBillingCount[6] := GetInvoiceLinesCount(InvDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                            IF InvDimCode = '40FT' then
                                TotalTeusBilled[6] := ContainerBillingCount[6];
                        end;
                    7:
                        begin
                            ContainerBillingCount[7] := GetInvoiceLinesCount(InvDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                            IF InvDimCode = '40FT' then
                                TotalTeusBilled[7] := ContainerBillingCount[7];
                        end;
                    8:
                        begin
                            ContainerBillingCount[8] := GetInvoiceLinesCount(InvDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                            IF InvDimCode = '40FT' then
                                TotalTeusBilled[8] := ContainerBillingCount[8];

                        end;
                    9:
                        begin
                            ContainerBillingCount[9] := GetInvoiceLinesCount(InvDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                            IF InvDimCode = '40FT' then
                                TotalTeusBilled[9] := ContainerBillingCount[9];
                        end;
                    10:
                        begin
                            ContainerBillingCount[10] := GetInvoiceLinesCount(InvDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                            IF InvDimCode = '40FT' then
                                TotalTeusBilled[10] := ContainerBillingCount[10];
                        end;
                    11:
                        begin
                            ContainerBillingCount[11] := GetInvoiceLinesCount(InvDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                            IF InvDimCode = '40FT' then
                                TotalTeusBilled[11] := ContainerBillingCount[11];
                        end;
                    12:
                        begin
                            ContainerBillingCount[12] := GetInvoiceLinesCount(InvDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                            IF InvDimCode = '40FT' then
                                TotalTeusBilled[12] := ContainerBillingCount[12];
                        end;
                END;
            end;
            DimLooseBilling_gcode := InvDimCode;
        end;
    End;

    //Container Billed Count Function 2

    local procedure GetInvoiceLinesCount(Containersize: Code[20]; CagoType: Code[20]; j: Integer): Integer;
    var
        SalesInvoiceLine2: Record "Sales Invoice Line";
        ManifestLine: Record "Manifest Line";
    begin
        clear(CountofContFT);
        SalesInvoiceLine2.Reset();
        SalesInvoiceLine2.SetCurrentKey("Shortcut Dimension 1 Code");
        SalesInvoiceLine2.SetAscending("Shortcut Dimension 1 Code", True);
        SalesInvoiceLine2.SetRange("Posting Date", StartDate_gDat[j], EndDate_gDat[j]);
        SalesInvoiceLine2.SetRange("Shortcut Dimension 5 Code", Containersize);
        SalesInvoiceLine2.SetRange("Shortcut Dimension 4 Code", CagoType);
        if SalesInvoiceLine2.FindSet() then //begin
            repeat
                IF ContainerId_gCode40FT <> SalesInvoiceLine2."Shortcut Dimension 1 Code" then begin
                    CountofContFT += 1;
                End;
                ContainerId_gCode40FT := SalesInvoiceLine2."Shortcut Dimension 1 Code";
            until SalesInvoiceLine2.Next() = 0;
        exit(CountofContFT);
    end;

    procedure GetCountforReceived(UNITDimCode: Code[20]; RDate: Date): Integer;
    var
        ManifestLine: Record "Manifest Line";
    begin

        Clear(TotalReceivedUnit);
        CreateDateFilters_lFnc;
        IF DimUnitReceived_gcode <> UNITDimCode THEN BEGIN
            FOR i := 1 TO 12 DO BEGIN
                ManifestLine.Reset();
                ManifestLine.SetCurrentKey("Shortcut Dimension 5 Code", "Date Received");
                ManifestLine.SetRange("Date Received", StartDate_gDat[i], EndDate_gDat[i]);
                ManifestLine.SetRange("Shortcut Dimension 4 Code", 'UNIT');
                ManifestLine.SetRange("Shortcut Dimension 5 Code", UNITDimCode);
                ManifestLine.SetRange(Received, true);
                TotalReceivedUnit += ManifestLine.Count;
                CASE i OF
                    1:
                        ReceivedUnitsCount[1] := ManifestLine.COUNT;
                    2:
                        ReceivedUnitsCount[2] := ManifestLine.COUNT;
                    3:
                        ReceivedUnitsCount[3] := ManifestLine.COUNT;
                    4:
                        ReceivedUnitsCount[4] := ManifestLine.COUNT;
                    5:
                        ReceivedUnitsCount[5] := ManifestLine.COUNT;
                    6:
                        ReceivedUnitsCount[6] := ManifestLine.COUNT;
                    7:
                        ReceivedUnitsCount[7] := ManifestLine.COUNT;
                    8:
                        ReceivedUnitsCount[8] := ManifestLine.COUNT;
                    9:
                        ReceivedUnitsCount[9] := ManifestLine.COUNT;
                    10:
                        ReceivedUnitsCount[10] := ManifestLine.COUNT;
                    11:
                        ReceivedUnitsCount[11] := ManifestLine.COUNT;
                    12:
                        ReceivedUnitsCount[12] := ManifestLine.COUNT;
                END;
                DimUnitReceived_gcode := UNITDimCode;

            END;
        End;
    end;

    //RELEASED UNITS

    procedure GetCountforReleased(UNITRelDimCode: Code[20]; RDate: Date): Integer;
    var
        ManifestLine: Record "Manifest Line";
    begin
        clear(TotalReleasedUnit);
        CreateDateFilters_lFnc;
        IF DimReleased_gcode <> UNITReLDimCode THEN BEGIN
            FOR i := 1 TO 12 DO BEGIN
                ManifestLine.Reset();
                ManifestLine.SetCurrentKey("Shortcut Dimension 5 Code", "Date Released");
                ManifestLine.SetRange("Date Released", StartDate_gDat[i], EndDate_gDat[i]);
                ManifestLine.SetRange("Shortcut Dimension 4 Code", 'UNIT');
                ManifestLine.SetRange("Shortcut Dimension 5 Code", UNITRelDimCode);
                ManifestLine.SetRange(Released, true);
                TotalReleasedUnit += ManifestLine.Count;
                CASE i OF
                    1:
                        BEGIN
                            ReleasedUnitsCount[1] := ManifestLine.COUNT;
                        END;
                    2:
                        BEGIN
                            ReleasedUnitsCount[2] := ManifestLine.COUNT;
                        END;
                    3:
                        BEGIN
                            ReleasedUnitsCount[3] := ManifestLine.COUNT;
                        END;
                    4:
                        BEGIN
                            ReleasedUnitsCount[4] := ManifestLine.COUNT;
                        END;
                    5:
                        BEGIN
                            ReleasedUnitsCount[5] := ManifestLine.COUNT;
                        END;
                    6:
                        BEGIN
                            ReleasedUnitsCount[6] := ManifestLine.COUNT;
                        END;
                    7:
                        BEGIN
                            ReleasedUnitsCount[7] := ManifestLine.COUNT;
                        END;
                    8:
                        BEGIN
                            ReleasedUnitsCount[8] := ManifestLine.COUNT;
                        END;
                    9:
                        BEGIN
                            ReleasedUnitsCount[9] := ManifestLine.COUNT;
                        END;
                    10:
                        BEGIN
                            ReleasedUnitsCount[10] := ManifestLine.COUNT;
                        END;
                    11:
                        BEGIN
                            ReleasedUnitsCount[11] := ManifestLine.COUNT;
                        END;
                    12:
                        BEGIN
                            ReleasedUnitsCount[12] := ManifestLine.COUNT;
                        END;
                END;
                DimReleased_gcode := UNITRelDimCode;

            END;
        End;

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

    procedure GetBillingUnitCount(InvUnitDimCode: Code[20]);
    var
        Saleinv_Lrec: Record "Sales Invoice Line";
    begin
        CreateDateFilters_lFnc;
        Clear(TotalBillingLooseCont);
        IF (DimUnitBilling_gcode <> InvUnitDimCode) THEN BEGIN
            FOR i := 1 TO 12 DO BEGIN
                SalesInvocieLine.Reset();
                SalesInvocieLine.SetFilter("Shortcut Dimension 4 Code", '%1', 'UNIT');
                SalesInvocieLine.SetRange("Posting Date", StartDate_gDat[i], EndDate_gDat[i]);
                SalesInvocieLine.SetFilter("Shortcut Dimension 5 Code", '%1', InvUnitDimCode);
                SalesInvocieLine.SetFilter("Shortcut Dimension 1 Code", '<>%1', '');
                IF SalesInvocieLine.FindFirst() then;
                CASE i OF
                    1:
                        begin
                            UnitBillingCount[1] := GetUnitInvoiceLinesCount(InvUnitDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);


                            //IF InvDimCode = '40FT' then
                            //Vaiablesample  += 2*GetInvoiceLinesCount(InvDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i); 
                        End;
                    2:
                        begin
                            UnitBillingCount[2] := GetUnitInvoiceLinesCount(InvUnitDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);

                        end;
                    3:
                        begin
                            UnitBillingCount[3] := GetUnitInvoiceLinesCount(InvUnitDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);

                        end;
                    4:
                        begin
                            UnitBillingCount[4] := GetUnitInvoiceLinesCount(InvUnitDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);

                        end;
                    5:
                        begin
                            UnitBillingCount[5] := GetUnitInvoiceLinesCount(InvUnitDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);

                        end;
                    6:
                        begin
                            UnitBillingCount[6] := GetUnitInvoiceLinesCount(InvUnitDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);

                        end;
                    7:
                        begin
                            UnitBillingCount[7] := GetUnitInvoiceLinesCount(InvUnitDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);

                        end;
                    8:
                        begin
                            UnitBillingCount[8] := GetUnitInvoiceLinesCount(InvUnitDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);

                        end;
                    9:
                        begin
                            UnitBillingCount[9] := GetUnitInvoiceLinesCount(InvUnitDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);

                        end;
                    10:
                        begin
                            UnitBillingCount[10] := GetUnitInvoiceLinesCount(InvUnitDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);

                        end;
                    11:
                        begin
                            UnitBillingCount[11] := GetUnitInvoiceLinesCount(InvUnitDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);

                        end;
                    12:
                        begin
                            UnitBillingCount[12] := GetUnitInvoiceLinesCount(InvUnitDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);

                        end;
                END;
            end;
            DimUnitBilling_gcode := InvUnitDimCode;
        end;
    End;

    local procedure GetUnitInvoiceLinesCount(Containersize: Code[20]; CagoType: Code[20]; j: Integer): Integer;
    var
        SalesInvoiceLine2: Record "Sales Invoice Line";
        ManifestLine: Record "Manifest Line";
    begin
        clear(CountofUnitFT);
        SalesInvoiceLine2.Reset();
        SalesInvoiceLine2.SetCurrentKey("Shortcut Dimension 1 Code");
        SalesInvoiceLine2.SetAscending("Shortcut Dimension 1 Code", True);
        SalesInvoiceLine2.SetRange("Posting Date", StartDate_gDat[j], EndDate_gDat[j]);
        SalesInvoiceLine2.SetRange("Shortcut Dimension 5 Code", Containersize);
        SalesInvoiceLine2.SetRange("Shortcut Dimension 4 Code", CagoType);
        if SalesInvoiceLine2.FindSet() then //begin
            repeat
                IF UnitId_gCode <> SalesInvoiceLine2."Shortcut Dimension 1 Code" then begin
                    CountofUnitFT += 1;
                End;
                UnitId_gCode := SalesInvoiceLine2."Shortcut Dimension 1 Code";
            until SalesInvoiceLine2.Next() = 0;
        exit(CountofUnitFT);
    end;



}
