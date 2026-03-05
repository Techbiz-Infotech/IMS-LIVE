table 50131 Vehicle
{
    Caption = 'Vehicle';
    DataClassification = ToBeClassified;
    LookupPageId = 50137;
    DrillDownPageId = 50137;
    fields
    {
        field(1; "Vehicle No."; Code[20])
        {
            Caption = 'Vehicle No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var

                ImsSetup: Record "IMS Setup";
                NoSeriesMgmt: Codeunit "No. Series";
            begin
                if "Vehicle No." <> xRec."Vehicle No." then begin
                    ImsSetup.Get;
                    NoSeriesMgmt.testmanual(ImsSetup."Vehicle Nos");
                    "NO.Series" := '';
                end;
            end;
        }
        field(2; "Driver Name"; Text[50])
        {
            Caption = 'Driver Name';
            DataClassification = ToBeClassified;
        }
        field(3; "NO.Series"; Code[30])
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
        field(5; Trailer; Text[50])
        {
            Caption = 'Trailer';
            DataClassification = ToBeClassified;
        }
        field(6; "ID No."; Code[25])
        {
            Caption = 'ID No.';
            DataClassification = ToBeClassified;
        }
        field(7; "Phone No."; Integer)
        {
            Caption = 'Phone No.';
            DataClassification = ToBeClassified;
        }




    }
    keys
    {
        key(PK; "Vehicle No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Vehicle No.", "Driver Name")
        {

        }
    }
    trigger OnInsert()
    var
        //myInt: Integer;
        Imssetup: Record "IMS Setup";
        NoSeriesMgt: Codeunit "No. Series";
    begin
        Rec."User ID" := UserId;
        if "Vehicle No." = '' THEN begin
            Imssetup.Get;
            Imssetup.TestField("Vehicle Nos");
            //NoSeriesMgt.InitSeries(Imssetup."Vehicle Nos", xRec."Vehicle No.", 0D, "Vehicle No.", "No.Series");
            "No.Series" := Imssetup."Vehicle Nos";
            if NoSeriesMgt.AreRelated(Imssetup."Vehicle Nos", xRec."No.Series") then
                "No.Series" := xRec."No.Series";
            "Vehicle No." := NoSeriesMgt.GetNextNo("No.Series");
        end;

    end;


    procedure AssistEdit(VehRec: Record Vehicle): Boolean
    var
        vehicleRec1: Record Vehicle;
        ImsSetup: Record "IMS Setup";
        NoSeriesMgt: Codeunit "No. Series";
    begin
        VehicleRec1 := Rec;
        ImsSetup.GET;
        ImsSetup.TESTFIELD(ImsSetup."Vehicle Nos");
        IF NoSeriesMgt.LookupRelatedNoSeries(ImsSetup."Vehicle Nos", VehRec."No.Series", "No.Series") THEN BEGIN
            NoSeriesMgt.GetNextNo("Vehicle No.");
            Rec := VehicleRec1;
            EXIT(TRUE);
        END;
    end;


}
