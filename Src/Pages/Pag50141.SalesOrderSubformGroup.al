page 50141 "Sales Order Subform Group"
{
    Caption = 'Proforma Invoice Line Group by Charge';
    PageType = ListPart;
    SourceTable = "Sales Line";
    SourceTableView = WHERE("Document Type" = FILTER(Order));
    SourceTableTemporary = true;
    DelayedInsert = true;
    AutoSplitKey = true;
    MultipleNewLines = true;
    LinksAllowed = false;
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the type of entity that will be posted for this sales line, such as Item, Resource, or G/L Account.';
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the entry of the product to be sold. To add a non-transactional text line, fill in the Description field only.';
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies how many units are being sold.';
                    ApplicationArea = All;
                }
                // field("Unit Price"; Rec."Unit Price")
                // {
                //     ToolTip = 'Specifies the price of one unit of the item or resource. You can enter a price manually or have it entered according to the Price/Profit Calculation field on the related card.';
                //     ApplicationArea = All;
                // }
                field("Line Amount"; Rec."Line Amount")
                {
                    ToolTip = 'Specifies the net amount, excluding any invoice discount amount, that must be paid for products on the line.';
                    ApplicationArea = All;
                }
            }
        }
    }

    procedure SetDocNo(p_DocNo: Code[20])

    begin
        Rec.RESET;
        Rec.DELETEALL;
        g_DocNo := p_DocNo;
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SETRANGE("Document No.", g_DocNo);
        IF SalesLine.FINDSET THEN
            REPEAT
                Rec.RESET;
                Rec.SETRANGE("Document Type", SalesLine."Document Type");
                Rec.SETRANGE("Document No.", SalesLine."Document No.");
                Rec.SETRANGE(Type, SalesLine.Type);
                Rec.SETRANGE("No.", SalesLine."No.");
                IF Rec.FINDSET THEN BEGIN
                    //rec.Description := SalesLine.Description;
                    Rec.Quantity += SalesLine.Quantity;
                    Rec."Line Amount" += SalesLine."Line Amount";
                    Rec.MODIFY;
                END ELSE BEGIN
                    Rec.INIT;
                    Rec."Document Type" := SalesLine."Document Type";
                    Rec."Document No." := SalesLine."Document No.";
                    Rec.Type := SalesLine.Type;
                    Rec."Line No." := SalesLine."Line No.";
                    rec.Description := SalesLine.Description;
                    Rec."No." := SalesLine."No.";
                    Rec.Quantity := SalesLine.Quantity;
                    rec."Unit Price" := SalesLine."Unit Price";
                    Rec."Line Amount" := SalesLine."Line Amount";
                    Rec.INSERT;
                END;
            UNTIL SalesLine.NEXT = 0;
    end;

    var
        SalesLine: Record "Sales Line";
        g_DocNo: code[20];
}
