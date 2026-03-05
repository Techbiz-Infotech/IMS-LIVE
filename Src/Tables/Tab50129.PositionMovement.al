table 50129 "Position Movement"
{
    Caption = 'Position Movement';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Position Movement No."; Code[20])
        {
            Caption = 'Position Movement No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var

                ImsSetup: Record "IMS Setup";
                NoSeriesMgmt: Codeunit "No. Series";
            begin
                if "Position Movement No." <> xRec."Position Movement No." then begin
                    ImsSetup.Get;
                    NoSeriesMgmt.TestManual(ImsSetup."Postion Movement Nos");
                    "NO.Series" := '';
                end;
            end;
        }
        field(2; "Container No./Chassis No."; Code[20])
        {
            Caption = 'Container No./Chassis No.';
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(3; "Position From"; Code[20])
        {
            Caption = 'Position From';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Position." Position ID" where(Status = const(Allocated));
        }
        field(4; "Position To"; Code[20])
        {
            Caption = 'Position To';
            DataClassification = ToBeClassified;
            TableRelation = Position." Position ID" where(Status = const(Open));
        }
        field(5; Machine; Code[20])
        {
            Caption = 'Machine';
            DataClassification = ToBeClassified;
            TableRelation = Machine;
        }
        field(6; "Machine Operator"; Code[20])
        {
            Caption = 'Machine Operator';
            DataClassification = ToBeClassified;
            TableRelation = "Machine Operator";
        }
        field(7; "Movement Date"; Date)
        {
            Caption = 'Movement Date';
            DataClassification = ToBeClassified;
        }
        field(8; "Movement Time"; Time)
        {
            Caption = 'Movement Time';
            DataClassification = ToBeClassified;
        }
        field(9; "No.Series"; Code[30])
        {
            Caption = 'No.series';
            DataClassification = ToBeClassified;
        }
        field(39; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            trigger OnValidate()
            var
                DimValueRec: Record "Dimension Value";
                GLSetup: Record "General Ledger Setup";
            begin
                GLSetup.get();
                DimValueRec.Reset();
                DimValueRec.setrange("Dimension Code", GLSetup."Global Dimension 1 Code");
                DimValueRec.SetRange(Code, "Global Dimension 1 Code");

                if DimValueRec.FindFirst() then begin
                    rec."Container No./Chassis No." := DimValueRec."Container/Chassis No.";
                    rec."Position From" := DimValueRec."Position No.";
                end;
            end;
        }
        field(40; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(41; "Global Dimension 1 Filter"; Code[20])
        {
            Caption = 'Global Dimension 1 Filter';

            FieldClass = FlowFilter;
            CaptionClass = '1,3,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(42; "Global Dimension 2 Filter"; Code[20])
        {
            Caption = 'Global Dimension 1 Filter';

            FieldClass = FlowFilter;
            CaptionClass = '1,3,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(43; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }

    }
    keys
    {
        key(PK; "Position Movement No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        ImsSetup: Record "IMS Setup";
        NoSeriesMgt: Codeunit "No. Series";
    begin
        Rec."User ID" := UserId;
        if "Position Movement No." = '' THEN begin
            ImsSetup.Get;
            ImsSetup.TestField("Postion Movement Nos");
            //NoSeriesMgt.InitSeries(ImsSetup."Postion Movement Nos", xRec."Position Movement No.", 0D, "Position Movement No.", "No.Series");
            "No.Series" := ImsSetup."Postion Movement Nos";
            if NoSeriesMgt.AreRelated(ImsSetup."Postion Movement Nos", xRec."No.Series") then
                "No.Series" := xRec."No.Series";
            "Position Movement No." := NoSeriesMgt.GetNextNo("No.Series");
        end;
        Rec."Movement Date" := today();
        rec."Movement Time" := Time;
    end;



    procedure AssistEdit(PosRec: Record "Position Movement"): Boolean
    var
        PosRec1: Record "Position Movement";
        ImsSetup: Record "IMS Setup";
        NoSeriesMgt: Codeunit "No. Series";

    begin
        PosRec1 := Rec;
        ImsSetup.GET;
        ImsSetup.TESTFIELD(ImsSetup."Postion Movement Nos");
        IF NoSeriesMgt.LookupRelatedNoSeries(ImsSetup."Postion Movement Nos", PosRec."No.Series", "No.Series") THEN BEGIN
            NoSeriesMgt.GetNextNo("Position Movement No.");
            Rec := PosRec1;
            EXIT(TRUE);
        END;
    end;

    procedure UpdatePositionToYardAllocation()
    var
        YardAlRec: Record YardAllocation;
    begin
        YardAlRec.Reset();
        YardAlRec.setrange("Global Dimension 1 Code", rec."Global Dimension 1 Code");
        if YardAlRec.FindFirst() then begin
            YardAlRec.Position := rec."Position To";
            YardAlRec.Modify();
        end;

    end;

    procedure UpdateContainer()
    var
        DimValRec: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.GET();
        DimValRec.Reset();
        DimValRec.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
        DimValRec.SetRange(Code, rec."Global Dimension 1 Code");
        if DimValRec.FindFirst() then begin
            DimValRec."Position No." := rec."Position To";
            DimValRec.Modify(true);
        end;
    end;

    procedure UpadateManifestLinePosition()
    var
        ManifestLineRec: Record "Manifest Line";
    begin
        ManifestLineRec.Reset();
        ManifestLineRec.setrange("Global Dimension 1 Code", rec."Global Dimension 1 Code");
        if ManifestLineRec.FindFirst() then begin
            ManifestLineRec.Validate(ManifestLineRec."Allocated Position", rec."Position To");
            ManifestLineRec.Modify();
        end;
    end;


}



