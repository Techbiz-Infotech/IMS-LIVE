page 50166 "Released Gate Pass Out Subform"
{
    Caption = 'Released Posted Gate Pass Out Lines';
    PageType = ListPart;
    SourceTable = "Posted Gate Pass out Line";
    DelayedInsert = true;
    AutoSplitKey = true;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Gate Pass No."; Rec."Gate Pass No.")
                {
                    ToolTip = 'Specifies the value of the Gate Pass No. field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                    ApplicationArea = All;
                }
                field("Container /Chasis No."; Rec."Container /Chasis No.")
                {
                    ToolTip = 'Specifies the value of the Container /Chasis No. field.';
                    ApplicationArea = All;
                }
                field("Job File No."; rec."Job File No.")
                {
                    ApplicationArea = all;
                }
                field("BL No."; rec."BL No.")
                {
                    ApplicationArea = all;
                }

                field("Position ID"; Rec."Position ID")
                {
                    ToolTip = 'Specifies the value of the Position ID field.';
                    ApplicationArea = All;
                }
                field("Consignee No."; Rec."Consignee No.")
                {
                    ToolTip = 'Specifies the value of the Consignee No. field.';
                    ApplicationArea = All;
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                    ToolTip = 'Specifies the value of the Consignee Name field.';
                    ApplicationArea = All;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ToolTip = 'Specifies the value of the Invoice No. field.';

                    ApplicationArea = All;
                }
                field("Invoice Date"; Rec."Invoice Date")
                {
                    ToolTip = 'Specifies the value of the Invoice Date field.';
                    ApplicationArea = All;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ToolTip = 'Specifies the value of the Receipt No. field.';
                    ApplicationArea = All;
                }
                field("No. Of Bags"; Rec."No. Of Bags")
                {
                    ToolTip = 'Specifies the value of the No. Of Bags field.';
                    ApplicationArea = All;
                }
                field("Truck No."; Rec."Truck No.")
                {
                    ToolTip = 'Specifies the value of the Truck No. field.';
                    ApplicationArea = All;
                }
                field("Agent Name"; Rec."Agent Name")
                {
                    ToolTip = 'Specifies the value of the Agent Name field.';
                    ApplicationArea = All;
                }
                field("Agent Port Pass"; Rec."Agent Port Pass")
                {
                    ToolTip = 'Specifies the value of the Agent Port Pass field.';
                    ApplicationArea = All;
                }
                field("Tranporter/Driver Name"; Rec."Tranporter/Driver Name")
                {
                    ToolTip = 'Specifies the value of the Tranporter/Driver Name field.';
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                    ApplicationArea = All;
                }
                field("Trailer No."; Rec."Trailer No.")
                {
                    ToolTip = 'Specifies the value of the Trailer No. field.';
                    ApplicationArea = All;
                }
                field(Released; rec.Released)
                {
                    ToolTip = 'Specifies the value of the Trailer No. field.';
                    ApplicationArea = All;
                }
                field("Released Date"; rec."Released Date")
                {
                    ToolTip = 'Specifies the value of the Trailer No. field.';
                    ApplicationArea = All;
                }
                field("DO No. Expiry date"; rec."DO No. Expiry date")
                {
                    ToolTip = 'Specifies the value of the DO No. Expiry date field.';
                    ApplicationArea = All;
                }

            }
        }
    }
}
