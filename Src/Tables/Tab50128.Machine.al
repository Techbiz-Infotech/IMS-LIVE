table 50128 Machine
{
    Caption = 'Machine';
    DataClassification = ToBeClassified;
    LookupPageId = 50131;
    DrillDownPageId = 50131;
    fields
    {
        field(1; "Machine Code"; Code[20])
        {
            Caption = 'Machine Code';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var

                ImsSetup: Record "IMS Setup";
                NoSeriesMgmt: Codeunit "No. Series";
            begin
                if "Machine Code" <> xRec."Machine Code" then begin
                    ImsSetup.Get;
                    NoSeriesMgmt.TestManual(ImsSetup."Machine Nos");
                    "NO.Series" := '';
                end;
            end;

        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "No.Series"; Code[30])
        {
            Caption = 'No.series';
            DataClassification = ToBeClassified;
        }
        field(4; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(5; "Machine Serial No."; Text[50])
        {
            Caption = 'Machine Serial No.';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Machine Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Machine Code", Description)
        {

        }
    }
    trigger OnInsert()
    var
        ImsSetup: Record "IMS Setup";
        NoSeriesMgt: Codeunit "No. Series";
    begin
        Rec."User ID" := UserId;
        if "Machine Code" = '' THEN begin
            ImsSetup.Get;
            ImsSetup.TestField("Machine Nos");
            //NoSeriesMgt.InitSeries(ImsSetup."Machine Nos", xRec."Machine Code", 0D, "Machine Code", "No.Series");
            "No.Series" := ImsSetup."Machine Nos";
            if NoSeriesMgt.AreRelated(ImsSetup."Machine Nos", xRec."No.Series") then
                "No.Series" := xRec."No.Series";
            "Machine Code" := NoSeriesMgt.GetNextNo("No.Series");
        end;

    end;

    procedure AssistEdit(MachineRec: Record Machine): Boolean
    var
        MachineRec1: Record Machine;
        ImsSetup: Record "IMS Setup";
        NoSeriesMgt: Codeunit "No. Series";

    begin
        MachineRec1 := Rec;
        ImsSetup.GET;
        ImsSetup.TESTFIELD(ImsSetup."Machine Nos");
        IF NoSeriesMgt.LookupRelatedNoSeries(ImsSetup."Machine Nos", MachineRec."No.Series", "No.Series") THEN BEGIN
            NoSeriesMgt.GetNextNo("Machine Code");
            Rec := MachineRec1;
            EXIT(TRUE);
        END;
    end;






}
