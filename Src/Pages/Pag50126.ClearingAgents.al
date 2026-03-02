page 50126 "Clearing Agent List"
{
    ApplicationArea = All;
    Caption = 'Clearing Agents';
    PageType = List;
    SourceTable = "Clearing Agent";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Clearing Agent Code"; Rec."Clearing Agent Code")
                {
                    ToolTip = 'Specifies the value of the Clearing Agent Code field.';
                    ApplicationArea = All;
                }
                field("Clearing Agent Name"; Rec."Clearing Agent Name")
                {
                    ToolTip = 'Specifies the value of the Clearing Agent Name field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
