reportextension 50101 AgedAccountRecExt extends "Aged Accounts Receivable"
{
    dataset
    {
        add(TempCustLedgEntryLoop)
        {
            column(BLNo; TempCustLedgEntry."BL No.") { }
            column(BLCaptionLbl; BLCaptionLbl) { }
        }
        modify(TempCustLedgEntryLoop)
        {
            trigger OnAfterAfterGetRecord()
            begin
                TempCustLedgEntry.calcfields("BL No.");
            end;

        }

    }
    var


        ManifestLineRec: Record "Manifest Line";
        BLCaptionLbl: Label 'BL No.';

}


