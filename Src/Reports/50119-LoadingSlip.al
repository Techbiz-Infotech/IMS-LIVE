Report 50119 "Loading Slip"
{
    UsageCategory = ReportsAndAnalysis;
    //ApplicationArea = all;
    DefaultLayout = RDLC;
    RDLCLayout = './Src/Reports/Layouts/Loading Slip Report.rdlc';

    dataset
    {
        dataitem("Gate Pass Out Line"; "Gate Pass Out Line")
        {
            DataItemTableView = sorting("Global Dimension 1 Code");
            RequestFilterFields = "Global Dimension 1 Code", "Line No.";
            column(Container__Chasis_No_; "Container /Chasis No.")
            {
            }
            column(Receipt_No_; "Receipt No.")
            { }
            column(Invoice_No_; "Invoice No.")
            { }
            column(Position_ID; "Position ID")
            { }
            column(Truck_No_; "Truck No.")
            { }
            column(Trailer_No_; "Trailer No.")
            { }
            column(Tranporter_Driver_Name; "Tranporter/Driver Name")
            { }
            column(Consignee_Name; "Consignee Name")
            { }


            column(Weight; manifestLineInfo.Weight)
            { }
            column(CBM_Tonage; manifestLineInfo."CBM Tonage")
            { }
            column(Shortcut_Dimension_5_Code; manifestLineInfo."Shortcut Dimension 5 Code")
            { }

            column(Seal_Engine_No_; manifestLineInfo."Seal/Engine No.")
            { }
            column(Global_Dimension_1_Code; "Container /Chasis No.")
            { }

            column(Text004; Text004)
            { }
            column(Agent_Name; "Agent Name")
            { }
            column(Agent_Port_Pass; "Agent Port Pass")
            { }
            column(CompanyInflogo; CompanyInf.Picture)
            {
            }
            column(CompanyName; CompanyInf.Name)
            {
            }
            column(Gate_Pass_No_; "Gate Pass No.")
            { }
            column(BL_No; "BL No")
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
            column(Custom_Entry_No_; "Custom Entry No.")
            { }
            column(CustomEntryDate; CustomEntryDate)
            { }
            column(Clearing_Agent; GetClearingAgentName(manifestLineInfo."Clearing Agent"))
            { }

            trigger OnAfterGetRecord()
            var

            begin

                GatePassoutLineInfo.Reset();

                GatePassoutLineInfo.SetRange("BL No", gatepassoutinfo."BL No.");

                IF GatePassoutLineInfo.FindFirst() then begin

                    manifestlineInfo.SetRange("BL No.", "gatepassoutinfo"."BL No.");

                    if manifestLineInfo.FindFirst() then;
                end;
                manifestLineInfo.Reset();
                ManifestLineinfo.SetRange("Global Dimension 1 Code", "Gate Pass Out Line"."Global Dimension 1 Code");
                if manifestLineInfo.FindFirst() then;
                //manifestheaderInfo.Get(manifestLineInfo."Job File No.");
            end;

        }


    }




    var
        CustomEntryDate: Date;
        RePrintedOn: Date;
        PrintedDate: Date;

        CompanyInf: Record "Company Information";
        LoadingSlip: Text;
        Text004: Label 'Cecilia Juma';
        // manifestheaderInfo: Record "Manifest Header";
        manifestLineInfo: Record "Manifest Line";
        GatePassoutLineInfo: Record "Gate Pass Out Line";
        gatepassoutinfo: Record "Gate Pass Out";


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





