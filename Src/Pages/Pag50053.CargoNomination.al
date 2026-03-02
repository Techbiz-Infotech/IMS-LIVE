page 50053 "Cargo Nomination"
{
    ApplicationArea = All;
    Caption = 'Cargo Nomination';
    PageType = List;
    SourceTable = "Cargo Nomination";
    UsageCategory = Lists;
    DelayedInsert = true;
    AutoSplitKey = true;
    InsertAllowed = false;
    //Editable = false;
    //ModifyAllowed = false;
    //DeleteAllowed = false;
    //SourceTableView = sorting("Job File Date") order(descending);
    SourceTableView = where(Archived = const(false), "Cargo Status" = filter(<> Cancelled), Nominated = const(false));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Cargo Nomination No."; rec."Cargo Nomination No.")
                {
                    ToolTip = 'Specifies the value of the Job File No. field.', Comment = '%';
                    ApplicationArea = all;
                    Editable = false;
                    // trigger OnAssistEdit()
                    // var
                    //     myInt: Integer;
                    // begin
                    //     if rec.OnAssistEdit(xRec) then
                    //         CurrPage.Update();
                    // end;

                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                    ApplicationArea = all;
                    Editable = false;

                }
                field("Cargo Status"; rec."Cargo Status")
                {
                    ToolTip = 'Specifies the value of the Cargo Status field.', Comment = '%';
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                    begin

                       CurrPage.Update(false);
                    end;
                }

                field("BL No."; Rec."BL No.")
                {
                    ToolTip = 'Specifies the value of the BL No. field.', Comment = '%';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Container/Chassis No."; Rec."Container/Chassis No.")
                {
                    ToolTip = 'Specifies the value of the Container/Chassis No. field.', Comment = '%';
                    ApplicationArea = all;
                    Editable = false;
                }

                field("Seal/Engine No."; Rec."Seal/Engine No.")
                {
                    ToolTip = 'Specifies the value of the Seal/Engine No. field.', Comment = '%';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Container Id"; rec."Container Id")
                {
                    ToolTip = 'Specifies the value of the Container Id field.', Comment = '%';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Client Type"; rec."Client Type")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.', Comment = '%';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Sales Person"; rec."Sales Person")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.', Comment = '%';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Cargo Type"; rec."Cargo Type")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.', Comment = '%';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Container size"; rec."Container size")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.', Comment = '%';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Process Type"; Rec."Process Type")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 6 Code field.', Comment = '%';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Container Type"; Rec."Container Type")
                {
                    ToolTip = 'Specifies the value of the Container Type field.', Comment = '%';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Container lock"; Rec."Container lock")
                {
                    ToolTip = 'Specifies the value of the Container lock field.', Comment = '%';
                    ApplicationArea = all;
                    Visible = false;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("CBM Tonage"; Rec."CBM Tonage")
                {
                    ToolTip = 'Specifies the value of the CBM Tonage field.', Comment = '%';
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Weight; Rec.Weight)
                {
                    ToolTip = 'Specifies the value of the Weight in Tonnes field.', Comment = '%';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("CBM-Wt Difference"; Rec."CBM-Wt Difference")
                {
                    ToolTip = 'Specifies the value of the CBM-Wt Difference field.', Comment = '%';
                    ApplicationArea = all;
                    Editable = false;
                }





                field("Port of Shipment"; Rec."Port of Shipment")
                {
                    ToolTip = 'Specifies the value of the Port of Shipment field.', Comment = '%';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Port of Discharge"; Rec."Port of Discharge")
                {
                    ToolTip = 'Specifies the value of the Port of Discharge field.', Comment = '%';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Destination Type"; Rec."Destination Type")
                {
                    ToolTip = 'Specifies the value of the Destination Type field.', Comment = '%';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                    ToolTip = 'Specifies the value of the Consignee Name field.', Comment = '%';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Clearing Agent"; Rec."Clearing Agent")
                {
                    ToolTip = 'Specifies the value of the Clearing Agent field.', Comment = '%';
                    ApplicationArea = all;
                    Editable = false;
                }

                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.', Comment = '%';
                    ApplicationArea = all;
                    Visible = false;
                    Editable = false;
                }
                field("Consignee No."; Rec."Consignee No.")
                {
                    ToolTip = 'Specifies the value of the Consignee No. field.', Comment = '%';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Job File Date"; Rec."Job File Date")
                {
                    ToolTip = 'Specifies the value of the Job File Date field.', Comment = '%';
                    ApplicationArea = all;
                    Visible = false;
                    Editable = false;
                }
                field("Invoicing Party No."; Rec."Invoicing Party No.")
                {
                    ToolTip = 'Specifies the value of the Invoicing Party No. field.', Comment = '%';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Parent Container ID"; Rec."Parent Container ID")
                {
                    ToolTip = 'Specifies the value of the Parent Container ID field.', Comment = '%';
                    ApplicationArea = all;
                    // Visible = false;
                    Editable = false;
                }
                field("TBL/MH"; Rec."TBL/MH")
                {
                    ToolTip = 'Specifies the value of the TBL/MH field.', Comment = '%';
                    ApplicationArea = all;
                    //Visible = false;
                    Editable = false;
                }
                field("Shipping Agent"; Rec."Shipping Agent")
                {
                    ToolTip = 'Specifies the value of the Shipping Agent field.', Comment = '%';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Shipping Agent Name"; Rec."Shipping Agent Name")
                {
                    ToolTip = 'Specifies the value of the Shipping Agent Name field.', Comment = '%';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Vessel Name"; Rec."Vessel Name")
                {
                    ToolTip = 'Specifies the value of the Vessel Name field.', Comment = '%';
                    ApplicationArea = all;
                    Editable = false;
                }


                field("Expected Arrival Date"; Rec."Expected Arrival Date")
                {
                    ToolTip = 'Specifies the value of the Expected Arrival Date field.', Comment = '%';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Vessel Arrival Date"; Rec."Vessel Arrival Date")
                {
                    ToolTip = 'Specifies the value of the Vessel Arrival Date field.', Comment = '%';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Cargo Dicharge Date"; rec."Cargo Dicharge Date")
                {
                    ToolTip = 'Specifies the value of the Cargo Dicharge Date field.', Comment = '%';
                    ApplicationArea = all;
                }
                field("Vessel Discharge Date"; Rec."Vessel Discharge Date")
                {
                    ToolTip = 'Specifies the value of the Vessel Discharge Date field.', Comment = '%';
                    ApplicationArea = all;
                }
                field("Last Sling Date"; Rec."Last Sling Date")
                {
                    ToolTip = 'Specifies the value of the Last Sling Date field.', Comment = '%';
                    ApplicationArea = all;
                }

                field(Marks; Rec.Marks)
                {
                    ToolTip = 'Specifies the value of the Marks field.', Comment = '%';
                    ApplicationArea = all;
                    // Editable = RemarksEdiable;
                }
                field("Cancelled Reason"; Rec."Cancelled Reason")
                {
                    ToolTip = 'Specifies the value of the Canceled Reason field.', Comment = '%';
                    ApplicationArea = all;
                    //Visible = false;
                }


            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Create Manifest")
            {
                ApplicationArea = All;
                Caption = 'Create Manifest';
                Image = NewDocument;
                ToolTip = 'Create Manifest';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    CargoNom: Record "Cargo Nomination";
                begin
                    // Rec.Nominated := true;
                    // Rec.Modify();
                    // CargoNom.Reset();
                    //  CurrPage.SetSelectionFilter(CargoNom);
                    // if CargoNom.IsEmpty() then
                    //     Error('Please select at least one line.');
                    Rec.CreatemanifestLines(CargoNom);
                    CurrPage.Update(false);
                    // Message('Selected lines nominated successfully.');
                end;
            }
            action("&Import Worksheet")
            {
                Caption = '&Import Worksheet';
                ApplicationArea = All;
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                //RunObject = page "Import worksheet";
                // RunPageLink = "Job File No." = field("Job File No.");
                trigger OnAction()
                var
                    ImportCargoNominationWS: Page "Import Cargo Nom Worksheet";
                                                 ImporCargotWS: Record "Import Cargo Nomi Worksheet";
                begin
                    //ImportWS.Reset();
                    //ImportWS.SetRange("Job File No.", Rec."Job File No.");
                    Clear(ImportCargoNominationWS);
                    ImportCargoNominationWS.SetTableView(ImporCargotWS);
                    ImportCargoNominationWS.SetRecord(ImporCargotWS);
                    ImportCargoNominationWS.LookupMode(true);
                    //Importworksheet.GetJobfileNo(Rec."Job File No.");
                    if ImportCargoNominationWS.RunModal() = Action::LookupOK then begin
                    end;

                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    var
    begin
        CanceledResonUpdate();
    end;

    trigger OnOpenPage()
    var
    begin
        CanceledResonUpdate();
    end;

    trigger OnAfterGetRecord()
    var
    begin
        CanceledResonUpdate();
    end;

    procedure CanceledResonUpdate()
    var

    begin
        if Rec."Cargo Status" = rec."Cargo Status"::Cancelled then
            RemarksEdiable := false
        else
            RemarksEdiable := true;
    end;

    var
        RemarksEdiable: Boolean;





}
