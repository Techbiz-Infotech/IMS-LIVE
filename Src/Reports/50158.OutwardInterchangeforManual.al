report 50158 "Outward Interchange for Manual"
{
    //ApplicationArea = All;
    Caption = 'Outward Interchange for Manual';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Src/Reports/Layouts/OutWard Interchange Report Manual.rdlc';
    dataset
    {

        dataitem("Parent Gatepass"; "Parent Gatepass line")
        {
            RequestFilterFields = "Parent Gatepass No.";

            column(Global_Dimension_1_Code; "Container /Chasis No.")
            { }
            column(Weight; ManifestlineInfo.Weight)
            { }
            column(CBM_Tonage; ManifestlineInfo."CBM Tonage")
            { }
            column(Shortcut_Dimension_5_Code; ManifestlineInfo."Shortcut Dimension 5 Code")
            { }

            column(Text004; Text004)
            { }
            column(CompanyInflogo; CompanyInf.Picture)
            {
            }
            column(CompanyName; CompanyInf.Name)
            {
            }
            column(Parent_Gatepass_No_; "Parent Gatepass No.")
            { }

            column(consignee; "Consignee Name")
            { }
            column(BL_No_; "BL No.")
            { }
            column(InvoicingPartyNo; ManifestlineInfo."Invoicing Party No.") { }

            column(Vessel_Arrival_Date; ManifestlineInfo."Vessel Arrival Date")
            { }
            column(Vessel_Name; ManifestlineInfo."Vessel Name")
            { }
            column(Voyage_No_; ManifestlineInfo."Voyage No.")
            { }
            column(Container__Chasis_No_; "Container /Chasis No.") { }

            column(ContainerStructuralStatus; ReceivingLogInfo."Container Structural Status") { }
            column(Consignee_Name; "Consignee Name") { }
            column(Clearing_Agent_Name; "Clearing Agent Name") { }


            trigger OnAfterGetRecord()
            var
            begin

                parenetgatePassRec.Reset();
                parenetgatePassRec.SetRange("BL No.", "parenetgatePassRec"."BL No.");
                if parenetgatePassRec.FindFirst() then begin
                    ManifestlineInfo.SetRange("BL No.", "Parent Gatepass"."BL No.");
                    if ManifestLineInfo.FindFirst() then;
                    //ManifestHeadInfo.Get(ManifestlineInfo."Job File No.");

                end;
                // ManifestLineinfo.Reset();
                // ManifestLineinfo.SetRange("Global Dimension 1 Code", "Parent Gatepass"."Global Dimension 1 Code");
                // if ManifestLineinfo.FindFirst() then;

                ReceivingLogInfo.Reset();
                ReceivingLogInfo.SetRange("BL No.", "Parent Gatepass"."BL No.");
                if ReceivingLogInfo.FindFirst() then;


            end;

        }


    }

    var
        RePrintedOn: Date;
        PrintedDate: Date;
        CompanyInf: Record "Company Information";
        LoadingSlip: Text;
        ManifestBLNo: Code[20];
        Text004: Label 'Cecilia Juma';
        ManifestlineInfo: Record "Manifest Line";
        //ManifestHeadInfo: Record "Manifest Header";
        parenetgatePassRec: Record "Parent Gatepass";
        GatepassoutInfo: Record "Gate Pass Out";
        ReceivingLogInfo: Record ReceivingLog;


    trigger OnPreReport()
    begin
        CompanyInf.Get();
        CompanyInf.CalcFields(Picture);
    end;
}




