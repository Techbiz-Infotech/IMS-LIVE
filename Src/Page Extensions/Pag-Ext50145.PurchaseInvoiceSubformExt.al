pageextension 50145 PurchaseInvoiceSubformExt extends "Purch. Invoice Subform"
{
    layout
    {
        modify("Shortcut Dimension 1 Code")
        {
            trigger OnAfterValidate()
            var
            begin
                UpdateDimensionFields();

            end;
        }
        addafter(Description)
        {
            field("Description of goods"; rec."Description of goods")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the description of goods';
            }
        }
        // addafter("Shortcut Dimension 1 Code")
        // {
        //     field("KPA Charges"; rec."KPA Charges")
        //     {
        //         ApplicationArea = all;
        //         ToolTip = 'Specifies the KPA charges field';
        //     }
        // }


    }
    procedure UpdateDimensionFields()
    var
        ManifestLine: Record "Manifest Line";
        PurchaseLineSubform: Page "Purch. Invoice Subform";
        PurchaseLine: Record "Purch. Inv. Line";
        ImsSetup: Record "IMS Setup";
    begin
        ImsSetup.Get();
        ManifestLine.Reset();
        ManifestLine.SetRange("Global Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
        if ManifestLine.FindFirst() then begin
            if ImsSetup."KPA Receive Manditory" then
                if not ManifestLine.Received then
                    Error('This container %1 is not received', ManifestLine."Global Dimension 1 Code");
            Rec."Shortcut Dimension 2 Code" := ManifestLine."Global Dimension 2 Code";
            ShortcutDimCode[3] := ManifestLine."Shortcut Dimension 3 Code";
            ShortcutDimCode[4] := ManifestLine."Shortcut Dimension 4 Code";
            ShortcutDimCode[5] := ManifestLine."Shortcut Dimension 5 Code";
            ShortcutDimCode[6] := ManifestLine."Shortcut Dimension 6 Code";
            rec.ValidateShortcutDimCode(2, rec."Shortcut Dimension 2 Code");
            rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
            Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
            Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
            Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);


        end else
            Error('Container %1 could not found', Rec."Shortcut Dimension 1 Code");
    end;
}
