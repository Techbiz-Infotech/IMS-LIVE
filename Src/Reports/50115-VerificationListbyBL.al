report 50115 "Verification List by BL"
{
    ApplicationArea = All;
    Caption = 'Verification List by BL';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Src/Reports/Layouts/Verification List by BL.rdlc';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(ManifestLine; "Manifest Line")
        {
            DataItemTableView = SORTING("Global Dimension 1 Code") WHERE(Received = const(true));
            column(JobFileNo; "Job File No.")
            {
            }
            column(companyLogo; companyInfo.Picture)
            { }
            column(BLNo; "BL No.")
            {
            }
            column(ContainerChassisNo; "Container/Chassis No.")
            {
            }
            column(SealEngineNo; "Seal/Engine No.")
            {
            }
            column(ShortcutDimension4Code; "Shortcut Dimension 4 Code")
            {
            }
            column(ContainerType; "Container Type")
            {
            }
            column(ShortcutDimension5Code; "Shortcut Dimension 5 Code")
            {
            }
            column(Description; Description)
            {
            }
            column(CBMTonage; "CBM Tonage")
            {
            }
            column(Weight; Weight)
            {
            }
            column(Verified; Verified)
            {
            }
            column(ConsigneeName; "Consignee Name")
            {
            }
            column(ClearingAgent; "Clearing Agent")
            {
            }
            column(ClearingAgentName; Clearingagent."Clearing Agent Name")
            { }
            trigger OnAfterGetRecord()
            begin
                Clearingagent.Reset();
                Clearingagent.SetRange("Clearing Agent Code", ManifestLine."Clearing Agent");
                if Clearingagent.FindFirst() then;
            end;

            trigger OnPreDataItem()
            begin

                if BLNo <> '' then
                    setfilter("BL No.", BLNo);
            end;


        }


    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(General)
                {

                    field("BLNo"; "BLNo")
                    {
                        ApplicationArea = all;
                        Caption = 'BL No.';

                        trigger OnLookup(var text: text): Boolean
                        var
                            ManiLine: Record "Manifest Line";
                        begin
                            ManiLine.Reset();
                            ManiLine.SetRange(Received, true);
                            //ManiLine.SetRange(Verified, false);
                            ManiLine.SetRange(Released, false);
                            ManiLine.FindFirst();
                            if page.RunModal(50122, ManiLine) = Action::LookupOK then begin
                                BLNo := ManiLine."BL No.";
                            end;
                        END;
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
        companyInfo: Record "Company Information";
        Clearingagent: Record "Clearing Agent";
        BLNo: Code[20];

    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture)
    end;

}
