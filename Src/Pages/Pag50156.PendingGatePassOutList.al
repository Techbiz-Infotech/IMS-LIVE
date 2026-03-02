page 50156 "Pending Gate Pass List"
{
    Caption = 'Pending Gate Pass Outs old';
    PageType = list;
    SourceTable = "Posted Gate Pass Out";
    CardPageId = 50154;
    SourceTableView = where(Released = const(false));
    //ApplicationArea = all;
    //UsageCategory = Lists;
    Editable = false;
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
                field("Gate Pass Status"; Rec."Gate Pass Status")
                {
                    ApplicationArea = all;
                }

                field(Released; Rec.Released)
                {
                    ToolTip = 'Specifies the value of the Released field.';
                    ApplicationArea = All;
                }

            }
        }
    }

}



