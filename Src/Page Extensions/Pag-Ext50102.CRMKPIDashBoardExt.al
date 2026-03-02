pageextension 50102 "CRM KPI Dash Board Ext" extends "Sales & Relationship Mgr. RC"
{
    layout
    {
        addafter(Control1)
        {
            part(CRMKPI; "CRM KPI")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Salesperson - &Commission")
        {
            action("Container Stock Report")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Container Stock Report';
                Image = "Report";
                RunObject = Report "Container Stock";
                ToolTip = '';
            }
            action("Unit Stock Report")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Unit Stock Report';
                Image = "Report";
                RunObject = Report "Units Stock";
                ToolTip = '';
            }
            action("Loose Cargo Stock Report")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Loose Cargo Stock Report';
                Image = "Report";
                RunObject = Report "Loose Cargo Stock";
                ToolTip = '';
            }
            action("Consolidated Stock Report")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Consolidated Stock Report';
                Image = "Report";
                RunObject = Report "Consolidated Stock ";
                ToolTip = '';
            }
            // action("Container Report")
            // {
            //     ApplicationArea = RelationshipMgmt;
            //     Caption = 'Container Report';
            //     Image = "Report";
            //     RunObject = Report "Container-Import";
            //     ToolTip = '';
            // }
            action("Container Received")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Container Received';
                Image = "Report";
                RunObject = Report "Container Received";
                ToolTip = '';
            }
            action("Container Released")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Container Released';
                Image = "Report";
                RunObject = Report "Container Released";
                ToolTip = '';
            }
            // action("Customer Listing")
            // {
            //     ApplicationArea = RelationshipMgmt;
            //     Caption = 'Container Listing';
            //     Image = "Report";
            //     RunObject = Report "Container Released report";
            //     ToolTip = 'View the quantity not yet shipped for each customer in three periods of 30 days each, starting from a selected date. There are also columns with orders to be shipped before and after the three periods and a column with the total order detail for each customer. The report can be used to analyze a company''s expected sales volume.';
            // }
            action("RORO Receieved")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Unit Received';
                Image = "Report";
                RunObject = Report "Unit Received";
                ToolTip = '';
            }
            action("RORO Released")
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Unit Released';
                Image = "Report";
                RunObject = Report "Unit Released";
                ToolTip = '';
            }

        }
    }
}
