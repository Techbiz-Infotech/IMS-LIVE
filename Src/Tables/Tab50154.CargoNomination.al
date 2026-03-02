table 50164 "Cargo Nomination"
{
    Caption = 'Cargo Nomination';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Cargo Nomination No."; code[40])
        {
            Caption = 'Cargo Nomination No.';
            DataClassification = ToBeClassified;
            trigger Onvalidate()
            var
                ImsSetup: Record "IMS Setup";
                NoSeriesMgt: Codeunit "No. Series";
            begin
                if "Cargo Nomination No." <> xRec."Cargo Nomination No." then begin
                    ImsSetup.GET;
                    NoSeriesMgt.TestManual(ImsSetup."Cargo Job File No.");
                    "No.Series" := '';
                end;

            end;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; Archived; Boolean)
        {
            Caption = 'Archived';
            DataClassification = ToBeClassified;
        }
        field(4; "BL No."; Code[30])
        {
            Caption = 'BL No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
            end;
        }
        field(5; "Container/Chassis No."; Code[30])
        {
            Caption = 'Container/Chassis No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
                strtxt: text;
                ContDim: Code[20];
                DimValue: Record "Dimension Value";
            begin
                // strtxt := rec."Container/Chassis No.";
                // if strlen(strtxt) > 14 then
                //     ContDim := CopyStr(strtxt, STRLEN(strtxt) - 13, 14) + '-' + CopyStr("BL No.", 1, 5)
                // else
                //     ContDim := strtxt + '-' + CopyStr("BL No.", 1, 5);

                // //                ContDim := CopyStr(rec."Container/Chassis No.", 1, 14) + '-' + CopyStr("BL No.", 1, 5);
                // //InsertDimensionValues(ContDim);
                // Rec.Validate("Global Dimension 1 Code", ContDim);
                // CheckReceived();
            end;
        }
        field(6; "Seal/Engine No."; Code[30])
        {
            Caption = 'Seal/Engine No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin

            end;
        }
        field(7; "Customs Seal No."; Code[30])
        {
            Caption = 'Customs Seal No.';
            DataClassification = ToBeClassified;
        }
        field(8; Marks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                //CheckReceived();
            end;
        }

        // field(61; "Sales Person Code"; Code[20])
        // {
        //     Caption = 'Sales Person code';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Salesperson/Purchaser";
        // }
        field(10; "Container Type"; Enum ContainerTypeEnum)
        {
            Caption = 'Container Type';
            DataClassification = ToBeClassified;
        }

        field(14; "Container lock"; Boolean)
        {
            Caption = 'Container lock';
            DataClassification = ToBeClassified;
        }
        field(15; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(16; "CBM Tonage"; Decimal)
        {
            Caption = 'CBM Tonage';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                WtInTon: Decimal;
            begin
                if "CBM Tonage" = 0 then
                    "CBM-Wt Difference" := 0;
                // if (Weight <> 0) or ("CBM Tonage" <> 0) then begin
                //     if rec."CBM Tonage" >= Weight then
                //         rec."CBM-Wt Difference" := rec."CBM Tonage"
                //     else
                //         Rec."CBM-Wt Difference" := Weight;
                // end;
                Clear(WtInTon);
                if (Weight <> 0) or ("CBM Tonage" <> 0) then begin
                    WtInTon := rec.Weight / 1000;
                    if rec."CBM Tonage" >= WtInTon then
                        rec."CBM-Wt Difference" := rec."CBM Tonage"
                    else
                        //if rec."CBM Tonage" <= rec.Weight then
                        Rec."CBM-Wt Difference" := WtInTon;
                end;
            end;
        }
        field(17; Weight; Decimal)
        {
            Caption = 'Weight in Tonnes';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                WtInTon: Decimal;
            begin
                if Weight = 0 then
                    "CBM-Wt Difference" := 0;
                // if (Weight <> 0) or ("CBM Tonage" <> 0) then begin
                //     if rec."CBM Tonage" >= Weight then
                //         rec."CBM-Wt Difference" := rec."CBM Tonage"
                //     else
                //         Rec."CBM-Wt Difference" := Weight;
                // end;
                Clear(WtInTon);
                if (Weight <> 0) or ("CBM Tonage" <> 0) then begin
                    WtInTon := rec.Weight / 1000;
                    if rec."CBM Tonage" >= WtInTon then
                        rec."CBM-Wt Difference" := rec."CBM Tonage"
                    else
                        //if rec."CBM Tonage" <= rec.Weight then
                        Rec."CBM-Wt Difference" := WtInTon;
                end;
            end;
        }
        field(18; "CBM-Wt Difference"; Decimal)
        {
            Caption = 'CBM-Wt Difference';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(19; "No. of Bags"; Decimal)
        {
            Caption = 'No. of Bags';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                rec."Remaining Bags" := rec."No. of Bags" - "No. of Bags Released";
            end;
        }
        field(20; "No. of Bags Released"; Decimal)
        {
            Caption = 'No. of Bags Released';
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                rec."Remaining Bags" := rec."No. of Bags" - "No. of Bags Released";
            end;
        }
        field(21; "Remaining Bags"; Decimal)
        {
            Caption = 'Remaining Bags';
            DataClassification = ToBeClassified;
            //Editable = false;

        }
        field(22; "Port of Shipment"; Code[30])
        {
            Caption = 'Port of Shipment';
            DataClassification = ToBeClassified;
            TableRelation = Port;
        }
        field(23; "Port of Discharge"; Code[30])
        {
            Caption = 'Port of Discharge';
            DataClassification = ToBeClassified;
            TableRelation = Port;
        }
        field(24; "Destination Type"; Enum DestinationTypeEnum)
        {
            Caption = 'Destination Type';
            DataClassification = ToBeClassified;
        }
        field(25; "Consignee Name"; Text[100])
        {
            Caption = 'Consignee Name';
            DataClassification = ToBeClassified;
        }
        field(26; "Clearing Agent"; Code[30])
        {
            Caption = 'Clearing Agent';
            DataClassification = ToBeClassified;
            TableRelation = "Clearing Agent";
        }
        field(11; "Container size"; Code[20])
        {
            Caption = 'Container Size';
            DataClassification = ToBeClassified;
        }
        field(12; "Cargo Type"; code[20])
        {
            Caption = 'Cargo Type';
            DataClassification = ToBeClassified;
        }

        field(13; "Client Type"; Code[30])
        {
            Caption = 'Client Type';
            DataClassification = ToBeClassified;
        }
        field(29; "Sales Person"; Code[20])
        {
            Caption = 'Sales Person';
            DataClassification = ToBeClassified;
        }
        field(27; "Process Type"; code[20])
        {
            Caption = 'Process Type';
            DataClassification = ToBeClassified;
        }


        field(28; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }



        field(30; "Consignee No."; code[20])
        {
            Caption = 'Consignee No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer;
            trigger Onvalidate()
            var
                CustRec: Record Customer;
            begin
                IF CustRec.get(rec."Consignee No.") then begin
                    rec."Consignee Name" := CustRec.Name;
                    rec."Sales Person" := CustRec."Salesperson Code"
                end else begin
                    rec."Consignee Name" := '';
                    rec."Sales Person" := '';
                end;
            end;
        }
        field(31; "Job File Date"; Date)
        {
            Caption = 'Nomination Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32; "Invoicing Party No."; Code[20])
        {
            Caption = 'Invoicing Party No.';
            TableRelation = Customer;
            DataClassification = ToBeClassified;
        }

        field(33; "Parent Container ID"; Code[20])
        {
            Caption = 'Parent Container ID';
            DataClassification = ToBeClassified;
            //TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

        }
        field(34; "TBL/MH"; Enum TBLNTBLEnum)
        {
            Caption = 'TBL/MH';
            DataClassification = ToBeClassified;
        }
        field(35; "Shipping Agent"; code[30])
        {
            Caption = 'Shipping Agent';
            DataClassification = ToBeClassified;
            //TableRelation = "Shipping Agent";
            trigger Onvalidate()
            var
                ShipAgentRec: Record "Shipping Agent";
            begin
                ShipAgentRec.get(rec."Shipping Agent");
                rec."Shipping Agent Name" := ShipAgentRec.Name;
            end;
        }
        field(36; "Shipping Agent Name"; text[40])
        {
            Caption = 'Shipping Agent Name';
            DataClassification = ToBeClassified;
            TableRelation = "Shipping Agent";
            Editable = false;
        }
        field(37; "Vessel Name"; Text[100])
        {
            Caption = 'Vessel Name';
            DataClassification = ToBeClassified;

        }
        field(38; "Voyage No."; code[30])
        {
            Caption = 'Voyage No.';
            DataClassification = ToBeClassified;
        }
        field(39; "Expected Arrival Date"; date)
        {
            Caption = 'Vessel Expected Date';
            DataClassification = ToBeClassified;
        }
        field(40; "Vessel Arrival Date"; date)
        {
            Caption = 'Vessel Arrival Date';
            DataClassification = ToBeClassified;
        }
        field(41; "Last Sling Date"; Date)
        {
            Caption = 'Last Sling Date';
            DataClassification = ToBeClassified;
        }
        field(42; "Vessel Arrival Time"; Time)
        {
            Caption = 'Vessel Arrival Time';
            DataClassification = ToBeClassified;
        }
        field(43; "No.Series"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Container Id"; Code[20])
        {
            Caption = 'Container Id';
            DataClassification = ToBeClassified;
        }
        field(45; Nominated; Boolean)
        {
            Caption = 'Nominated';
            DataClassification = ToBeClassified;
        }
        field(46; "Cargo Status"; Enum CargoNominationStatus)
        {
            Caption = 'Cargo Status';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
            begin
                // if Rec."Cargo Status" = Rec."Cargo Status"::Cancelled then begin
                //     if not Confirm('Are you sure you want to cancel this nomination?', false) then begin
                //         Rec."Cargo Status" := xRec."Cargo Status";
                //         exit;
                //     end else begin
                //         if StrLen(Rec."Cancelled Reason") < 20 then
                //             Error('Cancelled Reason must be at least 20 characters long.');
                //     end;
                //     Rec.Archived := true;
                // end;
                if Rec."Cargo Status" = Rec."Cargo Status"::Cancelled then begin
                    if not Confirm('Are you sure you want to cancel this nomination?', false) then begin
                        Rec."Cargo Status" := xRec."Cargo Status";
                        exit;
                    end;

                    if StrLen(Rec."Cancelled Reason") < 20 then
                        Error('Canceled Reason must be at least 20 characters long.');

                    Rec.Archived := true; 
                end;

            end;
        }
        field(47; "Vessel Discharge Date"; Date)
        {
            Caption = 'Vessel Discharge Date';
            DataClassification = ToBeClassified;
        }
        field(48; "Cargo Dicharge Date"; Date)
        {
            Caption = 'Cargo Dicharge Date';
            DataClassification = ToBeClassified;
        }

        field(50; "Cancelled Reason"; Text[250])
        {
            Caption = 'Cancelled Reason';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Cargo Nomination No.", "Line No.")
        {
            Clustered = true;
        }
        key(k2; "Container Id")
        {
        }
        key(k3; "Client Type")
        {
        }
        key(k4; "Consignee No.")
        {
        }
        key(k5; "Invoicing Party No.")
        {
        }
        key(k6; "Sales Person")
        {
        }
        key(k7; "Cargo Type")
        {
        }
        key(k8; "Container size")
        {
        }
        key(k9; "Process Type")
        {
        }
        key(k10; "BL No.")
        {
        }
        key(k11; "Job File Date")
        {

        }
    }
    trigger OnInsert()
    var
        ImsSetup: Record "IMS Setup";
        NoSeriesMgt: Codeunit "No. Series";
    begin
        //  rec."Date File Opened" := TODAY();
        Rec."User ID" := UserId;

        if "Cargo Nomination No." = '' then begin
            ImsSetup.get;
            ImsSetup.TestField("Cargo Job File No.");
            "No.Series" := ImsSetup."Cargo Job File No.";
            if NoSeriesMgt.AreRelated(ImsSetup."Cargo Job File No.", xRec."No.Series") then
                "No.Series" := xRec."No.Series";
            "Cargo Nomination No." := NoSeriesMgt.GetNextNo("No.Series");
        end;
    end;

    trigger OnDelete()
    var
        UserSetupRec: Record "User Setup";
    begin
        UserSetupRec.Get(UserId);
        if not UserSetupRec."Delete Cargo Nomination" then begin
            Error('You do not have permission to delete cargo nomination records. Please contact your Group Audit.');
            exit;
        end;
    end;

    procedure OnAssistEdit(CargoNomiRec: Record "Cargo Nomination"): Boolean
    var
        CargoRec: Record "Cargo Nomination";
        ImsSetup: Record "IMS Setup";
        NoSeriesMgt: Codeunit "No. Series";

    begin
        CargoRec := Rec;
        ImsSetup.Get;
        ImsSetup.TestField("Cargo Job File No.");
        if NoSeriesMgt.LookupRelatedNoSeries(ImsSetup."Cargo Job File No.", CargoNomiRec."No.Series", CargoRec."No.Series") then begin
            NoSeriesMgt.GetNextNo(CargoRec."Cargo Nomination No.", WorkDate(), true);
            Rec := CargoRec;
            exit(true);
        end;

    end;

    procedure CreateManifestLines(var CargoNomination: Record "Cargo Nomination")
    var
        MFLine: Record "Manifest Line";
        MFLine2: Record "Manifest Line";
        NoSeriesMgt: Codeunit "No. Series";
        IMSSetup: Record "Ims Setup";
        LineNo: Integer;
        BlNo: Code[20];
        JFileNo: Code[20];
        Counter: Integer;
    begin
        if not Confirm('Do you want to create manifest lines?', false) then
            exit;
        IMSSetup.Get();
        CargoNomination.Reset();
        CargoNomination.SetRange(Nominated, false);
        CargoNomination.SetFilter("Cargo Status", '%1|%2', CargoNominationStatus::"Approved Nomination", CargoNominationStatus::Transfer);
        if not CargoNomination.FindSet() then begin
            Error('No Approved Nomination or Transfer records found to process.');
            exit;
        end else begin

            // if CargoNomination.FindSet() then 
            repeat
                BlNo := CargoNomination."BL No.";

                // Reset MFLine2 before using SetRange
                MFLine2.Reset();
                MFLine2.SetRange("BL No.", BlNo);

                if MFLine2.FindFirst() then begin
                    JFileNo := MFLine2."Job File No."
                end else begin
                    JFileNo := NoSeriesMgt.GetNextNo(IMSSetup."Job File Nos", WorkDate(), true);
                end;
                MFLine.Reset();
                MFLine.SetRange("Job File No.", JFileNo);

                if MFLine.FindLast() then
                    LineNo := MFLine."Line No." + 10000
                else
                    LineNo := 10000;

                MFLine.Init();
                MFLine.Validate("Job File No.", JFileNo);
                MFLine."Line No." := LineNo;
                MFLine.Insert(true);
                MFLine.Validate("BL No.", CargoNomination."BL No.");
                MFLine.Validate(Manifested, true);
                MFLine.Validate("CBM Tonage", CargoNomination."CBM Tonage");
                MFLine."Global Dimension 1 Code" := CargoNomination."Container Id";
                MFLine."Job File Date" := CargoNomination."Job File Date";
                MFLine.Validate("Shortcut Dimension 4 Code", CargoNomination."Cargo Type");
                MFLine.Validate("Shortcut Dimension 6 Code", CargoNomination."Process Type");
                MFLine.Validate("Clearing Agent", CargoNomination."Clearing Agent");
                MFLine.Validate("Consignee No.", CargoNomination."Consignee No.");
                MFLine.Validate("Seal/Engine No.", CargoNomination."Seal/Engine No.");
                MFLine.Validate("Destination Type", CargoNomination."Destination Type");
                MFLine.Validate("Container Type", CargoNomination."Container Type");
                Evaluate(MFLine."Global Dimension 2 Code", CargoNomination."Client Type");
                MFLine.Validate(Weight, CargoNomination.Weight);
                MFLine.Validate("Shortcut Dimension 5 Code", CargoNomination."Container size");
                MFLine.Validate("Invoicing Party No.", CargoNomination."Invoicing Party No.");
                MFLine.Validate("Port of Discharge", CargoNomination."Port of Discharge");
                MFLine.Validate("Port of Shipment", CargoNomination."Port of Shipment");
                MFLine.Validate("Container/Chassis No.", CargoNomination."Container/Chassis No.");
                MFLine.Validate(Description, CargoNomination.Description);
                MFLine.Validate("Shipping Agent", CargoNomination."Shipping Agent");
                MFLine.Validate("Vessel Name", CargoNomination."Vessel Name");
                MFLine.Validate("Vessel Arrival Date", CargoNomination."Vessel Arrival Date");
                MFLine.Validate("Vessel Arrival Time", CargoNomination."Vessel Arrival Time");
                MFLine.Validate("Last Sling Date", CargoNomination."Last Sling Date");
                MFLine.Validate("Global Dimension 2 Code", CargoNomination."Client Type");
                MFLine."Parent Container ID" := CargoNomination."Parent Container ID";
                MFLine."TBL/MH" := CargoNomination."TBL/MH";
                MFLine."Cargo Nomination No." := CargoNomination."Cargo Nomination No.";
                // 
                MFLine.Modify(true);

                // Call dimension insert
                InsertDimensionValues(CargoNomination."Container/Chassis No.", MFLine);

                // Delete only selected line
                //CargoNomination.Delete();
                CargoNomination.Nominated := true;
                CargoNomination.Archived := true;
                CargoNomination.Modify(true);

            // Message(CargoNomination."Job File No." + ' - ' + Format(CargoNomination."Line No.") + 'Manifest line created');
            until CargoNomination.Next() = 0;
            Message('Manifest Lines created successfully');
        end;
    end;
    // end;
    //end;

    procedure InsertDimensionValues(ContainerID: Code[20]; ImportWS: Record "Manifest Line")
    var
        DimValueRec: Record "Dimension Value";
        GLSetupRec: Record "General Ledger Setup";
    begin
        GLSetupRec.Get();
        DimValueRec.Reset();
        DimValueRec.SetRange(Code, ContainerID);
        if not DimValueRec.FindFirst() then begin
            DimValueRec.Init();
            DimValueRec.validate("Dimension Code", GLSetupRec."Global Dimension 1 Code");
            DimValueRec.Code := ContainerID;
            DimValueRec.Insert(true);
            DimValueRec.Validate(Name, ImportWS."Container/Chassis No.");
            DimValueRec.Validate("Customer No.", ImportWS."Consignee No.");
            DimValueRec.Validate("Customer Name", ImportWS."Consignee Name");
            DimValueRec.Validate("BL No.", ImportWS."BL No.");
            DimValueRec.Validate("Job File No.", ImportWS."Job File No.");
            DimValueRec.Validate("Container/Chassis No.", ImportWS."Container/Chassis No.");
            DimValueRec.Validate("Manifest Line No.", ImportWS."Line No.");
            DimValueRec.validate("Container Status", DimValueRec."Container Status"::"Not Applicable");
            DimValueRec.Modify(true);
        end;
    end;
}
