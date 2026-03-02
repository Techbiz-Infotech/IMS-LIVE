pageextension 50113 UserSetupPageExt extends "User Setup"
{
    layout
    {
        addafter("Allow Posting To")
        {
            field(Receiving; Rec.Receiving)
            {
                ApplicationArea = all;
            }
            field("Receiving Log"; Rec."Receiving Log")
            {
                ApplicationArea = All;
            }
            field(Verification; Rec.Verification)
            {
                ApplicationArea = All;
            }
            field("Verification Log"; Rec."Verification Log")
            {
                ApplicationArea = All;
            }
            field("Charge Groups"; Rec."Charge Groups")
            {
                ApplicationArea = All;
            }
            field("Chart of Accounts"; Rec."Chart of Accounts")
            {
                ApplicationArea = All;
            }
            field("Account Schedules"; Rec."Account Schedules")
            {
                ApplicationArea = All;
            }
            field("Gate Pass"; Rec."Gate Pass")
            {
                ApplicationArea = All;
            }
            field(Manifest; Rec.Manifest)
            {
                ApplicationArea = All;
            }
            field(Containers; Rec.Containers)
            {
                ApplicationArea = All;
            }
            field(Item; rec.Item)
            {
                ApplicationArea = All;
            }
            field("General Posting Setup"; Rec."General Posting Setup")
            {
                ApplicationArea = All;
            }
            field(Customer; rec.Customer)
            {
                ApplicationArea = All;
            }
            field(Vendor; rec.Vendor)
            {
                ApplicationArea = All;
            }
            field(Contact; rec.Contact)
            {
                ApplicationArea = All;
            }
            field("Gatepass Approval"; Rec."Gatepass Approval")
            {
                ApplicationArea = All;
            }
            field("Change Customer on PFI"; Rec."Change Customer on PFI")
            {
                ApplicationArea = All;
            }
            field("Container lock Edit"; Rec."Container lock Edit")
            {
                ApplicationArea = All;
            }
            field(Workflow; Rec.Workflow)
            {
                ApplicationArea = All;
            }
            field("Sales Person Edit"; rec."Sales Person Edit")
            {
                ApplicationArea = all;
            }
            field("Verification Log Edit"; rec."Verification Log Edit")
            {
                ApplicationArea = all;
            }
            field("Pending Gate pass Edit"; rec."Pending Gate pass Edit")

            {
                ApplicationArea = all;
            }
            field("Delete Cargo Nomination"; rec."Delete Cargo Nomination")
            {
                ApplicationArea = all;
                ToolTip = 'Allows user to delete cargo nomination records. Please note that deletion of cargo nomination records may impact the integrity of historical data and should be done with caution. It is recommended to consult with your system administrator or support team before enabling this permission.';
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        IF (UserId <> 'GROUP.AUDIT') and (UserId <> 'TECHBIZINFOTECH') then
            error('You are not Authorized to view this area. Please contact Group Audit');
    end;
}
