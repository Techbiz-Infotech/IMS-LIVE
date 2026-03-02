page 50208 "Expired posted gatepass"

{
    ApplicationArea = All;
    Caption = 'Expired pending Gate Passes';
    PageType = List;
    SourceTable = "Posted Gate Pass out Line";
    SourceTableView = sorting("Expired Date")  ORDER(Descending) where("Gate Pass Status" = filter(InActive));
    UsageCategory = Lists;

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
                field("Container /Chasis No."; Rec."Container /Chasis No.")
                {
                    ToolTip = 'Specifies the value of the Container No. field.';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Container ID field.';
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


