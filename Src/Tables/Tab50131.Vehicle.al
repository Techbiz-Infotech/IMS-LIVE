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
                NoSeriesMgmt: Codeunit NoSeriesManagement;
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
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        Rec."User ID" := UserId;
        if "Vehicle No." = '' THEN begin
            Imssetup.Get;
            Imssetup.TestField("Vehicle Nos");
            NoSeriesMgt.InitSeries(Imssetup."Vehicle Nos", xRec."Vehicle No.", 0D, "Vehicle No.", "No.Series");
        end;

    end;


    procedure AssistEdit(VehRec: Record Vehicle): Boolean
    var
        vehicleRec1: Record Vehicle;
        ImsSetup: Record "IMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        VehicleRec1 := Rec;
        ImsSetup.GET;
        ImsSetup.TESTFIELD(ImsSetup."Vehicle Nos");
        IF NoSeriesMgt.SelectSeries(ImsSetup."Vehicle Nos", VehRec."No.Series", "No.Series") THEN BEGIN
            NoSeriesMgt.SetSeries("Vehicle No.");
            Rec := VehicleRec1;
            EXIT(TRUE);
        END;
    end;


}
