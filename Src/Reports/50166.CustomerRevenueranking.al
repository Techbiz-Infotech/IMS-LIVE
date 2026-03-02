report 50166 "Customer Revenue Ranking"
{
    ApplicationArea = All;
    Caption = 'Customer Revenue Ranking';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Src/Reports/Layouts/CustomerRevenueRanking.rdlc';
    dataset
    {
        dataitem("Manifest Line"; "Manifest Line")
        {
            column(Invoicing_Party_No_; "Invoicing Party No.") { }
            column(CutomerName; CutomerName) { }

            column(Companylogo; CompanyInfo.Picture) { }
            column(CompanyName; CompanyInfo.Name) { }
            column(CountOfContainer; CountOfContainer) { }
            column(CustConatinerCount; CustConatinerCount) { }
            column(CustNetRevenue; InvertValue(CustNetRevenue)) { }

            trigger OnAfterGetRecord()
            var
            begin
                if Custrec.get("Manifest Line"."Invoicing Party No.") then
                    CutomerName := Custrec.Name;
                GetCustManifestLinesCount("Invoicing Party No.");
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
                group(Options)
                {
                    Caption = 'Options';
                    field(StartDate; StartDate)
                    {
                        Caption = 'Start Date';
                        ApplicationArea = all;
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'End Date';
                        ApplicationArea = all;
                    }

                }
            }
        }


    }

    var
        CutomerName: text[100];
        CompanyInfo: Record "Company Information";
        StartDate: Date;
        EndDate: Date;
        Releasedcount: Integer;
        CountOfContainer: Integer;
        ContainerId_gCode: Code[20];
        DimCont_gcode: code[20];
        CustConatinerCount: Integer;
        Custrec: Record Customer;
        CustTotalCont: Integer;
        GLEntry: Record "G/L Entry";
        CustNetRevenue: Decimal;

        CustNo: Code[20];
        CustTotalAmount: Decimal;


    local procedure GetCustManifestLinesCount(CustomerNo: Code[20]): Integer;
    var
        ManifestLine: Record "Manifest Line";
    begin
        CustNetRevenue := 0;
        clear(CountOfContainer);
        ManifestLine.Reset();
        ManifestLine.SetCurrentKey("Global Dimension 1 Code");
        ManifestLine.SetAscending("Global Dimension 1 Code", true);
        ManifestLine.SetFilter("Date Released", '%1..%2', StartDate, EndDate);
        ManifestLine.SetRange("Invoicing Party No.", CustomerNo);
        if ManifestLine.FindFirst() then
            repeat
                IF ContainerId_gCode <> ManifestLine."Invoicing Party No." then begin
                    CountOfContainer := ManifestLine.Count;
                End;
                ContainerId_gCode := ManifestLine."Invoicing Party No.";
                GLEntry.Reset();
                GLEntry.SetRange("Global Dimension 1 Code", ManifestLine."Global Dimension 1 Code");
                GLEntry.SetRange("G/L Account No.", '40000105', '66000200');
                //GLEntry.SetFilter("G/L Account No.", '>%1', '4');
                if GLEntry.FindFirst() then
                    repeat
                        CustNetRevenue += GLEntry.Amount;
                    until GLEntry.Next() = 0;
            until ManifestLine.Next() = 0;
        CustTotalCont := CountOfContainer;
        exit(CountOfContainer);

    end;

    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture)
    end;

    procedure InvertValue(Value: Decimal): Decimal
    begin
        exit(-Value);
    end;
}
