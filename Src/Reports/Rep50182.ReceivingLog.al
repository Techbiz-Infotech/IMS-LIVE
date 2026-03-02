report 50182 "Receiving Log"
{
    //ApplicationArea = All;
    Caption = 'Receiving Log';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Src/Reports/Layouts/Receiving Log.rdlc';
    dataset
    {
        dataitem(ReceivingLog; ReceivingLog)
        {
            RequestFilterFields = "Global Dimension 1 Code";
            column(BLNo; "BL No.")
            {
            }
            column(ContainerNoChassisNo; "Container No./Chassis No.")
            {
            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code") { }
            column(ContainerStructuralStatus; "Container Structural Status")
            {
            }
            column(Entry_No_; "Entry No.") { }
            column(Description; Description)
            {
            }
            column(DriverID; "Driver ID")
            {
            }
            column(DriverName; "Driver Name")
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(ReceivedDate; "Received Date")
            {
            }
            column(Recieived; Recieived)
            {
            }
            column(ReleasingClerkDetails; "Releasing Clerk Details")
            {
            }
            column(SealNo1; "Seal No. 1")
            {
            }
            column(SealNo2; "Seal No. 2")
            {
            }
            column(ShipperSealNo; "Shipper Seal No.")
            {
            }
            column(TimeIn; "Time In")
            {
            }
            column(Transporter; Transporter)
            {
            }
            column(TransporterName; "Transporter Name")
            {
            }
            column(Vehicle; Vehicle)
            {
            }
            column(TruckWagonNo; "Truck /Wagon No.")
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(CompanyName; CompanyInfo.Name) { }
            column(CompanyInfoCity; CompanyInfo.City) { }
            column(CompanyInformation; CompanyInfo.Picture) { }
            column(CompanyInformation_Address; CompanyInfo.Address) { }
            column(CompanyInformation_Address2; CompanyInfo."Address 2") { }
            column(CompanyInformation_Postcode; CompanyInfo."Post Code") { }
            column(EmailCptnlbl; EmailCptnlbl) { }
            column(NameCptn; NameCptn) { }
            column(CompanyInformation_Email; CompanyInfo."E-Mail") { }
            column(TelCptnlbl; TelCptnlbl) { }
            column(CompanyInformation_Phone; CompanyInfo."Phone No.") { }
            column(BLNocaptn; BLNocaptn) { }
            column(DateCptn; DateCptn) { }
            column(Descriptioncptn; Descriptioncptn) { }
            column(ContainerNoCaptn; ContainerNoCaptn) { }
            column(SealCptn; SealCptn) { }
            column(ShippingLineSealcptn; ShippingLineSealcptn) { }
            column(ClientSealcptn; ClientSealcptn) { }
            column(Remarkscptn; Remarkscptn) { }
            column(DriverNamecptn; DriverNamecptn) { }
            column(DriverPortPasscptn; DriverPortPasscptn) { }
            column(ClerkTimeptn; ClerkTimeptn) { }
            column(Signcptn; Signcptn) { }
            column(Idnocptn; Idnocptn) { }
            column(VehiclePortPasscptn; VehiclePortPasscptn) { }
            column(Vehiclenocptn; Vehiclenocptn) { }
            column(CompanyNamecptn; CompanyNamecptn) { }
            column(Deliverdbycptn; Deliverdbycptn) { }
            column(Clerkportpassnocptn; Clerkportpassnocptn) { }
            column(receivedbycptn; receivedbycptn) { }
            column(Text001; Text001) { }
            column(ClerkSigncptn; ClerkSigncptn) { }
            column(Receivedgoodcptn; Receivedgoodcptn) { }
            column(ConatinerIdCptn; ConatinerIdCptn) { }
            column(NoCpatn; NoCpatn) { }
            column(DeliveryNoteCpatn; DeliveryNoteCpatn) { }


        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);

    end;

    var
        CompanyInfo: Record "Company Information";
        DeliveryNoteCpatn: Label ' DELIVERY NOTE';
        NoCpatn: Label 'No.';
        BLNocaptn: Label 'B/L No.:';
        DateCptn: Label 'Date:';
        ContainerNoCaptn: Label 'Container Nos:';
        Descriptioncptn: Label 'Description Of containers/weight:';
        SealCptn: Label 'Seal:';
        ShippingLineSealcptn: Label 'Shipping Line Seal:';
        ClientSealcptn: Label 'Client Seal:';
        Remarkscptn: Label 'Remarks:';
        DriverNamecptn: Label 'Driver Name:';
        NameCptn: Label 'Name';
        DriverPortPasscptn: Label 'Driver Port Pass No.:';
        Signcptn: Label 'Driver Signature:';
        Idnocptn: Label 'I.D No.:';
        CompanyNamecptn: Label 'Company Name:';
        Vehiclenocptn: Label 'Vehicle No.:';
        VehiclePortPasscptn: Label 'Vehicle Port Pass No.:';
        Deliverdbycptn: Label 'Delivered by';
        Clerkportpassnocptn: Label 'Clerk Port Pass No.';
        ClerkSigncptn: Label 'Sign';
        ClerkTimeptn: Label 'Time';
        Receivedgoodcptn: Label 'Received in good order and condition by:';
        receivedbycptn: Label 'Received by';
        Text001: Label 'All Business without exeption,is subject to the conditions overleaf whether we act as agents or otherwise arranagement with third parties are normally may bethe company as agents of the customer ';
        EmailCptnlbl: Label 'Email:';
        TelCptnlbl: Label 'Tel:';
        ConatinerIdCptn: Label 'Container ID:';

}


