report 50168 "ClearingAgent RR"
{
    ApplicationArea = All;
    Caption = 'Clearing Agent Revenue Ranking';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Src/Reports/Layouts/ClearingAgent RR.rdlc';
    dataset
    {

        dataitem("Manifest Line"; "Manifest Line")
        {
            column(Clearing_Agent; "Clearing Agent") { }
            column(NetRevenue; InvertValue(NetRevenue)) { }
            column(Companylogo; CompanyInfo.Picture) { }
            column(CompanyName; CompanyInfo.Name) { }
            column(CountOfContainer; CountOfContainer) { }
            trigger OnAfterGetRecord()
            var
            begin
                GetCustManifestLinesCount("Clearing Agent");
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
    local procedure GetCustManifestLinesCount(ClearingAgent: Code[20]): Integer;
    var
        ManifestLine: Record "Manifest Line";
    begin
        NetRevenue := 0;
        clear(CountOfContainer);
        ManifestLine.Reset();
        ManifestLine.SetCurrentKey("Global Dimension 1 Code");
        ManifestLine.SetAscending("Global Dimension 1 Code", true);
        ManifestLine.SetFilter("Date Released", '%1..%2', StartDate, EndDate);
        ManifestLine.SetRange("Clearing Agent", ClearingAgent);
        if ManifestLine.FindFirst() then //begin
            repeat
                IF ContainerId_gCode <> ManifestLine."Clearing Agent" then begin
                    CountOfContainer := ManifestLine.Count;
                End;
                ContainerId_gCode := ManifestLine."Clearing Agent";
                GLEntry.Reset();
                GLEntry.SetRange("Global Dimension 1 Code", ManifestLine."Global Dimension 1 Code");
                GLEntry.SetFilter("G/L Account No.", '>%1', '4');

                if GLEntry.FindFirst() then
                    repeat
                        NetRevenue += GLEntry.Amount;
                    until GLEntry.Next() = 0;

            until ManifestLine.Next() = 0;
        CustTotalCont := CountOfContainer;
        //CustTotalAmount := ShoreHandling;
        exit(CountOfContainer);
    end;

    var
        StartDate: Date;
        EndDate: Date;
        GLEntry: Record "G/L Entry";
        NetRevenue: Decimal;
        ContainerId_gCode: Code[20];
        CountOfContainer: Integer;
        CustTotalCont: Integer;
        CompanyInfo: Record "Company Information";

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
