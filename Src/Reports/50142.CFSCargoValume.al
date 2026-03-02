report 50142 "CFS Cargo Volume"
{
    ApplicationArea = All;
    Caption = 'CFS Cargo Volume';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Src/Reports/Layouts/CFS Cargo Volume.rdlc';

    //RECEIVED UNITS
    dataset
    {
        dataitem(ReceivedMFL; "Manifest Line")
        {
            DataItemTableView = sorting("Shortcut Dimension 5 Code", "Date Received") order(ascending) where("Shortcut Dimension 4 Code" = filter('UNIT'));
            column(Shortcut_Dimension_4_Code; ReceivedMFL."Shortcut Dimension 4 Code")
            {
            }
            column(Companylogo; CompanyInfo.Picture)
            { }
            column(CompanyName; CompanyInfo.Name)
            { }
            column(TotalReceivedUnit; TotalReceivedUnit)
            { }
            column(Shortcut_Dimension_5_Code; ReceivedMFL."Shortcut Dimension 5 Code")
            {
            }
            column(Received; ReceivedMFL.Received)
            {
            }
            column(Released; ReceivedMFL.Released)
            { }
            column(Received_By; ReceivedMFL."Received By")
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
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin

            end;

            trigger OnAfterGetRecord()
            var
            begin
                Clear(ReceivedUnitsCount);
                GetCountforReceivedUnits(ReceivedMFL."Shortcut Dimension 5 Code", ReceivedMFL."Date Received");
            end;
        }

        //RELEASED UNITS
        dataitem(ReleasedMFL; "Manifest Line")
        {
            DataItemTableView = sorting("Shortcut Dimension 5 Code", "Date Released") order(ascending) where("Shortcut Dimension 4 Code" = filter('UNIT'));
            column(Shortcut_Dimension_4_Code1; ReleasedMFL."Shortcut Dimension 4 Code")
            {
            }
            column(Shortcut_Dimension_5_Code1; "Shortcut Dimension 5 Code")
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
            var
                myInt: Integer;
            begin

            end;

            trigger OnAfterGetRecord()
            begin
                Clear(ReleasedUnitsCount);
                GetCountforReleasedUnits(ReleasedMFL."Shortcut Dimension 5 Code", ReleasedMFL."Date Released");

            end;
        }
        //RECEIVED STRIPPED UNITS
        dataitem(ReceivedStrippedUnitsMFL; "Manifest Line")
        {
            DataItemTableView = sorting("Shortcut Dimension 5 Code", "Date Received") order(ascending) where("Shortcut Dimension 4 Code" = filter('STRIPPED UNIT'));
            column(Shortcut_Dimension_4_Code8; ReceivedMFL."Shortcut Dimension 4 Code")
            {
            }

            column(Shortcut_Dimension_5_Code8; ReceivedMFL."Shortcut Dimension 5 Code")
            {
            }


            column(ReceivedStrippedUnitsCount1; ReceivedStrippedUnitsCount[1])
            {
            }
            column(ReceivedStrippedUnitsCount2; ReceivedStrippedUnitsCount[2])
            {
            }
            column(ReceivedStrippedUnitsCount3; ReceivedStrippedUnitsCount[3])
            {
            }
            column(ReceivedStrippedUnitsCount4; ReceivedStrippedUnitsCount[4])
            {
            }
            column(ReceivedStrippedUnitsCount5; ReceivedStrippedUnitsCount[5])
            {
            }
            column(ReceivedStrippedUnitsCount6; ReceivedStrippedUnitsCount[6])
            {
            }
            column(ReceivedStrippedUnitsCount7; ReceivedStrippedUnitsCount[7])
            {
            }
            column(ReceivedStrippedUnitsCount8; ReceivedStrippedUnitsCount[8])
            {
            }
            column(ReceivedStrippedUnitsCount9; ReceivedStrippedUnitsCount[9])
            {
            }
            column(ReceivedStrippedUnitsCount10; ReceivedStrippedUnitsCount[10])
            {
            }
            column(ReceivedStrippedUnitsCount11; ReceivedStrippedUnitsCount[11])
            {
            }
            column(ReceivedStrippedUnitsCount12; ReceivedStrippedUnitsCount[12])
            {
            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin

            end;

            trigger OnAfterGetRecord()
            var
            begin
                Clear(ReceivedUnitsCount);
                GetCountforReceivedUnits(ReceivedMFL."Shortcut Dimension 5 Code", ReceivedMFL."Date Received");
            end;
        }
        //RECEIVED STRIPPED UNITS

        //RECEIVED STRIPPED package
        dataitem(ReceivedStrippedPackageMFL; "Manifest Line")
        {
            DataItemTableView = sorting("Shortcut Dimension 5 Code", "Date Received") order(ascending) where("Shortcut Dimension 4 Code" = filter('STRIPPED PACKAGE'));
            column(Shortcut_Dimension_4_Code9; ReceivedMFL."Shortcut Dimension 4 Code")
            {
            }

            column(Shortcut_Dimension_5_Code9; ReceivedMFL."Shortcut Dimension 5 Code")
            {
            }
            column(ReceivedStrippedPackageCount1; ReceivedStrippedPackageCount[1])
            {
            }
            column(ReceivedStrippedPackageCount2; ReceivedStrippedPackageCount[2])
            {
            }
            column(ReceivedStrippedPackageCount3; ReceivedStrippedPackageCount[3])
            {
            }
            column(ReceivedStrippedPackageCount4; ReceivedStrippedPackageCount[4])
            {
            }
            column(ReceivedStrippedPackageCount5; ReceivedStrippedPackageCount[5])
            {
            }
            column(ReceivedStrippedPackageCount6; ReceivedStrippedPackageCount[6])
            {
            }
            column(ReceivedStrippedPackageCount7; ReceivedStrippedPackageCount[7])
            {
            }
            column(ReceivedStrippedPackageCount8; ReceivedStrippedPackageCount[8])
            {
            }
            column(ReceivedStrippedPackageCount9; ReceivedStrippedPackageCount[9])
            {
            }
            column(ReceivedStrippedPackageCount10; ReceivedStrippedPackageCount[10])
            {
            }
            column(ReceivedStrippedPackageCount11; ReceivedStrippedPackageCount[11])
            {
            }
            column(ReceivedStrippedPackageCount12; ReceivedStrippedPackageCount[12])
            {
            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin

            end;

            trigger OnAfterGetRecord()
            var
            begin
                Clear(ReceivedUnitsCount);
                GetCountforStrippedReceivedPackage(ReceivedStrippedPackageMFL."Shortcut Dimension 5 Code", ReceivedStrippedPackageMFL."Date Received");
            end;
        }
        //RECEIVED STRIPPED PACKAGE


        //Stripped Units Released
        dataitem(ReleasedStrippedUnitsMFL; "Manifest Line")
        {
            DataItemTableView = sorting("Shortcut Dimension 5 Code", "Date Released") order(ascending) where("Shortcut Dimension 4 Code" = filter('STRIPPED UNIT'));
            column(Shortcut_Dimension_4_Code7; ReleasedMFL."Shortcut Dimension 4 Code")
            {
            }
            column(Shortcut_Dimension_5_Code7; "Shortcut Dimension 5 Code")
            {
            }
            // column(TotalReleasedUnit; TotalReleasedUnit)
            // { }
            // column(TotalRecContCount1; TotalRecContCount)
            // { }
            column(ReleasedStrippedUnitsCount1; ReleasedStrippedUnitsCount[1])
            {
            }
            column(ReleasedStrippedUnitsCount2; ReleasedStrippedUnitsCount[2])
            {
            }
            column(ReleasedStrippedUnitsCount3; ReleasedStrippedUnitsCount[3])
            {
            }
            column(ReleasedStrippedUnitsCount4; ReleasedStrippedUnitsCount[4])
            {
            }
            column(ReleasedStrippedUnitsCount5; ReleasedStrippedUnitsCount[5])
            {
            }
            column(ReleasedStrippedUnitsCount6; ReleasedStrippedUnitsCount[6])
            {
            }
            column(ReleasedStrippedUnitsCount7; ReleasedStrippedUnitsCount[7])
            {
            }
            column(ReleasedStrippedUnitsCount8; ReleasedStrippedUnitsCount[8])
            {
            }
            column(ReleasedStrippedUnitsCount9; ReleasedStrippedUnitsCount[9])
            {
            }
            column(ReleasedStrippedUnitsCount10; ReleasedStrippedUnitsCount[10])
            {
            }
            column(ReleasedStrippedUnitsCount11; ReleasedStrippedUnitsCount[11])
            {
            }
            column(ReleasedStrippedUnitsCount12; ReleasedStrippedUnitsCount[12])
            {
            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin

            end;

            trigger OnAfterGetRecord()
            begin
                Clear(ReleasedStrippedUnitsCount);
                GetCountforStrippedReleasedUnits(ReleasedStrippedUnitsMFL."Shortcut Dimension 5 Code", ReleasedStrippedUnitsMFL."Date Released");

            end;
        }

        //Stripped Package Released
        dataitem(ReleasedStrippedPackageMFL; "Manifest Line")
        {
            DataItemTableView = sorting("Shortcut Dimension 5 Code", "Date Released") order(ascending) where("Shortcut Dimension 4 Code" = filter('STRIPPED PACKAGE'));
            column(Shortcut_Dimension_4_Code10; ReleasedStrippedPackageMFL."Shortcut Dimension 4 Code")
            {
            }
            column(Shortcut_Dimension_5_Code10; "Shortcut Dimension 5 Code")
            {
            }
            column(ReleasedStrippedPackageCount1; ReleasedStrippedPackageCount[1])
            {
            }
            column(ReleasedStrippedPackageCount2; ReleasedStrippedPackageCount[2])
            {
            }
            column(ReleasedStrippedPackageCount3; ReleasedStrippedPackageCount[3])
            {
            }
            column(ReleasedStrippedPackageCount4; ReleasedStrippedPackageCount[4])
            {
            }
            column(ReleasedStrippedPackageCount5; ReleasedStrippedPackageCount[5])
            {
            }
            column(ReleasedStrippedPackageCount6; ReleasedStrippedPackageCount[6])
            {
            }
            column(ReleasedStrippedPackageCount7; ReleasedStrippedPackageCount[7])
            {
            }
            column(ReleasedStrippedPackageCount8; ReleasedStrippedPackageCount[8])
            {
            }
            column(ReleasedStrippedPackageCount9; ReleasedStrippedPackageCount[9])
            {
            }
            column(ReleasedStrippedPackageCount10; ReleasedStrippedPackageCount[10])
            {
            }
            column(ReleasedStrippedPackageCount11; ReleasedStrippedPackageCount[11])
            {
            }
            column(ReleasedStrippedPackageCount12; ReleasedStrippedPackageCount[12])
            {
            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin

            end;

            trigger OnAfterGetRecord()
            begin
                Clear(ReleasedStrippedPackageCount);
                GetCountforReleasedStrippedPackage(ReleasedStrippedPackageMFL."Shortcut Dimension 5 Code", ReleasedStrippedPackageMFL."Date Released");
            end;
        }
        //RECEIVED LOOSE CARGO
        dataitem(ReceivedConMFL; "Manifest Line")
        {
            DataItemTableView = sorting("Shortcut Dimension 5 Code", "Date Received") order(ascending) where("Shortcut Dimension 4 Code" = filter('Loose'), Received = const(true));
            column(Shortcut_Dimension_4_Code2; ReceivedConMFL."Shortcut Dimension 4 Code")
            { }
            column(Shortcut_Dimension_5_Code2; "Shortcut Dimension 5 Code")
            {
            }
            column(TEUSTotal1; TEUSTotal[1])
            { }
            column(TEUSTotal2; TEUSTotal[2])
            { }
            column(TEUSTotal3; TEUSTotal[3])
            { }
            column(TEUSTotal4; TEUSTotal[4])
            { }
            column(TEUSTotal5; TEUSTotal[5])
            { }
            column(TEUSTotal6; TEUSTotal[6])
            { }
            column(TEUSTotal7; TEUSTotal[7])
            { }
            column(TEUSTotal8; TEUSTotal[8])
            { }
            column(TEUSTotal9; TEUSTotal[9])
            { }
            column(TEUSTotal10; TEUSTotal[10])
            { }
            column(TEUSTotal11; TEUSTotal[11])
            { }
            column(TEUSTotal12; TEUSTotal[12])
            { }
            column(TotalReceivedLooseCont; TotalReceivedLooseCont)
            { }
            column(ReceivedConCount1; ReceivedConCount[1])
            {
            }
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
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin

            end;

            trigger OnAfterGetRecord()
            var
            begin
                Clear(ReceivedConCount);
                GetLooseContCountforReceived(ReceivedConMFL."Shortcut Dimension 5 Code", ReceivedConMFL."Date Received");

            end;
        }
        //RECEIVED CONTAINER BY ROAD
        dataitem(ReceivedConByRoadMFL; "Manifest Line")
        {
            DataItemTableView = sorting("Shortcut Dimension 5 Code", "Date Received") order(ascending) where("Shortcut Dimension 4 Code" = filter('Container'));

            column(Shortcut_Dimension_4_Code3; ReceivedConMFL."Shortcut Dimension 4 Code")
            { }
            column(Shortcut_Dimension_5_Code3; "Shortcut Dimension 5 Code")
            {
            }
            column(ReceivedConRoadCount1; ReceivedContainerCountByRoad[1])
            {
            }
            column(ReceivedConRoadCount2; ReceivedContainerCountByRoad[2])
            {
            }
            column(ReceivedConRoadCount3; ReceivedContainerCountByRoad[3])
            {
            }
            column(ReceivedConRoadCount4; ReceivedContainerCountByRoad[4])
            {
            }
            column(ReceivedConRoadCount5; ReceivedContainerCountByRoad[5])
            {
            }
            column(ReceivedConRoadCount6; ReceivedContainerCountByRoad[6])
            {
            }
            column(ReceivedConRoadCount7; ReceivedContainerCountByRoad[7])
            {
            }
            column(ReceivedConRoadCount8; ReceivedContainerCountByRoad[8])
            {
            }
            column(ReceivedConRoadCount9; ReceivedContainerCountByRoad[9])
            {
            }
            column(ReceivedConRoadCount10; ReceivedContainerCountByRoad[10])
            {
            }
            column(ReceivedConRoadCount11; ReceivedContainerCountByRoad[11])
            {
            }
            column(ReceivedConRoadCount12; ReceivedContainerCountByRoad[12])
            {
            }
            column(TotalReceivedContainerByRoad; TotalReceivedContainerByRoad)
            { }
            column(TotalRoadTeusReceived1; TotalRoadTeusReceived[1])
            { }
            column(TotalRoadTeusReceived2; TotalRoadTeusReceived[2])
            { }
            column(TotalRoadTeusReceived3; TotalRoadTeusReceived[3])
            { }
            column(TotalRoadTeusReceived4; TotalRoadTeusReceived[4])
            { }
            column(TotalRoadTeusReceived5; TotalRoadTeusReceived[5])
            { }
            column(TotalRoadTeusReceived6; TotalRoadTeusReceived[6])
            { }
            column(TotalRoadTeusReceived7; TotalRoadTeusReceived[7])
            { }
            column(TotalRoadTeusReceived8; TotalRoadTeusReceived[8])
            { }
            column(TotalRoadTeusReceived9; TotalRoadTeusReceived[9])
            { }
            column(TotalRoadTeusReceived10; TotalRoadTeusReceived[10])
            { }
            column(TotalRoadTeusReceived11; TotalRoadTeusReceived[12])
            { }
            column(TotalRoadTeusReceived12; TotalRoadTeusReceived[12])
            { }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin

            end;

            trigger OnAfterGetRecord()
            var
            begin
                Clear(ReceivedContainerCountByRoad);
                GetContCountByroadReceived(ReceivedConByRoadMFL."Shortcut Dimension 5 Code", ReceivedConByRoadMFL."Date Received");

            end;
        }

        //BILLED LOOSE CARGO
        dataitem(BilledLooseMFL; "Manifest Line")
        {
            DataItemTableView = sorting("Shortcut Dimension 5 Code") order(ascending) where("Shortcut Dimension 4 Code" = filter('Loose'));
            column(Shortcut_Dimension_4_Code5; BilledLooseMFL."Shortcut Dimension 4 Code")
            { }
            column(Shortcut_Dimension_5_Code5; "Shortcut Dimension 5 Code")
            {
            }
            column(ReleasedLooseBillingCount; ReleasedLooseBillingCount[1])
            {
            }
            column(ReleasedLooseBillingCount2; ReleasedLooseBillingCount[2])
            {
            }
            column(ReleasedLooseBillingCount3; ReleasedLooseBillingCount[3])
            {
            }
            column(ReleasedLooseBillingCount4; ReleasedLooseBillingCount[4])
            {
            }
            column(ReleasedLooseBillingCount5; ReleasedLooseBillingCount[5])
            {
            }
            column(ReleasedLooseBillingCount6; ReleasedLooseBillingCount[6])
            {
            }
            column(ReleasedLooseBillingCount7; ReleasedLooseBillingCount[7])
            {
            }
            column(ReleasedLooseBillingCount8; ReleasedLooseBillingCount[8])
            {
            }
            column(ReleasedLooseBillingCount9; ReleasedLooseBillingCount[9])
            {
            }
            column(ReleasedLooseBillingCount0; ReleasedLooseBillingCount[10])
            {
            }
            column(ReleasedLooseBillingCount11; ReleasedLooseBillingCount[11])
            {
            }
            column(ReleasedLooseBillingCount12; ReleasedLooseBillingCount[12])
            {
            }

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin

            end;

            trigger OnAfterGetRecord()
            var
            begin
                Clear(ReleasedLooseBillingCount);

                GetBillingLooseCount(BilledLooseMFL."Shortcut Dimension 5 Code");//SHR

            end;
        }
        //BILLED CONTAINERS MODE OF TRANSPORT - BY ROAD
        dataitem(BilledRoadMFL; "Manifest Line")

        {
            //DataItemTableView = sorting("Global Dimension 1 Code") order(ascending) where("Received By" = filter('Road'));
            DataItemTableView = sorting("Shortcut Dimension 5 Code") order(ascending) where("Shortcut Dimension 4 Code" = filter('Container'));
            ;
            column(Shortcut_Dimension_4_Code6;
            BilledRoadMFL."Shortcut Dimension 4 Code")
            { }
            column(Shortcut_Dimension_5_Code6; "Shortcut Dimension 5 Code")
            {
            }
            column(LooseBillingroadCount; LooseBillingroadCount[1])
            {
            }
            column(LooseBillingroadCount2; LooseBillingroadCount[2])
            {
            }
            column(LooseBillingroadCount3; LooseBillingroadCount[3])
            {
            }
            column(LooseBillingroadCount4; LooseBillingroadCount[4])
            {
            }
            column(LooseBillingroadCount5; LooseBillingroadCount[5])
            {
            }
            column(LooseBillingroadCount6; LooseBillingroadCount[6])
            {
            }
            column(LooseBillingroadCount7; LooseBillingroadCount[7])
            {
            }
            column(LooseBillingroadCount8; LooseBillingroadCount[8])
            {
            }
            column(LooseBillingroadCount9; LooseBillingroadCount[9])
            {
            }
            column(LooseBillingroadCount10; LooseBillingroadCount[10])
            {
            }
            column(LooseBillingroadCount11; LooseBillingroadCount[11])
            {
            }
            column(LooseBillingroadCount12; LooseBillingroadCount[12])
            {
            }
            column(TotalRoadTeusBilled1; TotalRoadTeusBilled[1])
            { }
            column(TotalRoadTeusBilled2; TotalRoadTeusBilled[2])
            { }
            column(TotalRoadTeusBilled3; TotalRoadTeusBilled[3])
            { }
            column(TotalRoadTeusBilled4; TotalRoadTeusBilled[4])
            { }
            column(TotalRoadTeusBilled5; TotalRoadTeusBilled[5])
            { }
            column(TotalRoadTeusBilled6; TotalRoadTeusBilled[6])
            { }
            column(TotalRoadTeusBilled7; TotalRoadTeusBilled[7])
            { }
            column(TotalRoadTeusBilled8; TotalRoadTeusBilled[8])
            { }
            column(TotalRoadTeusBilled9; TotalRoadTeusBilled[9])
            { }
            column(TotalRoadTeusBilled10; TotalRoadTeusBilled[10])
            { }
            column(TotalRoadTeusBilled11; TotalRoadTeusBilled[11])
            { }
            column(TotalRoadTeusBilled12; TotalRoadTeusBilled[12])
            { }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin

            end;

            trigger OnAfterGetRecord()
            var
            begin
                Clear(LooseBillingroadCount);

                GetBillingLooseRoadCount(BilledRoadMFL."Shortcut Dimension 5 Code");
                //BilledRoadMFL.SetRange("Shortcut Dimension 3 Code", SalesPersonCode);
                //GetBillingLooseRoadCount(BilledRoadMFL."Shortcut Dimension 5 Code", BilledRoadMFL."Global Dimension 1 Code");
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
                    field(SalesPersonCode; SalesPersonCode)
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'SalesPerson';
                        TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(3));
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
        TotalRecContCount, i, Period, ReleasedPeriod : Integer;
        ReceivedUnitsCount: array[20] of Integer;
        ReleasedUnitsCount: array[20] of Integer;
        ReceivedStrippedUnitsCount: array[20] of Integer;
        ReleasedStrippedUnitsCount: array[20] of Integer;
        ReceivedStrippedPackageCount: array[20] of Integer;
        ReleasedStrippedPackageCount: array[20] of Integer;
        ReceivedConCount: array[20] of Decimal;
        ReleasedConCount: array[20] of Integer;
        LooseBillingroadCount: array[20] of Integer;
        ContBillingRailCount: array[20] of Integer;
        ReceivedContainerCountByRoad: array[20] of Integer;
        TotalReceivedContainerByRoad: Integer;
        TotalReceivedContainerByRail: Integer;
        TotalReceivedUnit: Integer;
        TotalReceivedLooseCont: Integer;
        TotalBillingLooseCont: Integer;
        ReceivedContainerCountByRail: array[20] of Integer;
        ReleasedLooseBillingCount: array[20] of Decimal;
        StartingDate: Date;
        MonthNameTxt: array[20] of text;
        Text50011: textConst ENU = '<Month Text>';
        CountofContRailFT: integer;
        CountofContRoadFT: Integer;
        CountofLooseFT: Integer;
        UnitsCount: Integer;
        SalesInvocieLine: Record "Sales Invoice Line";
        salesInvoiceHead: Record "Sales Invoice Header";
        ContCountReceived: Integer;
        StippedPackageCountReceived: Integer;
        StrippedUnitCountreceived: Integer;
        UnitsCountReleased: Integer;
        StrippedUnitreleasedCount: integer;
        StrippedPacakgeCount: Integer;

        TotalReleasedUnit: Integer;
        ContainerId_gCode: Code[20];
        UnitsCount1: Integer;
        StartDate_gDat: array[12] of Date;
        EndDate_gDat: array[12] of Date;
        Year_Int: Integer;

        YearFilter: Text[10];
        DimReceived_gcode: Code[20];
        DimReceived_gPackagecode: Code[20];
        DimStrippedReceived_gcode: Code[20];
        DimLooseBillingRoad_gcode: code[20];
        DimContBillingRail_gcode: code[20];
        DimReleased_gcode: Code[20];
        DimReleased_gPackagecode: Code[20];
        DimStrippedReleased_gcode: Code[20];
        DimLooseReceived_gcode: Code[20];
        DimContReceivedByRoad_gcode: Code[20];
        DimContReceivedByRail_gcode: Code[20];
        DimLooseBilling_gcode: code[20];
        ConatinerID: code[20];
        SalesPersonCode: code[30];
        j: Integer;
        Text50002_gCtx: Label 'Please select proper Year';
        ContainerId_gCode40FT: Code[20];
        Temp20ftcount: array[20] of Integer;
        Temp40ftcount: array[20] of Integer;
        TotalLooseTeusBilled: array[12] of Integer;
        TotalTeusrailbilled: array[20] of Integer;
        T20ftcount: array[20] of Integer;
        T40ftcount: array[20] of Integer;
        TEUSTotal: array[12] of Decimal;
        TotalRoadTeusReceived: array[12] of Integer;
        TotalRoadTeusBilled: array[12] of Integer;
        TotalRailTeusReceived: array[12] of Integer;
        Testfield_received: Decimal;

    //RECEIVED UNITS
    procedure GetCountforReceivedUnits(ReceivedDimCode: Code[20]; RDate: Date): Integer;
    var
        ReceivedManifestLine: Record "Manifest Line";
    begin

        Clear(TotalReceivedUnit);
        CreateDateFilters_lFnc;
        IF DimReceived_gcode <> ReceivedDimCode THEN BEGIN
            FOR i := 1 TO 12 DO BEGIN
                ReceivedManifestLine.Reset();
                ReceivedManifestLine.SetCurrentKey("Shortcut Dimension 5 Code", "Date Received");
                ReceivedManifestLine.SetRange("Date Received", StartDate_gDat[i], EndDate_gDat[i]);
                if SalesPersonCode <> '' then
                    ReceivedManifestLine.SetRange("Shortcut Dimension 3 Code", SalesPersonCode);
                ReceivedManifestLine.SetRange("Shortcut Dimension 4 Code", 'UNIT');
                ReceivedManifestLine.SetRange("Shortcut Dimension 5 Code", ReceivedDimCode);
                ReceivedManifestLine.SetRange(Received, true);
                TotalReceivedUnit += ReceivedManifestLine.Count;
                CASE i OF
                    1:
                        ReceivedUnitsCount[1] := ReceivedManifestLine.COUNT;
                    2:
                        ReceivedUnitsCount[2] := ReceivedManifestLine.COUNT;
                    3:
                        ReceivedUnitsCount[3] := ReceivedManifestLine.COUNT;
                    4:
                        ReceivedUnitsCount[4] := ReceivedManifestLine.COUNT;
                    5:
                        ReceivedUnitsCount[5] := ReceivedManifestLine.COUNT;
                    6:
                        ReceivedUnitsCount[6] := ReceivedManifestLine.COUNT;
                    7:
                        ReceivedUnitsCount[7] := ReceivedManifestLine.COUNT;
                    8:
                        ReceivedUnitsCount[8] := ReceivedManifestLine.COUNT;
                    9:
                        ReceivedUnitsCount[9] := ReceivedManifestLine.COUNT;
                    10:
                        ReceivedUnitsCount[10] := ReceivedManifestLine.COUNT;
                    11:
                        ReceivedUnitsCount[11] := ReceivedManifestLine.COUNT;
                    12:
                        ReceivedUnitsCount[12] := ReceivedManifestLine.COUNT;
                END;
                DimReceived_gcode := ReceivedDimCode;
            END;
        End;
    end;
    //Code For Stripped received Package

    procedure GetCountforStrippedReceivedPackage(ReceivedPackageDimCode: Code[20]; RDate: Date): Integer;
    var
        ReceivedpackageManifestLine: Record "Manifest Line";
    begin

        Clear(TotalReceivedUnit);
        CreateDateFilters_lFnc;
        IF DimReceived_gPackagecode <> ReceivedPackageDimCode THEN BEGIN
            FOR i := 1 TO 12 DO BEGIN
                ReceivedpackageManifestLine.Reset();
                ReceivedpackageManifestLine.SetCurrentKey("Shortcut Dimension 5 Code", "Date Received");
                ReceivedpackageManifestLine.SetRange("Date Received", StartDate_gDat[i], EndDate_gDat[i]);
                if SalesPersonCode <> '' then
                    ReceivedpackageManifestLine.SetRange("Shortcut Dimension 3 Code", SalesPersonCode);
                ReceivedpackageManifestLine.SetRange("Shortcut Dimension 4 Code", 'STRIPPED PACKAGE');
                ReceivedpackageManifestLine.SetRange("Shortcut Dimension 5 Code", ReceivedPackageDimCode);
                ReceivedpackageManifestLine.SetRange(Received, true);
                TotalReceivedUnit += ReceivedpackageManifestLine.Count;
                CASE i OF
                    1:
                        ReceivedStrippedPackageCount[1] := ReceivedpackageManifestLine.COUNT;
                    2:
                        ReceivedStrippedPackageCount[2] := ReceivedpackageManifestLine.COUNT;
                    3:
                        ReceivedStrippedPackageCount[3] := ReceivedpackageManifestLine.COUNT;
                    4:
                        ReceivedStrippedPackageCount[4] := ReceivedpackageManifestLine.COUNT;
                    5:
                        ReceivedStrippedPackageCount[5] := ReceivedpackageManifestLine.COUNT;
                    6:
                        ReceivedStrippedPackageCount[6] := ReceivedpackageManifestLine.COUNT;
                    7:
                        ReceivedStrippedPackageCount[7] := ReceivedpackageManifestLine.COUNT;
                    8:
                        ReceivedStrippedPackageCount[8] := ReceivedpackageManifestLine.COUNT;
                    9:
                        ReceivedStrippedPackageCount[9] := ReceivedpackageManifestLine.COUNT;
                    10:
                        ReceivedStrippedPackageCount[10] := ReceivedpackageManifestLine.COUNT;
                    11:
                        ReceivedStrippedPackageCount[11] := ReceivedpackageManifestLine.COUNT;
                    12:
                        ReceivedStrippedPackageCount[12] := ReceivedpackageManifestLine.COUNT;
                END;
                DimReceived_gPackagecode := ReceivedPackageDimCode;
            END;
        End;
    end;
    //Code For Stripped Received Package

    //Code For Stripped Released Package
    procedure GetCountforReleasedStrippedPackage(ReleasedPackageDimCode: Code[20]; RDate: Date): Integer;
    var
        ReleasedPackgeManifestLine: Record "Manifest Line";
    begin
        clear(TotalReleasedUnit);
        CreateDateFilters_lFnc;
        IF DimReleased_gPackagecode <> ReleasedPackageDimCode THEN BEGIN
            FOR i := 1 TO 12 DO BEGIN
                ReleasedPackgeManifestLine.Reset();
                ReleasedPackgeManifestLine.SetCurrentKey("Shortcut Dimension 5 Code", "Date Released");
                ReleasedPackgeManifestLine.SetRange("Date Released", StartDate_gDat[i], EndDate_gDat[i]);
                if SalesPersonCode <> '' then
                    ReleasedPackgeManifestLine.SetRange("Shortcut Dimension 3 Code", SalesPersonCode);
                ReleasedPackgeManifestLine.SetRange("Shortcut Dimension 4 Code", 'STRIPPED PACKAGE');
                ReleasedPackgeManifestLine.SetRange("Shortcut Dimension 5 Code", ReleasedPackageDimCode);
                ReleasedPackgeManifestLine.SetRange(Released, true);
                TotalReleasedUnit += ReleasedPackgeManifestLine.Count;
                CASE i OF
                    1:
                        ReleasedStrippedPackageCount[1] := ReleasedPackgeManifestLine.COUNT;
                    2:
                        ReleasedStrippedPackageCount[2] := ReleasedPackgeManifestLine.COUNT;
                    3:
                        ReleasedStrippedPackageCount[3] := ReleasedPackgeManifestLine.COUNT;
                    4:
                        ReleasedStrippedPackageCount[4] := ReleasedPackgeManifestLine.COUNT;
                    5:
                        ReleasedStrippedPackageCount[5] := ReleasedPackgeManifestLine.COUNT;
                    6:
                        ReleasedStrippedPackageCount[6] := ReleasedPackgeManifestLine.COUNT;
                    7:
                        ReleasedStrippedPackageCount[7] := ReleasedPackgeManifestLine.COUNT;
                    8:
                        ReleasedStrippedPackageCount[8] := ReleasedPackgeManifestLine.COUNT;
                    9:
                        ReleasedStrippedPackageCount[9] := ReleasedPackgeManifestLine.COUNT;
                    10:
                        ReleasedStrippedPackageCount[10] := ReleasedPackgeManifestLine.COUNT;
                    11:
                        ReleasedStrippedPackageCount[11] := ReleasedPackgeManifestLine.COUNT;
                    12:
                        ReleasedStrippedPackageCount[12] := ReleasedPackgeManifestLine.COUNT;
                END;
            END;
        End;
        DimReleased_gPackagecode := ReleasedPackageDimCode;
    end;
    ////Code For Stripped Released Package

    //RELEASED UNITS
    procedure GetCountforReleasedUnits(ReleasedDimCode: Code[20]; RDate: Date): Integer;
    var
        ManifestLine: Record "Manifest Line";
    begin
        clear(TotalReleasedUnit);
        CreateDateFilters_lFnc;
        IF DimReleased_gcode <> ReleasedDimCode THEN BEGIN
            FOR i := 1 TO 12 DO BEGIN
                ManifestLine.Reset();
                ManifestLine.SetCurrentKey("Shortcut Dimension 5 Code", "Date Released");
                ManifestLine.SetRange("Date Released", StartDate_gDat[i], EndDate_gDat[i]);
                if SalesPersonCode <> '' then
                    ManifestLine.SetRange("Shortcut Dimension 3 Code", SalesPersonCode);
                ManifestLine.SetRange("Shortcut Dimension 4 Code", 'UNIT');
                ManifestLine.SetRange("Shortcut Dimension 5 Code", ReleasedDimCode);
                ManifestLine.SetRange(Released, true);
                TotalReleasedUnit += ManifestLine.Count;
                CASE i OF
                    1:
                        ReleasedUnitsCount[1] := ManifestLine.COUNT;
                    2:
                        ReleasedUnitsCount[2] := ManifestLine.COUNT;
                    3:
                        ReleasedUnitsCount[3] := ManifestLine.COUNT;
                    4:
                        ReleasedUnitsCount[4] := ManifestLine.COUNT;
                    5:
                        ReleasedUnitsCount[5] := ManifestLine.COUNT;
                    6:
                        ReleasedUnitsCount[6] := ManifestLine.COUNT;
                    7:
                        ReleasedUnitsCount[7] := ManifestLine.COUNT;
                    8:
                        ReleasedUnitsCount[8] := ManifestLine.COUNT;
                    9:
                        ReleasedUnitsCount[9] := ManifestLine.COUNT;
                    10:
                        ReleasedUnitsCount[10] := ManifestLine.COUNT;
                    11:
                        ReleasedUnitsCount[11] := ManifestLine.COUNT;
                    12:
                        ReleasedUnitsCount[12] := ManifestLine.COUNT;
                END;
            END;
        End;
        DimReleased_gcode := ReleasedDimCode;
    end;
    //RECEIVED lOOSE CARGO
    procedure GetLooseContCountforReceived(LooseDimCode: Code[20]; RDate: Date): Integer;
    var
        ManifestLineLoose: Record "Manifest Line";
    begin
        Clear(TEUSTotal);
        Clear(TotalReceivedLooseCont);
        CreateDateFilters_lFnc;
        IF DimLooseReceived_gcode <> LooseDimCode THEN BEGIN
            FOR i := 1 TO 12 DO BEGIN
                ManifestLineLoose.Reset();
                ManifestLineLoose.SetCurrentKey("Shortcut Dimension 5 Code", "Date Received");
                ManifestLineLoose.SetRange("Date Received", StartDate_gDat[i], EndDate_gDat[i]);
                if SalesPersonCode <> '' then
                    ManifestLineLoose.SetRange("Shortcut Dimension 3 Code", SalesPersonCode);
                ManifestLineLoose.SetRange("Shortcut Dimension 4 Code", 'Loose');
                ManifestLineLoose.SetRange("Shortcut Dimension 5 Code", LooseDimCode);
                ManifestLineLoose.SetRange(Received, true);
                TotalReceivedLooseCont += ManifestLineLoose.Count;
                CASE i OF
                    1:
                        begin
                            if ManifestLineLoose.FindSet() then begin
                                repeat
                                    ReceivedConCount[1] += ManifestLineLoose."CBM Tonage";
                                until ManifestLineLoose.Next() = 0;
                            end;
                        end;


                    2:

                        begin
                            if ManifestLineLoose.FindSet() then begin
                                repeat
                                    ReceivedConCount[2] += ManifestLineLoose."CBM Tonage";
                                until ManifestLineLoose.Next() = 0;
                            end;
                        end;


                    3:

                        begin
                            if ManifestLineLoose.FindSet() then begin
                                repeat
                                    ReceivedConCount[3] += ManifestLineLoose."CBM Tonage";
                                until ManifestLineLoose.Next() = 0;
                            end;
                        end;


                    4:
                        begin
                            if ManifestLineLoose.FindSet() then begin
                                repeat
                                    ReceivedConCount[4] += ManifestLineLoose."CBM Tonage";
                                until ManifestLineLoose.Next() = 0;
                            end;
                        end;

                    5:
                        begin
                            if ManifestLineLoose.FindSet() then begin
                                repeat
                                    ReceivedConCount[5] += ManifestLineLoose."CBM Tonage";
                                until ManifestLineLoose.Next() = 0;
                            end;
                        end;

                    6:
                        begin
                            if ManifestLineLoose.FindSet() then begin
                                repeat
                                    ReceivedConCount[6] += ManifestLineLoose."CBM Tonage";
                                until ManifestLineLoose.Next() = 0;
                            end;
                        end;
                    7:

                        begin
                            if ManifestLineLoose.FindSet() then begin
                                repeat
                                    ReceivedConCount[7] += ManifestLineLoose."CBM Tonage";
                                until ManifestLineLoose.Next() = 0;
                            end;
                        end;

                    8:

                        begin
                            if ManifestLineLoose.FindSet() then begin
                                repeat
                                    ReceivedConCount[8] += ManifestLineLoose."CBM Tonage";
                                until ManifestLineLoose.Next() = 0;
                            end;
                        end;
                    9:

                        begin
                            if ManifestLineLoose.FindSet() then begin
                                repeat
                                    ReceivedConCount[9] += ManifestLineLoose."CBM Tonage";
                                until ManifestLineLoose.Next() = 0;
                            end;
                        end;

                    10:

                        begin
                            if ManifestLineLoose.FindSet() then begin
                                repeat
                                    ReceivedConCount[10] += ManifestLineLoose."CBM Tonage";
                                until ManifestLineLoose.Next() = 0;
                            end;
                        end;

                    11:

                        begin
                            if ManifestLineLoose.FindSet() then begin
                                repeat
                                    ReceivedConCount[11] += ManifestLineLoose."CBM Tonage";
                                until ManifestLineLoose.Next() = 0;
                            end;
                        end;
                    12:

                        begin
                            if ManifestLineLoose.FindSet() then begin
                                repeat
                                    ReceivedConCount[12] += ManifestLineLoose."CBM Tonage";
                                until ManifestLineLoose.Next() = 0;
                            end;
                        end;

                END;
            END;
        End;
        DimLooseReceived_gcode := LooseDimCode;
    end;

    //RECEIVED CONTAINERS
    procedure GetContCountByroadReceived(RoadDimCode: Code[20]; RDate: Date): Integer;
    var
        ManifestLineRoad: Record "Manifest Line";
    begin
        clear(TotalRoadTeusReceived);
        CreateDateFilters_lFnc;
        Clear(TotalReceivedContainerByRoad);
        IF DimContReceivedByRoad_gcode <> RoadDimCode THEN BEGIN
            FOR i := 1 TO 12 DO BEGIN
                ManifestLineRoad.Reset();
                ManifestLineRoad.SetCurrentKey("Shortcut Dimension 5 Code", "Date Received");
                ManifestLineRoad.SetRange("Date Received", StartDate_gDat[i], EndDate_gDat[i]);
                if SalesPersonCode <> '' then
                    ManifestLineRoad.SetRange("Shortcut Dimension 3 Code", SalesPersonCode);
                ManifestLineRoad.SetRange("Shortcut Dimension 4 Code", 'Container');
                ManifestLineRoad.SetRange("Shortcut Dimension 5 Code", RoadDimCode);
                ManifestLineRoad.SetRange(Received, true);
                CASE i OF
                    1:
                        BEGIN
                            ReceivedContainerCountByRoad[1] := ManifestLineRoad.COUNT;
                            if RoadDimCode = '40FT' then
                                TotalRoadTeusReceived[1] := ReceivedContainerCountByRoad[1];
                        END;
                    2:
                        BEGIN
                            ReceivedContainerCountByRoad[2] := ManifestLineRoad.COUNT;
                            if RoadDimCode = '40FT' then
                                TotalRoadTeusReceived[2] := ReceivedContainerCountByRoad[2];
                        END;
                    3:
                        BEGIN
                            ReceivedContainerCountByRoad[3] := ManifestLineRoad.COUNT;
                            if RoadDimCode = '40FT' then
                                TotalRoadTeusReceived[3] := ReceivedContainerCountByRoad[3];
                        END;
                    4:
                        BEGIN
                            ReceivedContainerCountByRoad[4] := ManifestLineRoad.COUNT;
                            if RoadDimCode = '40FT' then
                                TotalRoadTeusReceived[4] := ReceivedContainerCountByRoad[4];
                        END;
                    5:
                        BEGIN
                            ReceivedContainerCountByRoad[5] := ManifestLineRoad.COUNT;
                            if RoadDimCode = '40FT' then
                                TotalRoadTeusReceived[5] := ReceivedContainerCountByRoad[5];
                        END;
                    6:
                        BEGIN
                            ReceivedContainerCountByRoad[6] := ManifestLineRoad.COUNT;
                            if RoadDimCode = '40FT' then
                                TotalRoadTeusReceived[6] := ReceivedContainerCountByRoad[6];
                            //Message('%1', TotalRoadTeusReceived[6]);
                        END;
                    7:
                        BEGIN
                            ReceivedContainerCountByRoad[7] := ManifestLineRoad.COUNT;
                            if RoadDimCode = '40FT' then
                                TotalRoadTeusReceived[7] := ReceivedContainerCountByRoad[7];
                        END;
                    8:
                        BEGIN
                            ReceivedContainerCountByRoad[8] := ManifestLineRoad.COUNT;
                            if RoadDimCode = '40FT' then
                                TotalRoadTeusReceived[8] := ReceivedContainerCountByRoad[8];
                        END;
                    9:
                        BEGIN
                            ReceivedContainerCountByRoad[9] := ManifestLineRoad.COUNT;
                            if RoadDimCode = '40FT' then
                                TotalRoadTeusReceived[9] := ReceivedContainerCountByRoad[9];
                        END;
                    10:
                        BEGIN
                            ReceivedContainerCountByRoad[10] := ManifestLineRoad.COUNT;
                            if RoadDimCode = '40FT' then
                                TotalRoadTeusReceived[10] := ReceivedContainerCountByRoad[10];
                        END;
                    11:
                        BEGIN
                            ReceivedContainerCountByRoad[11] := ManifestLineRoad.COUNT;
                            if RoadDimCode = '40FT' then
                                TotalRoadTeusReceived[11] := ReceivedContainerCountByRoad[11];
                        END;
                    12:
                        BEGIN
                            ReceivedContainerCountByRoad[12] := ManifestLineRoad.COUNT;
                            if RoadDimCode = '40FT' then
                                TotalRoadTeusReceived[12] := ReceivedContainerCountByRoad[12];
                        END;
                END;
                DimContReceivedByRoad_gcode := RoadDimCode;
            END;
        End;

    end;


    //Billed Loose Cargo

    procedure GetBillingLooseCount(InvDimCode: Code[20]);
    var
        Saleinv_Lrec: Record "Sales Invoice Line";
        ManifestLineRec: Record "Manifest Line";
    begin
        clear(TotalLooseTeusBilled);
        CreateDateFilters_lFnc;
        Clear(TotalBillingLooseCont);
        IF (DimLooseBilling_gcode <> InvDimCode) THEN BEGIN
            FOR i := 1 TO 12 DO BEGIN
                ManifestLineRec.Reset();
                ManifestLineRec.SetCurrentKey("Shortcut Dimension 5 Code", "Date Released");
                ManifestLineRec.SetRange("Date Released", StartDate_gDat[i], EndDate_gDat[i]);
                ManifestLineRec.SetRange("Shortcut Dimension 4 Code", 'LOOSE');
                if SalesPersonCode <> '' then
                    ManifestLineRec.SetRange("Shortcut Dimension 3 Code", SalesPersonCode);
                ManifestLineRec.SetRange("Shortcut Dimension 5 Code", InvDimCode);
                ManifestLineRec.SetRange(Released, true);
                CASE i OF
                    1:
                        begin
                            if ManifestLineRec.FindSet() then begin
                                repeat
                                    ReleasedLooseBillingCount[1] += ManifestLineRec."CBM Tonage";
                                until ManifestLineRec.Next() = 0;
                            end
                        end;
                    2:
                        begin
                            if ManifestLineRec.FindSet() then begin
                                repeat
                                    ReleasedLooseBillingCount[2] += ManifestLineRec."CBM Tonage";
                                until ManifestLineRec.Next() = 0;
                            end
                        end;
                    3:
                        begin
                            if ManifestLineRec.FindSet() then begin
                                repeat
                                    ReleasedLooseBillingCount[3] += ManifestLineRec."CBM Tonage";
                                until ManifestLineRec.Next() = 0;
                            end
                        end;
                    4:
                        begin
                            if ManifestLineRec.FindSet() then begin
                                repeat
                                    ReleasedLooseBillingCount[4] += ManifestLineRec."CBM Tonage";
                                until ManifestLineRec.Next() = 0;
                            end
                        end;
                    5:
                        begin
                            if ManifestLineRec.FindSet() then begin
                                repeat
                                    ReleasedLooseBillingCount[5] += ManifestLineRec."CBM Tonage";
                                until ManifestLineRec.Next() = 0;
                            end
                        end;
                    6:
                        begin
                            if ManifestLineRec.FindSet() then begin
                                repeat
                                    ReleasedLooseBillingCount[6] += ManifestLineRec."CBM Tonage";
                                until ManifestLineRec.Next() = 0;
                            end
                        end;
                    7:
                        begin
                            if ManifestLineRec.FindSet() then begin
                                repeat
                                    ReleasedLooseBillingCount[7] += ManifestLineRec."CBM Tonage";
                                until ManifestLineRec.Next() = 0;
                            end
                        end;
                    8:
                        begin
                            if ManifestLineRec.FindSet() then begin
                                repeat
                                    ReleasedLooseBillingCount[8] += ManifestLineRec."CBM Tonage";
                                until ManifestLineRec.Next() = 0;
                            end
                        end;
                    9:
                        begin
                            if ManifestLineRec.FindSet() then begin
                                repeat
                                    ReleasedLooseBillingCount[9] += ManifestLineRec."CBM Tonage";
                                until ManifestLineRec.Next() = 0;
                            end
                        end;
                    10:
                        begin
                            if ManifestLineRec.FindSet() then begin
                                repeat
                                    ReleasedLooseBillingCount[10] += ManifestLineRec."CBM Tonage";
                                until ManifestLineRec.Next() = 0;
                            end
                        end;
                    11:
                        begin
                            if ManifestLineRec.FindSet() then begin
                                repeat
                                    ReleasedLooseBillingCount[11] += ManifestLineRec."CBM Tonage";
                                until ManifestLineRec.Next() = 0;
                            end
                        end;
                    12:
                        begin
                            if ManifestLineRec.FindSet() then begin
                                repeat
                                    ReleasedLooseBillingCount[12] += ManifestLineRec."CBM Tonage";
                                until ManifestLineRec.Next() = 0;
                            end
                        end;
                end;

            end;
        end;
        DimLooseBilling_gcode := InvDimCode;
    End;



    LOCAL procedure CreateDateFilters_lFnc();
    begin
        StartDate_gDat[1] := DMY2DATE(1, 1, Year_Int);
        EndDate_gDat[1] := CALCDATE('1M', StartDate_gDat[1]) - 1;
        FOR i := 2 TO 12 DO BEGIN
            StartDate_gDat[i] := CALCDATE('1M', StartDate_gDat[i - 1]);
            EndDate_gDat[i] := CALCDATE('1M', StartDate_gDat[i]) - 1;
        END;
    end;
    //Billing Count For CONTAINERS

    //procedure GetBillingLooseRoadCount(RInvDimCode: Code[20]; containerid: code[20]);
    procedure GetBillingLooseRoadCount(RInvDimCode: Code[20]);
    var
        ManifestLine_Lrec: Record "Manifest Line";
    begin
        Clear(TotalRoadTeusBilled);
        CreateDateFilters_lFnc;
        Clear(TotalBillingLooseCont);


        IF (DimLooseBillingRoad_gcode <> RInvDimCode) THEN BEGIN
            FOR i := 1 TO 12 DO BEGIN
                SalesInvocieLine.Reset();
                SalesInvocieLine.SetFilter("Shortcut Dimension 4 Code", '%1', 'Container');
                SalesInvocieLine.SetRange("Posting Date", StartDate_gDat[i], EndDate_gDat[i]);
                if SalesPersonCode <> '' then
                    SalesInvocieLine.SetRange("Shortcut Dimension 3 Code", SalesPersonCode);
                SalesInvocieLine.SetFilter("Shortcut Dimension 5 Code", '%1', RInvDimCode);
                //SalesInvocieLine.SetFilter("Shortcut Dimension 1 Code", '<>%1', '');
                IF SalesInvocieLine.FindFirst() then;
                CASE i OF
                    1:
                        begin
                            LooseBillingroadCount[1] := GetRoadInvoiceLinesCount(RInvDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                            if RInvDimCode = '40FT' then
                                TotalRoadTeusBilled[1] := LooseBillingroadCount[1];
                        end;
                    2:
                        begin
                            LooseBillingroadCount[2] := GetRoadInvoiceLinesCount(RInvDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                            if RInvDimCode = '40FT' then
                                TotalRoadTeusBilled[2] := LooseBillingroadCount[2];
                        end;
                    3:
                        begin
                            LooseBillingroadCount[3] := GetRoadInvoiceLinesCount(RInvDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                            if RInvDimCode = '40FT' then
                                TotalRoadTeusBilled[3] := LooseBillingroadCount[3];
                        end;
                    4:
                        begin
                            LooseBillingroadCount[4] := GetRoadInvoiceLinesCount(RInvDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                            if RInvDimCode = '40FT' then
                                TotalRoadTeusBilled[4] := LooseBillingroadCount[4];
                        end;
                    5:
                        begin
                            LooseBillingroadCount[5] := GetRoadInvoiceLinesCount(RInvDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                            if RInvDimCode = '40FT' then
                                TotalRoadTeusBilled[5] := LooseBillingroadCount[5];
                            //Message('%1', TotalRoadTeusBilled[5]);
                        end;
                    6:
                        begin
                            LooseBillingroadCount[6] := GetRoadInvoiceLinesCount(RInvDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                            if RInvDimCode = '40FT' then
                                TotalRoadTeusBilled[6] := LooseBillingroadCount[6];
                        end;
                    7:
                        begin
                            LooseBillingroadCount[7] := GetRoadInvoiceLinesCount(RInvDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                            if RInvDimCode = '40FT' then
                                TotalRoadTeusBilled[7] := LooseBillingroadCount[7];
                        end;
                    8:
                        begin
                            LooseBillingroadCount[8] := GetRoadInvoiceLinesCount(RInvDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                            if RInvDimCode = '40FT' then
                                TotalRoadTeusBilled[8] := LooseBillingroadCount[8];
                        end;
                    9:
                        begin
                            LooseBillingroadCount[9] := GetRoadInvoiceLinesCount(RInvDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                            if RInvDimCode = '40FT' then
                                TotalRoadTeusBilled[9] := LooseBillingroadCount[9];
                        end;
                    10:
                        begin
                            LooseBillingroadCount[10] := GetRoadInvoiceLinesCount(RInvDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                            if RInvDimCode = '40FT' then
                                TotalRoadTeusBilled[10] := LooseBillingroadCount[10];
                        end;
                    11:
                        begin
                            LooseBillingroadCount[11] := GetRoadInvoiceLinesCount(RInvDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                            if RInvDimCode = '40FT' then
                                TotalRoadTeusBilled[11] := LooseBillingroadCount[11];

                        end;
                    12:
                        begin
                            LooseBillingroadCount[12] := GetRoadInvoiceLinesCount(RInvDimCode, SalesInvocieLine."Shortcut Dimension 4 Code", i);
                            if RInvDimCode = '40FT' then
                                TotalRoadTeusBilled[12] := LooseBillingroadCount[12];
                        end;
                END;

            end;

        end;
        DimLooseBillingRoad_gcode := RInvDimCode;
    End;

    //Billing Count For CONTAINERS MODE OF TRANSPORT - BY Road
    local procedure GetRoadInvoiceLinesCount(Containersize: Code[20]; CagoType: Code[20]; j: Integer): Integer;
    var
        SalesInvoiceLine3: Record "Sales Invoice Line";
        ManifestLine: Record "Manifest Line";
    begin
        clear(CountofContRoadFT);
        SalesInvoiceLine3.Reset();
        SalesInvoiceLine3.SetCurrentKey("Shortcut Dimension 1 Code");
        SalesInvoiceLine3.SetAscending("Shortcut Dimension 1 Code", True);
        SalesInvoiceLine3.SetRange("Posting Date", StartDate_gDat[j], EndDate_gDat[j]);
        if SalesPersonCode <> '' then
            SalesInvoiceLine3.SetRange("Shortcut Dimension 3 Code", SalesPersonCode);
        SalesInvoiceLine3.SetRange("Shortcut Dimension 5 Code", Containersize);
        SalesInvoiceLine3.SetRange("Shortcut Dimension 4 Code", CagoType);
        if SalesInvoiceLine3.FindSet() then //begin
            repeat
                IF ContainerId_gCode40FT <> SalesInvoiceLine3."Shortcut Dimension 1 Code" then begin
                    CountofContRoadFT += 1;
                end;
                ContainerId_gCode40FT := SalesInvoiceLine3."Shortcut Dimension 1 Code";
            until SalesInvoiceLine3.Next() = 0;
        exit(CountofContRoadFT);
    end;
    //Stripped Units
    procedure GetCountforReceivedStrippedUnits(ReceivedStrippedDimCode: Code[20]; RDate: Date): Integer;
    var
        ReceivedManifestLine: Record "Manifest Line";
    begin

        Clear(TotalReceivedUnit);
        CreateDateFilters_lFnc;
        IF DimStrippedReceived_gcode <> ReceivedStrippedDimCode THEN BEGIN
            FOR i := 1 TO 12 DO BEGIN
                ReceivedManifestLine.Reset();
                ReceivedManifestLine.SetCurrentKey("Shortcut Dimension 5 Code", "Date Received");
                ReceivedManifestLine.SetRange("Date Received", StartDate_gDat[i], EndDate_gDat[i]);
                if SalesPersonCode <> '' then
                    ReceivedManifestLine.SetRange("Shortcut Dimension 3 Code", SalesPersonCode);
                ReceivedManifestLine.SetRange("Shortcut Dimension 4 Code", 'UNIT');
                ReceivedManifestLine.SetRange("Shortcut Dimension 5 Code", ReceivedStrippedDimCode);
                ReceivedManifestLine.SetRange(Received, true);
                TotalReceivedUnit += ReceivedManifestLine.Count;
                CASE i OF
                    1:
                        ReceivedStrippedUnitsCount[1] := ReceivedManifestLine.COUNT;
                    2:
                        ReceivedStrippedUnitsCount[2] := ReceivedManifestLine.COUNT;
                    3:
                        ReceivedStrippedUnitsCount[3] := ReceivedManifestLine.COUNT;
                    4:
                        ReceivedStrippedUnitsCount[4] := ReceivedManifestLine.COUNT;
                    5:
                        ReceivedStrippedUnitsCount[5] := ReceivedManifestLine.COUNT;
                    6:
                        ReceivedStrippedUnitsCount[6] := ReceivedManifestLine.COUNT;
                    7:
                        ReceivedStrippedUnitsCount[7] := ReceivedManifestLine.COUNT;
                    8:
                        ReceivedStrippedUnitsCount[8] := ReceivedManifestLine.COUNT;
                    9:
                        ReceivedStrippedUnitsCount[9] := ReceivedManifestLine.COUNT;
                    10:
                        ReceivedStrippedUnitsCount[10] := ReceivedManifestLine.COUNT;
                    11:
                        ReceivedStrippedUnitsCount[11] := ReceivedManifestLine.COUNT;
                    12:
                        ReceivedStrippedUnitsCount[12] := ReceivedManifestLine.COUNT;
                END;
                DimStrippedReceived_gcode := ReceivedStrippedDimCode;
            END;
        End;
    end;

    //Stripped UNITS
    procedure GetCountforStrippedReleasedUnits(ReleasedStrippedDimCode: Code[20]; RDate: Date): Integer;
    var
        ReleasedManifestLine: Record "Manifest Line";
    begin
        clear(TotalReleasedUnit);
        CreateDateFilters_lFnc;
        IF DimStrippedReleased_gcode <> ReleasedStrippedDimCode THEN BEGIN
            FOR i := 1 TO 12 DO BEGIN
                ReleasedManifestLine.Reset();
                ReleasedManifestLine.SetCurrentKey("Shortcut Dimension 5 Code", "Date Released");
                ReleasedManifestLine.SetRange("Date Released", StartDate_gDat[i], EndDate_gDat[i]);
                if SalesPersonCode <> '' then
                    ReleasedManifestLine.SetRange("Shortcut Dimension 3 Code", SalesPersonCode);
                ReleasedManifestLine.SetRange("Shortcut Dimension 4 Code", 'STRIPPED UNIT');
                ReleasedManifestLine.SetRange("Shortcut Dimension 5 Code", ReleasedStrippedDimCode);
                ReleasedManifestLine.SetRange(Released, true);
                TotalReleasedUnit += ReleasedManifestLine.Count;
                CASE i OF
                    1:
                        ReleasedStrippedUnitsCount[1] := ReleasedManifestLine.COUNT;
                    2:
                        ReleasedStrippedUnitsCount[2] := ReleasedManifestLine.COUNT;
                    3:
                        ReleasedStrippedUnitsCount[3] := ReleasedManifestLine.COUNT;
                    4:
                        ReleasedStrippedUnitsCount[4] := ReleasedManifestLine.COUNT;
                    5:
                        ReleasedStrippedUnitsCount[5] := ReleasedManifestLine.COUNT;
                    6:
                        ReleasedStrippedUnitsCount[6] := ReleasedManifestLine.COUNT;
                    7:
                        ReleasedStrippedUnitsCount[7] := ReleasedManifestLine.COUNT;
                    8:
                        ReleasedStrippedUnitsCount[8] := ReleasedManifestLine.COUNT;
                    9:
                        ReleasedStrippedUnitsCount[9] := ReleasedManifestLine.COUNT;
                    10:
                        ReleasedStrippedUnitsCount[10] := ReleasedManifestLine.COUNT;
                    11:
                        ReleasedStrippedUnitsCount[11] := ReleasedManifestLine.COUNT;
                    12:
                        ReleasedStrippedUnitsCount[12] := ReleasedManifestLine.COUNT;
                END;
            END;
        End;
        DimStrippedReleased_gcode := ReleasedStrippedDimCode;
    end;

    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

}
