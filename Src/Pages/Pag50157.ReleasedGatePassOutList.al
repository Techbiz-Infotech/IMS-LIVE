page 50157 "Released Gate Pass Outs"
{
    //ApplicationArea = All;
    Caption = 'Released Gate Pass Outs';
    PageType = List;
    SourceTable = "Posted Gate Pass Out";
    //UsageCategory = Lists;
    CardPageId = 50158;
    Editable = false;
    SourceTableView = where(Released = const(true), "Gate Pass Status" = const(Active));
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
                }
                
                field("Job File No."; Rec."Job File No.")
                {
                    ToolTip = 'Specifies the value of the Job File No. field.';
                    ApplicationArea = All;
                }
                field("BL No."; Rec."BL No.")
                {
                    ToolTip = 'Specifies the value of the BL No. field.';
                    ApplicationArea = All;
                }
                
                
                field("Activity Date"; rec."Activity Date")
                {
                    ToolTip = 'Specifies the value of the Activity Date field.';
                    ApplicationArea = All;
                }
                field("Activity Time"; rec."Activity Time")
                {
                    ToolTip = 'Specifies the value of the Gate Pass Out Time field.';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                
                field("Gate Pass Status"; Rec."Gate Pass Status")
                {
                    ToolTip = 'Specifies the value of the Gate Pass Status field.';
                    ApplicationArea = All;
                }
                
                field(Released; Rec.Released)
                {
                    ToolTip = 'Specifies the value of the Released field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Released Date"; Rec."Released Date")
                {
                    ToolTip = 'Specifies the value of the Released Date field.';
                    ApplicationArea = All;
                }
                field("Released Time"; rec."Released Time")
                {
                    ApplicationArea = all;
                }
                
            }
        }
    }
}
