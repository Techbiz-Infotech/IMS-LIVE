page 50137 VehicleList
{
    ApplicationArea = All;
    Caption = 'Vehicles';
    PageType = List;
    SourceTable = Vehicle;
    UsageCategory = Lists;
    CardPageId = "Vehicle Card";
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ToolTip = 'Specifies the value of the Vehicle No. field.';
                    ApplicationArea = All;
                }
                field("Vehicle Name"; Rec."Driver Name")
                {
                    ToolTip = 'Specifies the value of the Vehicle Name field.';
                    ApplicationArea = All;
                }
                field(Trailer; Rec.Trailer)
                {
                    ApplicationArea = All;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}

