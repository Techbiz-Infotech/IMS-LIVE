report 50155 "Manual Gatepass"
{
    //ApplicationArea = All;
    Caption = 'Manual Gatepass';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Src/Reports/Layouts/Manual Gatepass.rdlc';
    dataset
    {
        dataitem(ParentGatepass; "Parent Gatepass line")
        {
            RequestFilterFields = "Parent Gatepass No.";
            column(ParentGatepassNo; "Parent Gatepass No.") { }
            column(BL_No_; "BL No.") { }
            column(InvoicingPartyNo; ManifestLineRec."Invoicing Party No.") { }
            column(ContainerChassisNo; ManifestLineRec."Container/Chassis No.") { }
            column(Weight; ManifestLineRec.Weight) { }
            column(ContainerType; ManifestLineRec."Container Type") { }
            column(VesselName; ManifestLineRec."Vessel Name") { }
            column(VoyageNo; ManifestLineRec."Voyage No.") { }
            column(VesselArrivalDate; ManifestLineRec."Vessel Arrival Date") { }
            column(CompanyLogo; CompanyInfo.Picture) { }
            column(CompanyName; CompanyInfo.Name) { }
            column(PhoneNo; CompanyInfo."Phone No.") { }
            column(Postcode; CompanyInfo."Post Code") { }
            column(text003; text003)
            { }
            column(Description; ManifestLineRec.Description) { }
            column(Consignee_No_; "Consignee No.") { }
            column(ShortcutDimension5Code; ManifestLineRec."Shortcut Dimension 5 Code") { }
            column(CBMTonage; ManifestLineRec."CBM Tonage") { }
            column(Consignee_Name; "Consignee Name") { }


            trigger OnAfterGetRecord()
            begin
                Paregatepassrec.Reset();
                Paregatepassrec.SetRange("Parent Gatepass No.", ParentGatepass."Parent Gatepass No.");
                if Paregatepassrec.FindFirst() then begin
                    ManifestLineRec.SetRange("BL No.", ParentGatepass."BL No.");
                    if ManifestLineRec.FindFirst() then;
                    //if ManifestheadRec.Get("Job File No.") then;
                end;
                ManifestLineRec.Reset();
                ManifestLineRec.SetRange("Global Dimension 1 Code", ParentGatepass."Global Dimension 1 Code");
                if ManifestLineRec.FindFirst() then;


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
        ManifestLineRec: Record "Manifest Line";
        //ManifestheadRec: Record "Manifest Header";
        ReceivingLog: Record ReceivingLog;
        CompanyInfo: Record "Company Information";
        Paregatepassrec: Record "Parent Gatepass";
        text003: Label 'Prepared By';

    trigger OnInitReport()
    begin
        CompanyInfo.get;
        CompanyInfo.CalcFields(Picture)
    end;
}