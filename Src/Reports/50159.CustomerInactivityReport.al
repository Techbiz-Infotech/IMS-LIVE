report 50159 CustomerInactivityReport
{
    ApplicationArea = All;
    Caption = 'Customer Inactivity';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;
    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            trigger OnPreDataItem()
            begin
                lastDate := CalcDate('-' + Format(FilterInActivedays) + 'D', Today);
                Customer.CalcFields("Last Recieved Date");
                Customer.SetRange("Last Recieved Date", 20000101D, lastDate);
            end;

            trigger OnAfterGetRecord()
            begin
                Customer.CalcFields("Last Recieved Date");
                DaysInactive := Today - Customer."Last Recieved Date";
                MakeBody;
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
                    field(FilterInActivedays; FilterInActivedays)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inactive Days';
                    }
                }
            }
        }

    }
    trigger OnPreReport()
    begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.DELETEALL();
        MakeHeader; //Create Header Part
    end;

    trigger OnPostReport()
    begin
        CreateExcelBook; // Create Excel Book
    end;

    local procedure MakeHeader()
    var
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Customer Inactivity Report', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Customer Name', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Last Manifest Date', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Days Inactive', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);

    end;

    local procedure MakeBody()
    var
        myInt: Integer;
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(Customer.Name, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::text);
        TempExcelBuffer.AddColumn(Customer."Last Recieved Date", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn(DaysInactive, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
    end;

    Local procedure CreateExcelBook();
    begin
        TempExcelBuffer.CreateNewBook('Customer Inactivity Report');
        TempExcelBuffer.WriteSheet('Customer Inactivity Report', CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename('Customer Inactivity Report_' + CompanyName + '_' + Format(CurrentDateTime));
        TempExcelBuffer.OpenExcel();
    end;

    var
        DaysInactive, FilterInActivedays : Integer;
        TempExcelBuffer: Record "Excel Buffer" temporary;
        ManifestLineInfo: Record "Manifest Line";
        lastDate: Date;
        ReceivedDate: Date;
        RecordExist: Boolean;




}
