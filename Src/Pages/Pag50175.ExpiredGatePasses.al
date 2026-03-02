page 50175 "Expired Gate Passes"

{
    ApplicationArea = All;
    Caption = 'Expired Gate Passes';
    PageType = List;
    SourceTable = "Gate Pass Out";
    SourceTableView = sorting("Gate Pass No.")  ORDER(Descending) where("Gate Pass Status" = filter(InActive));
    UsageCategory = Lists;
    CardPageId = 50155;
    Editable = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;
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
                field("Activity Date"; rec."Activity Date")
                {
                    ApplicationArea = all;
                }
                field("Activity Time"; rec."Activity Time")
                {
                    ToolTip = 'Specifies the value of the Gate Pass Out Time field.';
                    ApplicationArea = All;
                }
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
                field("Expired Date"; Rec."Expired Date")
                {
                    ToolTip = 'Specifies the value of the Expired Date field.';
                    ApplicationArea = All;
                }
                field("Expired Time"; Rec."Expired Time")
                {
                    ToolTip = 'Specifies the value of the Expired Time field.';
                    ApplicationArea = All;
                }

            }
        }
    }
}

