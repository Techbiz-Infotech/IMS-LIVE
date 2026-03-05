table 50103 YardAllocation
{

    Caption = 'YardAllocation';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Yard Allocation No."; Code[40])
        {
            Caption = 'Yard Allocation No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var

                ImsSetup: Record "IMS Setup";
                NoSeriesMgmt: Codeunit "No. Series";
            begin
                if "Yard Allocation No." <> xRec."Yard Allocation No." then begin
                    ImsSetup.Get;
                    NoSeriesMgmt.TestManual(ImsSetup."Yard Allocation Nos");
                    "No.Series" := '';
                end;
            end;

        }
        field(2; "Container No./Chassis No."; Code[40])
        {
            Caption = 'Container No./Chassis No.';
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(3; Position; code[50])
        {
            Caption = 'Position';
            DataClassification = ToBeClassified;
            TableRelation = Position." Position ID" where(Status = const(Open));
        }
        field(4; "Machine No."; Code[40])
        {
            Caption = 'Machine No.';
            DataClassification = ToBeClassified;
            TableRelation = Machine;
        }
        field(5; "Machine Operator"; Text[60])
        {
            Caption = 'Machine Operator';
            DataClassification = ToBeClassified;
            TableRelation = "Machine Operator";
        }
        field(6; "No.Series"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), "Container Status" = const("In Stock"));
            trigger OnValidate()
            var
                DimValueRec: Record "Dimension Value";
                GLSetup: Record "General Ledger Setup";
            begin
                GLSetup.get();
                DimValueRec.Reset();
                DimValueRec.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
                DimValueRec.SetRange(code, rec."Global Dimension 1 Code");
                if DimValueRec.FindFirst() then
                    rec."Container No./Chassis No." := DimValueRec."Container/Chassis No.";
            end;

            trigger OnLookup()
            var
                ManiLine: Record "Manifest Line";
            begin
                ManiLine.Reset();
                ManiLine.SetRange("Container lock", false);
                ManiLine.SetRange(Received, true);
                ManiLine.SetRange(Manifested, true);
                //ManiLine.SetRange(Verified, false);
                ManiLine.SetRange(Released, false);
                ManiLine.SetRange("Allocated Position", '');
                if page.RunModal(50140, ManiLine) = Action::LookupOK then begin
                    VALIDATE("Global Dimension 1 Code", ManiLine."Global Dimension 1 Code");
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
        Field(42; "Global Dimension 2 Filter"; Code[20])
        {
            Caption = 'Global Dimension 1 Filter';

            FieldClass = FlowFilter;
            CaptionClass = '1,3,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(43; "Allocation Date"; Date)
        {
            Caption = 'Allocation Date';
            DataClassification = ToBeClassified;
        }
        field(44; "Allocation Time"; Time)
        {
            Caption = 'Allocation Time';
            DataClassification = ToBeClassified;
        }
        field(45; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
    }
    keys
    {
        key(PK; "Yard Allocation No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        AimsRec: Record "IMS Setup";
        NoSeriesMgt: Codeunit "No. Series";
    begin
        Rec."User ID" := UserId;
        if "Yard Allocation No." = '' THEN begin
            AimsRec.Get;
            AimsRec.TestField("Yard Allocation Nos");
            //NoSeriesMgt.InitSeries(AimsRec."Yard Allocation Nos", xRec."Yard Allocation No.", 0D, "Yard Allocation No.", "No.Series");
            "No.Series" := AimsRec."Yard Allocation Nos";
            if NoSeriesMgt.AreRelated(AimsRec."Yard Allocation Nos", xRec."No.Series") then
                "No.Series" := xRec."No.Series";
            "Yard Allocation No." := NoSeriesMgt.GetNextNo("No.Series");

        end;
        rec."Allocation Date" := today();
        rec."Allocation Time" := Time;
    end;

    procedure AssistEdit(YardRec: Record YardAllocation): Boolean
    var
        YardRec1: Record YardAllocation;
        ImsSetup: Record "IMS Setup";
        NoSeriesMgt: Codeunit "No. Series";

    begin
        YardRec1 := Rec;
        ImsSetup.GET;
        ImsSetup.TESTFIELD(ImsSetup."Yard Allocation Nos");
        IF NoSeriesMgt.LookupRelatedNoSeries(ImsSetup."Yard Allocation Nos", YardRec."No.Series", "No.Series") THEN BEGIN
            NoSeriesMgt.GetNextNo("Yard Allocation No.");
            Rec := YardRec1;
            EXIT(TRUE);
        END;
    end;
}
