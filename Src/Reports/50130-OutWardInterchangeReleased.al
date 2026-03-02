report 50130 "OutWard Interchange Released"
{
    //ApplicationArea = All;
    Caption = 'OutWard Interchange Released';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Src/Reports/Layouts/OutWard Interchange Report Released.rdlc';
    dataset
    {

        dataitem("Posted Gate Pass out Line"; "Posted Gate Pass out Line")
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
            column(Activity_Date; PostedGatepassoutRec."Activity Date")
            { }
            column(consignee; "Consignee Name")
            { }
            column(BL_No; "BL No.")
            { }
            column(Custom_Entry_No_; "Custom Entry No.")
            { }
            column(Agent_Name; "Agent Name")
            { }
            column(AgentPort_Pass; "Agent Port Pass")
            { }
            column(Vessel_Arrival_Date; ManifestlineInfo."Vessel Arrival Date")
            { }
            column(Vessel_Name; ManifestlineInfo."Vessel Name")
            { }
            column(Voyage_No_; ManifestlineInfo."Voyage No.")
            { }
            column(RePrintedOn; RePrintedOn)
            { }
            column(PrintedDate; PrintedDate)
            { }
            column(Clearing_Agent; GetClearingAgentName(ManifestlineInfo."Clearing Agent"))
            { }
            trigger OnAfterGetRecord()
            var
            begin
                PostedGatePassoutLineRec.Reset();
                PostedGatePassoutLineRec.SetRange("BL No.", "PostedGatepassoutRec"."BL No.");
                IF PostedGatePassoutLineRec.FindFirst() then begin
                    ManifestlineInfo.SetRange("BL No.", "PostedGatepassoutRec"."BL No.");
                    if ManifestLineInfo.FindFirst() then;

                end;
                ManifestLineinfo.Reset();
                ManifestLineinfo.SetRange("Global Dimension 1 Code", "Posted Gate Pass out Line"."Global Dimension 1 Code");
                if ManifestLineinfo.FindFirst() then begin
                   // ManifestHeadInfo.Get(ManifestlineInfo."Job File No.");
                end;


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
        PostedGatePassoutLineRec: Record "Posted Gate Pass out Line";
        PostedGatepassoutRec: Record "Posted Gate Pass Out";

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






