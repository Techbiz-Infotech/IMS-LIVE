report 50132 "Customer Rebate"
{
    ApplicationArea = All;
    Caption = 'Customer Rebate';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Src/Reports/Layouts/Customer Rebate.rdlc';

    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "Sell-to Customer No.", "Posting Date", "Clearing Agent";
            column(INV_No; "No.") { }
            column(PostingDate; "Posting Date") { }
            column(SelltoCustomerName; "Sell-to Customer Name") { }
            // column(ClearingAgent; ClearingAgent) { }
            column(ClearingAgent; "Clearing Agent Name") { }
            column(BLNo; "BL No.") { }
            column(VesselName; ManifestLine."Vessel Name") { }
            column(Countof20FT; Countof20FT) { }
            column(Countof40FT; Countof40FT) { }
            column(UnitsCount; UnitsCount) { }
            column(UNIT; SalesInvocieLine."Shortcut Dimension 4 Code") { }
            column(CBM; LCBM) { }
            column(Weight; LWeight) { }
            column(CompanyLogo; CompanyInfo.Picture) { }
            column(CompanyName; CompanyInfo.Name) { }
            //New
            column(Amount; "Amount Including VAT") { }
            column(Remaining_Amount; "Remaining Amount") { }
            column(CFShandlingCharges; CFShandlingCharges) { }
            column(ShorehandlingCharges; ShorehandlingCharges) { }
            //**
            trigger OnAfterGetRecord()
            var
                SalesInvocieLine_Lrec: Record "Sales Invoice Line";
                SalesInvocieLine_Lrec1: Record "Sales Invoice Line";
            begin
                ClearingAgent := '';
                SalesInvocieLine.Reset();
                SalesInvocieLine.SetRange("Document No.", SalesInvoiceHeader."No.");
                IF SalesInvocieLine.FindFirst() then begin
                    ManifestLine.Reset();
                    //ManifestLine.SetRange("Global Dimension 1 Code", SalesInvocieLine."Shortcut Dimension 1 Code");
                    ManifestLine.SetRange("Container/Chassis No.", SalesInvocieLine."Container No./Chassis No.");
                    if ManifestLine.FindFirst() then begin
                        ClearingAgent := ManifestLine."Clearing Agent";
                      //  if manifesthead.Get(ManifestLine."Job File No.") then;
                    end;
                    CFShandlingCharges := 0;
                    IMSSetup.Get();
                    SalesInvocieLine2.Reset();
                    SalesInvocieLine2.SetRange("Document No.", SalesInvoiceHeader."No.");
                    SalesInvocieLine2.SetRange("Item Category Code", IMSSetup."Category Code for CFS Handling");
                    if SalesInvocieLine2.FindFirst() then
                        CFShandlingCharges := SalesInvocieLine2."Unit Price"
                    else
                        CFShandlingCharges := 0;

                    ShorehandlingCharges := 0;
                    IMSSetup.Get();
                    SalesInvocieLine2.Reset();
                    SalesInvocieLine2.SetRange("Document No.", SalesInvoiceHeader."No.");
                    SalesInvocieLine2.SetRange("Item Category Code", IMSSetup."Category for Shorehandling");
                    if SalesInvocieLine2.FindFirst() then
                        ShorehandlingCharges := SalesInvocieLine2."Unit Price"
                    else
                        ShorehandlingCharges := 0;
                end;

                ///UNIT Code//
                clear(UnitsCount);
                Clear(UnitCBM);
                Clear(Unitweight);
                SalesInvocieLine.Reset();
                SalesInvocieLine.SetCurrentKey("Shortcut Dimension 1 Code");
                SalesInvocieLine.SetAscending("Shortcut Dimension 1 Code", true);
                SalesInvocieLine.setrange("Document No.", SalesInvoiceHeader."No.");
                SalesInvocieLine.SetRange("Shortcut Dimension 4 Code", 'UNIT');
                if SalesInvocieLine.FindSet() then begin
                    repeat
                        IF ContainerId_gCode <> SalesInvocieLine."Container No./Chassis No." then begin
                            UnitsCount += 1;
                            ManifestLine.Reset();
                            //ManifestLine.SetRange("Global Dimension 1 Code", SalesInvocieLine."Shortcut Dimension 1 Code");
                            ManifestLine.SetRange("Container/Chassis No.", SalesInvocieLine."Container No./Chassis No.");
                            if ManifestLine.FindFirst() then begin
                                UnitCBM += ManifestLine."CBM Tonage";
                                Unitweight += ManifestLine.Weight;
                            end;
                            //ContainerId_gCode := SalesInvocieLine."Shortcut Dimension 1 Code";
                            ContainerId_gCode := SalesInvocieLine."Container No./Chassis No.";
                        end;
                    until SalesInvocieLine.Next() = 0;
                end;
                //20FT Code//

                clear(Countof20FT);
                Clear(CBM20FT);
                Clear(weight20FT);
                ContainerId_gCode20FT := '';
                SalesInvocieLine.Reset();
                SalesInvocieLine.SetCurrentKey("Shortcut Dimension 1 Code");
                SalesInvocieLine.SetAscending("Shortcut Dimension 1 Code", true);
                SalesInvocieLine.setrange("Document No.", "No.");
                SalesInvocieLine.SetRange("Shortcut Dimension 5 Code", '20FT');
                SalesInvocieLine.SetRange("Shortcut Dimension 4 Code", 'CONTAINER');
                if SalesInvocieLine.FindSet() then begin
                    repeat
                        IF ContainerId_gCode20FT <> SalesInvocieLine."Container No./Chassis No." then begin
                            Countof20FT += 1;
                            ManifestLine.Reset();

                            //ManifestLine.SetRange("Global Dimension 1 Code", SalesInvocieLine."Shortcut Dimension 1 Code");
                            ManifestLine.SetRange("Container/Chassis No.", SalesInvocieLine."Container No./Chassis No.");
                            if ManifestLine.FindFirst() then begin
                                CBM20FT += ManifestLine."CBM Tonage";
                                weight20FT += ManifestLine.Weight;
                            end;
                            ContainerId_gCode20FT := SalesInvocieLine."Container No./Chassis No.";
                        end;
                    until SalesInvocieLine.Next() = 0;
                end;
                //40FT Code//

                clear(Countof40FT);
                clear(CBM40FT);
                Clear(weight40FT);
                ContainerId_gCode40FT := '';
                SalesInvocieLine.Reset();
                SalesInvocieLine.SetCurrentKey("Shortcut Dimension 1 Code");
                SalesInvocieLine.SetAscending("Shortcut Dimension 1 Code", true);
                SalesInvocieLine.setrange("Document No.", "No.");
                SalesInvocieLine.SetRange("Shortcut Dimension 5 Code", '40FT');
                SalesInvocieLine.SetRange("Shortcut Dimension 4 Code", 'CONTAINER');
                if SalesInvocieLine.FindSet() then begin
                    repeat
                        IF ContainerId_gCode40FT <> SalesInvocieLine."Container No./Chassis No." then begin
                            Countof40FT += 1;
                            ManifestLine.Reset();

                            //ManifestLine.SetRange("Global Dimension 1 Code", SalesInvocieLine."Shortcut Dimension 1 Code");
                            ManifestLine.SetRange("Container/Chassis No.", SalesInvocieLine."Container No./Chassis No.");
                            if ManifestLine.FindFirst() then begin
                                CBM40FT += ManifestLine."CBM Tonage";
                                weight40FT += ManifestLine.Weight;
                            end;
                            ContainerId_gCode40FT := SalesInvocieLine."Container No./Chassis No.";
                        end;
                    until SalesInvocieLine.Next() = 0;
                end;
                LCBM := UnitCBM + CBM20FT + CBM40FT;
                Lweight := Unitweight + weight20FT + weight40FT;
                //new
                SalesInvoiceHeader.CalcFields(Amount);
                SalesInvoiceHeader.CalcFields("Remaining Amount");
                //**

            end;
        }
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "Sell-to Customer No.", "Posting Date";


            column(Cr_No; "No.") { }
            column(CrPostingDate; "Posting Date") { }
            column(CrSelltoCustomerName; "Sell-to Customer Name") { }
            //column(CrClearingAgent; ManifestLine."Clearing Agent") { }
            column(CrClearingAgent; "Clearing Agent Name"){}
            column(CrBLNo; "BL No.") { }
            column(CrVesselName; ManifestLine."Vessel Name") { }
            column(CrRemaining_Amount; "Remaining Amount") { }
            column(CrCFShandlingCharges; CFShandlingCharges) { }
            column(CrShorehandlingCharges; ShorehandlingCharges) { }
            column(CrAmount; Amount) { }
            column(CrCountof20FT; CrCountof20FT) { }
            column(CrCountof40FT; CrCountof40FT) { }
            column(CrUnitsCount; CrUnitsCount) { }
            column(CrUNIT; SalesInvocieLine."Shortcut Dimension 4 Code") { }
            column(CrLCBM; CrLCBM) { }
            column(CrLweight; CrLweight) { }

            trigger OnAfterGetRecord()
            var


                SalesCrMemoLine_Lrec1: Record "Sales Cr.Memo Line";
                SalesCrMemoLine_Lrec: Record "Sales Cr.Memo Line";
            begin
                CrClearingAgent := '';
                SalesCrMemoLine.Reset();
                SalesCrMemoLine.SetRange("Document No.", "No.");
                IF SalesCrMemoLine.FindFirst() then begin
                    ManifestLine.Reset();
                    //ManifestLine.SetRange("Global Dimension 1 Code", SalesInvocieLine."Shortcut Dimension 1 Code");
                    ManifestLine.SetRange("Container/Chassis No.", SalesCrMemoLine."Container No./Chassis No.");
                    if ManifestLine.FindFirst() then begin
                        CrClearingAgent := ManifestLine."Clearing Agent";
                        //if manifesthead.Get(ManifestLine."Job File No.") then;
                    end;
                    CFShandlingCharges := 0;
                    IMSSetup.Get();
                    SalesCrMemoLine2.Reset();
                    SalesCrMemoLine2.SetRange("Document No.", "No.");
                    SalesCrMemoLine2.SetRange("Item Category Code", IMSSetup."Category Code for CFS Handling");
                    if SalesCrMemoLine2.FindFirst() then
                        CFShandlingCharges := SalesCrMemoLine2."Unit Price"
                    else
                        CFShandlingCharges := 0;

                    ShorehandlingCharges := 0;
                    IMSSetup.Get();
                    SalesCrMemoLine2.Reset();
                    SalesCrMemoLine2.SetRange("Document No.", "No.");
                    SalesCrMemoLine2.SetRange("Item Category Code", IMSSetup."Category for Shorehandling");
                    if SalesCrMemoLine2.FindFirst() then
                        ShorehandlingCharges := SalesInvocieLine2."Unit Price"
                    else
                        ShorehandlingCharges := 0;
                end;

                //CFS Handling





                ///UNIT Code//

                clear(CrUnitsCount);
                Clear(CrUnitCBM);
                Clear(CrUnitweight);
                SalesCrMemoLine.Reset();
                SalesCrMemoLine.SetCurrentKey("Shortcut Dimension 1 Code");
                SalesCrMemoLine.SetAscending("Shortcut Dimension 1 Code", true);
                SalesCrMemoLine.setrange("Document No.", "No.");
                SalesCrMemoLine.SetRange("Shortcut Dimension 4 Code", 'UNIT');
                if SalesCrMemoLine.FindSet() then begin
                    repeat
                        IF CrContainerId_gCode <> SalesCrMemoLine."Container No./Chassis No." then begin
                            CrUnitsCount += 1;
                            ManifestLine.Reset();
                            //ManifestLine.SetRange("Global Dimension 1 Code", SalesInvocieLine."Shortcut Dimension 1 Code");
                            ManifestLine.SetRange("Container/Chassis No.", SalesCrMemoLine."Container No./Chassis No.");
                            if ManifestLine.FindFirst() then begin
                                CrUnitCBM += ManifestLine."CBM Tonage";
                                CrUnitweight += ManifestLine.Weight;
                            end;
                            //ContainerId_gCode := SalesInvocieLine."Shortcut Dimension 1 Code";
                            CrContainerId_gCode := SalesCrMemoLine."Container No./Chassis No.";
                        end;
                    until SalesCrMemoLine.Next() = 0;
                end;
                //20FT Code//

                clear(CrCountof20FT);
                Clear(CrCBM20FT);
                Clear(Crweight20FT);
                CrContainerId_gCode20FT := '';
                SalesCrMemoLine.Reset();
                SalesCrMemoLine.SetCurrentKey("Shortcut Dimension 1 Code");
                SalesCrMemoLine.SetAscending("Shortcut Dimension 1 Code", true);
                SalesCrMemoLine.setrange("Document No.", "No.");
                SalesCrMemoLine.SetRange("Shortcut Dimension 5 Code", '20FT');
                SalesCrMemoLine.SetRange("Shortcut Dimension 4 Code", 'CONTAINER');
                if SalesCrMemoLine.FindSet() then begin
                    repeat
                        IF CrContainerId_gCode20FT <> SalesCrMemoLine."Container No./Chassis No." then begin
                            CrCountof20FT += 1;
                            ManifestLine.Reset();
                            //ManifestLine.SetRange("Global Dimension 1 Code", SalesInvocieLine."Shortcut Dimension 1 Code");
                            ManifestLine.SetRange("Container/Chassis No.", SalesCrMemoLine."Container No./Chassis No.");
                            if ManifestLine.FindFirst() then begin
                                CrCBM20FT += ManifestLine."CBM Tonage";
                                Crweight20FT += ManifestLine.Weight;
                            end;
                            CrContainerId_gCode20FT := SalesCrMemoLine."Container No./Chassis No.";
                        end;
                    until SalesCrMemoLine.Next() = 0;
                end;
                //40FT Code//

                clear(CrCountof40FT);
                clear(CBM40FT);
                Clear(weight40FT);
                CrContainerId_gCode40FT := '';
                SalesCrMemoLine.Reset();
                SalesCrMemoLine.SetCurrentKey("Shortcut Dimension 1 Code");
                SalesCrMemoLine.SetAscending("Shortcut Dimension 1 Code", true);
                SalesCrMemoLine.setrange("Document No.", "No.");
                SalesCrMemoLine.SetRange("Shortcut Dimension 5 Code", '40FT');
                SalesCrMemoLine.SetRange("Shortcut Dimension 4 Code", 'CONTAINER');
                if SalesCrMemoLine.FindSet() then begin
                    repeat
                        IF CrContainerId_gCode40FT <> SalesCrMemoLine."Container No./Chassis No." then begin
                            CrCountof40FT += 1;
                            ManifestLine.Reset();

                            //ManifestLine.SetRange("Global Dimension 1 Code", SalesInvocieLine."Shortcut Dimension 1 Code");
                            ManifestLine.SetRange("Container/Chassis No.", SalesCrMemoLine."Container No./Chassis No.");
                            if ManifestLine.FindFirst() then begin
                                CrCBM40FT += ManifestLine."CBM Tonage";
                                Crweight40FT += ManifestLine.Weight;
                            end;
                            CrContainerId_gCode40FT := SalesCrMemoLine."Container No./Chassis No.";
                        end;
                    until SalesCrMemoLine.Next() = 0;
                end;
                CrLCBM := CrUnitCBM + CrCBM20FT + CrCBM40FT;
                CrLweight := CrUnitweight + Crweight20FT + Crweight40FT;

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
        PrevContainerNo: Code[20];
        GroupByContainerID: code[20];
        ContainerId_gCode20FT: Code[20];
        ContainerId_gCode40FT: Code[20];
        ManifestLine: Record "Manifest Line";
        //ManifestHead: Record "Manifest Header";
        Countof20FT: Integer;
        Countof40FT: Integer;
        SalesInvocieLine2, SalesInvocieLine : Record "Sales Invoice Line";
        UnitsCount: Integer;
        ShorehandlingCharges, CFShandlingCharges : Decimal;
        IMSSetup: Record "IMS Setup";


        CrClearingAgent, ClearingAgent : Code[20];
        RecClearingAgent: Record "Clearing Agent";
        ClearingAgentName: Text[50];
        ContainerID_gTxt: Text;
        ContainerId_gCode: Code[100];
        UnitCBM: Decimal;
        Unitweight: Decimal;
        CBM20FT: Decimal;
        CBM40FT: Decimal;
        weight20FT: decimal;
        weight40FT: decimal;
        LCBM: Decimal;
        Lweight: Decimal;
        CompanyInfo: Record "Company Information";
        CrPrevContainerNo: Code[20];
        CrGroupByContainerID: code[20];
        CrContainerId_gCode20FT: Code[20];
        CrContainerId_gCode40FT: Code[20];
        CrCountof20FT: Integer;
        CrCountof40FT: Integer;
        SalesCrMemoLine2, SalesCrMemoLine : Record "Sales Cr.Memo Line";
        CrUnitsCount: Integer;
        CrContainerID_gTxt: Text;
        CrContainerId_gCode: Code[100];
        CrUnitCBM: Decimal;
        CrUnitweight: Decimal;
        CrCBM20FT: Decimal;
        CrCBM40FT: Decimal;
        Crweight20FT: decimal;
        Crweight40FT: decimal;
        CrLCBM: Decimal;
        CrLweight: Decimal;

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);

    end;

}
