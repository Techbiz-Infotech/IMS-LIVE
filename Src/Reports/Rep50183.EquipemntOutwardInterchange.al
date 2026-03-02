report 50183 EquipemntOutwardInterchange
{
    ApplicationArea = All;
    Caption = 'EquipemntOutwardInterchange';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Src/Reports/Layouts/EquipmentOuterChangechangereport.rdlc';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem("Posted Gate Pass out Line"; "Posted Gate Pass out Line")
        {
            RequestFilterFields = "Global Dimension 1 Code";

            column(Gate_Pass_No_; "Gate Pass No.") { }
            column(NoCpatn; NoCpatn) { }

            column(Container__Chasis_No_; "Container /Chasis No.")
            {
            }
            column(ShortcutDimension5Code; "Shortcut Dimension 5 Code")
            {
            }
            column(Activity_Date; "Activity Date") { }
            column(Activity_Time; "Activity Time") { }
            column(Delivery_Order_No_; "Delivery Order No.")
            {
            }
            column(UserID; "User ID")
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(Clearingagent; ManifestLine."Clearing Agent") { }
            column(ConsigneeName; ManifestLine."Consignee Name") { }
            column(CompanyName; CompanyInfo.Name) { }
            column(CompanyInfoCity; CompanyInfo.City) { }
            column(CompanyInformation; CompanyInfo.Picture) { }
            column(CompanyInformation_Address; CompanyInfo.Address) { }
            column(CompanyInformation_Address2; CompanyInfo."Address 2") { }
            column(CompanyInformation_Postcode; CompanyInfo."Post Code") { }
            column(EmailCptnlbl; EmailCptnlbl) { }
            column(NameCptn; NameCptn) { }
            column(AdditionalCharge; AdditionalCharge.Rate) { }
            column(CompanyInformation_Email; CompanyInfo."E-Mail") { }
            // column(TelCptnlbl; TelCptnlbl) { }
            column(CompanyInformation_Phone; CompanyInfo."Phone No.") { }
            column(DateCptn; DateCptn) { }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(ClerkSigncptn; ClerkSigncptn) { }
            column(TransporterName; "Tranporter/Driver Name")
            {
            }
            column(Trailer_No_; "Trailer No.") { }

            column(VoyageNo; ManifestLine."Voyage No.")
            {

            }
            column(ReprtCptn; ReprtCptn) { }

            column(VesselCptn; VesselCptn) { }
            column(VoyageCptn; VoyageCptn) { }
            column(VesselName; ManifestLine."Vessel Name")
            {
            }
            column(ShippingAgentName; ManifestLine."Shipping Agent Name") { }
            column(ShippingAgentCptn; ShippingAgentCptn) { }
            column(Sizecaption; Sizecaption) { }
            column(Idnocptn; Idnocptn) { }
            column(ContainerNoCaptn; ContainerNoCaptn) { }
            column(DriverNamecptn; DriverNamecptn) { }
            column(VehicleCapt; VehicleCapt) { }
            column(TransporterCptn; TransporterCptn) { }
            column(Remarkscptn; Remarkscptn) { }
            column(Vehiclenocptn; Vehiclenocptn) { }
            column(CompanyNamecptn; CompanyNamecptn) { }
            column(ConatinerIdCptn; ConatinerIdCptn) { }
            trigger OnAfterGetRecord()
            var
            begin
                ManifestLine.Reset();
                ManifestLine.SetRange("Global Dimension 1 Code", "Posted Gate Pass out Line"."Global Dimension 1 Code");
                if ManifestLine.FindFirst() then;
                AdditionalCharge.Reset();
                AdditionalCharge.SetRange("Container ID", ManifestLine."Global Dimension 1 Code");
                if AdditionalCharge.FindFirst() then;
            end;
        }
    }
    var
        ManifestLine: Record "Manifest Line";
        AdditionalCharge: Record "Additional Charges - Receiving";
        ReprtCptn: Label 'EQUIPMENT INSPECTION INTERCHANGE-INWARD';
        CompanyInfo: Record "Company Information";
        VesselCptn: Label 'VESSEL: ';
        VoyageCptn: Label 'Voyage No:';
        Idnocptn: Label 'ID/DRIVING NO.:';
        ShippingAgentCptn: Label 'SHIPPING AGENT: ';
        Sizecaption: Label 'SIZE/TYPE: ';
        VehicleCapt: Label 'VEHICLE';
        NameCptn: Label 'NAME';
        ClerkSigncptn: Label 'SIGNATURE';
        TransporterCptn: Label 'TRANSPORTER: ';
        Remarkscptn: Label 'REMARKS: ';
        DriverNamecptn: Label 'DRIVER NAME:';
        BLNocaptn: Label 'B/L NO.:';
        DateCptn: Label 'DATE:';
        ContainerNoCaptn: Label 'CONTAINER NUMBER:';
        CompanyNamecptn: Label 'Company Name:';
        ConatinerIdCptn: Label 'CONTAINER ID:';
        Vehiclenocptn: Label 'VEHICLE NO.:';
        EmailCptnlbl: Label 'Email:';
        NoCpatn: Label 'No.';
    //TelCptnlbl: Label 'Tel:';

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

}




