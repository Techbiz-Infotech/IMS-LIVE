Report 50126 "OutWard Interchange Report"
{
    UsageCategory = ReportsAndAnalysis;
    //ApplicationArea = all;
    DefaultLayout = RDLC;
    RDLCLayout = './Src/Reports/Layouts/OutWard Interchange Report.rdlc';
    dataset
    {

        dataitem("Gate Pass Out Line"; "Gate Pass Out Line")
        {
            RequestFilterFields = "Global Dimension 1 Code", "Line No.";
            column(Receipt_No_; "Receipt No.")
            { }
            column(Invoice_No_; "Invoice No.")
            { }
            column(Agent_Port_Pass; "Agent Port Pass")
            { }
            column(Truck_No_; "Truck No.")
            { }
            column(Trailer_No_; "Trailer No.")
            { }
            column(Tranporter_Driver_Name; "Tranporter/Driver Name")
            { }
            column(Global_Dimension_1_Code; "Container /Chasis No.")
            { }
            column(Weight; ManifestlineInfo.Weight)
            { }
            column(CBM_Tonage; ManifestlineInfo."CBM Tonage")
            { }
            column(Shortcut_Dimension_5_Code; ManifestlineInfo."Shortcut Dimension 5 Code")
            { }

            column(Seal_Engine_No_; ManifestlineInfo."Seal/Engine No.")
            { }
            column(Position_ID; "Position ID")
            { }
            column(Text004; Text004)
            { }
            column(CompanyInflogo; CompanyInf.Picture)
            {
            }
            column(CompanyName; CompanyInf.Name)
            {
            }
            column(Gate_Pass_No_; "Gate Pass No.")
            { }
            column(Activity_Date; GatepassoutInfo."Activity Date")
            { }
            column(consignee; "Consignee Name")
            { }
            column(BL_No; "BL No")
            { }
            column(Custom_Entry_No_; "Custom Entry No.")
            { }
            column(Agent_Name; "Agent Name")
            { }
            column(AgentPort_Pass; "Agent Port Pass")
            { }
            column(Vessel_Arrival_Date; ManifestLineinfo."Vessel Arrival Date")
            { }
            column(Vessel_Name; ManifestLineinfo."Vessel Name")
            { }
            column(Voyage_No_; ManifestLineinfo."Voyage No.")
            { }
            column(RePrintedOn; RePrintedOn)
            { }
            column(PrintedDate; PrintedDate)
            { }
            column(Container_Structural_Status; "Container Structural Status") { }
            column(Clearing_Agent; GetClearingAgentName(ManifestlineInfo."Clearing Agent"))
            { }
            trigger OnAfterGetRecord()
            var
            begin
                "Gate Pass Out Line".CalcFields("Container Structural Status");
                GatePassoutLineInfo.Reset();
                GatePassoutLineInfo.SetRange("BL No", "GatepassoutInfo"."BL No.");
                IF GatePassoutLineInfo.FindFirst() then begin
                    ManifestlineInfo.SetRange("BL No.", "GatepassoutInfo"."BL No.");
                    if ManifestLineInfo.FindFirst() then;

                end;
                ManifestLineinfo.Reset();
                ManifestLineinfo.SetRange("Global Dimension 1 Code", "Gate Pass Out Line"."Global Dimension 1 Code");
                if ManifestLineinfo.FindFirst() then;
               // ManifestHeadInfo.Get(ManifestlineInfo."Job File No.");


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
        GatePassoutLineInfo: Record "Gate Pass Out Line";
        GatepassoutInfo: Record "Gate Pass Out";
        ReceivingLogInfo: Record ReceivingLog;

    procedure GetClearingAgentName(ClearingAgent: Code[20]) ClearingAgentName: Text[100]
    var
        ClearingAgentRec: Record "Clearing Agent";

    begin
        IF ClearingAgentRec.get(ClearingAgent) then
            ClearingAgentName := ClearingAgentRec."Clearing Agent Name"
        else
            ClearingAgentName := '';
    end;

    trigger OnPreReport()
    begin
        CompanyInf.Get();
        CompanyInf.CalcFields(Picture);
    end;
}




