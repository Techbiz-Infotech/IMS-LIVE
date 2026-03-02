// report 50112 "Docs Flow Report"
// {
//     Caption = 'Docs Flow';
//     //ApplicationArea = all;
//     UsageCategory = ReportsAndAnalysis;
//     ProcessingOnly = true;
//     dataset
//     {
//         dataitem("Manifest Line"; "Manifest Line")
//         {
//             DataItemTableView = sorting("Job File No.", "Line No.");
//             RequestFilterFields = "Global Dimension 1 Code", "Global Dimension 2 Code", "Shortcut Dimension 3 Code", "Shortcut Dimension 4 Code", "Shortcut Dimension 5 Code", "Shortcut Dimension 6 Code";


//             trigger OnAfterGetRecord()
//             begin
//                 ManifestHeaderRec.Reset();
//                 ManifestHeaderRec.SetRange("Job File No.", "Manifest Line"."Job File No.");
//                 if ManifestHeaderRec.FindFirst() then
//                     if not (ManifestHeaderRec."Expected Arrival Date" <= ManifestHeaderRec."Last Sling Date") then
//                         CurrReport.skip;

//                 ReceivingLogRec.Reset();
//                 ReceivingLogRec.SetRange("Global Dimension 1 Code", "Manifest Line"."Global Dimension 1 Code");
//                 if ReceivingLogRec.FindFirst() then
//                     MakeBody();

//             end;

//             trigger OnPreDataItem()
//             begin
//                 IF JobFileNo <> '' then
//                     SetRange("Manifest Line"."Job File No.", JobFileNo);
//             end;
//         }

//     }
//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 group(General)
//                 {
//                     Caption = 'General';
//                     field(JobFileNo; JobFileNo)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Job File No';
//                         trigger OnLookup(var Text: Text): Boolean
//                         var

//                             ManifestHeader: Record "Manifest Header";

//                         begin
//                             IF Page.RunModal(50121, ManifestHeader) = Action::LookupOK then
//                                 JobFileNo := ManifestHeader."Job File No.";
//                         end;

//                     }
//                     field(ToDate; ToDate)
//                     {
//                         ApplicationArea = all;
//                         Caption = 'To Date';

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
//         MakeHeader;
//     end;


//     trigger OnPostReport()
//     begin
//         CreateExcelBook; // Create Excel Book
//     end;

//     var
//         JobFileNo: text[100];
//         ReceivingLogRec: Record ReceivingLog;
//         TempExcelBuffer: Record "Excel Buffer" temporary;
//         ManifestLineRec: Record "Manifest Line";
//         //ManifestHeaderRec: Record "Manifest Header";
//         PostedGatePassOutRec: Record "Posted Gate Pass Out";
//         //ReceivingLogRec : Record ReceivingLog;
//         // ETA: Date;
//         // LastSlingDate: date;
//         ToDate: date;


//     local procedure MakeHeader()
//     var
//         myInt: Integer;
//     begin
//         TempExcelBuffer.NewRow();
//         TempExcelBuffer.AddColumn('DOCS FLOW REPORT', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.NewRow();
//         TempExcelBuffer.AddColumn('ETA Less Than Equal To' + '  ' + Format(ToDate), false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.NewRow();
//         TempExcelBuffer.AddColumn('Voyage No', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Vessel ETA', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('ATA', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Last Sling', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Container/Chassis', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Container/Chassis No', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Contaier/Unit Type', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Description', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Size Type', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Weight', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Voloum/CBM', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Depot Seal No', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Carrier Seal No', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Shipper Seal No', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Customs Seal No', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Shipping Line', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Bill Of Loading', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('B/C/U/V/R', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Docs Rcvd', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('CFS RO Date Rcvd', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('File Number', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Lodged On CAMIS', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('CAMIS Apporval', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('One Step Center', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('KPA/CDO', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Sighted & Rels Dates', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Destuffed ON', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Released From MICD', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('CAMIS Transaction No.', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Remarks', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Guarantee/DO RECVD', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Maersk LPO No.', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Consolidator Rebate Invoice', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Stripping Invoice', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Invoicing Party', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Clearing Name', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Consignee', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);


//     end;

//     procedure MakeBody()
//     var
//         myInt: Integer;
//         ContainerSize: Text;
//         SRNo: Integer;
//     begin
//         TempExcelBuffer.NewRow();
//         TempExcelBuffer.AddColumn(ManifestHeaderRec."Voyage No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn(ManifestHeaderRec."Vessel Arrival Date", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
//         TempExcelBuffer.AddColumn(ManifestHeaderRec."Expected Arrival Date", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
//         TempExcelBuffer.AddColumn(ManifestHeaderRec."Last Sling Date", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
//         TempExcelBuffer.AddColumn("Manifest Line"."Shortcut Dimension 4 Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn("Manifest Line"."Container/Chassis No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn("Manifest Line"."Shortcut Dimension 4 Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn("Manifest Line".Description, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn("Manifest Line"."Shortcut Dimension 5 Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         //TempExcelBuffer.AddColumn("Manifest Line"."Container Type", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn("Manifest Line".Weight, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn("Manifest Line"."CBM Tonage", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn(ReceivingLogRec."Shipper Seal No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn("Manifest Line"."Customs Seal No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn(ManifestHeaderRec."Shipping Agent", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn("Manifest Line"."BL No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn("Manifest Line"."Date Received", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
//         TempExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn("Manifest Line"."Job File No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn("Manifest Line"."Other remarks", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn("Manifest Line"."Invoicing Party No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn("Manifest Line"."Clearing Agent", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn("Manifest Line"."Consignee No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
//     end;

//     Local procedure CreateExcelBook();
//     begin
//         TempExcelBuffer.CreateNewBook('Docs Flow');
//         TempExcelBuffer.WriteSheet('Docs Flow', CompanyName, UserId);
//         TempExcelBuffer.CloseBook();
//         TempExcelBuffer.SetFriendlyFilename('Docs Flow');
//         TempExcelBuffer.OpenExcel();
//     end;
// }  we are not using this report




