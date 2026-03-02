page 50195 Transporters
{
    ApplicationArea = All;
    Caption = 'Transporters';
    PageType = List;
    SourceTable = Transporter;
    UsageCategory = Lists;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Transporter Code"; Rec."Transporter Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transporter Code field.';
                }
                field("Transporter Name"; Rec."Transporter Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transporter Name field.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor Name field.';
                }
            }
        }
    }
}
