page 50131 "Machine List"
{
    ApplicationArea = All;
    Caption = 'Machines';
    PageType = List;
    SourceTable = Machine;
    UsageCategory = Lists;
    CardPageId = 50130;
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Machine Code"; Rec."Machine Code")
                {
                    ToolTip = 'Specifies the value of the Machine Code field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Machine Serial No."; Rec."Machine Serial No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
