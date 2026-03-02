page 50121 "Manifest List"
{
    //ApplicationArea = All;
    Caption = 'Old Manifests';
    PageType = List;
    SourceTable = "Manifest Header";
    SourceTableView = SORTING("Job File No.") ORDER(Descending);
    UsageCategory = Lists;
    CardPageId = 50113;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Job File No."; Rec."Job File No.")
                {
                    ToolTip = 'Specifies the value of the JobFileNumber field.';
                    ApplicationArea = All;
                }
                field("Date File Opened"; Rec."Date File Opened")
                {
                    ToolTip = 'Specifies the value of the DateFileOpened field.';
                    ApplicationArea = All;
                }
                field("Client Type"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the ClientType field.';
                    ApplicationArea = All;
                }
                field("Shipping Agent"; Rec."Shipping Agent")
                {
                    ToolTip = 'Specifies the value of the ShippingAgent field.';
                    ApplicationArea = All;
                }
                field("Shipping Agent Name"; Rec."Shipping Agent Name")
                {
                    ToolTip = 'Specifies the value of the Shipping Agent Name field.';
                    ApplicationArea = All;
                }

                field("Vessel Name"; Rec."Vessel Name")
                {
                    ToolTip = 'Specifies the value of the VesselName field.';
                    ApplicationArea = All;
                }
                field("Vessel Arrival Date"; Rec."Vessel Arrival Date")
                {
                    ToolTip = 'Specifies the value of the VesselArrivalDate field.';
                    ApplicationArea = All;
                }
                field("Voyage No."; Rec."Voyage No.")
                {
                    ToolTip = 'Specifies the value of the VoyageNo field.';
                    ApplicationArea = All;
                }
                field("Expected Arrival Date"; Rec."Expected Arrival Date")
                {
                    ToolTip = 'Specifies the value of the ExpectedArrivalDate field.';
                    ApplicationArea = All;
                }

                field("Last Sling Date"; Rec."Last Sling Date")
                {
                    ToolTip = 'Specifies the value of the LastSlingDate field.';
                    ApplicationArea = All;
                }
                field("User ID"; rec."User ID")
                {

                    ToolTip = 'Specifies the value of the Start After field.';
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
}
