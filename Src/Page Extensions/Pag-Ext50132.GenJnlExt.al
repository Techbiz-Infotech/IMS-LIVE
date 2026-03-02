pageextension 50132 GenJnlExt extends "General Journal"
{
    layout
    {
        addafter(Description)
        {
            field("IMS Document Type"; Rec."IMS Document Type")
            {
                ApplicationArea = All;
            }
        }
        modify("Document Type")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            trigger OnAfterValidate()
            var
            begin
                UpdateDimensionFields();

            end;
        }
        modify("Account Type")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
                UserSetup: Record "User Setup";
            begin
                if Rec."Account Type" = Rec."Account Type"::Customer then begin
                    UserSetup.Get(UserId);
                    if not UserSetup."General Posting Setup" then
                        Error('You can not select Vendor/Customer. Please contact Audit');
                end;
                if Rec."Account Type" = Rec."Account Type"::Vendor then begin
                    UserSetup.Get(UserId);
                    if not UserSetup."General Posting Setup" then
                        Error('You can not select Vendor/Customer. Please contact Audit');
                end;

            end;
        }
        modify("Bal. Account Type")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
                UserSetup: Record "User Setup";
            begin
                if Rec."Bal. Account Type" = Rec."Bal. Account Type"::Customer then begin
                    UserSetup.Get(UserId);
                    if not UserSetup."General Posting Setup" then
                        Error('You can not select Vendor/Customer. Please contact Audit');
                end;
                if Rec."Bal. Account Type" = Rec."Bal. Account Type"::Vendor then begin
                    UserSetup.Get(UserId);
                    if not UserSetup."General Posting Setup" then
                        Error('You can not select Vendor/Customer. Please contact Audit');
                end;

            end;
        }
    }
    procedure UpdateDimensionFields()
    var
        ManifestLine: Record "Manifest Line";
        ImsSetup: Record "IMS Setup";
    begin
        ImsSetup.Get();
        ManifestLine.Reset();
        ManifestLine.SetRange("Global Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
        if ManifestLine.FindFirst() then begin
            if ImsSetup."KPA Receive Manditory" then
                if not ManifestLine.Received then
                    Error('This container %1 is not received', Rec."Shortcut Dimension 1 Code");
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
