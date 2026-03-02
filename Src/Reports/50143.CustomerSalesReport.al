report 50143 "IMS Customer Sales"
{
    ApplicationArea = All;
    Caption = 'IMS Customer Sales';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Src/Reports/Layouts/CustomerSales.rdlc';
    dataset
    {
        //Customer Container Count Data Set
        dataitem("Sales Invoice Line"; "Sales Invoice Line")
        {
            DataItemTableView = sorting("Sell-to Customer No.") order(ascending) where("Shortcut Dimension 4 Code" = filter('container'));
            column(Sell_to_Customer_No_; "Sell-to Customer No.") { }
            column(CutomerName; CutomerName) { }
            column(Companylogo; CompanyInfo.Picture) { }
            column(CompanyName; CompanyInfo.Name) { }
            column(TotalRecContCount; TotalRecContCount) { }
            column(MonthNameTxt1; StrSubstNo('Jan - %1', YearFilter)) { }
            column(MonthNameTxt2; StrSubstNo('Feb - %1', YearFilter)) { }
            column(MonthNameTxt3; StrSubstNo('Mar - %1', YearFilter)) { }
            column(MonthNameTxt4; StrSubstNo('Apr - %1', YearFilter)) { }
            column(MonthNameTxt5; StrSubstNo('May - %1', YearFilter)) { }
            column(MonthNameTxt6; StrSubstNo('Jun - %1', YearFilter)) { }
            column(MonthNameTxt7; StrSubstNo('Jul - %1', YearFilter)) { }
            column(MonthNameTxt8; StrSubstNo('Aug - %1', YearFilter)) { }
            column(MonthNameTxt9; StrSubstNo('Sep - %1', YearFilter)) { }
            column(MonthNameTxt10; StrSubstNo('Oct - %1', YearFilter)) { }
            column(MonthNameTxt11; StrSubstNo('Nov - %1', YearFilter)) { }
            column(MonthNameTxt12; StrSubstNo('Dec - %1', YearFilter)) { }
            column(CustContainerCount1; CustContainerCount[1]) { }
            column(CustContainerCount2; CustContainerCount[2]) { }
            column(CustContainerCount3; CustContainerCount[3]) { }
            column(CustContainerCount4; CustContainerCount[4]) { }
            column(CustContainerCount5; CustContainerCount[5]) { }
            column(CustContainerCount6; CustContainerCount[6]) { }
            column(CustContainerCount7; CustContainerCount[7]) { }
            column(CustContainerCount8; CustContainerCount[8]) { }
            column(CustContainerCount9; CustContainerCount[9]) { }
            column(CustContainerCount10; CustContainerCount[10]) { }
            column(CustContainerCount11; CustContainerCount[11]) { }
            column(CustContainerCount12; CustContainerCount[12]) { }

            trigger OnPreDataItem()
            begin
                //CreateDateFilters_lFnc;
                // Message('start Date %1,end date %2', StartDate_gDat[i], EndDate_gDat[i]);
                // "Sales Invoice Line".SetRange("Posting Date", StartDate_gDat[i], EndDate_gDat[i]);
            end;

            trigger OnAfterGetRecord()
            var
                Custrec: Record Customer;

            begin
                //     CreateDateFilters_lFnc;
                //     
                if Custrec.get("Sales Invoice Line"."Sell-to Customer No.") then
                    CutomerName := Custrec.Name;
                Clear(CustContainerCount);
                //CustTotalCont +=
                //"Sales Invoice Line".SetRange("Posting Date", StartDate_gDat[1], EndDate_gDat[12]);
                GetCustomerContCount("Sales Invoice Line"."Sell-to Customer No.");

                // Message('start Date %1,end date %2', StartDate_gDat[1], EndDate_gDat[12]);
                // Message('%1', CustTotalCont);
                If CustTotalCont = 0 then
                    CurrReport.Skip();
            end;
        }
        dataitem(CustomerUnitSalesLine; "Sales Invoice Line")
        {
            DataItemTableView = sorting("Sell-to Customer No.") order(ascending) where("Shortcut Dimension 4 Code" = filter('Unit'));
            column(Sell_to_Customer_No_1; "Sell-to Customer No.") { }
            column(CutomerName1; CutomerName) { }
            column(CustUnitsCount1; CustUnitsCount[1]) { }
            column(CustUnitsCount2; CustUnitsCount[2]) { }
            column(CustUnitsCount3; CustUnitsCount[3]) { }
            column(CustUnitsCount4; CustUnitsCount[4]) { }
            column(CustUnitsCount5; CustUnitsCount[5]) { }
            column(CustUnitsCount6; CustUnitsCount[6]) { }
            column(CustUnitsCount7; CustUnitsCount[7]) { }
            column(CustUnitsCount8; CustUnitsCount[8]) { }
            column(CustUnitsCount9; CustUnitsCount[9]) { }
            column(CustUnitsCount10; CustUnitsCount[10]) { }
            column(CustUnitsCount11; CustUnitsCount[11]) { }
            column(CustUnitsCount12; CustUnitsCount[12]) { }

            trigger OnPreDataItem()
            begin
            end;

            trigger OnAfterGetRecord()
            var
                Custrec: Record Customer;
            begin
                if Custrec.get(CustomerUnitSalesLine."Sell-to Customer No.") then
                    CutomerName := Custrec.Name;
                Clear(CustUnitsCount);
                GetCustomerUnitsCount(CustomerUnitSalesLine."Sell-to Customer No.");
                //CustomerUnitSalesLine.SetRange("Posting Date", StartDate_gDat[1], EndDate_gDat[12]);
                If CustUnitsTotalCont = 0 then
                    CurrReport.Skip();

            end;


        }
        //customer loose Cargo count
        dataitem(CustLoosecargoCountSalesLine; "Sales Invoice Line")
        {
            DataItemTableView = sorting("Sell-to Customer No.") order(ascending) where("Shortcut Dimension 4 Code" = filter('LOOSE'));
            column(Sell_to_Customer_No4_; "Sell-to Customer No.") { }
            column(CutomerName4; CutomerName) { }
            column(CustLooseCargoCount1; CustLooseCargoCount[1]) { }
            column(CustLooseCargoCount2; CustLooseCargoCount[2]) { }
            column(CustLooseCargoCount3; CustLooseCargoCount[3]) { }
            column(CustLooseCargoCount4; CustLooseCargoCount[4]) { }
            column(CustLooseCargoCount5; CustLooseCargoCount[5]) { }
            column(CustLooseCargoCount6; CustLooseCargoCount[6]) { }
            column(CustLooseCargoCount7; CustLooseCargoCount[7]) { }
            column(CustLooseCargoCount8; CustLooseCargoCount[8]) { }
            column(CustLooseCargoCount9; CustLooseCargoCount[9]) { }
            column(CustLooseCargoCount10; CustLooseCargoCount[10]) { }
            column(CustLooseCargoCount11; CustLooseCargoCount[11]) { }
            column(CustLooseCargoCount12; CustLooseCargoCount[12]) { }
            trigger OnPreDataItem()
            begin
            end;

            trigger OnAfterGetRecord()
            var
                Customerrec: Record Customer;
            begin
                if Customerrec.get(CustLoosecargoCountSalesLine."Sell-to Customer No.") then
                    CutomerName := Customerrec.Name;
                Clear(CustLooseCargoCount);
                GetCustomerLooseCargoCount(CustLoosecargoCountSalesLine."Sell-to Customer No.");
                If CustLooseTotalCont = 0 then
                    CurrReport.Skip();

            end;
        }
        //Customer Container Amount Data Set
        dataitem(CustomerContainerAmtSalesLine; "Sales Invoice Line")
        {
            DataItemTableView = sorting("Sell-to Customer No.") order(ascending) where("Shortcut Dimension 4 Code" = filter('Container'));
            column(Sell_to_Customer_No2_; "Sell-to Customer No.") { }
            column(CutomerName2; CutomerName) { }
            column(CustContainerAmountCount1; CustContainerAmountCount[1]) { }
            column(CustContainerAmountCount2; CustContainerAmountCount[2]) { }
            column(CustContainerAmountCount3; CustContainerAmountCount[3]) { }
            column(CustContainerAmountCount4; CustContainerAmountCount[4]) { }
            column(CustContainerAmountCount5; CustContainerAmountCount[5]) { }
            column(CustContainerAmountCount6; CustContainerAmountCount[6]) { }
            column(CustContainerAmountCount7; CustContainerAmountCount[7]) { }
            column(CustContainerAmountCount8; CustContainerAmountCount[8]) { }
            column(CustContainerAmountCount9; CustContainerAmountCount[9]) { }
            column(CustContainerAmountCount10; CustContainerAmountCount[10]) { }
            column(CustContainerAmountCount11; CustContainerAmountCount[11]) { }
            column(CustContainerAmountCount12; CustContainerAmountCount[12]) { }

            trigger OnPreDataItem()
            begin
            end;

            trigger OnAfterGetRecord()
            var
                Custrec: Record Customer;
            begin
                if Custrec.get(CustomerContainerAmtSalesLine."Sell-to Customer No.") then
                    CutomerName := Custrec.Name;
                Clear(CustContainerAmountCount);
                GetCustomerContAmountCount(CustomerContainerAmtSalesLine."Sell-to Customer No.");
                If CustAmtTotalCont = 0 then
                    CurrReport.Skip();
            end;
        }
        //Customer Units Amount Data Set

        dataitem(CustomerUnitAmtSalesLine; "Sales Invoice Line")
        {
            DataItemTableView = sorting("Sell-to Customer No.") order(ascending) where("Shortcut Dimension 4 Code" = filter('Unit'));
            column(Sell_to_Customer_No_3; "Sell-to Customer No.") { }
            column(CutomerName3; CutomerName) { }
            column(CustUnitsAmountCount1; CustUnitsAmountCount[1]) { }
            column(CustUnitsAmountCount2; CustUnitsAmountCount[2]) { }
            column(CustUnitsAmountCount3; CustUnitsAmountCount[3]) { }
            column(CustUnitsAmountCount4; CustUnitsAmountCount[4]) { }
            column(CustUnitsAmountCount5; CustUnitsAmountCount[5]) { }
            column(CustUnitsAmountCount6; CustUnitsAmountCount[6]) { }
            column(CustUnitsAmountCount7; CustUnitsAmountCount[7]) { }
            column(CustUnitsAmountCount8; CustUnitsAmountCount[8]) { }
            column(CustUnitsAmountCount9; CustUnitsAmountCount[9]) { }
            column(CustUnitsAmountCount10; CustUnitsAmountCount[10]) { }
            column(CustUnitsAmountCount11; CustUnitsAmountCount[11]) { }
            column(CustUnitsAmountCount12; CustUnitsAmountCount[12]) { }
            trigger OnPreDataItem()
            begin
            end;

            trigger OnAfterGetRecord()
            var
                Custrec: Record Customer;
            begin
                if Custrec.get(CustomerUnitAmtSalesLine."Sell-to Customer No.") then
                    CutomerName := Custrec.Name;
                Clear(CustUnitsAmountCount);
                GetCustomerUnitsAmtCount(CustomerUnitAmtSalesLine."Sell-to Customer No.");
                If CustUnitsAmtTotalCont = 0 then
                    CurrReport.Skip();
            end;


        }
        //Customer LooseCargo Amount Data Set
        dataitem(CustomerLooseCargoAmtSalesLine; "Sales Invoice Line")
        {
            DataItemTableView = sorting("Sell-to Customer No.") order(ascending) where("Shortcut Dimension 4 Code" = filter('LOOSE'));
            column(Sell_to_Customer_No5_; "Sell-to Customer No.") { }
            column(CutomerName5; CutomerName) { }
            column(CustLooseCargoAmountCount1; CustLooseCargoAmountCount[1]) { }
            column(CustLooseCargoAmountCount2; CustLooseCargoAmountCount[2]) { }
            column(CustLooseCargoAmountCount3; CustLooseCargoAmountCount[3]) { }
            column(CustLooseCargoAmountCount4; CustLooseCargoAmountCount[4]) { }
            column(CustLooseCargoAmountCount5; CustLooseCargoAmountCount[5]) { }
            column(CustLooseCargoAmountCount6; CustLooseCargoAmountCount[6]) { }
            column(CustLooseCargoAmountCount7; CustLooseCargoAmountCount[7]) { }
            column(CustLooseCargoAmountCount8; CustLooseCargoAmountCount[8]) { }
            column(CustLooseCargoAmountCount9; CustLooseCargoAmountCount[9]) { }
            column(CustLooseCargoAmountCount10; CustLooseCargoAmountCount[10]) { }
            column(CustLooseCargoAmountCount11; CustLooseCargoAmountCount[11]) { }
            column(CustLooseCargoAmountCount12; CustLooseCargoAmountCount[12]) { }
            trigger OnPreDataItem()
            begin
            end;

            trigger OnAfterGetRecord()
            var
                Custrec: Record Customer;
            begin
                if Custrec.get(CustomerLooseCargoAmtSalesLine."Sell-to Customer No.") then
                    CutomerName := Custrec.Name;
                Clear(CustLooseCargoAmountCount);
                GetCustomerLooseAmountCount(CustomerLooseCargoAmtSalesLine."Sell-to Customer No.");
                If CustLooseAmtTotalCont = 0 then
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
                    field(Salespersoncode; Salespersoncode)
                    {
                        Caption = 'SalesPerson';
                        ApplicationArea = Basic, Suite;
                        TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(3));
                    }
                }
            }
        }

    }
    var
        SalesInvoiceHeaderRec: Record "Sales Invoice Header";
        CompanyInfo: Record "Company Information";
        Salespersoncode: code[30];
        AccountingPeriod: Record "Accounting Period";
        StartDate, EndDate : array[20] of date;
        DatePeriodFilter, StartDateFilter, EndDateFilter : Text;
        TotalRecContCount, i, Period, CrPeriod : Integer;
        CustContainerCount: array[20] of Integer;
        CustContainerAmountCount: array[20] of Decimal;
        CustUnitsAmountCount: array[20] of Decimal;
        CustUnitsCount: array[20] of Integer;
        CustLooseCargoAmountCount: array[20] of Decimal;
        //CustLooseCargoCount: array[20] of Integer;
        CustLooseCargoCount: array[20] of Decimal;
        StartingDate: Date;
        MonthNameTxt: array[20] of text;
        Text50011: textConst ENU = '<Month Text>';
        CountofContiner: Integer;
        ContainerId_gCode: Code[20];
        UnitId_gCode: Code[20];
        DimUnit_gcode: code[20];
        DimUnitAmt_gcode: code[20];
        LoosecargoId_gCode: Code[20];
        DimLooseCargo_gcode: code[20];
        DimLoosecargoAmt_gcode: code[20];
        LooseCBM: Decimal;
        SalesInvocieLine: Record "Sales Invoice Line";
        SalesInvoiceHead: Record "Sales Invoice Header";
        CutomerName: text[100];
        ManifestLine: Record "Manifest Line";
        StartDate_gDat: array[12] of Date;
        EndDate_gDat: array[12] of Date;
        Year_Int: Integer;
        CustTotalCont: Integer;
        CustUnitsTotalCont: Integer;
        CustLooseTotalCont: Decimal;
        CustAmtTotalCont: Decimal;
        CustUnitsAmtTotalCont: Decimal;
        CustLooseAmtTotalCont: Decimal;
        YearFilter: Text[10];
        Text50002_gCtx: Label 'Please select proper Year';
        DimReceived_gcode: code[20];
        CountOfContainer: Integer;
        CountOfAmtUnits: Decimal;
        CountOfUnits: Integer;
        CountOfLoosecargo: Decimal;
        CountOfLooseCargoAmounts: Integer;
        CountOfContainerAmt: Decimal;
        CountOfLooseAmt: Decimal;
        DimCont_gcode: code[20];
        DimContAmt_gcode: code[20];
        DimlooseAmt_gcode: code[20];

    //customer Container Counts
    procedure GetCustomerContCount(DimCode: Code[20]): Integer;
    var
        ManifestLine: Record "Manifest Line";
    begin
        CreateDateFilters_lFnc;
        IF (DimCont_gcode <> DimCode) then begin
            FOR i := 1 TO 12 DO BEGIN
                SalesInvocieLine.Reset();
                SalesInvocieLine.SetRange("Shortcut Dimension 4 Code", 'Container');
                SalesInvocieLine.SetRange("Posting Date", StartDate_gDat[i], EndDate_gDat[i]);
                if SalesPersonCode <> '' then
                    SalesInvocieLine.SetFilter("Shortcut Dimension 3 Code", '%1', Salespersoncode);
                SalesInvocieLine.SetFilter("Shortcut Dimension 1 Code", '<>%1', '');
                SalesInvocieLine.SetFilter("Sell-to Customer No.", '%1', DimCode);
                if SalesInvocieLine.FindFirst() then;
                CASE i OF
                    1:
                        CustContainerCount[1] := GetCustInvoiceLinesCount(DimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    2:
                        CustContainerCount[2] := GetCustInvoiceLinesCount(DimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    3:
                        CustContainerCount[3] := GetCustInvoiceLinesCount(DimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    4:
                        CustContainerCount[4] := GetCustInvoiceLinesCount(DimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    5:
                        CustContainerCount[5] := GetCustInvoiceLinesCount(DimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    6:
                        CustContainerCount[6] := GetCustInvoiceLinesCount(DimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    7:
                        CustContainerCount[7] := GetCustInvoiceLinesCount(DimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    8:
                        CustContainerCount[8] := GetCustInvoiceLinesCount(DimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    9:
                        CustContainerCount[9] := GetCustInvoiceLinesCount(DimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    10:
                        CustContainerCount[10] := GetCustInvoiceLinesCount(DimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    11:
                        CustContainerCount[11] := GetCustInvoiceLinesCount(DimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    12:
                        CustContainerCount[12] := GetCustInvoiceLinesCount(DimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                end;

                CustTotalCont := CustContainerCount[1] + CustContainerCount[2] + CustContainerCount[3] + CustContainerCount[4] + CustContainerCount[5]
               + CustContainerCount[6] + CustContainerCount[7] + CustContainerCount[8] + CustContainerCount[9] + CustContainerCount[10] + CustContainerCount[11] + CustContainerCount[12];
                //Message('%1', CustTotalCont);
            end;
            DimCont_gcode := DimCode;
        end;
    END;

    LOCAL procedure CreateDateFilters_lFnc();
    begin
        StartDate_gDat[1] := DMY2DATE(1, 1, Year_Int);
        EndDate_gDat[1] := CALCDATE('1M', StartDate_gDat[1]) - 1;
        FOR i := 2 TO 12 DO BEGIN
            StartDate_gDat[i] := CALCDATE('1M', StartDate_gDat[i - 1]);
            EndDate_gDat[i] := CALCDATE('1M', StartDate_gDat[i]) - 1;
        END;
    end;
    //Customer COntainer Count function 2
    local procedure GetCustInvoiceLinesCount(CustomerNo: Code[20]; CagoType: Code[20]; j: Integer): Integer;
    var
        SalesInvoiceLine2: Record "Sales Invoice Line";
        ManifestLine: Record "Manifest Line";
    begin
        clear(CountOfContainer);
        SalesInvoiceLine2.Reset();
        SalesInvoiceLine2.SetCurrentKey("Shortcut Dimension 1 Code");
        SalesInvoiceLine2.SetAscending("Shortcut Dimension 1 Code", True);
        SalesInvoiceLine2.SetRange("Posting Date", StartDate_gDat[j], EndDate_gDat[j]);
        if SalesPersonCode <> '' then
            SalesInvoiceLine2.SetFilter("Shortcut Dimension 3 Code", '%1', Salespersoncode);
        SalesInvoiceLine2.SetRange("Sell-to Customer No.", CustomerNo);
        SalesInvoiceLine2.SetRange("Shortcut Dimension 4 Code", CagoType);
        if SalesInvoiceLine2.FindSet() then //begin
            repeat
                IF ContainerId_gCode <> SalesInvoiceLine2."Shortcut Dimension 1 Code" then begin
                    CountOfContainer += 1;
                End;
                ContainerId_gCode := SalesInvoiceLine2."Shortcut Dimension 1 Code";
            until SalesInvoiceLine2.Next() = 0;
        exit(CountOfContainer);
    end;
    //Customer Units Count

    procedure GetCustomerUnitsCount(UDimCode: Code[20]): Integer;
    var
    begin
        CreateDateFilters_lFnc;
        IF (DimUnit_gcode <> UDimCode) then begin
            FOR i := 1 TO 12 DO BEGIN
                SalesInvocieLine.Reset();
                SalesInvocieLine.SetFilter("Shortcut Dimension 4 Code", '%1', 'UNIT');
                SalesInvocieLine.SetRange("Posting Date", StartDate_gDat[i], EndDate_gDat[i]);
                if SalesPersonCode <> '' then
                    SalesInvocieLine.SetFilter("Shortcut Dimension 3 Code", '%1', Salespersoncode);
                SalesInvocieLine.SetFilter("Shortcut Dimension 1 Code", '<>%1', '');
                SalesInvocieLine.SetFilter("Sell-to Customer No.", '%1', UDimCode);
                if SalesInvocieLine.FindFirst() then;
                CASE i OF
                    1:
                        CustUnitsCount[1] := GetCustUnitsInvoiceLinesCount(UDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    2:
                        CustUnitsCount[2] := GetCustUnitsInvoiceLinesCount(UDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    3:
                        CustUnitsCount[3] := GetCustUnitsInvoiceLinesCount(UDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    4:
                        CustUnitsCount[4] := GetCustUnitsInvoiceLinesCount(UDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    5:
                        CustUnitsCount[5] := GetCustUnitsInvoiceLinesCount(UDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    6:
                        CustUnitsCount[6] := GetCustUnitsInvoiceLinesCount(UDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    7:
                        CustUnitsCount[7] := GetCustUnitsInvoiceLinesCount(UDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    8:
                        CustUnitsCount[8] := GetCustUnitsInvoiceLinesCount(UDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    9:
                        CustUnitsCount[9] := GetCustUnitsInvoiceLinesCount(UDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    10:
                        CustUnitsCount[10] := GetCustUnitsInvoiceLinesCount(UDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    11:
                        CustUnitsCount[11] := GetCustUnitsInvoiceLinesCount(UDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    12:
                        CustUnitsCount[12] := GetCustUnitsInvoiceLinesCount(UDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                end;
                CustUnitsTotalCont := CustUnitsCount[1] + CustUnitsCount[2] + CustUnitsCount[3] + CustUnitsCount[4] + CustUnitsCount[5]
               + CustUnitsCount[6] + CustUnitsCount[7] + CustUnitsCount[8] + CustUnitsCount[9] + CustUnitsCount[10] + CustUnitsCount[11] + CustContainerCount[12];
                //Message('%1', CustTotalCont);
            end;
            DimUnit_gcode := UDimCode;
        end;
    END;
    //Customer Units Count
    local procedure GetCustUnitsInvoiceLinesCount(CustomerNo: Code[20]; CagoType: Code[20]; j: Integer): Decimal;
    var
        SalesInvoiceLine2: Record "Sales Invoice Line";
        ManifestLine: Record "Manifest Line";
    begin
        clear(CountOfUnits);
        SalesInvoiceLine2.Reset();
        SalesInvoiceLine2.SetCurrentKey("Shortcut Dimension 1 Code");
        SalesInvoiceLine2.SetAscending("Shortcut Dimension 1 Code", True);
        SalesInvoiceLine2.SetRange("Posting Date", StartDate_gDat[j], EndDate_gDat[j]);
        if SalesPersonCode <> '' then
            SalesInvoiceLine2.SetFilter("Shortcut Dimension 3 Code", '%1', Salespersoncode);
        SalesInvoiceLine2.SetRange("Sell-to Customer No.", CustomerNo);
        SalesInvoiceLine2.SetRange("Shortcut Dimension 4 Code", CagoType);
        if SalesInvoiceLine2.FindSet() then //begin
            repeat
                IF UnitId_gCode <> SalesInvoiceLine2."Shortcut Dimension 1 Code" then begin
                    CountOfUnits += 1;
                End;
                UnitId_gCode := SalesInvoiceLine2."Shortcut Dimension 1 Code";
            until SalesInvoiceLine2.Next() = 0;
        exit(CountOfUnits);
    end;
    //Get CustomerLooseCargoCount function 1
    procedure GetCustomerLooseCargoCount(LCDimCode: Code[20]): Integer;
    var
        ManifestLine_Lrec: Record "Manifest Line";
    begin
        CreateDateFilters_lFnc;
        ManifestLine_Lrec.Reset();
        ManifestLine_Lrec.SetRange("Shortcut Dimension 4 Code", 'LOOSE');
        ManifestLine_Lrec.SetRange("Invoicing Party No.", '%1', LCDimCode);
        ManifestLine_Lrec.CalcFields("Charge ID");
        ManifestLine_Lrec.SetFilter("Charge ID", '<>%1', '');
        if ManifestLine_Lrec.FindFirst() then begin
            IF (DimLooseCargo_gcode <> LCDimCode) then begin
                FOR i := 1 TO 12 DO BEGIN
                    SalesInvocieLine.Reset();
                    SalesInvocieLine.SetFilter("Shortcut Dimension 4 Code", '%1', 'LOOSE');
                    SalesInvocieLine.SetRange("Posting Date", StartDate_gDat[i], EndDate_gDat[i]);
                    if SalesPersonCode <> '' then
                        SalesInvocieLine.SetFilter("Shortcut Dimension 3 Code", '%1', Salespersoncode);
                    SalesInvocieLine.SetFilter("Shortcut Dimension 1 Code", '<>%1', '');
                    SalesInvocieLine.SetFilter("Sell-to Customer No.", '%1', LCDimCode);
                    if SalesInvocieLine.FindFirst() then;
                    CASE i OF
                        1:
                            CustLooseCargoCount[1] := GetCustLooseCargoInvoiceLinesCount(LCDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                        2:
                            CustLooseCargoCount[2] := GetCustLooseCargoInvoiceLinesCount(LCDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                        3:
                            CustLooseCargoCount[3] := GetCustLooseCargoInvoiceLinesCount(LCDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                        4:
                            CustLooseCargoCount[4] := GetCustLooseCargoInvoiceLinesCount(LCDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                        5:
                            CustLooseCargoCount[5] := GetCustLooseCargoInvoiceLinesCount(LCDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                        6:
                            CustLooseCargoCount[6] := GetCustLooseCargoInvoiceLinesCount(LCDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                        7:
                            CustLooseCargoCount[7] := GetCustLooseCargoInvoiceLinesCount(LCDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                        8:
                            CustLooseCargoCount[8] := GetCustLooseCargoInvoiceLinesCount(LCDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                        9:
                            CustLooseCargoCount[9] := GetCustLooseCargoInvoiceLinesCount(LCDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                        10:
                            CustLooseCargoCount[10] := GetCustLooseCargoInvoiceLinesCount(LCDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                        11:
                            CustLooseCargoCount[11] := GetCustLooseCargoInvoiceLinesCount(LCDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                        12:
                            CustLooseCargoCount[12] := GetCustLooseCargoInvoiceLinesCount(LCDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    end;
                    CustLooseTotalCont := CustLooseCargoCount[1] + CustLooseCargoCount[2] + CustLooseCargoCount[3] + CustLooseCargoCount[4] + CustLooseCargoCount[5]
                   + CustLooseCargoCount[6] + CustLooseCargoCount[7] + CustLooseCargoCount[8] + CustLooseCargoCount[9] + CustLooseCargoCount[10] + CustLooseCargoCount[11] + CustLooseCargoCount[12];

                end;
                DimLooseCargo_gcode := LCDimCode;
            end;

        END;
    end;
    //Customer Loosecargo Count function 2
    local procedure GetCustLooseCargoInvoiceLinesCount(CustomerNo: Code[20]; CagoType: Code[20]; j: Integer): Decimal;
    var
        SalesInvoiceLine2: Record "Sales Invoice Line";
        ManifestLine: Record "Manifest Line";
    begin
        clear(CountOfLoosecargo);
        SalesInvoiceLine2.Reset();
        SalesInvoiceLine2.SetCurrentKey("Shortcut Dimension 1 Code");
        SalesInvoiceLine2.SetAscending("Shortcut Dimension 1 Code", True);
        SalesInvoiceLine2.SetRange("Posting Date", StartDate_gDat[j], EndDate_gDat[j]);
        if SalesPersonCode <> '' then
            SalesInvoiceLine2.SetFilter("Shortcut Dimension 3 Code", '%1', Salespersoncode);
        SalesInvoiceLine2.SetRange("Sell-to Customer No.", CustomerNo);
        //SalesInvoiceLine2.SetRange("Shortcut Dimension 4 Code", 'LOOSE');
        SalesInvoiceLine2.SetRange("Shortcut Dimension 4 Code", CagoType);
        if SalesInvoiceLine2.FindSet() then
            repeat
                IF LoosecargoId_gCode <> SalesInvoiceLine2."Shortcut Dimension 1 Code" then begin

                    ManifestLine.Reset();
                    ManifestLine.SetRange("Container/Chassis No.", SalesInvoiceLine2."Container No./Chassis No.");
                    ManifestLine.SetRange("Shortcut Dimension 4 Code", CagoType);
                    ManifestLine.SetRange("Invoicing Party No.", CustomerNo);
                    //ManifestLine.SetRange("Invoicing Party No.", No);
                    if ManifestLine.FindSet() then
                        repeat
                            CountOfloosecargo += ManifestLine."CBM Tonage";
                        //CountOfloosecargo += 1;
                        until ManifestLine.Next() = 0;
                end;
                LoosecargoId_gCode := SalesInvoiceLine2."Shortcut Dimension 1 Code";
            //End;

            until SalesInvoiceLine2.Next() = 0;
        exit(CountOfLoosecargo);
    end;
    //end;

    //Customer Container Amount Function 1

    procedure GetCustomerContAmountCount(ContAmtDimCode: Code[20]): Integer;
    var
        ManifestLine: Record "Manifest Line";
    begin
        CreateDateFilters_lFnc;
        IF (DimContAmt_gcode <> ContAmtDimCode) then begin
            FOR i := 1 TO 12 DO BEGIN
                SalesInvocieLine.Reset();
                SalesInvocieLine.SetRange("Shortcut Dimension 4 Code", 'Container');
                SalesInvocieLine.SetRange("Posting Date", StartDate_gDat[i], EndDate_gDat[i]);
                if SalesPersonCode <> '' then
                    SalesInvocieLine.SetFilter("Shortcut Dimension 3 Code", '%1', Salespersoncode);
                SalesInvocieLine.SetFilter("Shortcut Dimension 1 Code", '<>%1', '');
                SalesInvocieLine.SetFilter("Sell-to Customer No.", '%1', ContAmtDimCode);
                if SalesInvocieLine.FindFirst() then;
                CASE i OF
                    1:
                        CustContainerAmountCount[1] := GetCustContAmtInvoiceLinesCount(ContAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    2:
                        CustContainerAmountCount[2] := GetCustContAmtInvoiceLinesCount(ContAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    3:
                        CustContainerAmountCount[3] := GetCustContAmtInvoiceLinesCount(ContAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    4:
                        CustContainerAmountCount[4] := GetCustContAmtInvoiceLinesCount(ContAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    5:
                        CustContainerAmountCount[5] := GetCustContAmtInvoiceLinesCount(ContAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    6:
                        CustContainerAmountCount[6] := GetCustContAmtInvoiceLinesCount(ContAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    7:
                        CustContainerAmountCount[7] := GetCustContAmtInvoiceLinesCount(ContAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    8:
                        CustContainerAmountCount[8] := GetCustContAmtInvoiceLinesCount(ContAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    9:
                        CustContainerAmountCount[9] := GetCustContAmtInvoiceLinesCount(ContAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    10:
                        CustContainerAmountCount[10] := GetCustContAmtInvoiceLinesCount(ContAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    11:
                        CustContainerAmountCount[11] := GetCustContAmtInvoiceLinesCount(ContAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    12:
                        CustContainerAmountCount[12] := GetCustContAmtInvoiceLinesCount(ContAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                end;
                CustAmtTotalCont := CustContainerAmountCount[1] + CustContainerAmountCount[2] + CustContainerAmountCount[3] + CustContainerAmountCount[4] + CustContainerAmountCount[5]
                  + CustContainerAmountCount[6] + CustContainerAmountCount[7] + CustContainerAmountCount[8] + CustContainerAmountCount[9] + CustContainerAmountCount[10] + CustContainerAmountCount[11] + CustContainerAmountCount[12];

            end;
            DimContAmt_gcode := ContAmtDimCode;
        end;
    END;

    //Customer Container Amount Function2

    local procedure GetCustContAmtInvoiceLinesCount(CustomerNo: Code[20]; CagoType: Code[20]; j: Integer): Decimal;
    var
        SalesInvoiceLine2: Record "Sales Invoice Line";
    begin
        clear(CountOfContainerAmt);
        SalesInvoiceLine2.Reset();
        SalesInvoiceLine2.SetCurrentKey("Shortcut Dimension 1 Code");
        SalesInvoiceLine2.SetAscending("Shortcut Dimension 1 Code", True);
        SalesInvoiceLine2.SetRange("Posting Date", StartDate_gDat[j], EndDate_gDat[j]);
        if SalesPersonCode <> '' then
            SalesInvoiceLine2.SetFilter("Shortcut Dimension 3 Code", '%1', Salespersoncode);
        SalesInvoiceLine2.SetRange("Sell-to Customer No.", CustomerNo);
        SalesInvoiceLine2.SetRange("Shortcut Dimension 4 Code", CagoType);
        if SalesInvoiceLine2.FindSet() then //begin
            repeat
                // IF UnitId_gCode <> SalesInvoiceLine2."Shortcut Dimension 1 Code" then begin
                CountOfContainerAmt += SalesInvoiceLine2."Line Amount";
            //End;
            //UnitId_gCode := SalesInvoiceLine2."Shortcut Dimension 1 Code";
            until SalesInvoiceLine2.Next() = 0;
        exit(CountOfContainerAmt);
    end;


    //Customer Units Amount Function1
    procedure GetCustomerUnitsAmtCount(UAmtDimCode: Code[20]): Integer;
    var
    begin
        CreateDateFilters_lFnc;
        IF (DimUnitAmt_gcode <> UAmtDimCode) then begin
            FOR i := 1 TO 12 DO BEGIN
                SalesInvocieLine.Reset();
                SalesInvocieLine.SetFilter("Shortcut Dimension 4 Code", '%1', 'UNIT');
                SalesInvocieLine.SetRange("Posting Date", StartDate_gDat[i], EndDate_gDat[i]);
                if SalesPersonCode <> '' then
                    SalesInvocieLine.SetFilter("Shortcut Dimension 3 Code", '%1', Salespersoncode);
                SalesInvocieLine.SetFilter("Shortcut Dimension 1 Code", '<>%1', '');
                SalesInvocieLine.SetFilter("Sell-to Customer No.", '%1', UAmtDimCode);
                if SalesInvocieLine.FindFirst() then;
                CASE i OF
                    1:
                        CustUnitsAmountCount[1] := GetCustUnitsAmtInvoiceLinesCount(UAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    2:
                        CustUnitsAmountCount[2] := GetCustUnitsAmtInvoiceLinesCount(UAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    3:
                        CustUnitsAmountCount[3] := GetCustUnitsAmtInvoiceLinesCount(UAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    4:
                        CustUnitsAmountCount[4] := GetCustUnitsAmtInvoiceLinesCount(UAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    5:
                        CustUnitsAmountCount[5] := GetCustUnitsAmtInvoiceLinesCount(UAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    6:
                        CustUnitsAmountCount[6] := GetCustUnitsAmtInvoiceLinesCount(UAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    7:
                        CustUnitsAmountCount[7] := GetCustUnitsAmtInvoiceLinesCount(UAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    8:
                        CustUnitsAmountCount[8] := GetCustUnitsAmtInvoiceLinesCount(UAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    9:
                        CustUnitsAmountCount[9] := GetCustUnitsAmtInvoiceLinesCount(UAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    10:
                        CustUnitsAmountCount[10] := GetCustUnitsAmtInvoiceLinesCount(UAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    11:
                        CustUnitsAmountCount[11] := GetCustUnitsAmtInvoiceLinesCount(UAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    12:
                        CustUnitsAmountCount[12] := GetCustUnitsAmtInvoiceLinesCount(UAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                end;
                CustUnitsAmtTotalCont := CustUnitsAmountCount[1] + CustUnitsAmountCount[2] + CustUnitsAmountCount[3] + CustUnitsAmountCount[4] + CustUnitsAmountCount[5]
                + CustUnitsAmountCount[6] + CustUnitsAmountCount[7] + CustUnitsAmountCount[8] + CustUnitsAmountCount[9] + CustUnitsAmountCount[10] + CustUnitsAmountCount[11] + CustUnitsAmountCount[12];

            end;
            DimUnitAmt_gcode := UAmtDimCode;
        end;
    END;
    //Customer Units Amount Function 2
    local procedure GetCustUnitsAmtInvoiceLinesCount(CustomerNo: Code[20]; CagoType: Code[20]; j: Integer): Decimal;
    var
        SalesInvoiceLine2: Record "Sales Invoice Line";
        ManifestLine: Record "Manifest Line";
    begin
        clear(CountOfAmtUnits);
        SalesInvoiceLine2.Reset();
        SalesInvoiceLine2.SetCurrentKey("Shortcut Dimension 1 Code");
        SalesInvoiceLine2.SetAscending("Shortcut Dimension 1 Code", True);
        SalesInvoiceLine2.SetRange("Posting Date", StartDate_gDat[j], EndDate_gDat[j]);
        if SalesPersonCode <> '' then
            SalesInvoiceLine2.SetFilter("Shortcut Dimension 3 Code", '%1', Salespersoncode);
        SalesInvoiceLine2.SetRange("Sell-to Customer No.", CustomerNo);
        SalesInvoiceLine2.SetRange("Shortcut Dimension 4 Code", CagoType);
        if SalesInvoiceLine2.FindSet() then //begin
            repeat
                // IF UnitId_gCode <> SalesInvoiceLine2."Shortcut Dimension 1 Code" then begin
                CountOfAmtUnits += SalesInvoiceLine2."Line Amount";
            //End;
            //UnitId_gCode := SalesInvoiceLine2."Shortcut Dimension 1 Code";
            until SalesInvoiceLine2.Next() = 0;
        exit(CountOfAmtUnits);
    end;
    //Customer Loose cargo Amount Function 1

    procedure GetCustomerLooseAmountCount(LooseAmtDimCode: Code[20]): Integer;
    var
        ManifestLine: Record "Manifest Line";
    begin
        CreateDateFilters_lFnc;
        IF (DimlooseAmt_gcode <> LooseAmtDimCode) then begin
            FOR i := 1 TO 12 DO BEGIN
                SalesInvocieLine.Reset();
                SalesInvocieLine.SetRange("Shortcut Dimension 4 Code", 'LOOSE');
                SalesInvocieLine.SetRange("Posting Date", StartDate_gDat[i], EndDate_gDat[i]);
                if SalesPersonCode <> '' then
                    SalesInvocieLine.SetFilter("Shortcut Dimension 3 Code", '%1', Salespersoncode);
                SalesInvocieLine.SetFilter("Shortcut Dimension 1 Code", '<>%1', '');
                SalesInvocieLine.SetFilter("Sell-to Customer No.", '%1', LooseAmtDimCode);
                if SalesInvocieLine.FindFirst() then;
                CASE i OF
                    1:
                        CustLooseCargoAmountCount[1] := GetCustLooseAmtInvoiceLinesCount(LooseAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    2:
                        CustLooseCargoAmountCount[2] := GetCustLooseAmtInvoiceLinesCount(LooseAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    3:
                        CustLooseCargoAmountCount[3] := GetCustLooseAmtInvoiceLinesCount(LooseAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    4:
                        CustLooseCargoAmountCount[4] := GetCustLooseAmtInvoiceLinesCount(LooseAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    5:
                        CustLooseCargoAmountCount[5] := GetCustLooseAmtInvoiceLinesCount(LooseAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    6:
                        CustLooseCargoAmountCount[6] := GetCustLooseAmtInvoiceLinesCount(LooseAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    7:
                        CustLooseCargoAmountCount[7] := GetCustLooseAmtInvoiceLinesCount(LooseAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    8:
                        CustLooseCargoAmountCount[8] := GetCustLooseAmtInvoiceLinesCount(LooseAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    9:
                        CustLooseCargoAmountCount[9] := GetCustLooseAmtInvoiceLinesCount(LooseAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    10:
                        CustLooseCargoAmountCount[10] := GetCustLooseAmtInvoiceLinesCount(LooseAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    11:
                        CustLooseCargoAmountCount[11] := GetCustLooseAmtInvoiceLinesCount(LooseAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                    12:
                        CustLooseCargoAmountCount[12] := GetCustLooseAmtInvoiceLinesCount(LooseAmtDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                end;
                CustLooseAmtTotalCont := CustLooseCargoAmountCount[1] + CustLooseCargoAmountCount[2] + CustLooseCargoAmountCount[3] + CustLooseCargoAmountCount[4] + CustLooseCargoAmountCount[5]
               + CustLooseCargoAmountCount[6] + CustLooseCargoAmountCount[7] + CustLooseCargoAmountCount[8] + CustLooseCargoAmountCount[9] + CustLooseCargoAmountCount[10] + CustLooseCargoAmountCount[11] + CustLooseCargoAmountCount[12];

            end;
            DimlooseAmt_gcode := LooseAmtDimCode;
        end;
    END;

    //Customer Loose Cargo Amount Function2

    local procedure GetCustLooseAmtInvoiceLinesCount(CustomerNo: Code[20]; CagoType: Code[20]; j: Integer): Decimal;
    var
        SalesInvoiceLine2: Record "Sales Invoice Line";
    begin
        clear(CountOfLooseAmt);
        SalesInvoiceLine2.Reset();
        SalesInvoiceLine2.SetCurrentKey("Shortcut Dimension 1 Code");
        SalesInvoiceLine2.SetAscending("Shortcut Dimension 1 Code", True);
        SalesInvoiceLine2.SetRange("Posting Date", StartDate_gDat[j], EndDate_gDat[j]);
        if SalesPersonCode <> '' then
            SalesInvoiceLine2.SetFilter("Shortcut Dimension 3 Code", '%1', Salespersoncode);
        SalesInvoiceLine2.SetRange("Sell-to Customer No.", CustomerNo);
        SalesInvoiceLine2.SetRange("Shortcut Dimension 4 Code", CagoType);
        if SalesInvoiceLine2.FindSet() then //begin
            repeat
                CountOfLooseAmt += SalesInvoiceLine2."Line Amount";
            until SalesInvoiceLine2.Next() = 0;
        exit(CountOfLooseAmt);
    end;



    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;
}
