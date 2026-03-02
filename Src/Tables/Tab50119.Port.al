table 50119 Port
{
    Caption = 'Port';
    DataClassification = ToBeClassified;
    LookupPageId = 50120;
    DrillDownPageId = 50120;

    fields
    {
        field(1; "Port Code"; Code[20])
        {
            Caption = 'Port Code';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var

                ImsSetup: Record "IMS Setup";
                NoSeriesMgmt: Codeunit NoSeriesManagement;
            begin
                if "Port Code" <> xRec."Port Code" then begin
                    ImsSetup.Get;
                    NoSeriesMgmt.TestManual(ImsSetup."Port Nos");
                    "NO.Series" := '';
                end;
            end;

        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "NO.Series"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.Series';
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
        key(PK; "Port Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Port Code", "Description")
        {

        }
    }
    trigger OnInsert()
    var
        //myInt: Integer;
        ImsSetup: Record "IMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        Rec."User ID" := UserId;
        if "Port Code" = '' THEN begin
            ImsSetup.Get;
            ImsSetup.TestField("Port Nos");
            NoSeriesMgt.InitSeries(ImsSetup."Port Nos", xRec."Port Code", 0D, "Port Code", "No.Series");
        end;

    end;

    procedure AssistEdit(PortRec: Record Port): Boolean
    var
        PortRec1: Record Port;
        ImsSetup: Record "IMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    begin
        PortRec1 := Rec;
        ImsSetup.GET;
        ImsSetup.TESTFIELD(ImsSetup."Port Nos");
        IF NoSeriesMgt.SelectSeries(ImsSetup."Port Nos", PortRec."No.Series", "No.Series") THEN BEGIN
            NoSeriesMgt.SetSeries("Port Code");
            Rec := PortRec1;
            EXIT(TRUE);
        END;
    end;

}
