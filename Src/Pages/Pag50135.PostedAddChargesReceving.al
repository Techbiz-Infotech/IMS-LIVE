page 50135 "Posted Add. Charges Receving"
{
    //ApplicationArea = All;
    Caption = 'Posted Add. Charges Receving';
    PageType = List;
    SourceTable = "Posted Add. Charges receiving";
    UsageCategory = History;
    
    // Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Receiving Entry No."; Rec."Receiving Entry No.")
                {
                    ToolTip = 'Specifies the value of the Receiving Entry No. field.';
                    ApplicationArea = All;
                }
                field("Container ID"; Rec."Container ID")
                {
                    ToolTip = 'Specifies the value of the Container ID field.';
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                }
                field("Charges Code"; Rec."Charges Code")
                {
                    ToolTip = 'Specifies the value of the Charges Code field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
