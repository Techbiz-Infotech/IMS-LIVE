report 50100 DocumentExpirationChecker

{
    Caption = 'DocumentExpirationChecker';
    //UsageCategory = ReportsAndAnalysis;
    //ApplicationArea = All;
    AdditionalSearchTerms = 'DocumentExpirationChecker';
    ProcessingOnly = true;
    UseRequestPage = false;


    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            trigger OnAfterGetRecord()
            begin
                "Sales Header".Reset;
                "Sales Header".SetRange("Document Type", "Sales Header"."Document Type"::Order);
                "Sales Header".SetRange(Closed, false);
                IF "Sales Header".FindFirst() then
                    repeat
                        if ("Sales Header"."Posting Date" < TODAY) or ("Sales Header"."Posting Date" = TODAY) then begin
                            "Sales Header".Closed := true;
                            "Sales Header".Expired := true;
                            "Sales Header"."Expired Date" := Today;
                            "Sales Header"."Expired Time" := time;
                            "Sales Header".Modify();
                        end;
                    until "Sales Header".Next() = 0;
            end;
        }
        dataitem("Posted Gate Pass Out"; "Posted Gate Pass Out")
        {
            trigger OnAfterGetRecord()
            begin
                "Posted Gate Pass Out".Reset;
                "Posted Gate Pass Out".SetRange("Gate Pass Status", "Gate Pass Status"::Active);
                "Posted Gate Pass Out".SetRange(Released, false);
                IF "Posted Gate Pass Out".FindFirst() then begin
                    repeat
                        if ("Posted Gate Pass Out"."Activity Date" < TODAY) or ("Posted Gate Pass Out"."Activity Date" = TODAY) then begin
                            "Posted Gate Pass Out"."Gate Pass Status" := "Posted Gate Pass Out"."Gate Pass Status"::InActive;
                            "Posted Gate Pass Out"."Expired Date" := Today;
                            "Posted Gate Pass Out"."Expired Time" := Time;
                            "Posted Gate Pass Out".Modify();
                            PostedGPOLine.Reset();
                            PostedGPOLine.SetRange("Gate Pass No.", "Posted Gate Pass Out"."Gate Pass No.");
                            PostedGPOLine.SetRange("Gate Pass Status", "Gate Pass Status"::Active);
                            PostedGPOLine.SetRange(Released, false);
                            if PostedGPOLine.FindFirst() then
                                repeat
                                    PostedGPOLine."Gate Pass Status" := PostedGPOLine."Gate Pass Status"::InActive;
                                    PostedGPOLine."Expired Date" := Today;
                                    PostedGPOLine."Expired Time" := Time;
                                    PostedGPOLine.Modify();
                                until PostedGPOLine.Next() = 0;
                        end;
                    until "Posted Gate Pass Out".Next() = 0;
                end;
            end;
        }
        dataitem("Gate Pass Out"; "Gate Pass Out")
        {
            trigger OnAfterGetRecord()
            begin
                "Gate Pass Out".Reset;
                "Gate Pass Out".SetRange("Gate Pass Status", "Gate Pass Status"::Active);
                IF "Gate Pass Out".FindFirst() then begin
                    repeat
                        if ("Gate Pass Out"."Activity Date" < TODAY) or ("Gate Pass Out"."Activity Date" = TODAY) then begin
                            "Gate Pass Out"."Gate Pass Status" := "Gate Pass Out"."Gate Pass Status"::InActive;
                            "Gate Pass Out"."Expired Date" := Today;
                            "Gate Pass Out"."Expired Time" := Time;
                            "Gate Pass Out".Modify();
                            GPOLine.Reset();
                            GPOLine.SetRange("Gate Pass No.", "Gate Pass Out"."Gate Pass No.");
                            GPOLine.SetRange("Gate Pass Status", "Gate Pass Status"::Active);
                            if GPOLine.FindFirst() then
                                repeat
                                    GPOLine."Gate Pass Status" := GPOLine."Gate Pass Status"::InActive;
                                    GPOLine.Modify();
                                until GPOLine.Next() = 0;
                        end;
                    until "Gate Pass Out".Next() = 0;
                end;
            end;
        }
        dataitem(ParentGatepass; "Parent Gatepass")
        {
            trigger OnAfterGetRecord()
            begin
                ParentGatepass.Reset;
                ParentGatepass.SetRange("Parent GatePass Status", ParentGatepass."Parent GatePass Status"::Active);
                IF ParentGatepass.FindFirst() then begin
                    repeat
                        if (ParentGatepass."Activity Date" < TODAY) or (ParentGatepass."Activity Date" = TODAY) then begin
                            ParentGatepass."Parent GatePass Status" := ParentGatepass."Parent GatePass Status"::InActive;
                            ParentGatepass."Expired Date" := Today;
                            ParentGatepass."Expired Time" := Time;
                            ParentGatepass.Modify();
                            ManualGatepassLine.Reset();
                            ManualGatepassLine.SetRange("Parent Gatepass No.", ParentGatepass."Parent Gatepass No.");
                            ManualGatepassLine.SetRange("Parent GatePass Status", "Parent GatePass Status"::Active);
                            if ManualGatepassLine.FindFirst() then
                                repeat
                                    ManualGatepassLine."Parent GatePass Status" := ManualGatepassLine."Parent GatePass Status"::InActive;
                                    ManualGatepassLine.Modify();
                                until ManualGatepassLine.Next() = 0;
                        end;
                    until ParentGatepass.Next() = 0;
                end;
            end;
        }
    }


    var
        PostedGPOLine: Record "Posted Gate Pass out Line";
        GPOLine: Record "Gate Pass out Line";
        ManualGatepassLine: Record "Parent Gatepass Line";
}