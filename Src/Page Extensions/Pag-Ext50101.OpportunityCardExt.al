pageextension 50101 "Opportunity Card Ext" extends "Opportunity Card"
{
    layout
    {

        addlast(General)
        {
            field("Shortcut Dimension 4 Code"; rec."Shortcut Dimension 4 Code")
            {
                ApplicationArea = All;
            }

            field(Quantity; Rec.Quantity)
            {
                ApplicationArea = All;
            }
            field("20Ft Container"; Rec."20Ft Container")
            {
                ApplicationArea = All;
            }
            field("40Ft Container"; Rec."40Ft Container")
            {
                ApplicationArea = All;
            }
            field("BL No."; Rec."BL No.")
            {
                ApplicationArea = All;
            }
            field("20Ft Container Manifested"; Rec."20Ft Container Manifested")
            {
                ApplicationArea = All;
            }
            field("40Ft Container Manifested"; Rec."40Ft Container Manifested")
            {
                ApplicationArea = All;
            }
        }
        modify("Segment No.")
        {
            Visible = false;
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Sales Cycle Code")
        {
            ShowMandatory = true;
        }
    }
    actions
    {
        addafter("Oppo&rtunity")
        {
            action("Opportunity Estimated Quantity")
            {
                ApplicationArea = All;
                Caption = 'Opportunity Estimated Quantity';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Opportunity;
                RunObject = page "Opportunity Estimated Quanity";
                RunPageLink = "Opportunity No." = field("No.");
                trigger OnAction()
                begin

                end;
            }
        }
    }
}
