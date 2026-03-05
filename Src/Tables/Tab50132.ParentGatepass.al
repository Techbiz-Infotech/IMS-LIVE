table 50132 "Parent Gatepass"
{
    Caption = 'Manual Gatepass';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Parent Gatepass No."; Code[20])
        {
            Caption = 'Manual Gatepass No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                ImsSetup: Record "IMS Setup";
                NoSeriesMgmt: Codeunit "No. Series";
            begin
                if "Parent Gatepass No." <> xRec."Parent GatePass No." then begin
                    ImsSetup.Get;
                    NoSeriesMgmt.TestManual(ImsSetup."Parent Gatepass Nos");
                    "NO.Series" := '';
                end;
            end;

        }
        field(2; "Posted"; Boolean)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Job File No."; Code[20])
        {
            Caption = 'Job File No.';
            DataClassification = ToBeClassified;
            TableRelation = "Manifest Line";
            Editable = false;
        }
        field(4; "BL No."; Code[20])
        {
            Caption = 'BL No.';
            DataClassification = ToBeClassified;
            trigger OnLookup()
            var
                BLPage: Page "BL List";
                ManifestLine: Record "Manifest Line";
                MGPOLine: Record "Parent Gatepass Line";
                ClearingAgent: Record "Clearing Agent";
            begin
                ManifestLine.Reset();
                ManifestLine.SetRange(Received, true);
                ManifestLine.SetRange("Container lock", false);
                ManifestLine.SetRange(Released, false);
                ManifestLine.FindFirst();
                IF Page.RunModal(50122, ManifestLine) = Action::LookupOK then begin
                    Rec."BL No." := ManifestLine."BL No.";
                    rec."Job File No." := ManifestLine."Job File No.";
                    Rec."Consignee No." := ManifestLine."Consignee No.";
                    Rec."Consignee Name" := ManifestLine."Consignee Name";
                    rec."Clearing Agent" := ManifestLine."Clearing Agent";
                    if ClearingAgent.get("Clearing Agent") then
                        "Clearing Agent Name" := ClearingAgent."Clearing Agent Name"
                    else
                        "Clearing Agent Name" := '';
                end;
            end;

            trigger OnValidate()
            begin
                if Rec."BL No." = '' then begin
                    rec."Job File No." := '';
                    Rec."Consignee No." := '';
                    Rec."Consignee Name" := '';
                    rec."Clearing Agent" := '';
                    rec."Clearing Agent Name" := '';
                end;
            end;
        }
        field(7; "Activity Date"; Date)
        {
            Caption = 'Activity Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Activity Time"; Time)
        {
            Caption = 'Activity Time';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Container /Chasis No."; Code[30])
        {
            Caption = 'Container /Chasis No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Parent GatePass Status"; Enum "Active/In-Active Enum")
        {
            Caption = 'Manual GatePass Status';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Posted Date"; Date)
        {
            Caption = 'Posted Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Posted Time"; Time)
        {
            Caption = 'Posted Time';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(13; "Agent Name"; Text[20])
        {
            Caption = 'Agent Name';
            DataClassification = ToBeClassified;
        }
        field(16; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        // field(23; "Position ID"; code[20])
        // {
        //     Caption = 'Position ID';
        //     DataClassification = ToBeClassified;
        //     TableRelation = Position." Position ID" where(Status = const(Allocated));
        //     Editable = false;
        // }
        field(24; "No.Series"; code[20])
        {
            Caption = 'No.Series';
            DataClassification = ToBeClassified;
        }
        field(36; "Clearing Agent"; Code[20])
        {
            Caption = 'Clearing Agent';
            DataClassification = ToBeClassified;
            TableRelation = "Clearing Agent";
            Editable = false;
        }
        field(37; "Clearing Agent Name"; Text[50])
        {
            Caption = 'Clearing Agent Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(39; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            trigger OnLookup()
            var
                BLPage: Page "BL List";
                ManifestLine: Record "Manifest Line";
            begin
                ManifestLine.Reset();
                ManifestLine.SetRange("BL No.", Rec."BL No.");
                ManifestLine.FindFirst();
                IF Page.RunModal(50140, ManifestLine) = Action::LookupOK then begin
                    Rec.validate("Global Dimension 1 Code", ManifestLine."Global Dimension 1 Code");
                    Rec."Container /Chasis No." := ManifestLine."Container/Chassis No.";
                end;
            end;

            trigger OnValidate()
            var
                Manifestline: Record "Manifest Line";
            begin
                if Rec."Global Dimension 1 Code" <> '' then begin
                    Manifestline.Reset();
                    Manifestline.SetRange("BL No.", Rec."BL No.");
                    Manifestline.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                    if not Manifestline.FindFirst() then
                        Error('BL No. and Container ID does not match');
                end else
                    rec."Container /Chasis No." := '';
            end;
        }
        field(40; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            Editable = false;
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
        field(44; "Consignee No."; Code[20])
        {
            Caption = 'Consignee No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer;
            Editable = false;
        }
        field(45; "Consignee Name"; Text[100])
        {
            Caption = 'Consignee Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(46; "Parent GatePass Printed"; Boolean)
        {
            Caption = 'Manual GatePass Printed';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(47; Approved; Boolean)
        {
            Caption = 'Approved';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(48; "Approved By"; Code[50])
        {
            Caption = 'Approved By';
            DataClassification = ToBeClassified;
            TableRelation = User;
            Editable = false;
        }
        field(49; "Approved Date Time"; DateTime)
        {
            Caption = 'Approved Date Time';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50; "Expired Date"; Date)
        {
            Caption = 'Expired Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51; "Expired Time"; Time)
        {
            Caption = 'Expired Time';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Parent GatePass No.")
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
        if "Parent GatePass No." = '' THEN begin
            ImsSetup.Get;
            ImsSetup.TestField("Parent Gatepass Nos");
            //NoSeriesMgt.InitSeries(ImsSetup."Parent Gatepass Nos", xRec."Parent GatePass No.", 0D, "Parent GatePass No.", "No.Series");
            "No.Series" := ImsSetup."Parent Gatepass Nos";
            if NoSeriesMgt.AreRelated(ImsSetup."Parent Gatepass Nos", xRec."No.Series") then
                "No.Series" := xRec."No.Series";
            "Parent GatePass No." := NoSeriesMgt.GetNextNo("No.Series");
        end;
        rec."Activity Date" := Today();
        rec."Activity Time" := Time;

    end;

    procedure AssistEdit(GatePassRec: Record "Parent GatePass"): Boolean
    var
        GatePassRec1: Record "Parent Gatepass";
        ImsSetup: Record "IMS Setup";
        NoSeriesMgt: Codeunit "No. Series";

    begin
        GatePassRec1 := Rec;
        ImsSetup.GET;
        ImsSetup.TESTFIELD(ImsSetup."Parent Gatepass Nos");
        IF NoSeriesMgt.LookupRelatedNoSeries(ImsSetup."Parent Gatepass Nos", GatePassRec."No.Series", "No.Series") THEN BEGIN
            NoSeriesMgt.GetNextNo("Parent Gatepass No.");
            Rec := GatePassRec1;
            EXIT(TRUE);
        END;
    end;

    procedure GetLines()
    var
        ManifestLine: Record "Manifest Line";
        MGPOLine: Record "Parent Gatepass Line";
        LineNo: Integer;
        ClearingAgent: Record "Clearing Agent";
    begin
        MGPOLine.Reset();
        MGPOLine.SetRange("Parent Gatepass No.", Rec."Parent Gatepass No.");
        if MGPOLine.Findset() then begin
            if Confirm('Do you want to delete the existing lines?', true) then
                MGPOLine.DeleteAll();
        end;
        ManifestLine.Reset();
        ManifestLine.SetRange("BL No.", Rec."BL No.");
        ManifestLine.SetRange(Received, true);
        ManifestLine.SetRange("Container lock", false);
        ManifestLine.SetRange(Released, false);
        if ManifestLine.FindFirst() then
            repeat
                MGPOLine.Reset();
                MGPOLine.SetRange("Parent Gatepass No.", Rec."Parent Gatepass No.");
                if MGPOLine.FindLast() then
                    LineNo := MGPOLine."Line No." + 10000
                else
                    LineNo := 10000;
                MGPOLine.Reset();
                MGPOLine.Init();
                MGPOLine."Parent Gatepass No." := Rec."Parent Gatepass No.";
                MGPOLine."Line No." := LineNo;
                MGPOLine."Global Dimension 1 Code" := ManifestLine."Global Dimension 1 Code";
                MGPOLine."Container /Chasis No." := ManifestLine."Container/Chassis No.";
                MGPOLine."Global Dimension 2 Code" := ManifestLine."Global Dimension 2 Code";
                MGPOLine."BL No." := Rec."BL No.";
                MGPOLine."Activity Date" := Rec."Activity Date";
                MGPOLine."Activity Time" := Rec."Activity Time";
                MGPOLine."Job File No." := ManifestLine."Job File No.";
                MGPOLine."Consignee No." := ManifestLine."Consignee No.";
                MGPOLine."Consignee Name" := ManifestLine."Consignee Name";
                MGPOLine."Clearing Agent" := ManifestLine."Clearing Agent";
                if ClearingAgent.get(MGPOLine."Clearing Agent") then
                    "Clearing Agent Name" := ClearingAgent."Clearing Agent Name"
                else
                    "Clearing Agent Name" := '';

                MGPOLine.Insert();
            until ManifestLine.Next() = 0;
    end;

    procedure UpdateRelasedDetails()
    var
        myInt: Integer;
        ManifestLine: Record "Manifest Line";
        DimValRec: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        MGPOLine: Record "Parent Gatepass Line";
    begin
        MGPOLine.Reset();
        MGPOLine.SetRange("Parent Gatepass No.", Rec."Parent Gatepass No.");
        if MGPOLine.FindFirst() then
            repeat
                ManifestLine.Reset();
                ManifestLine.SetRange("BL No.", MGPOLine."BL No.");
                ManifestLine.SetRange("Global Dimension 1 Code", MGPOLine."Global Dimension 1 Code");
                if ManifestLine.FindFirst() then begin
                    ManifestLine.Released := true;
                    ManifestLine."Date Released" := Today;
                    ManifestLine.Modify();
                end;
                GLSetup.get();
                DimValRec.Reset();
                DimValRec.setrange("Dimension Code", GLSetup."Global Dimension 1 Code");
                DimValRec.SetRange(code, MGPOLine."Global Dimension 1 Code");
                if DimValRec.FindFirst() then begin
                    DimValRec."Container Status" := DimValRec."Container Status"::Delivered;
                    DimValRec.Modify();
                end;
                MGPOLine.Posted := true;
                MGPOLine."Posted Date" := Today;
                MGPOLine."Posted Time" := Time;
                MGPOLine.Modify();
            until MGPOLine.Next() = 0;
    end;

}

