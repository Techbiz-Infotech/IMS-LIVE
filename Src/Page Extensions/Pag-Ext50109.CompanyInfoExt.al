pageextension 50109 CompanyInfoExt extends "Company Information"
{
    layout
    {
        addlast(Payments)
        {
            Group("Bank Info")
            {
                field("Bank Account Name"; rec."Bank Account Name")
                {
                    caption = 'Bank Account Name';
                    ApplicationArea = All;
                }
                field("LCY Account 1"; Rec."LCY Account 1")
                {
                    Caption = 'LCY Account 1';
                    ApplicationArea = All;
                }
                field("LCY Account 2"; Rec."LCY Account 2")
                {
                    Caption = 'LCY Account 2';
                    ApplicationArea = All;
                }

                field("FCY Account 1"; Rec."FCY Account 1")
                {
                    Caption = 'FCY Account 1';
                    ApplicationArea = All;
                }
                field("FCY Account 2"; Rec."FCY Account 2")
                {
                    Caption = 'FCY Account 2';
                    ApplicationArea = All;
                }
                field("MPESA Account"; Rec."MPESA Account")
                {
                    Caption = 'MPESA Account';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        //addafter("Bank Accounts")
        addbefore("General Ledger Setup")
        {
            action("Test- Do not press")
            {
                Caption = 'Test- Do not touch';
                ApplicationArea = All;
                //AccessByPermission = tabledata "Sales Invoice Line" = rimd;
                AccessByPermission = tabledata "Approval Entry" = rimd;
                trigger OnAction()
                var
                    SalesInvLine: Record "Sales Invoice Line";
                    ApprovalEntry: Record "Approval Entry";
                begin

                    IF UserId <> 'TECHBIZINFOTECH' then
                        Error('you do not have permission');

                    ApprovalEntry.Reset();
                    ApprovalEntry.SetFilter("Due Date", '<%1', 20240101D);
                    ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                    if ApprovalEntry.FindFirst() then
                        repeat
                            ApprovalEntry.Delete();
                        until ApprovalEntry.Next() = 0;
                end;
            }
            action("Test- Do not press1")
            {
                ApplicationArea = All;
                AccessByPermission = tabledata "G/L Entry" = rimd;

                trigger OnAction()
                var
                    GPO: Record "Posted Gate Pass Out";
                    GPOLine: Record "Posted Gate Pass out Line";
                    MFhead: Record "Manifest Header";
                    MFLine: Record "Manifest Line";
                    Dimvalue: Code[20];
                    DimensionSetEntry: Record "Dimension Set Entry";
                    GLEntry: Record "G/L Entry";
                begin
                    IF UserId <> 'TECHBIZINFOTECH' then
                        Error('you do not have permission');
                    // GPO.Reset();
                    // if gpo.FindFirst() then begin
                    //     repeat
                    //         GPOLine.Reset();
                    //         GPOLine.SetRange("Gate Pass No.", GPO."Gate Pass No.");
                    //         if GPOLine.FindFirst() then
                    //             repeat
                    //                 GPOLine."Expired Date" := GPO."Expired Date";
                    //                 GPOLine."Expired Time" := GPO."Expired Time";
                    //                 GPOLine.Modify();
                    //             until GPOLine.Next() = 0;
                    //     until GPO.Next() = 0;
                    // end;
                    // MFhead.Reset();
                    // if MFhead.FindFirst() then
                    //     repeat
                    //         MFLine.Reset();
                    //         MFLine.SetRange("Job File No.", MFhead."Job File No.");
                    //         if MFLine.FindFirst() then
                    //             repeat
                    //                 MFLine."Shipping Agent" := MFhead."Shipping Agent";
                    //                 MFLine."Shipping Agent Name" := MFhead."Shipping Agent Name";
                    //                 MFLine."Vessel Arrival Date" := MFhead."Vessel Arrival Date";
                    //                 MFLine."Last Sling Date" := MFhead."Last Sling Date";
                    //                 MFLine."Expected Arrival Date" := MFhead."Expected Arrival Date";
                    //                 MFLine."Vessel Name" := MFhead."Vessel Name";
                    //                 MFLine."Job File Date" := MFhead."Date File Opened";
                    //                 MFLine."Global Dimension 2 Code" := MFhead."Global Dimension 2 Code";
                    //                 MFLine."Shortcut Dimension 6 Code" := MFhead."Shortcut Dimension 6 Code";
                    //                 MFLine.Modify();
                    //             until MFLine.Next() = 0;
                    //     until MFhead.Next() = 0;
                    GLEntry.Reset();
                    if GLEntry.FindFirst() then
                        repeat
                            if DimensionSetEntry.Get(GLEntry."Dimension Set ID", 'CONTAINER') then begin
                                Dimvalue := DimensionSetEntry."Dimension Value Code";
                                if GLEntry."Global Dimension 1 Code" <> Dimvalue then begin
                                    GLEntry."Global Dimension 1 Code" := Dimvalue;
                                    GLEntry.Modify();
                                end;
                            end;
                        until GLEntry.Next() = 0;

                end;
            }
        }
    }
}
