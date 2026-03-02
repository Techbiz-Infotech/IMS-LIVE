table 50107 "Manifest Line"
{
    Caption = 'Manifest Line';
    DataClassification = ToBeClassified;
    LookupPageId = "Container List MFL";
    DrillDownPageId = "Container List MFL";

    fields
    {
        field(1; "Job File No."; code[40])
        {
            Caption = 'Job File No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Charge ID"; Code[30])
        {
            Caption = 'Charge ID';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Invoice Line"."Charge ID" WHERE("Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Code")));
        }
        field(4; Manifested; Boolean)
        {
            Caption = 'Manifested';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                CheckReceived();
            end;

        }
        field(5; "BL No."; Code[30])
        {
            Caption = 'BL No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                //GetHeadDetails();
                CheckReceived();
            end;
        }
        field(6; "Container/Chassis No."; Code[30])
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
                CheckReceived();
            end;
        }
        field(7; "Seal/Engine No."; Code[30])
        {
            Caption = 'Seal/Engine No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                CheckReceived();
            end;
        }
        field(8; "Customs Seal No."; Code[30])
        {
            Caption = 'Customs Seal No.';
            DataClassification = ToBeClassified;
        }
        field(9; Marks; Text[30])
        {
            Caption = 'Marks';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                CheckReceived();
            end;
        }

        field(10; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }

        field(11; "Container Type"; Enum ContainerTypeEnum)
        {
            Caption = 'Container Type';
            DataClassification = ToBeClassified;
        }
        field(12; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }
        field(13; "Container lock"; Boolean)
        {
            Caption = 'Container lock';
            DataClassification = ToBeClassified;
        }
        field(14; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(15; "CBM Tonage"; Decimal)
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
        field(16; Weight; Decimal)
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
        field(17; "CBM-Wt Difference"; Decimal)
        {
            Caption = 'CBM-Wt Difference';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(18; "No. of Bags"; Decimal)
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
        field(19; "No. of Bags Released"; Decimal)
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
        field(20; "Remaining Bags"; Decimal)
        {
            Caption = 'Remaining Bags';
            DataClassification = ToBeClassified;
            //Editable = false;

        }
        field(21; "Port of Shipment"; Code[30])
        {
            Caption = 'Port of Shipment';
            DataClassification = ToBeClassified;
            TableRelation = Port;
        }
        field(22; "Port of Discharge"; Code[30])
        {
            Caption = 'Port of Discharge';
            DataClassification = ToBeClassified;
            TableRelation = Port;
        }
        field(23; "Destination Type"; Enum DestinationTypeEnum)
        {
            Caption = 'Destination Type';
            DataClassification = ToBeClassified;
        }
        field(24; "Consignee Name"; Text[100])
        {
            Caption = 'Consignee Name';
            DataClassification = ToBeClassified;
        }
        field(25; "Clearing Agent"; Code[30])
        {
            Caption = 'Clearing Agent';
            DataClassification = ToBeClassified;
            TableRelation = "Clearing Agent";
        }
        field(26; "ICDN In-Date"; Date)
        {
            Caption = 'ICDN In-Date';
            DataClassification = ToBeClassified;
        }
        field(27; "Verification Print Date"; Date)
        {
            Caption = 'Verification Print Date';
            DataClassification = ToBeClassified;
        }
        field(28; "Verification Type"; Enum "Verification TypeEnum")

        {
            Caption = 'Verification Type';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(29; "Allocated Position"; Code[30])
        {
            Caption = 'Allocated Position';
            DataClassification = ToBeClassified;
            TableRelation = Position;
            Editable = false;
        }
        field(30; "Date Received"; Date)
        {
            Caption = 'Date Received';
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(31; "Date Released"; Date)
        {
            Caption = 'Date Released';
            DataClassification = ToBeClassified;

        }
        field(32; "Driver Name"; Text[30])
        {
            Caption = 'Driver Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(33; "Driver ID"; Code[30])
        {
            Caption = 'Driver ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34; Vehicle; Code[30])
        {
            Caption = 'Vehicle';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(35; "Delivery Order No."; Text[30])
        {
            Caption = 'Delivery Order No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(36; "Received By"; Enum ReceivedByEnum)
        {
            Caption = 'Received By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(37; Verified; Boolean)
        {
            Caption = 'Verified';
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        field(38; "Verification Time"; Time)
        {
            Caption = 'Verification Time';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(39; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            //Editable = false;
        }
        field(40; "Final Destination"; Code[10])
        {
            Caption = 'Final Destination';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
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
        field(44; "Custom Entry No."; code[20])
        {
            caption = 'Custom Entry No.';
            DataClassification = ToBeClassified;
        }
        field(45; Received; Boolean)
        {
            Caption = 'Received';
            DataClassification = ToBeClassified;
        }
        field(46; "Received Time"; Time)
        {
            Caption = 'Received Time';
            DataClassification = ToBeClassified;
        }
        field(47; "Verification Notes"; text[50])
        {
            Caption = 'Verification Notes';
            DataClassification = ToBeClassified;
        }
        field(48; Released; Boolean)
        {
            Caption = 'Released';
            DataClassification = ToBeClassified;

        }
        field(49; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }


        field(50; "Consignee No."; code[20])
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
                    rec."Shortcut Dimension 3 Code" := CustRec."Salesperson Code"
                end else begin
                    rec."Consignee Name" := '';
                    rec."Shortcut Dimension 3 Code" := '';
                end;
            end;
        }
        field(51; "Job File Date"; Date)
        {
            Caption = 'Job File Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(52; "Discharge Date"; Date)
        {
            Caption = 'Discharge Date';
            DataClassification = ToBeClassified;
        }
        field(53; "Railed Date"; Date)
        {
            Caption = 'Railed Date';
            DataClassification = ToBeClassified;
        }
        field(54; "SICD In-Date"; Date)
        {
            Caption = 'SICD In-Date';
            DataClassification = ToBeClassified;
        }
        field(55; "Other remarks"; Text[250])
        {
            Caption = 'Other remarks';
            DataClassification = ToBeClassified;
        }
        field(56; "Client Reference No."; Text[100])
        {
            Caption = 'Client Reference No.';
            DataClassification = ToBeClassified;
        }
        field(57; "Invoicing Party No."; Code[20])
        {
            Caption = 'Invoicing Party No.';
            TableRelation = Customer;
            DataClassification = ToBeClassified;
        }
        field(58; "Seal Locked?"; Boolean)
        {
            Caption = 'Seal Locked?';
            DataClassification = ToBeClassified;
        }
        field(59; "Seal Tagged?"; Boolean)
        {
            Caption = 'Seal Tagged?';
            DataClassification = ToBeClassified;
        }
        field(60; "Lock No."; Text[100])
        {
            Caption = 'Lock No.';
            DataClassification = ToBeClassified;
        }
        // field(61; "Sales Person Code"; Code[20])
        // {
        //     Caption = 'Sales Person code';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Salesperson/Purchaser";
        // }
        field(61; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }
        field(62; "Sales Quote No."; Code[20])
        {
            Caption = 'Sales Quote No.';
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header";
        }
        field(63; "Oppertunity No."; Code[20])
        {
            Caption = ' Oppertunity No.';
            DataClassification = ToBeClassified;
            TableRelation = Opportunity;
        }
        field(64; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }


        field(66; "Stripping Date"; Date)
        {
            Caption = 'Stripping Date';
            DataClassification = ToBeClassified;
        }
        field(67; "Stripping Type"; Enum "Stripping TypeEnum")

        {
            Caption = 'Verification Type';
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
            ObsoleteReason = 'As per client request';
            Editable = false;
        }
        field(68; Stripped; Boolean)
        {
            Caption = 'Stripped';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(69; "Stripping Time"; Time)
        {
            Caption = 'Stripping Time';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70; "Stripping Notes"; text[50])
        {
            Caption = 'Stripping Notes';
            DataClassification = ToBeClassified;
        }
        field(71; "Parent Container ID"; Code[20])
        {
            Caption = 'Parent Container ID';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

        }
        field(72; "Empty Container"; Boolean)
        {
            Caption = 'Empty Container';
            DataClassification = ToBeClassified;
        }
        field(73; "GP Delivery Order No."; Code[30])
        {
            Caption = 'Delivery Order No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(74; "Landing Date"; Date)
        {
            Caption = 'Landing Date';
            DataClassification = ToBeClassified;
        }
        field(75; "Landing Time"; Time)
        {
            Caption = 'Landing Time';
            DataClassification = ToBeClassified;
        }
        field(76; "Docs Received Date"; Date)
        {
            Caption = 'Docs Received Date';
            DataClassification = ToBeClassified;
        }
        field(77; Invoices; Boolean)
        {
            Caption = 'Invoices';
            FieldClass = FlowField;
            CalcFormula = exist("Sales Invoice Line" WHERE("Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Code")));

        }
        field(78; "Credit Memos"; Boolean)
        {
            Caption = 'Credit Memos';
            FieldClass = FlowField;
            CalcFormula = exist("Sales Cr.Memo Line" WHERE("Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Code")));
        }
        field(79; "TBL/MH"; Enum TBLNTBLEnum)
        {
            Caption = 'TBL/MH';
            DataClassification = ToBeClassified;
        }
        field(80; Transporter; Text[50])
        {
            Caption = 'Transporter';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(ReceivingLog.Transporter where("Global Dimension 1 Code" = field("Global Dimension 1 Code")));

        }
        field(81; "Transporter Name"; Text[100])
        {
            Caption = 'Transporter Name';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(ReceivingLog."Transporter Name" where("Global Dimension 1 Code" = field("Global Dimension 1 Code")));
        }
        field(82; "Container Status"; Enum "Container Status Ext")
        {
            Caption = 'Container Status';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("Dimension Value"."Container Status" where(Code = field("Global Dimension 1 Code")));
        }
        field(83; "KPA Charges Calculated"; Boolean)
        {
            Caption = 'KPA Charges Calculated';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = exist("Purch. Inv. Line" WHERE("Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Code")));
        }

        field(85; "Shipping Agent"; code[30])
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
        field(86; "Shipping Agent Name"; text[40])
        {
            Caption = 'Shipping Agent Name';
            DataClassification = ToBeClassified;
            TableRelation = "Shipping Agent";
            Editable = false;
        }
        field(88; "Vessel Name"; Text[100])
        {
            Caption = 'Vessel Name';
            DataClassification = ToBeClassified;

        }
        field(89; "Voyage No."; code[30])
        {
            Caption = 'Voyage No.';
            DataClassification = ToBeClassified;
        }
        field(90; "Expected Arrival Date"; date)
        {
            Caption = 'Expected Arrival Date';
            DataClassification = ToBeClassified;
        }
        field(91; "Vessel Arrival Date"; date)
        {
            Caption = 'Vessel Arrival Date';
            DataClassification = ToBeClassified;
        }
        field(92; "Last Sling Date"; Date)
        {
            Caption = 'Last Sling Date';
            DataClassification = ToBeClassified;

        }
        field(93; "Vessel Arrival Time"; Time)
        {
            Caption = 'Vessel Arrival Time';
            DataClassification = ToBeClassified;
        }
        field(94; "No.Series"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(95; "Cargo Nomination No."; Code[40])
        {
            DataClassification = ToBeClassified;
            Caption = '"Cargo Nomination No."';
        }
    }
    keys
    {
        key(PK; "Job File No.", "Line No.")
        {
            Clustered = true;
        }
        key(k2; "Global Dimension 1 Code")
        {
        }
        key(k3; "Global Dimension 2 Code")
        {
        }
        key(k4; "Consignee No.")
        {
        }
        key(k5; "Invoicing Party No.")
        {
        }
        key(k6; "Shortcut Dimension 3 Code")
        {
        }
        key(k7; "Shortcut Dimension 4 Code")
        {
        }
        key(k8; "Shortcut Dimension 5 Code")
        {
        }
        key(k9; "Shortcut Dimension 6 Code")
        {
        }
        key(k10; "BL No.")
        {
        }
        key(k11; "Shortcut Dimension 5 Code", "Date Received")
        {

        }
        key(k12; "Shortcut Dimension 5 Code", "Date Released")
        {

        }
        key(k13; "Clearing Agent", "Date Released")
        {

        }
        key(k14; "Job File Date")
        {

        }
    }
    trigger OnInsert()
    var
        ImsSetup: Record "IMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        // Rec."User ID" := UserId;
        // Manifested := true;
        // rec."Job File Date" := TODAY();
        // if "Job File No." = '' then begin
        //     ImsSetup.get;
        //     ImsSetup.TestField("Job File Nos");
        //     NoSeriesMgt.InitSeries(ImsSetup."Job File Nos", xRec."Job File No.", 0D, "Job File No.", "No.Series");
        // end;

        //GetHeadDetails();
    end;

    procedure OnAssistEdit(ManifestRec: Record "Manifest Line"): Boolean
    var
        ManiRec: Record "Manifest Line";
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

    trigger OnDelete()
    var
        ManifestLine: Record "Manifest Line";
        UserSetup: Record "User Setup";
    begin
        if Rec.Received then
            error('This Manifest Line has transactions. You can not delete the Manifest No. %1 and Line No. %2. Please contact administrator', Rec."Job File No.", Rec."Line No.");
        UserSetup.get(UserId);
        if not UserSetup."Gatepass Approval" then
            Error('You do not have permission to delete. Please contact Group Audit');
    end;

    local procedure InsertDimensionValues(ContainerID: Code[20])
    var
        DimValueRec: Record "Dimension Value";
        GLSetupRec: Record "General Ledger Setup";
    begin
        GLSetupRec.Get();
        DimValueRec.Reset();
        DimValueRec.SetRange(Code, ContainerID);
        if DimValueRec.FindFirst() then
            Error('%1 Container ID is already Exist.', ContainerID)
        else begin
            DimValueRec.Init();
            DimValueRec.validate("Dimension Code", GLSetupRec."Global Dimension 1 Code");
            DimValueRec.Code := ContainerID;
            DimValueRec.Insert(true);
            DimValueRec.Validate(Name, rec."Container/Chassis No.");
            DimValueRec.Validate("Customer No.", rec."Consignee No.");
            DimValueRec.Validate("Customer Name", rec."Consignee Name");
            DimValueRec.Validate("BL No.", rec."BL No.");
            DimValueRec.Validate("Job File No.", REC."Job File No.");
            DimValueRec.Validate("Container/Chassis No.", rec."Container/Chassis No.");
            DimValueRec.Validate("Manifest Line No.", rec."Line No.");
            DimValueRec.validate("Container Status", DimValueRec."Container Status"::"Not Applicable");
            DimValueRec.Modify(true);
        end;
    end;

    // procedure GetHeadDetails()
    // var
    //     ManifestHeadRec: Record "Manifest Header";
    // begin
    //     ManifestHeadRec.Reset();
    //     ManifestHeadRec.SetRange("Job File No.", rec."Job File No.");
    //     if ManifestHeadRec.FindFirst() then begin
    //         rec.validate("Global Dimension 2 Code", ManifestHeadRec."Global Dimension 2 Code");
    //         rec.validate("Job File Date", ManifestHeadRec."Date File Opened");
    //         rec.validate(Manifested, true);
    //         rec.validate("Shortcut Dimension 6 Code", ManifestHeadRec."Shortcut Dimension 6 Code");
    //     end;
    // end;

    procedure CheckReceived()
    begin
        //      IF Received = true then
        //          error('Container already received')
        //      else
        //          exit;
    end;

    var
        ParentEditable: Boolean;
}
