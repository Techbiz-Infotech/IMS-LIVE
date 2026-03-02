page 50103 "CRM KPI"
{
    ApplicationArea = All;
    Caption = 'CRM KPI';
    PageType = CardPart;
    SourceTable = "CRM KPI Dashboard";
    SourceTableView = sorting("Month No.");
    UsageCategory = Lists;
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Month; Rec.Month)
                {
                    ToolTip = 'Specifies the value of the Month field.';
                    ApplicationArea = All;
                }
                field("No. of Client Visits"; Rec."No. of Client Visits")
                {
                    ToolTip = 'Specifies the value of the No. of Client Visits field.';
                    Caption = 'Client Visits 60 PM';
                    ApplicationArea = All;
                }
                field("No. of Calls/Emails"; Rec."No. of Calls/Emails")
                {
                    ToolTip = 'Specifies the value of the No. of Calls/Emails field.';
                    Caption = 'Calls/Emails 120 PM';
                    ApplicationArea = All;
                }
                field("No. Of Online Presentations"; Rec."No. Of Online Presentations")
                {
                    ToolTip = 'Specifies the value of the No. Of Online Presentations field.';
                    Caption = 'Online Presentations 12 PM';
                    ApplicationArea = All;
                }
                field("No of new clients/prospects"; Rec."No of new clients/prospects")
                {
                    ToolTip = 'Specifies the value of the No of new clients/prospects field.';
                    Caption = 'New Clients/Prospects 40 PM';
                    ApplicationArea = All;
                }
                field("No of containers (TEUs)"; Rec."No of containers (TEUs)")
                {
                    ToolTip = 'Specifies the value of the No of containers (TEUs) field.';
                    Caption = 'Containers (TEUs) 469.5 PM';
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        DateRec: Record Date;
        CurrentYear: Integer;
        FirstDayOfYear: Date;
        LastDayOfYear: Date;
        KPIRec: Record "CRM KPI Dashboard";
    begin


        KPIRec.DeleteAll();

        CurrentYear := DATE2DMY(today, 3);
        FirstDayOfYear := CALCDATE('<-CY>', Today);
        LastDayOfYear := CALCDATE('<CY>', Today);
        DateRec.Reset();
        DateRec.SetRange("Period Type", DateRec."Period Type"::Month);
        DateRec.SetRange("Period Start", FirstDayOfYear, LastDayOfYear);
        if DateRec.FindFirst() then
            repeat
                KPIRec.SetCurrentKey("Month No.");
                KPIRec.Init();
                KPIRec.Year := CurrentYear;
                KPIRec.Month := DateRec."Period Name";
                KPIRec."Month Start" := DateRec."Period Start";
                KPIRec."Month End" := DateRec."Period End";
                KPIRec."Month No." := DateRec."Period No.";
                KPIRec.Insert();
            until DateRec.Next() = 0;
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.SetFilter("Date Filter", '%1..%2', Rec."Month Start", Rec."Month End");
    end;
}
