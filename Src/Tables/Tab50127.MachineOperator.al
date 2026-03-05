table 50127 "Machine Operator"
{
    Caption = 'Machine Operator';
    DataClassification = ToBeClassified;
    LookupPageId = 50129;
    DrillDownPageId = 50129;

    fields
    {
        field(1; "Machine Operator Code"; Code[20])
        {
            Caption = 'Machine Operator Code';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var

                ImsSetup: Record "IMS Setup";
                NoSeriesMgmt: Codeunit "No. Series";
            begin
                if "Machine Operator Code" <> xRec."Machine Operator Code" then begin
                    ImsSetup.Get;
                    NoSeriesMgmt.TestManual(ImsSetup."Machine Operator Nos");
                    "NO.Series" := '';
                end;
            end;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "No.Series"; Code[20])
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
    }
    keys
    {
        key(PK; "Machine Operator Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Machine Operator Code", Description)
        {

        }
    }


    trigger OnInsert()
    var
        //myInt: Integer;
        ImsSetup: Record "IMS Setup";
        NoSeriesMgt: Codeunit "No. Series";
    begin
        Rec."User ID" := UserId;
        if "Machine Operator Code" = '' THEN begin
            ImsSetup.Get;
            ImsSetup.TestField("Machine Operator Nos");
            //NoSeriesMgt.InitSeries(ImsSetup."Machine Operator Nos", xRec."Machine Operator Code", 0D, "Machine Operator Code", "No.Series");
            "No.Series" := ImsSetup."Machine Operator Nos";
            if NoSeriesMgt.AreRelated(ImsSetup."Machine Operator Nos", xRec."No.Series") then
                "No.Series" := xRec."No.Series";
            "Machine Operator Code" := NoSeriesMgt.GetNextNo("No.Series");

        end;
    end;

    procedure AssistEdit(MachineOpeRec: Record "Machine Operator"): Boolean
    var
        MachineOpeRec1: Record "Machine Operator";
        ImsSetup: Record "IMS Setup";
        NoSeriesMgt: Codeunit "No. Series";

    begin
        MachineOpeRec1 := Rec;
        ImsSetup.GET;
        ImsSetup.TESTFIELD(ImsSetup."Machine Operator Nos");
        IF NoSeriesMgt.LookupRelatedNoSeries(ImsSetup."Machine Operator Nos", MachineOpeRec."No.Series", "No.Series") THEN BEGIN
            NoSeriesMgt.GetNextNo("Machine Operator Code");
            Rec := MachineOpeRec1;
            EXIT(TRUE);
        END;
    end;

}
