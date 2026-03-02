page 50122 "BL List"
{
    ApplicationArea = All;
    Caption = 'BL List';
    PageType = List;
    SourceTable = "Manifest Line";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("BL No."; Rec."BL No.")
                {
                    ToolTip = 'Specifies the value of the BL No. field.';
                    ApplicationArea = All;
                }
                field("Job File No."; Rec."Job File No.")
                {
                    ToolTip = 'Specifies the value of the Job File No. field.';
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
