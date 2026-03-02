report 50120 "Released Gate Pass"
{
    UsageCategory = ReportsAndAnalysis;
    //ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Released GatePass';
    RDLCLayout = './Src/Reports/Layouts/Gate Pass Released.rdlc';


    dataset
    {
        dataitem("Posted Gate Pass out Line"; "Posted Gate Pass out Line")
        {
            DataItemTableView = sorting("Global Dimension 1 Code");
            RequestFilterFields = "Global Dimension 1 Code", "Line No.";
            column(GatePassNumber; "Gate Pass No.")
            {
            }
            column(Date; PostedGatepassOutRec."Activity Date")
            { }
            column(CompanyLogo; CompanyInfo.Picture)
            { }
            column(CompanyName; CompanyInfo.Name)
            { }
            column(PhoneNo; CompanyInfo."Phone No.")
            { }
            column(Postcode; CompanyInfo."Post Code")
            { }
            column(POL; POL)
            { }
            column(printedOn; PrintedOn)
            { }
            column(Allocation; Allocation)
            { }
            column(Rim; Rim)
            { }
            column(Agent; Agent)
            { }

            column(BL_No_; "BL No.")
            { }

            column(Clearing_Agent;GetClearingAgentName(ManifestLineinfo."Clearing Agent"))
            { }

            column(Delivery_Order_No_; "Delivery Order No.")
            { }
            column(Custom_Entry_No_; "Custom Entry No.")
            { }
            column(CustomEntryDate; CustomEntryDate)
            { }
            column(Agent_Port_Pass; "Agent Port Pass")
            { }
            column(Agent_Name; "Agent Name")
            { }
            column(Vessel_Name; ManifestLineinfo."Vessel Name")
            { }
            column(Vessel_Arrival_Date; ManifestLineinfo."Vessel Arrival Date")
            { }
            column(Voyage_No_; ManifestLineinfo."Voyage No.")
            { }
            column(Text001; Text001)
            { }
            column(text002; text002)
            { }
            column(text003; text003)
            { }
            column(text004; text004)
            { }
            column(text005; text005)
            { }
            column(text006; text006)
            { }
            column(BL_No; "BL No.")
            { }
            column(Consignee_Name; "Consignee Name")
            { }
            column(Truck_No_; "Truck No.")
            { }
            column(TrailerNo_; "Trailer No.")
            { }
            column(TranporterDriver_Name; "Tranporter/Driver Name")
            { }
            column(Licence_No; LicenceNo)
            { }
            column(Invoice_No_; "Invoice No.")
            { }
            column(Receipt_No_; "Receipt No.")
            { }
            column(Shortcut_Dimension_5_Code; ManifestLineinfo."Shortcut Dimension 5 Code")
            { }
            column(Container_Type; ManifestLineinfo."Container Type")
            { }
            column(Weight; ManifestLineinfo.Weight)
            { }
            column(CBM_Tonage; ManifestLineinfo."CBM Tonage")
            { }
            column(Description; ManifestLineinfo.Description)
            { }
            column(Global_Dimension_1_Code;"Container /Chasis No.")
            { }
            // trigger OnAfterGetRecord()
            // var
            // begin
            //     PostedGatePassOutLineRec.Reset();
            //     PostedGatePassOutLineRec.SetRange("Gate Pass No.", "Posted Gate Pass out Line"."Gate Pass No.");
            //     IF PostedGatePassOutLineRec.FindFirst() then begin
            //         ManifestlineInfo.SetRange("BL No.", "Posted Gate Pass out Line"."BL No.");
            //         if ManifestLineInfo.FindFirst() then;
            //         ManifestHeadInfo.Get("Job File No.");
            //     end;
            // end;





            trigger OnAfterGetRecord()
            begin
                manifestLineInfo.Reset();
                ManifestLineinfo.SetRange("Global Dimension 1 Code", "Posted Gate Pass Out Line"."Global Dimension 1 Code");
                ManifestLineinfo.SetRange("BL No.", "Posted Gate Pass out Line"."BL No.");
                if manifestLineInfo.FindFirst() then;
                //manifestHeadinfo.Get("Job File No.");
            end;
        }
    }
    var
        ManifestLineinfo: Record "Manifest Line";
       // manifestHeadinfo: Record "Manifest Header";
        myInt: Integer;
        CustomEntryDate: Date;
        Allocation: Decimal;
        Rim: Decimal;
        POL: text;
        LicenceNo: Text;
        Agent: Text;
        PortPassId: text;
        Name: text;
        PrintedOn: DateTime;
        CompanyInfo: Record "Company Information";
        PostedGatepassOutRec: Record "Posted Gate Pass Out";

        PostedGatePassOutLineRec: Record "Posted Gate Pass Out Line";
        Text001: Label 'Gate Pass';
        text002: Label 'Released To';
        text003: Label 'Prepared By';
        text004: Label 'Authorized By';
        text005: Label 'Customs Release';
        text006: Label 'Releasing Officer';

    procedure GetClearingAgentName(ClearingAgent: Code[20]) ClearingAgentName: Text[100]
    var
        ClearingAgentRec: Record "Clearing Agent";

    begin
        IF ClearingAgentRec.get(ClearingAgent) then
            ClearingAgentName := ClearingAgentRec."Clearing Agent Name"
        else
            ClearingAgentName := '';
    end;

    trigger OnInitReport()
    begin
        CompanyInfo.get;
        CompanyInfo.CalcFields(Picture)
    end;
}