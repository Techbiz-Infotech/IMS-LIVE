table 50106 Position
{
    Caption = 'Position';
    DataClassification = ToBeClassified;
    LookupPageId = 50115;
    DrillDownPageId = 50115;
    fields
    {
        field(1; " Position ID"; Code[30])
        {
            Caption = ' Position ID';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var

                ImsSetup: Record "IMS Setup";
                NoSeriesMgmt: Codeunit "No. Series";
            begin
                if " Position ID" <> xRec." Position ID" then begin
                    ImsSetup.Get;
                    NoSeriesMgmt.TestManual(ImsSetup."Position Nos");
                    "NO.Series" := '';
                end;
            end;
        }
        field(2; "Position Description"; Text[30])
        {
            Caption = 'Position Description';
            DataClassification = ToBeClassified;
        }
        field(3; Status; Enum PositionStausEnum)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        field(4; "No.Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }

        field(7; "Container No./Chassis No."; code[20])
        {
            Caption = 'Container No./Chassis No.';
            DataClassification = ToBeClassified;
            //Editable = false;

        }
        field(39; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            //Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                UpdateDimensionPosition();
            end;
        }
    }
    keys
    {
        key(PK; " Position ID")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; " Position ID", "Position Description", Status)
        {
        }
    }
    trigger OnInsert()
    var
        ImsSetup: Record "IMS Setup";
        NoSeriesMgt: Codeunit "No. Series";
    begin
        Rec."User ID" := UserId;
        if " Position ID" = '' THEN begin
            ImsSetup.Get;
            ImsSetup.TestField(ImsSetup."Position Nos");
            //NoSeriesMgt.InitSeries(ImsSetup."Position Nos", xRec." Position ID", 0D, " Position ID", "No.Series");
            "No.Series" := ImsSetup."Position Nos";
            if NoSeriesMgt.AreRelated(ImsSetup."Position Nos", xRec."No.Series") then
                "No.Series" := xRec."No.Series";
            " Position ID" := NoSeriesMgt.GetNextNo("No.Series");
        end;
    end;


    procedure AssistEdit(PositionRec: Record Position): Boolean
    var
        PositionRec1: Record Position;
        ImsSetup: Record "IMS Setup";
        NoSeriesMgt: Codeunit "No. Series";
    begin
        PositionRec1 := Rec;
        ImsSetup.GET;
        ImsSetup.TESTFIELD(ImsSetup."Position Nos");
        IF NoSeriesMgt.LookupRelatedNoSeries(ImsSetup."Position Nos", PositionRec."No.Series", "No.Series") THEN BEGIN
            NoSeriesMgt.GetNextNo(" Position ID");
            Rec := PositionRec1;
            EXIT(TRUE);
        END;
    end;


    procedure UpdateDimensionPosition()
    var
        DimValRec: Record "Dimension Value";
        GLSetupRec: Record "General Ledger Setup";
    begin
        GLSetupRec.Get();
        DimValRec.Reset();
        DimValRec.setrange("Dimension Code", GLSetupRec."Global Dimension 1 Code");
        DimValRec.SetRange(code, rec."Global Dimension 1 Code");
        if DimValRec.FindFirst() then begin
            rec."Container No./Chassis No." := DimValRec."Container/Chassis No.";
            DimValRec.Modify();
        end;
    end;
}