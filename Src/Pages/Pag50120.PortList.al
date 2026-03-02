page 50120 "Port List"
{
    Caption = 'Ports';
    PageType = List;
    SourceTable = Port;
    Editable = false;
    CardPageId = 50119;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Port Code"; Rec."Port Code")
                {
                    ToolTip = 'Specifies the value of the Port Code field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
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
