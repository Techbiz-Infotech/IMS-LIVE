pageextension 50110 "Sales Invoice Ext" extends "Sales Invoice"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Clearing Agent"; rec."Clearing Agent")
            {
                Caption = 'Clearing Agent';
                ApplicationArea = All;
            }
            field("Clearing Agent Name"; rec."Clearing Agent Name")
            {
                Caption = 'Clearing Agent Name';
                ApplicationArea = All;
            }
            field("Proforma No."; Rec."Proforma No.")
            {
                Caption = 'Proforma No.';
                ApplicationArea = All;
                //Editable = false;
            }
        }

    }
    actions
    {
        modify(CopyDocument)
        {
            Visible = false;
        }
        // modify(Post)
        // {
        //     // trigger OnBeforeAction()
        //     // var
        //     //     myInt: Integer;
        //     // begin
        //     //     if Rec."Posting Date" > WorkDate() then
        //     //         Error('Posting date should be %1', WorkDate());
        //     // end;
        // }
        addlast(processing)
        {
            action("IMSCopyDocument")
            {
                ApplicationArea = all;
                Image = Copy;
                Caption = 'Copy Proforma Invoice';
                trigger OnAction()
                begin
                    IMSCopyDocument();
                    if Rec.Get(Rec."Document Type", Rec."No.") then;
                end;
            }
        }
       
    }
    local procedure IMSCopyDocument()
    var
        IMSCopyDoc: Report " IMS Copy Sales Document";
    begin
        IMSCopyDoc.SetSalesHeader(Rec);
        IMSCopyDoc.RunModal();
    end;
}




