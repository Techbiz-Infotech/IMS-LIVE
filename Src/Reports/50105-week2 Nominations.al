report 50105 "Week 2 Nominations"
{
    UsageCategory = ReportsAndAnalysis;
    //ApplicationArea = All;
    ProcessingOnly = true;
    UseRequestPage = true;


    dataset
    {
        dataitem("Manifest Line"; "Manifest Line")
        {
            DataItemTableView = SORTING("Job File No.") where(Received = const(true));

            trigger OnPreDataItem()
            begin
                SetRange("Manifest Line"."Date Received", StartDate, EndDate);
            end;

            trigger OnAfterGetRecord()
            begin
                //Create Body or Line Part
                MakeBody;
            end;

        }

    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    // field(ContainerID;ContainerID)
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'ContainerID';
                    //     TableRelation = Dimension Value;
                    // }
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Start Date';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'End Date';
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
        TempExcelBuffer.DELETEALL();
        IF StartDate = 0D THEN //Validation
            ERROR('Start Date must not be blank');//Validation
        IF EndDate = 0D THEN //Validation
            ERROR('End Date must not be blank');//Validation
        MakeHeader; //Create Header Part
    end;

    trigger OnPostReport()
    begin

        CreateExcelBook; // Create Excel Book
    end;

    var
        SNo: Integer;
        StartDate: Date;
        EndDate: Date;
        CustomerNo: Code[250];
        TempExcelBuffer: Record "Excel Buffer" temporary;
        RecordCount: Integer;
        TCount: Integer;


    local procedure MakeHeader()
    var
        myInt: Integer;

    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Sr.No.', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Nomination Received Date', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Client Name', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('BL No.', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Count of 20FT', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Count of 40FT', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Total Container', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Total TEU', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        // TempExcelBuffer.NewRow();
        // TempExcelBuffer.AddColumn('Weekly Totals', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
    end;

    local procedure MakeBody()
    var
        myInt: Integer;
    begin
        SNo := SNo + 1;
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(SNo, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn("Manifest Line"."Date Received", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn("Manifest Line"."Consignee Name", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Manifest Line"."BL No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TCount := 0;
        if "Manifest Line"."Shortcut Dimension 5 Code" = '20FT' then begin
            TCount := TCount + 1;
            TempExcelBuffer.AddColumn(TCount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        end
        else
            if (not ("manifest Line"."Shortcut Dimension 5 Code" = '20ft')) and ("Manifest Line"."Shortcut Dimension 5 Code" = '40FT') then
                TempExcelBuffer.AddColumn('0', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);

        if "Manifest Line"."Shortcut Dimension 5 Code" = '40FT' then begin
            TCount := TCount + 1;
            TempExcelBuffer.AddColumn(TCount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        end else
            if not ("Manifest Line"."Shortcut Dimension 5 Code" = '40FT') and ("Manifest Line"."Shortcut Dimension 5 Code" = '20FT') then
                TempExcelBuffer.AddColumn('0', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(TCount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        if "Manifest Line"."Shortcut Dimension 5 Code" = '20FT' then
            TempExcelBuffer.AddColumn(TCount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number)
        else
            TempExcelBuffer.AddColumn(TCount * 2, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
    end;



    Local procedure CreateExcelBook();
    begin
        TempExcelBuffer.CreateNewBook('Weekly Nomination');
        TempExcelBuffer.WriteSheet('Weekly Nomination', CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename('Weekly Nominations');
        TempExcelBuffer.OpenExcel();
    end;

    var
        TotalDays: Integer;


}