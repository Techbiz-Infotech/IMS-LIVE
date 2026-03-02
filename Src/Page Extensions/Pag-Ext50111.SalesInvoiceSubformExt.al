pageextension 50111 SalesInvoiceSubformExt extends "Sales Invoice Subform"
{
    layout
    {
        addafter("Shortcut Dimension 1 Code")
        {
            field("BL No."; Rec."BL No.")
            {
                ApplicationArea = All;
                Editable = LineFieldEditable;
            }

            field("Container Type"; Rec."Container Type")
            {
                ApplicationArea = All;
                Editable = LineFieldEditable;
            }
            field("Job File No."; Rec."Job File No.")
            {
                ApplicationArea = All;
                Editable = LineFieldEditable;
            }
            field("Job File Date"; Rec."Job File Date")
            {
                ApplicationArea = All;
                Editable = LineFieldEditable;
            }
            field("Position ID"; Rec."Position ID")
            {
                ApplicationArea = All;
                Editable = LineFieldEditable;
            }
            field("Charge ID"; Rec."Charge ID")
            {
                ApplicationArea = All;
                Editable = LineFieldEditable;
            }
            field("Storage Start Date"; Rec."Storage Start Date")
            {
                ApplicationArea = All;
                Editable = LineFieldEditable;
            }
            field("Free Days"; Rec."Free Days")
            {
                ApplicationArea = All;
                Editable = LineFieldEditable;
            }
            field("Storage Days"; Rec."Storage Days")
            {
                ApplicationArea = All;
                Editable = LineFieldEditable;
            }
            field("Chargable Storage Days"; Rec."Chargable Storage Days")
            {
                ApplicationArea = All;
                Editable = LineFieldEditable;
            }
            field("Reefer Hours"; rEC."Reefer Hours")
            {
                ApplicationArea = All;
                Editable = LineFieldEditable;
            }
            field("Container No./Chassis No."; rec."Container No./Chassis No.")
            {
                ApplicationArea = All;
                Editable = LineFieldEditable;
            }
            field("Clearing Agent"; rec."Clearing Agent")
            {
                ApplicationArea = all;
                Editable = LineFieldEditable;
            }
            field("Clearing Agent Name"; rec."Clearing Agent Name")
            {
                ApplicationArea = all;
                Editable = LineFieldEditable;
            }
            field("Auto Calculated"; Rec."Auto Calculated")
            {
                ApplicationArea = all;
                Editable = LineFieldVisible;
                ToolTip = 'Specifies the Auto calculated charge.';
                Visible = LineFieldVisible;
            }

        }
        modify("Line No.")
        {
            ApplicationArea = All;
            Editable = False;
            Visible = true;
        }
        modify("No.")
        {
            ApplicationArea = All;
            Editable = LineFieldEditable;
        }
        modify(Quantity)
        {
            ApplicationArea = All;
            Editable = LineFieldEditable;
        }
        modify("Unit Price")
        {
            ApplicationArea = All;
            Editable = LineFieldEditable;
        }
        modify("Line Amount")
        {
            ApplicationArea = All;
            Editable = LineFieldEditable;
        }
        modify("Line Discount %")
        {
            ApplicationArea = All;
            Editable = LineFieldEditable;
        }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = All;
            Editable = LineFieldEditable;
        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = All;
            Editable = LineFieldEditable;
        }
        modify(ShortcutDimCode3)
        {
            ApplicationArea = All;
            Editable = LineFieldEditable;
        }
        modify(ShortcutDimCode4)
        {
            ApplicationArea = All;
            Editable = LineFieldEditable;
        }
        modify(ShortcutDimCode5)
        {
            ApplicationArea = All;
            Editable = LineFieldEditable;
        }
        modify(ShortcutDimCode6)
        {
            ApplicationArea = All;
            Editable = LineFieldEditable;
        }

    }
    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        LineVisible();
        LineEditable();
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        LineVisible();
        LineEditable();
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        if Rec."Auto Calculated" then
            error('You can delete the calculated lines');
    end;

    procedure LineEditable()
    begin
        if rec."Auto Calculated" then
            LineFieldEditable := false
        else
            LineFieldEditable := true;
    end;

    procedure LineVisible()
    begin
        if (UserId <> 'GROUP.AUDIT') and (UserId <> 'TECHBIZINFOTECH') then
            LineFieldVisible := false
        else
            LineFieldVisible := true;
    end;

    var
        LineFieldEditable, LineFieldVisible : Boolean;
}


