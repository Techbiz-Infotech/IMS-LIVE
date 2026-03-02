xmlport 50101 PurchaseLinesImport
{
    Caption = 'PurchaseLinesImport';
    Direction = Import;
    Format = VariableText;
    TableSeparator = '<NewLine>';
    TextEncoding = UTF8;
    UseRequestPage = false;
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(PurchaseLine; "Purchase Line")
            {
                XmlName = 'PurchaseLine';
                fieldelement(No; PurchaseLine."No.")
                {
                }
                fieldelement(DirectUnitCost; PurchaseLine."Direct Unit Cost")
                {
                }
                fieldelement(ShortcutDimension1Code; PurchaseLine."Shortcut Dimension 1 Code")
                {
                }

                trigger OnBeforeInsertRecord()
                var
                    ManifestLine: Record "Manifest Line";
                    PurchHead: Record "Purchase Header";
                    PurchLineRec: Record "Purchase Line";
                begin
                    PurchaseLine."Document Type" := PurchaseLine."Document Type"::Invoice;
                    PurchaseLine."No." := PINo;
                    PurchLineRec.Reset();
                    PurchLineRec.SetRange("Document No.", PurchaseLine."Document No.");
                    IF PurchLineRec.FindLast() then begin
                        PurchaseLine."Line No." := PurchLineRec."Line No." + 10000
                    end Else begin
                        PurchaseLine."Line No." := 10000;
                    end;
                    //PurchaseLine.Type := PurchaseLine.Type::Item;
                    //PurchaseLine.validate("No.");

                End;

                trigger OnAfterInsertRecord()
                var
                    myInt: Integer;
                begin
                    Manifestline.reset;
                    ManifestLine.setrange("Global Dimension 1 Code", PurchaseLine."Shortcut Dimension 1 Code");
                    if ManifestLine.FindFirst() then begin
                        PurchaseLine.validate("Shortcut Dimension 2 Code", ManifestLine."Global Dimension 2 Code");
                    end;
                end;
            }
        }
    }
    var
        LineNo_gInt: Integer;
        PINo: Code[20];
        GLSetup: Record "General Ledger Setup";
        TmpDimSetEntry: Record "Dimension Set Entry" temporary;
        DimValue: Record "Dimension Value";
        DimMgmt: Codeunit DimensionManagement;
        ManifestLine: Record "Manifest Line";


    procedure GetPurchHeadNo(var NewPurchHeadNo: code[20])
    var
        myInt: Integer;
    begin
        PINo := NewPurchHeadNo;
    end;

    procedure GetDimSetID()
    begin
        TmpDimSetEntry.DELETEALL;
        DimValue.GET(GLSetup."Global Dimension 1 Code", ManifestLine."Global Dimension 1 Code");
        TmpDimSetEntry.INIT;
        TmpDimSetEntry.VALIDATE("Dimension Code", GLSetup."Global Dimension 1 Code");
        TmpDimSetEntry.VALIDATE("Dimension Value Code", ManifestLine."Global Dimension 1 Code");
        TmpDimSetEntry.INSERT;

        DimValue.GET(GLSetup."Global Dimension 2 Code", ManifestLine."Global Dimension 2 Code");
        TmpDimSetEntry.INIT;
        TmpDimSetEntry.VALIDATE("Dimension Code", GLSetup."Global Dimension 2 Code");
        TmpDimSetEntry.VALIDATE("Dimension Value Code", ManifestLine."Global Dimension 2 Code");
        TmpDimSetEntry.INSERT;

        DimValue.GET(GLSetup."Shortcut Dimension 3 Code", ManifestLine."Shortcut Dimension 3 Code");
        TmpDimSetEntry.INIT;
        TmpDimSetEntry.VALIDATE("Dimension Code", GLSetup."Shortcut Dimension 3 Code");
        TmpDimSetEntry.VALIDATE("Dimension Value Code", ManifestLine."Shortcut Dimension 3 Code");
        TmpDimSetEntry.INSERT;

        DimValue.GET(GLSetup."Shortcut Dimension 4 Code", ManifestLine."Shortcut Dimension 4 Code");
        TmpDimSetEntry.INIT;
        TmpDimSetEntry.VALIDATE("Dimension Code", GLSetup."Shortcut Dimension 4 Code");
        TmpDimSetEntry.VALIDATE("Dimension Value Code", ManifestLine."Shortcut Dimension 4 Code");
        TmpDimSetEntry.INSERT;

        DimValue.GET(GLSetup."Shortcut Dimension 5 Code", ManifestLine."Shortcut Dimension 5 Code");
        TmpDimSetEntry.INIT;
        TmpDimSetEntry.VALIDATE("Dimension Code", GLSetup."Shortcut Dimension 5 Code");
        TmpDimSetEntry.VALIDATE("Dimension Value Code", ManifestLine."Shortcut Dimension 5 Code");
        TmpDimSetEntry.INSERT;

        DimValue.GET(GLSetup."Shortcut Dimension 6 Code", ManifestLine."Shortcut Dimension 6 Code");
        TmpDimSetEntry.INIT;
        TmpDimSetEntry.VALIDATE("Dimension Code", GLSetup."Shortcut Dimension 6 Code");
        TmpDimSetEntry.VALIDATE("Dimension Value Code", ManifestLine."Shortcut Dimension 6 Code");
        TmpDimSetEntry.INSERT;
        PurchaseLine.validate("Dimension Set ID", DimMgmt.GetDimensionSetID(TmpDimSetEntry));
        PurchaseLine.insert(true);
    end;
}
