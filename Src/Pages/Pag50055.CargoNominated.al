page 50055 "Cargo Nominated"
{
    ApplicationArea = All;
    Caption = 'Cargo Nomination Archive';
    PageType = List;
    SourceTable = "Cargo Nomination";
    UsageCategory = Lists;
    SourceTableView = where(Archived = const(true));
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Cargo Nomination No."; rec."Cargo Nomination No.")
                {
                    ToolTip = 'Specifies the value of the Job File No. field.', Comment = '%';
                    ApplicationArea = All;

                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Job File Date"; Rec."Job File Date")
                {
                    ToolTip = 'Specifies the value of the Job File Date field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Cargo Status"; Rec."Cargo Status")
                {
                    ToolTip = 'Specifies the value of the Cargo Status field.', Comment = '%';
                    ApplicationArea = All;
                }

                field("BL No."; Rec."BL No.")
                {
                    ToolTip = 'Specifies the value of the BL No. field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Container/Chassis No."; Rec."Container/Chassis No.")
                {
                    ToolTip = 'Specifies the value of the Container/Chassis No. field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Seal/Engine No."; Rec."Seal/Engine No.")
                {
                    ToolTip = 'Specifies the value of the Seal/Engine No. field.', Comment = '%';
                    ApplicationArea = All;
                }
                // field("Customs Seal No."; Rec."Customs Seal No.")
                // {
                //     ToolTip = 'Specifies the value of the Customs Seal No. field.', Comment = '%';
                //     ApplicationArea = All;
                // }
                field("Container Id"; rec."Container Id")
                {
                    ToolTip = 'Specifies the value of the Container Id field.', Comment = '%';
                    ApplicationArea = all;
                }
                field("Client Type"; rec."Client Type")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.', Comment = '%';
                    ApplicationArea = all;
                }
                field("Sales Person"; rec."Sales Person")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.', Comment = '%';
                    ApplicationArea = all;
                }
                field("Cargo Type"; rec."Cargo Type")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.', Comment = '%';
                    ApplicationArea = all;
                }
                field("Container size"; rec."Container size")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.', Comment = '%';
                    ApplicationArea = all;
                }
                field("Process Type"; Rec."Process Type")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 6 Code field.', Comment = '%';
                    ApplicationArea = all;
                }


                field("Container Type"; Rec."Container Type")
                {
                    ToolTip = 'Specifies the value of the Container Type field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Container lock"; Rec."Container lock")
                {
                    ToolTip = 'Specifies the value of the Container lock field.', Comment = '%';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("CBM Tonage"; Rec."CBM Tonage")
                {
                    ToolTip = 'Specifies the value of the CBM Tonage field.', Comment = '%';
                    ApplicationArea = All;
                }
                field(Weight; Rec.Weight)
                {
                    ToolTip = 'Specifies the value of the Weight in Tonnes field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("CBM-Wt Difference"; Rec."CBM-Wt Difference")
                {
                    ToolTip = 'Specifies the value of the CBM-Wt Difference field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("No. of Bags"; Rec."No. of Bags")
                {
                    ToolTip = 'Specifies the value of the No. of Bags field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("No. of Bags Released"; Rec."No. of Bags Released")
                {
                    ToolTip = 'Specifies the value of the No. of Bags Released field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Remaining Bags"; Rec."Remaining Bags")
                {
                    ToolTip = 'Specifies the value of the Remaining Bags field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Port of Shipment"; Rec."Port of Shipment")
                {
                    ToolTip = 'Specifies the value of the Port of Shipment field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Port of Discharge"; Rec."Port of Discharge")
                {
                    ToolTip = 'Specifies the value of the Port of Discharge field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Destination Type"; Rec."Destination Type")
                {
                    ToolTip = 'Specifies the value of the Destination Type field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                    ToolTip = 'Specifies the value of the Consignee Name field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Clearing Agent"; Rec."Clearing Agent")
                {
                    ToolTip = 'Specifies the value of the Clearing Agent field.', Comment = '%';
                    ApplicationArea = All;
                }

                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.', Comment = '%';
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Consignee No."; Rec."Consignee No.")
                {
                    ToolTip = 'Specifies the value of the Consignee No. field.', Comment = '%';
                    ApplicationArea = All;
                }

                field("Invoicing Party No."; Rec."Invoicing Party No.")
                {
                    ToolTip = 'Specifies the value of the Invoicing Party No. field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Parent Container ID"; Rec."Parent Container ID")
                {
                    ToolTip = 'Specifies the value of the Parent Container ID field.', Comment = '%';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("TBL/MH"; Rec."TBL/MH")
                {
                    ToolTip = 'Specifies the value of the TBL/MH field.', Comment = '%';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipping Agent"; Rec."Shipping Agent")
                {
                    ToolTip = 'Specifies the value of the Shipping Agent field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Shipping Agent Name"; Rec."Shipping Agent Name")
                {
                    ToolTip = 'Specifies the value of the Shipping Agent Name field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Vessel Name"; Rec."Vessel Name")
                {
                    ToolTip = 'Specifies the value of the Vessel Name field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Voyage No."; Rec."Voyage No.")
                {
                    ToolTip = 'Specifies the value of the Voyage No. field.', Comment = '%';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Expected Arrival Date"; Rec."Expected Arrival Date")
                {
                    ToolTip = 'Specifies the value of the Expected Arrival Date field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Vessel Arrival Date"; Rec."Vessel Arrival Date")
                {
                    ToolTip = 'Specifies the value of the Vessel Arrival Date field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Last Sling Date"; Rec."Last Sling Date")
                {
                    ToolTip = 'Specifies the value of the Last Sling Date field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Cargo Dicharge Date"; rec."Cargo Dicharge Date")
                {
                    ToolTip = 'Specifies the value of the Cargo Dicharge Date field.', Comment = '%';

                    ApplicationArea = all;
                }
                field("Vessel Discharge Date"; rec."Vessel Discharge Date")
                {
                    ToolTip = 'Specifies the value of the Vessel Discharge Date field.', Comment = '%';
                    ApplicationArea = all;
                }
                field("Vessel Arrival Time"; Rec."Vessel Arrival Time")
                {
                    ToolTip = 'Specifies the value of the Vessel Arrival Time field.', Comment = '%';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Marks; Rec.Marks)
                {
                    ToolTip = 'Specifies the value of the Marks field.', Comment = '%';
                    ApplicationArea = All;
                }
                field(Nominated; Rec.Nominated)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies whether the cargo is nominated.', Comment = '%';
                }


            }
        }
    }
}
