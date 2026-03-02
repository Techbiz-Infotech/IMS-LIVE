// report 50140 "Container received Export"
// {
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = All;
//     ProcessingOnly = true;
//     UseRequestPage = true;


//     dataset
//     {
//         dataitem("Manifest Line"; "Manifest Line")
//         {
//             DataItemTableView = SORTING("Job File No.") where("Shortcut Dimension 6 Code" = filter('Export'), Received = const(true));

//             trigger OnPreDataItem()
//             begin
//                 SetRange("Manifest Line"."Date Received", StartDate, EndDate);
//             end;

//             trigger OnAfterGetRecord()
//             begin
//                 //Create Body or Line Part
//                 MakeBody;
//             end;

//         }
//         dataitem(ReceivingLog; ReceivingLog)
//         {

//         }
//         dataitem("Manifest Header"; "Manifest Header")
//         {

//         }
//         dataitem("Gate Pass Out"; "Gate Pass Out")
//         { }

//     }
//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 group(Options)
//                 {
//                     Caption = 'Options';
//                     // field(ContainerID;ContainerID)
//                     // {
//                     //     ApplicationArea = Basic, Suite;
//                     //     Caption = 'ContainerID';
//                     //     TableRelation = Dimension Value;
//                     // }
//                     field(StartDate; StartDate)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Start Date';
//                     }
//                     field(EndDate; EndDate)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'End Date';
//                     }

//                 }
//             }
//         }

//         actions
//         {
//             area(processing)
//             {
//                 action(ActionName)
//                 {
//                     ApplicationArea = All;

//                 }
//             }
//         }

//     }
//     trigger OnPreReport()
//     begin
//         TempExcelBuffer.Reset();
//         TempExcelBuffer.DELETEALL();
//         //IF StartDate = 0D THEN //Validation
//         //ERROR('Start Date must not be blank');//Validation
//         IF EndDate = 0D THEN //Validation
//             ERROR('End Date must not be blank');//Validation
//         MakeHeader; //Create Header Part
//     end;

//     trigger OnPostReport()
//     begin
//         CreateExcelBook; // Create Excel Book
//     end;

//     var
//         SNo: Integer;
//         StartDate: Date;
//         EndDate: Date;
//         CustomerNo: Code[250];
//         TempExcelBuffer: Record "Excel Buffer" temporary;

//     local procedure MakeHeader()
//     var
//         myInt: Integer;

//     begin
//         TempExcelBuffer.NewRow();
//         TempExcelBuffer.AddColumn('Sr.No.', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Nomination Date', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('SHIPPER', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Clearing Agent', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Entry No.', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Vessel/Voyage', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('ETA', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('SHIPPING ORDER NO', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Container Nos.', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Size', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Seal No.', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Weight', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Description of Goods', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('SICD In-Date', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);

//     end;

//     local procedure MakeBody()
//     var
//         myInt: Integer;
//     begin
//         SNo := SNo + 1;
//         TempExcelBuffer.NewRow();
//         TempExcelBuffer.AddColumn(SNo, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn("Manifest Line"."Job File Date", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
//         TempExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn("Manifest Line"."Clearing Agent", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
//         TempExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         "Manifest Header".Reset();
//         "Manifest Header".SetRange("Job File No.", "Manifest Line"."Job File No.");
//         if "Manifest Header".FindFirst() then begin
//             TempExcelBuffer.AddColumn("Manifest Header"."Vessel Name", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
//             TempExcelBuffer.AddColumn("Manifest Header"."Expected Arrival Date", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
//         end;
//         TempExcelBuffer.AddColumn(' ', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn("Manifest Line"."Global Dimension 1 Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn("Manifest Line"."Shortcut Dimension 5 Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
//         ReceivingLog.Reset();
//         ReceivingLog.SetRange("Global Dimension 1 Code", "Manifest Line"."Global Dimension 1 Code");
//         if ReceivingLog.FindFirst() then
//             TempExcelBuffer.AddColumn(ReceivingLog."Shipper Seal No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn("Manifest Line".Weight, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn("Manifest Line".Description, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn("Manifest Line"."SICD In-Date", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::date);

//     end;

//     Local procedure CreateExcelBook();
//     begin
//         TempExcelBuffer.CreateNewBook('Container Receivied Export');
//         TempExcelBuffer.WriteSheet('Container Received Export', CompanyName, UserId);
//         TempExcelBuffer.CloseBook();
//         TempExcelBuffer.SetFriendlyFilename('Container Received Export');
//         TempExcelBuffer.OpenExcel();
//     end;

//     var
//         SICDStorageDays: Integer;


// }