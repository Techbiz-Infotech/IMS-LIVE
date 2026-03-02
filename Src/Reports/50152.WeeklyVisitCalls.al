report 50152 "Weekly Visit Calls"
{
    //ApplicationArea = All;
    Caption = 'Weekly Visit Calls';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(InteractionLogEntry; "Interaction Log Entry")
        {
            DataItemTableView = sorting("Contact No.");
            trigger OnPreDataItem()
            begin
                SetRange(InteractionLogEntry.Date, FromDate, Todate);
            end;

            trigger OnAfterGetRecord()
            begin
                OpportunityRec.Reset();
                OpportunityRec.SetRange("No.", InteractionLogEntry."Opportunity No.");
                if OpportunityRec.FindFirst() then;

                ContactsRec.Reset();
                ContactsRec.SetRange("No.", OpportunityRec."Contact No.");
                if ContactsRec.FindFirst() then;

                // OpportunityEstimatedRec.Reset();
                // OpportunityEstimatedRec.SetRange("Opportunity No.", InteractionLogEntry."Opportunity No.");
                // OpportunityEstimatedRec.SetRange("Shortcut Dimension 5 Code", '20FT');
                // OpportunityEstimatedRec.SetRange("Shortcut Dimension 4 Code", 'CONTAINER');
                // if OpportunityEstimatedRec.FindFirst() then;
                OpportunityEstimatedRec.Reset();
                OpportunityEstimatedRec.SetRange("Opportunity No.", InteractionLogEntry."Opportunity No.");
                if OpportunityEstimatedRec.FindSet() then;
                MakeBody();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(FromDate; FromDate)
                    {
                        ApplicationArea = all;
                        Caption = 'From Date';
                    }
                    field(ToDate; ToDate)
                    {
                        ApplicationArea = all;
                        Caption = 'To Date';
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnPreReport()
    begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        MakeHeader();
    end;

    trigger OnPostReport()
    begin
        CreateExcelBook();
    end;

    var
        FromDate: Date;
        Todate: Date;
        TempExcelBuffer: Record "Excel Buffer";
        OpportunityRec: Record Opportunity;
        OpportunityEstimatedRec: Record "Opportunity Estimated Quanity";
        ContactsRec: Record Contact;
        T20FTCount: Integer;
         T40FTCount: Integer;

    local procedure MakeHeader()
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Client Visit', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Date', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Client/ Agent Name', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Volume Projection (Monthly)', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Prospective Deal Size (SICD Handling)', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        //TempExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Contact Person', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Phone No.', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Email Address', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Status', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Remarks', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Client Visit', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('DD/MM/YYYY', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('20FT', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('40FT', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('USD', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Name', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Cell Phone', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
    end;

    local procedure MakeBody()
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(InteractionLogEntry."Interaction Template Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(InteractionLogEntry.Date, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
        InteractionLogEntry.CalcFields("Contact Company Name");

        TempExcelBuffer.AddColumn(InteractionLogEntry."Contact Company Name", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
        //if OpportunityEstimatedRec."Shortcut Dimension 5 Code" = '20FT' then
        OpportunityEstimatedRec.Reset();
        OpportunityEstimatedRec.SetRange("Opportunity No.", InteractionLogEntry."Opportunity No.");
        OpportunityEstimatedRec.SetRange("Shortcut Dimension 5 Code", '20FT');
        OpportunityEstimatedRec.SetRange("Shortcut Dimension 4 Code", 'CONTAINER');
        if OpportunityEstimatedRec.FindFirst() then
             T20FTCount:= OpportunityEstimatedRec."Estimated Quantity"
        else
             T20FTCount:= 0;
        TempExcelBuffer.AddColumn( T20FTCount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        // if OpportunityEstimatedRec."Shortcut Dimension 5 Code" = '40FT' then
        OpportunityEstimatedRec.Reset();
        OpportunityEstimatedRec.SetRange("Opportunity No.", InteractionLogEntry."Opportunity No.");
        OpportunityEstimatedRec.SetRange("Shortcut Dimension 5 Code", '40FT');
        OpportunityEstimatedRec.SetRange("Shortcut Dimension 4 Code", 'CONTAINER');
        if OpportunityEstimatedRec.FindFirst() then
            T40FTCount := OpportunityEstimatedRec."Estimated Quantity"
        else
            T40FTCount := 0;
        TempExcelBuffer.AddColumn(T40FTCount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(OpportunityRec."Estimated Value (LCY)", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        InteractionLogEntry.CalcFields("Contact Name");
        TempExcelBuffer.AddColumn(InteractionLogEntry."Contact Name", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
        TempExcelBuffer.AddColumn(InteractionLogEntry."Contact No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(ContactsRec."E-Mail", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(OpportunityRec."Sales Cycle Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        InteractionLogEntry.CalcFields("Interaction Comments");
        TempExcelBuffer.AddColumn(InteractionLogEntry."Interaction Comments", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
    end;

    procedure CreateExcelBook();
    begin
        TempExcelBuffer.CreateNewBook('Weekly Calls Status');
        TempExcelBuffer.WriteSheet('Weekly Calls Status', CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename('Weekly Calls Status');
        TempExcelBuffer.OpenExcel();
    end;
}
