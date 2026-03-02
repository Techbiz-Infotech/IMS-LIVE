report 50106 "Client Production"
{
    //ApplicationArea = all;
    UsageCategory = Administration;
    ProcessingOnly = true;
    Caption = 'Client Production';
    dataset
    {
        dataitem("Manifest Line"; "Manifest Line")
        {
            DataItemTableView = sorting("Consignee No.") where("Received" = const(true));
            RequestFilterFields = "Consignee No.";
            trigger OnPreDataItem()
            begin

                //mod//
                // if CustomerNo <> '' then
                //     SetRange("Manifest Line"."Consignee No.", CustomerNo);
            end;

            trigger OnAfterGetRecord()

            begin
                MakeBody();
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
                    // Caption = 'Options';
                    // field(CustomerNo; CustomerNo)
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Customer No.';
                    //     TableRelation = Customer;
                    // }

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
        MakeHeader;
    end;

    trigger OnPostReport()
    begin
        CreateExcelBook; // Create Excel Book
    end;

    var

        // CustomerName: text[100];
        //mod//
        CustomerNo: Code[30];
        TempExcelBuffer: Record "Excel Buffer" temporary;
        TotalContainerCount: Integer;
        RecordCount: Integer;
        TEUS: Integer;
        Countof20FT: Integer;
        Countof40FT: Integer;
        ContainerId_gCode20FT: Code[20];
        ContainerId_gCode40FT: Code[20];
        SalesInvoiceLineRec: Record "Sales Invoice Line";

        FromDate: Date;
        ToDate: Date;


    local procedure MakeHeader()
    var
        myInt: Integer;
    begin
        TempExcelBuffer.NewRow();

        TempExcelBuffer.AddColumn('Customer Name', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Sales Person', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('20ft', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('40ft', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Total Container', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('TEUS', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
    end;

    local procedure MakeBody()
    var
        myInt: Integer;
        ContainerSize: Text;
        CustNo: Code[20];
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn("Manifest Line"."Consignee Name", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn("Manifest Line"."Shortcut Dimension 3 Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);

        clear(Countof20FT);

        ContainerId_gCode20FT := '';

        "Manifest Line".Reset();
        "Manifest Line".SetCurrentKey("Global Dimension 1 Code");
        "Manifest Line".SetAscending("Global Dimension 1 Code", true);
        "Manifest Line".SetRange("Consignee No.", CustomerNo);
        "Manifest Line".SetRange(Received, true);
        "Manifest Line".SetRange("Shortcut Dimension 5 Code", '20FT');
        // "Manifest Line".SetRange("Shortcut Dimension 4 Code", 'CONTAINER');
        if "Manifest Line".FindSet() then begin
            repeat
                IF ContainerId_gCode20FT <> "Manifest Line"."Global Dimension 1 Code" then begin
                    //Message('%1', ContainerId_gCode20FT);
                    Countof20FT += 1;
                    ContainerId_gCode20FT := "Manifest Line"."Global Dimension 1 Code";
                end;
            until "Manifest Line".Next() = 0;
        end;



        clear(Countof40FT);
        ContainerId_gCode40FT := '';
        "Manifest Line".Reset();
        "Manifest Line".SetCurrentKey("Global Dimension 1 Code");
        "Manifest Line".SetAscending("Global Dimension 1 Code", true);
        "Manifest Line".SetRange("Consignee No.", CustomerNo);
        "Manifest Line".SetRange(Received, true);
        "Manifest Line".SetRange("Shortcut Dimension 5 Code", '40FT');
        //"Manifest Line".SetRange("Shortcut Dimension 4 Code", 'CONTAINER');
        if "Manifest Line".FindSet() then begin
                repeat
                    IF ContainerId_gCode40FT <> "Manifest Line"."Global Dimension 1 Code" then begin
                    Message('%1', ContainerId_gCode40FT);
                    Countof40FT += 1;
                    ContainerId_gCode40FT := "Manifest Line"."Global Dimension 1 Code";
                end;
            until "Manifest Line".Next() = 0;
        end;


        TempExcelBuffer.AddColumn(Countof20FT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(Countof40FT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(Countof20FT + Countof40FT, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(Countof20FT + (Countof40FT * 2), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
    end;

    Local procedure CreateExcelBook();
    begin
        TempExcelBuffer.CreateNewBook('Client Production');
        TempExcelBuffer.WriteSheet('Client Production', CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename('Client production');
        TempExcelBuffer.OpenExcel();
    end;

    var
        ManifestLineRec: Record "Manifest Line";
}