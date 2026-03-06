page 50139 "IMS Setup"
{
    ApplicationArea = All;
    Caption = 'IMS Setup';
    PageType = Card;
    SourceTable = "IMS Setup";
    UsageCategory = Administration;
    RefreshOnActivate = true;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Job File No."; Rec."Job File Nos")
                {
                    ToolTip = 'Specifies the value of the Job File No. field.';
                    ApplicationArea = All;
                }
                field("Cargo Job File No."; rec."Cargo Job File No.")
                {
                    ApplicationArea = all;
                }
                field("Verification No."; Rec."Verification Nos")
                {
                    ToolTip = 'Specifies the value of the Verification No. field.';
                    ApplicationArea = All;
                }
                field("Position ID"; Rec."Position Nos")
                {
                    ToolTip = 'Specifies the value of the Position ID field.';
                    ApplicationArea = All;
                }
                field("Yard Allocation No."; Rec."Yard Allocation Nos")
                {
                    ToolTip = 'Specifies the value of the Yard Allocation No. field.';
                    ApplicationArea = All;
                }
                field("Postion Movement No."; Rec."Postion Movement Nos")
                {
                    ToolTip = 'Specifies the value of the Postion Movement No. field.';
                    ApplicationArea = All;
                }
                field("Out Gate Pass No."; Rec."Out Gate Pass Nos")
                {
                    ToolTip = 'Specifies the value of the Out Gate Pass No. field.';
                    ApplicationArea = All;
                }
                field("Machine No."; Rec."Machine Nos")
                {
                    ToolTip = 'Specifies the value of the Machine No. field.';
                    ApplicationArea = All;
                }
                field("Machine Operator No."; Rec."Machine Operator Nos")
                {
                    ToolTip = 'Specifies the value of the Machine Operator No. field.';
                    ApplicationArea = All;
                }
                field("Vessel No."; Rec."Vessel Nos")
                {
                    ToolTip = 'Specifies the value of the Vessel No. field.';
                    ApplicationArea = All;
                }
                field("Vehicle No."; Rec."Vehicle Nos")
                {
                    ToolTip = 'Specifies the value of the Vehicle No. field.';
                    ApplicationArea = All;
                }
                field("Port Nos"; Rec."Port Nos")
                {
                    ApplicationArea = All;
                }
                field("Cancel Gatepass Nos"; Rec."Cancel Gatepass Nos")
                {
                    ToolTip = 'Specifies the value of the Cancel Gatepass No. field.';
                    ApplicationArea = All;
                }
                field("Parent Gatepass Nos"; Rec."Parent Gatepass Nos")
                {
                    ToolTip = 'Specifies the value of the Cancel Gatepass No. field.';
                    ApplicationArea = All;
                }
            }
            group("IMS Defaults Values")
            {
                field("Skip KPA Charges on Invoice"; Rec."Skip KPA Charges on Invoice")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Skip KPA Charges on Invoice field.';
                }
                field("Minimum Standard Charges"; Rec."Minimum Standard Charges")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Minimum Standard Charges field.';
                }
                field("Purchase Prepayment From"; Rec."Purchase Prepayment From")
                {
                    ApplicationArea = All;
                }
                field("Purchase Prepayment To"; Rec."Purchase Prepayment To")
                {
                    ApplicationArea = All;
                }
                field("Purchase Prepayment Wharfage"; Rec."Purchase Prepayment Wharfage")
                {
                    ApplicationArea = All;
                }
                field("Purchase Prepayment Transport"; Rec."Purchase Prepayment Transport")
                {
                    ApplicationArea = All;
                }
                field("Charge ID 20FT Verification"; Rec."Charge ID 20FT Verification")
                {
                    ApplicationArea = All;
                }
                field("Charge ID 40FT Verification"; Rec."Charge ID 40FT Verification")
                {
                    ApplicationArea = All;
                }
                field("Charge ID for Stripping"; Rec."Charge ID for Stripping")
                {
                    ApplicationArea = All;
                }
                field("Default HS Code"; Rec."Default HS Code")
                {
                    Caption = 'Default HS Code for Exempt';
                    ApplicationArea = All;
                }
                field("Default HS Code Zero rated"; Rec."Default HS Code Zero rated")
                {
                    ApplicationArea = All;
                }
                field("Default Charge ID Reefer"; Rec."Default Charge ID Reefer")
                {
                    ApplicationArea = All;
                }
                field("Category Code for Transport"; Rec."Category Code for Transport")
                {
                    ApplicationArea = All;
                }
                field("Category Code for Storage"; Rec."Category Code for Storage")
                {
                    ApplicationArea = All;
                }
                field("Category Code for CFS Handling"; Rec."Category Code for CFS Handling")
                {
                    ApplicationArea = All;
                }
                field("Category for Shorehandling"; Rec."Category for Shorehandling")
                {
                    ApplicationArea = All;
                }
                field("Category Code for Rebate"; rec."Category Code for Rebate")
                {
                    ApplicationArea = all;
                }
                field("Category Code Wharfage"; rec."Category Code Wharfage")
                {
                    ApplicationArea = all;

                }
                field("Category Code for IMCO"; rec."Category Code for IMCO")
                {
                    ApplicationArea = all;

                }
                field("Category Code forIMCO MSA TOLL"; rec."Category Code forIMCO MSA TOLL")
                {
                    ApplicationArea = all;

                }
                field("Category Code for TOLL"; rec."Category Code for TOLL")
                {
                    ApplicationArea = all;
                }
                field("20FT Full Verification Rate"; Rec."20FT Full Verification Rate")
                {
                    ApplicationArea = All;
                }
                field("40FT Full Verification Rate"; Rec."40FT Full Verification Rate")
                {
                    ApplicationArea = All;
                }
                field("Partial Verification Rate"; Rec."Partial Verification Rate")
                {
                    Caption = '20FT Partial Verification Rate';
                    ApplicationArea = All;
                }
                field("40FT Partial Verification Rate"; Rec."40FT Partial Verification Rate")
                {
                    ApplicationArea = All;
                }
                field("Sighting Verification Rate"; rec."Sighting Verification Rate")
                {
                    ApplicationArea = All;
                }
                field(Position; rec.Position)
                {
                    ApplicationArea = all;
                }
                field("KPA Receive Manditory"; Rec."KPA Receive Manditory")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the name of KPA Receive Manditory';
                }

            }
        }

    }
    actions
    {
        area(Processing)
        {
            action("Manifest Line Field Security")
            {
                Caption = 'Manifest Line Field Security';
                ApplicationArea = All;
                RunObject = page "Field Edit Permission List";
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        IF (UserId <> 'GROUP.AUDIT') and (UserId <> 'TECHBIZINFOTECH') and (UserId <> 'SHILLAH') then
            error('You are not Authorized to view this area. Please contact Group Audit');
    end;

}
