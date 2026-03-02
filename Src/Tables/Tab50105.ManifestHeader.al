Table 50105 "Manifest Header"
{
    Caption = 'Manifest Header';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Job File No."; code[20])
        {
            Caption = 'Job File No.';
            DataClassification = ToBeClassified;
            trigger Onvalidate()
            var
                ImsSetup: Record "IMS Setup";
                NoSeriesMgt: Codeunit NoSeriesManagement;
            begin
                rec."Date File Opened" := WorkDate();
                if "Job File No." <> xRec."Job File No." then begin
                    ImsSetup.GET;
                    NoSeriesMgt.TestManual(ImsSetup."Job File Nos");
                    "No.Series" := '';
                end;

            end;
        }
        field(3; "Date File Opened"; Date)
        {
            Caption = 'Date File Opened';
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            begin
                UpdateManifestLine();
            end;

        }
        field(4; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            trigger OnValidate()
            begin
                UpdateManifestLine();
            end;
        }
        field(5; "Shipping Agent"; code[30])
        {
            Caption = 'Shipping Agent';
            DataClassification = ToBeClassified;
            TableRelation = "Shipping Agent";
            trigger Onvalidate()
            var
                ShipAgentRec: Record "Shipping Agent";
            begin
                ShipAgentRec.get(rec."Shipping Agent");
                rec."Shipping Agent Name" := ShipAgentRec.Name;
            end;
        }
        field(6; "Shipping Agent Name"; text[40])
        {
            Caption = 'Shipping Agent Name';
            DataClassification = ToBeClassified;
            TableRelation = "Shipping Agent";
            Editable = false;
        }
        field(8; "Vessel Name"; Text[100])
        {
            Caption = 'Vessel Name';
            DataClassification = ToBeClassified;

        }
        field(9; "Voyage No."; code[30])
        {
            Caption = 'Voyage No.';
            DataClassification = ToBeClassified;
        }
        field(10; "Expected Arrival Date"; date)
        {
            Caption = 'Expected Arrival Date';
            DataClassification = ToBeClassified;
        }
        field(11; "Vessel Arrival Date"; date)
        {
            Caption = 'Vessel Arrival Date';
            DataClassification = ToBeClassified;
        }
        field(12; "Last Sling Date"; Date)
        {
            Caption = 'Last Sling Date';
            DataClassification = ToBeClassified;

        }
        field(13; "Vessel Arrival Time"; Time)
        {
            Caption = 'Vessel Arrival Time';
            DataClassification = ToBeClassified;
        }
        field(14; "No.Series"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        // field(16; "Process Type"; Enum ManifestProcessTypeEnum)
        // {
        //     Caption = 'Process Type';
        //     DataClassification = ToBeClassified;
        // }

        field(16; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
            trigger OnValidate()
            begin
                UpdateManifestLine();
            end;
        }
    }
    keys
    {
        key(key1; "Job File No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Job File No.", "Global Dimension 2 Code")
        {

        }
    }
    trigger OnInsert()
    var
        ImsSetup: Record "IMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        rec."Date File Opened" := TODAY();
        Rec."User ID" := UserId;

        if "Job File No." = '' then begin
            ImsSetup.get;
            ImsSetup.TestField("Job File Nos");
            NoSeriesMgt.InitSeries(ImsSetup."Job File Nos", xRec."Job File No.", 0D, "Job File No.", "No.Series");
        end;
    end;

    trigger OnDelete()
    var
        ManifestLine: Record "Manifest Line";
        UserSetup: Record "User Setup";
    begin
        UserSetup.get(UserId);
        if not UserSetup."Gatepass Approval" then
            Error('You do not have permission to delete. Please contact Group Audit');
        ManifestLine.reset;
        ManifestLine.SetRange("Job File No.", "Job File No.");
        ManifestLine.SetRange(Received, true);
        if ManifestLine.FindSet() then
            error('Lines has transactions. You can not delete the Manifest %1. Please contact administrator', Rec."Job File No.");

        ManifestLine.reset;
        ManifestLine.SetRange("Job File No.", "Job File No.");
        if ManifestLine.FindSet() then
            ManifestLine.DeleteAll();
    end;


    procedure OnAssistEdit(ManifestRec: Record "Manifest Header"): Boolean
    var
        ManiRec: Record "Manifest Header";
        ImsSetup: Record "IMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    begin
        ManiRec := Rec;
        ImsSetup.Get;
        ImsSetup.TestField("Job File Nos");
        if NoSeriesMgt.SelectSeries(ImsSetup."Job File Nos", ManifestRec."No.Series", "No.Series") then begin
            NoSeriesMgt.SetSeries("Job File No.");
            Rec := ManiRec;
            exit(true);
        end;

    end;

    procedure UpdateManifestLine()
    var
        ManifestLine: Record "Manifest Line";
    begin
        ManifestLine.Reset();
        ManifestLine.SetRange("Job File No.", Rec."Job File No.");
        if ManifestLine.FindFirst() then
            repeat
                ManifestLine."Job File Date" := Rec."Date File Opened";
                ManifestLine."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                ManifestLine."Shortcut Dimension 6 Code" := Rec."Shortcut Dimension 6 Code";
                ManifestLine.Modify();
            until ManifestLine.Next() = 0;
    end;
}
