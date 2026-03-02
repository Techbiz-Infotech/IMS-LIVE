Report 50127 "Custom Verification Order NICT"
{
    Caption = 'Custom Verification Order-NICT';
    //ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Src/Reports/Layouts/Custom Verification-NICT.RDLC';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(VerificationLog; VerificationLog)
        {
            column(CompanyInflogo; CompanyInf.Picture)
            {
            }
            column(BL_No_; "BL No.")
            { }
            column(Description; Description)
            { }
            column(Allocated_Position; position)
            { }
            column(Consignee_Name; ConsigneeName)
            { }
            column(Wt; Wt)
            { }
            column(CBM; CBM)
            { }
            column(Global_Dimension_1_Code; "Container No./Chassis No.")
            { }
            column(Shortcut_Dimension_5_Code; "Shortcut Dimension 5 Code")
            { }
            column(Shipper_Seal; "Shipper Seal")
            { }
            column(Details; Details)
            { }
            column(CountOfContainer; CountOfContainer)
            { }
            column(ClearingAgent1; ClearingAgent)
            { }
            // dataitem("Manifest Header"; "Manifest Header")
            // {
            //     DataItemLinkReference = VerificationLog;
            //     DataItemLink = "Job File No." = field("Job File No.");

            dataitem("Manifest Line"; "Manifest Line")
            {
                DataItemLinkReference = VerificationLog;
                DataItemLink = "Job File No." = field("Job File No.");
                column(Clearing_Agent; clearingagentname)
                { }
                column(Marks; Marks)
                { }
                column(Vessel_Name; "Vessel Name")
                { }
                column(Expected_Arrival_Date; "Expected Arrival Date")
                { }
                column(No__of_Bags; "No. of Bags")
                { }
                column(CBM_Tonage; "CBM Tonage")
                { }
                column(Weight; Weight)
                { }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin

                end;
            }
            //}

            trigger OnPreDataItem()
            begin
                //SetRange("BL No.", ManifestBLNo);
            end;

            trigger OnAfterGetRecord()
            begin
                // if "Global Dimension 1 Code" <> '' then
                CountOfContainer := CountOfContainer + 1;

                ManifestLine.Reset();
                ManifestLine.SetRange("Global Dimension 1 Code", VerificationLog."Global Dimension 1 Code");
                IF ManifestLine.FindFirst() then begin
                    ClearingAgent := ManifestLine."Clearing Agent";
                    ConsigneeName := "Manifest Line"."Consignee Name";
                    Position := ManifestLine."Allocated Position";
                    CBM := ManifestLine."CBM Tonage";
                    Wt := ManifestLine.Weight;
                end else begin
                    ConsigneeName := '';
                    ClearingAgent := '';
                    Position := '';
                    Wt := 0;
                    CBM := 0;
                end;
                if RecClearingAgent.get(ClearingAgent) then
                    ClearingAgentName := RecClearingAgent."Clearing Agent Name"
                else
                    clearingAgentName := '';

            end;

        }

    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(general)
                {
                    // field(BLNo; ManifestBLNo)
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'BL No';
                    //     trigger OnLookup(var Text: Text): Boolean
                    //     var
                    //         ManifestLine: Record "Manifest Line";

                    //     begin
                    //         if Page.RunModal(50122, ManifestLine) = Action::LookupOK then
                    //             ManifestBLNo := ManifestLine."BL No.";
                    //     end;
                    // }
                }

            }
        }
    }
    var
        Details: code[20];
        CompanyInf: Record "Company Information";
        CountOfContainer: Integer;
        ManifestBLNo: Code[20];
        ManifestLine: Record "Manifest Line";
        ClearingAgent: Code[20];
        RecClearingAgent: Record "Clearing Agent";
        ClearingAgentName: Text[100];
        ConsigneeName: text[100];
        Position: Code[30];
        CBM, Wt : Decimal;


    trigger OnPreReport()
    begin
        CompanyInf.Get();
        CompanyInf.CalcFields(Picture);

    end;
}