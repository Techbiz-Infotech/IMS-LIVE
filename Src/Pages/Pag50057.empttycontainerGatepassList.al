
page 50057 "Empty Container Gatepass List"
{
    ApplicationArea = All;
    Caption = 'Empty Container Gatepass List';
    PageType = List;
    SourceTable = "Gate Pass Out";
    SourceTableView = sorting("Gate Pass No.") where("Gate Pass Status" = filter(Active), "Shortcut Dimension 6 Code" = filter('EMPTY CONTAINER'));
    UsageCategory = Lists;
    CardPageId = "Empty Container Gatepass";
    Editable = false;
    DeleteAllowed = false;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Gate Pass No."; Rec."Gate Pass No.")
                {
                    ToolTip = 'Specifies the value of the Gate Pass No. field.';
                    ApplicationArea = All;
                }
                field("Activity Date"; rec."Activity Date")
                {
                    ApplicationArea = all;
                }
                field("Activity Time"; rec."Activity Time")
                {
                    ToolTip = 'Specifies the value of the Gate Pass Out Time field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ToolTip = 'Specifies the value of the Process Type field.';
                    ApplicationArea = All;
                }
                field("Clearing Agent"; rec."Clearing Agent")
                {
                    ToolTip = 'Specifies the value of the Clearing Agent No. field.';
                    ApplicationArea = All;
                }
                field("Clearing Agent Name"; rec."Clearing Agent Name")
                {
                    ToolTip = 'Specifies the value of the Clearing Agent Name field.';
                    ApplicationArea = All;
                }
                field("Consignee No."; Rec."Consignee No.")
                {
                    ToolTip = 'Specifies the value of the Consignee No. field.';
                    ApplicationArea = All;
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                    ToolTip = 'Specifies the value of the Consignee Name. field.';
                    ApplicationArea = All;
                }

                field("Job File No."; Rec."Job File No.")
                {
                    ToolTip = 'Specifies the value of the Job File No. field.';
                    ApplicationArea = All;
                }
                field(Approved; rec.Approved)
                {
                    ToolTip = 'Specifies the value of the Approved field.';
                    ApplicationArea = All;
                }

            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Approve';
                //Visible = PageEdit;
                trigger OnAction()
                var
                    Usersetup: Record "User Setup";
                    GatepassHead: Record "Gate Pass Out";
                begin
                    if Rec.approved then
                        error('The document is aleady approved');
                    Usersetup.Get(UserId);
                    if not Usersetup."Gatepass Approval" then
                        error('You do not have permission')
                    else begin
                        CurrPage.SetSelectionFilter(GatepassHead);
                        if GatepassHead.FindFirst() then
                            repeat
                                GatepassHead.Approved := true;
                                GatepassHead."Approved By" := UserId;
                                GatepassHead."Approved Date Time" := CurrentDateTime;
                                GatepassHead.Modify();
                            until GatepassHead.Next() = 0;
                        CurrPage.Update();
                    end;
                end;
            }
        }
    }

}



