report 50157 "Customer report"
{
    //ApplicationArea = All;
    Caption = 'Customer report';
    //UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Src/Reports/Layouts/CustomerReport.rdlc';
    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "Posting Date", "Clearing Agent";
            column(Posting_Date; "Posting Date") { }
            column("SelltoCustomerName"; "Sell-to Customer Name") { }
            column(ClearingAgent; SalesinvoiceLineRec."Clearing Agent") { }
            column(LineAmount; SalesinvoiceLineRec."Line Amount") { }
            column(Salesperson_Code; "Salesperson Code") { }
            column(Countof20FT; Countof20FT) { }
            column(Countof40FT; Countof40FT) { }
            column(UnitsCount; UnitsCount) { }
            column(CBMLoose; CBMLoose) { }
            column(CompanyLogo; CompanyInfo.Picture) { }
            column(CompanyName; CompanyInfo.Name) { }
            column(Amount; Amount) { }


            trigger OnAfterGetRecord()
            begin
                clear(UnitsCount);
                ContainerId_gCode := '';
                SalesinvoiceLineRec.Reset();
                SalesinvoiceLineRec.SetCurrentKey("Shortcut Dimension 1 Code");
                SalesinvoiceLineRec.SetAscending("Shortcut Dimension 1 Code", true);
                SalesinvoiceLineRec.setrange("Document No.", "No.");
                SalesinvoiceLineRec.SetRange("Shortcut Dimension 4 Code", 'UNIT');
                if SalesinvoiceLineRec.FindSet() then begin
                    repeat
                        IF ContainerId_gCode <> SalesinvoiceLineRec."Shortcut Dimension 1 Code" then begin
                            UnitsCount += 1;
                            ContainerId_gCode := SalesinvoiceLineRec."Shortcut Dimension 1 Code";
                        end;
                    until SalesinvoiceLineRec.Next() = 0;
                end;
                //end;
                //20FT Code//

                clear(Countof20FT);
                ContainerId_gCode20FT := '';
                SalesinvoiceLineRec.Reset();
                SalesinvoiceLineRec.SetCurrentKey("Shortcut Dimension 1 Code");
                SalesinvoiceLineRec.SetAscending("Shortcut Dimension 1 Code", true);
                SalesinvoiceLineRec.setrange("Document No.", "No.");
                SalesinvoiceLineRec.SetRange("Shortcut Dimension 5 Code", '20FT');
                SalesinvoiceLineRec.SetRange("Shortcut Dimension 4 Code", 'CONTAINER');
                if SalesinvoiceLineRec.FindSet() then begin
                    repeat
                        IF ContainerId_gCode20FT <> SalesinvoiceLineRec."Container No./Chassis No." then begin
                            Countof20FT += 1;

                            ContainerId_gCode20FT := SalesinvoiceLineRec."Container No./Chassis No.";
                        end;
                    until SalesinvoiceLineRec.Next() = 0;
                end;
                //40FT Code//

                clear(Countof40FT);
                clear(CBM40FT);
                Clear(weight40FT);
                ContainerId_gCode40FT := '';
                SalesinvoiceLineRec.Reset();
                SalesinvoiceLineRec.SetCurrentKey("Shortcut Dimension 1 Code");
                SalesinvoiceLineRec.SetAscending("Shortcut Dimension 1 Code", true);
                SalesinvoiceLineRec.setrange("Document No.", "No.");
                SalesinvoiceLineRec.SetRange("Shortcut Dimension 5 Code", '40FT');
                SalesinvoiceLineRec.SetRange("Shortcut Dimension 4 Code", 'CONTAINER');
                if SalesinvoiceLineRec.FindSet() then begin
                    repeat
                        IF ContainerId_gCode40FT <> SalesinvoiceLineRec."Container No./Chassis No." then begin
                            Countof40FT += 1;
                            ContainerId_gCode40FT := SalesinvoiceLineRec."Container No./Chassis No.";
                        end;
                    until SalesinvoiceLineRec.Next() = 0;
                end;

                Clear(CBMLoose);
                Clear(groupLoosecargoId);
                ContainerId_gCodeLoose := '';
                SalesinvoiceLineRec.Reset();
                SalesinvoiceLineRec.SetCurrentKey("Shortcut Dimension 1 Code");
                SalesinvoiceLineRec.SetAscending("Shortcut Dimension 1 Code", true);
                SalesinvoiceLineRec.SetRange("Document No.", "No.");
                SalesinvoiceLineRec.SetRange("Shortcut Dimension 5 Code", 'LOOSE');
                SalesinvoiceLineRec.SetRange("Shortcut Dimension 4 Code", 'LOOSE');
                if SalesinvoiceLineRec.FindSet() then begin
                    repeat
                        IF ContainerId_gCodeLoose <> SalesinvoiceLineRec."Container No./Chassis No." then begin
                            ManifestLineRec.Reset();

                            ManifestLineRec.SetRange("Container/Chassis No.", SalesinvoiceLineRec."Container No./Chassis No.");
                            ManifestLineRec.SetRange("Shortcut Dimension 4 Code", 'LOOSE');
                            ManifestLineRec.SetRange("Shortcut Dimension 5 Code", 'LOOSE');
                            if ManifestLineRec.FindSet() then begin
                                repeat
                                    CBMLoose += ManifestLineRec."CBM Tonage";
                                until ManifestLineRec.Next = 0;
                            end;

                            ContainerId_gCodeLoose := SalesinvoiceLineRec."Container No./Chassis No.";
                        end;
                    until SalesinvoiceLineRec.Next() = 0;
                end;
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
        JobFileNo: text[100];

        ManifestLineRec: Record "Manifest Line";
        SalesInvoiceHeaderRec: Record "Sales Invoice Header";
        SalesinvoiceLineRec: Record "Sales Invoice Line";
        FromDate: Date;
        ToDate: date;
        CustomerNo: Code[20];
        UnitsCount: Integer;
        Countof20FT: Integer;
        Countof40FT: Integer;
        UnitCBM: Decimal;
        LoosecargoCBM: Decimal;
        groupLoosecargoId: code[20];
        GroupByContainerID: code[20];
        ContainerId_gCodeLoose: Code[20];
        ContainerId_gCode20FT: Code[20];
        ContainerId_gCode40FT: Code[20];
        ClearingAgent: Code[20];
        RecClearingAgent: Record "Clearing Agent";
        ClearingAgentName: Text[50];
        ContainerID_gTxt: Text;
        ContainerId_gCode: Code[100];
        Unitweight: Decimal;
        CBM20FT: Decimal;
        CBM40FT: Decimal;
        CBMLoose: Decimal;
        weight20FT: decimal;
        weight40FT: decimal;
        LCBM: Decimal;
        Lweight: Decimal;
        CompanyInfo: Record "Company Information";

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);

    end;

}
