table 50150 "Gate Pass Out"
{
    Caption = 'Gate Pass Out';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Gate Pass No."; Code[20])
        {
            Caption = 'Gate Pass No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                ImsSetup: Record "IMS Setup";
                NoSeriesMgmt: Codeunit "No. Series";
            begin
                if "Gate Pass No." <> xRec."Gate Pass No." then begin
                    ImsSetup.Get;
                    NoSeriesMgmt.TestManual(ImsSetup."Out Gate Pass Nos");
                    "NO.Series" := '';
                end;
            end;

        }
        field(2; "Invoice No."; Code[20])
        {
            Caption = 'Invoice No.';
            DataClassification = ToBeClassified;
            TableRelation = "Sales Invoice Header";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                // GetInvoiceDetails();
                GetReceiptNo();
            end;
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
                GPOLine: Record "Gate Pass Out Line";
                ClearingAgent: Record "Clearing Agent";
            begin
                ManifestLine.Reset();
                ManifestLine.SetRange(Received, true);
                //ManifestLine.SetRange(Verified, true);
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
                    //Rec.InsertGatePassLines();
                end;
            end;

        }
        field(5; "Receipt No."; Code[20])
        {
            Caption = 'Receipt No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Invoice Date"; Date)
        {
            Caption = 'Invoice Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Activity Date"; Date)
        {
            Caption = 'Activity Date';
            DataClassification = ToBeClassified;
            // Editable = false;
        }
        field(8; "Activity Time"; Time)
        {
            Caption = 'Activity Time';
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        field(9; "Container /Chasis No."; Code[20])
        {
            Caption = 'Container /Chasis No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Gate Pass Status"; Enum "Active/In-Active Enum")
        {
            Caption = 'Gate Pass Status';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "No. Of Bags"; Decimal)
        {
            Caption = 'No. Of Bags';
            DataClassification = ToBeClassified;
        }
        field(12; "Truck No."; Code[20])
        {
            Caption = 'Truck No.';
            DataClassification = ToBeClassified;
        }
        field(13; "Agent Name"; Text[20])
        {
            Caption = 'Agent Name';
            DataClassification = ToBeClassified;
        }
        field(14; "Agent Port Pass"; Code[20])
        {
            Caption = 'Agent Port Pass';
            DataClassification = ToBeClassified;
        }
        field(15; "Tranporter/Driver Name"; Text[40])
        {
            Caption = 'Tranporter/Driver Name';
            DataClassification = ToBeClassified;
        }
        field(16; Remarks; Text[50])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(22; "Trailer No."; Code[20])
        {
            Caption = 'Trailer No.';
            DataClassification = ToBeClassified;
        }


        field(23; "Position ID"; code[20])
        {
            Caption = 'Position ID';
            DataClassification = ToBeClassified;
            TableRelation = Position." Position ID" where(Status = const(Allocated));
            Editable = false;
        }
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
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            Editable = false;
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
        field(46; "Gate Pass Printed"; Boolean)
        {
            Caption = 'Gate Pass Printed';
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
        field(52; "Receipts Verified"; Boolean)
        {
            Caption = 'Receipts Verified';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(53; "Stripped Units"; Boolean)
        {

            DataClassification = ToBeClassified;

        }
        field(54; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }



    }
    keys
    {
        key(PK; "Gate Pass No.")
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
        if "Gate Pass No." = '' THEN begin
            ImsSetup.Get;
            ImsSetup.TestField("Out Gate Pass Nos");
            //NoSeriesMgt.InitSeries(ImsSetup."Out Gate Pass Nos", xRec."Gate Pass No.", 0D, "Gate Pass No.", "No.Series");
            "No.Series" := ImsSetup."Out Gate Pass Nos";
            if NoSeriesMgt.AreRelated(ImsSetup."Out Gate Pass Nos", xRec."No.Series") then
                "No.Series" := xRec."No.Series";
            "Gate Pass No." := NoSeriesMgt.GetNextNo("No.Series");
        end;
        rec."Activity Date" := Today();
        rec."Activity Time" := Time;

    end;

    trigger OnDelete()
    var
        GPLine: Record "Gate Pass out Line";
    begin
        GPLine.reset;
        GPLine.SetRange("Gate Pass No.", "Gate Pass No.");
        if GPLine.FindSet() then
            GPLine.DeleteAll();
    end;

    procedure AssistEdit(GatePassRec: Record "Gate Pass Out"): Boolean
    var
        GatePassRec1: Record "Gate Pass Out";
        ImsSetup: Record "IMS Setup";
        NoSeriesMgt: Codeunit "No. Series";

    begin
        GatePassRec1 := Rec;
        ImsSetup.GET;
        ImsSetup.TESTFIELD(ImsSetup."Out Gate Pass Nos");
        IF NoSeriesMgt.LookupRelatedNoSeries(ImsSetup."Out Gate Pass Nos", GatePassRec."No.Series", "No.Series") THEN BEGIN
            NoSeriesMgt.GetNextNo("Gate Pass No.");
            Rec := GatePassRec1;
            EXIT(TRUE);
        END;
    end;

    procedure PendingGateOut()
    var
        PostGatePass: Record "Posted Gate Pass Out";
        GatePassLineRec: Record "Gate Pass Out Line";
        PostGatePassLineRec: Record "Posted Gate Pass out Line";
    begin
        GatePassLineRec.Reset();
        GatePassLineRec.SetRange("Gate Pass No.", Rec."Gate Pass No.");
        IF not GatePassLineRec.FindFirst() then
            Error('There is nothing to post');
        PostGatePass.Init();
        PostGatePass.TransferFields(Rec);
        PostGatePass.Insert();
        //Lines//
        GatePassLineRec.Reset();
        GatePassLineRec.SetRange("Gate Pass No.", rec."Gate Pass No.");
        if GatePassLineRec.FindFirst() then
            repeat
                PostGatePassLineRec.Init();
                PostGatePassLineRec."Gate Pass No." := GatePassLineRec."Gate Pass No.";
                PostGatePassLineRec."Line No." := GatePassLineRec."Line No.";
                PostGatePassLineRec.Insert();
                PostGatePassLineRec."Invoice No." := GatePassLineRec."Invoice No.";
                PostGatePassLineRec."Global Dimension 1 Code" := GatePassLineRec."Global Dimension 1 Code";
                PostGatePassLineRec."Global Dimension 2 Code" := GatePassLineRec."Global Dimension 2 Code";
                PostGatePassLineRec."Shortcut Dimension 3 Code" := GatePassLineRec."Shortcut Dimension 3 Code";
                PostGatePassLineRec."Shortcut Dimension 4 Code" := GatePassLineRec."Shortcut Dimension 4 Code";
                PostGatePassLineRec."Shortcut Dimension 5 Code" := GatePassLineRec."Shortcut Dimension 5 Code";
                PostGatePassLineRec."Shortcut Dimension 6 Code" := GatePassLineRec."Shortcut Dimension 6 Code";
                PostGatePassLineRec."Container /Chasis No." := GatePassLineRec."Container /Chasis No.";
                PostGatePassLineRec."Job File No." := GatePassLineRec."Job File No";
                PostGatePassLineRec."BL No." := GatePassLineRec."BL No";
                PostGatePassLineRec."Invoice Date" := GatePassLineRec."Invoice Date";
                PostGatePassLineRec."Position ID" := GatePassLineRec."Position ID";
                PostGatePassLineRec."Consignee No." := GatePassLineRec."Consignee No.";
                PostGatePassLineRec."Consignee Name" := GatePassLineRec."Consignee Name";
                PostGatePassLineRec."Receipt No." := GatePassLineRec."Receipt No.";
                PostGatePassLineRec."Trailer No." := GatePassLineRec."Trailer No.";
                PostGatePassLineRec."Agent Port Pass" := GatePassLineRec."Agent Port Pass";
                PostGatePassLineRec."Agent Name" := GatePassLineRec."Agent Name";
                PostGatePassLineRec."DO No. Expiry date" := GatePassLineRec."DO No. Expiry date";
                PostGatePassLineRec."Truck No." := GatePassLineRec."Truck No.";
                PostGatePassLineRec."Tranporter/Driver Name" := GatePassLineRec."Tranporter/Driver Name";
                PostGatePassLineRec.Remarks := GatePassLineRec.Remarks;
                PostGatePassLineRec."Trailer No." := GatePassLineRec."Trailer No.";
                PostGatePassLineRec."No. Of Bags" := GatePassLineRec."No. Of Bags";
                PostGatePassLineRec."Custom Entry No." := GatePassLineRec."Custom Entry No.";
                PostGatePassLineRec."Delivery Order No." := GatePassLineRec."Delivery Order No.";
                PostGatePassLineRec."Payment Method" := GatePassLineRec."Payment Method";
                PostGatePassLineRec."Activity Date" := GatePassLineRec."Activity Date";
                PostGatePassLineRec."Activity Time" := GatePassLineRec."Activity Time";
                PostGatePassLineRec.Modify();
            until GatePassLineRec.next = 0;

        //Lines//   
        Delete();

        Message('%1 Printed & posted successfully', TableCaption);
    end;
    //for empty containers
    Procedure InsertEmptyGatepassLines()
    var

        ManifestLine: Record "Manifest Line";
        GManifestLine, TestManifestLine : Record "Manifest Line";
        ClosedCont: Integer;
        ManifestLookup: Page "Manifest lookup";
        EmptyContainerManifest: record "Manifest Line" temporary;
        SelectionFilter: Text;
    begin

        ClosedCont := 0;
        //EmptyContainerManifest.DeleteAll();
        if rec."Shortcut Dimension 6 Code" = 'EMPTY CONTAINER' Then begin
            ManifestLine.Reset();
            ManifestLine.SetRange("Shortcut Dimension 6 Code", Rec."Shortcut Dimension 6 Code");
            ManifestLine.SetRange(Released, False);
            if ManifestLine.FindSet() then
                repeat
                    EmptyContainerManifest.init();
                    EmptyContainerManifest.TransferFields(ManifestLine);
                    EmptyContainerManifest.Insert();
                until ManifestLine.Next() = 0;

            clear(ManifestLookup);
            ManifestLookup.SetTempManifest(EmptyContainerManifest);
            ManifestLookup.GetGPNo(Rec."Gate Pass No.");
            ManifestLookup.LookupMode(true);
            if ManifestLookup.RunModal = ACTION::LookupOK then begin

                GatePassLine.Reset();
                GatePassLine.SetRange("Gate Pass No.", Rec."Gate Pass No.");
                if GatePassLine.FindSet() then
                    if Confirm('Do you want to delete existing gate pass lines?', true) then
                        GatePassLine.DeleteAll()
                    else
                        exit;

                if EmptyContainerManifest.FindSet() then
                    repeat
                        if EmptyContainerManifest.Selected then
                            InsertEmptyContainerGatePassLine(EmptyContainerManifest);
                    until EmptyContainerManifest.Next() = 0;


            end;

        end else
            exit;
    End;

    Procedure InsertEmptyContainerGatePassLine(Var TempManifest: record "Manifest Line" temporary)
    var
        GatePassLine: record "Gate Pass Out Line";
        GPHead: record "Gate Pass Out";
        LineNo: Integer;
        SalesInvHead: Record "Sales Invoice Header";
        SalesInvLine: Record "Sales Invoice Line";
    begin
        GatePassLine.Reset();
        GatePassLine.SetRange("Gate Pass No.", Rec."Gate Pass No.");

        if GatePassLine.FindLast() then
            LineNo := GatePassLine."Line No." + 10000;


        GatePassLine.Init();
        GatePassLine."Gate Pass No." := Rec."Gate Pass No.";
        GatePassLine."Line No." := LineNo;
        GatePassLine.Insert();
        if TempManifest."Parent Container ID" <> '' then begin
            SalesInvLine.reset;
            SalesInvLine.SetRange("Shortcut Dimension 1 Code", TempManifest."Parent Container ID");
            SalesInvLine.SetRange("BL No.", TempManifest."BL No.");
            if SalesInvLine.FindFirst() then begin
                GatePassLine."Invoice No." := SalesInvLine."Document No.";
                GatePassLine."Invoice Date" := SalesInvLine."Posting Date";
            end;
        end;


        GatePassLine."Global Dimension 1 Code" := TempManifest."Global Dimension 1 Code";
        GatePassLine."Global Dimension 2 Code" := TempManifest."Global Dimension 2 Code";
        GatePassLine."Shortcut Dimension 3 Code" := TempManifest."Shortcut Dimension 3 Code";
        GatePassLine."Shortcut Dimension 4 Code" := TempManifest."Shortcut Dimension 4 Code";
        GatePassLine."Shortcut Dimension 5 Code" := TempManifest."Shortcut Dimension 5 Code";
        GatePassLine."Shortcut Dimension 6 Code" := TempManifest."Shortcut Dimension 6 Code";
        GatePassLine."Job File No" := TempManifest."Job File No.";
        GatePassLine."Container /Chasis No." := TempManifest."Container/Chassis No.";
        //GatePassLine."Position ID" := TempManifest.
        GatePassLine."BL No" := TempManifest."BL No.";
        //GatePassLine."Invoice Date" := SalesInvLine."Posting Date";
        GatePassLine."Consignee No." := TempManifest."Consignee No.";
        // GatePassLine."Gen. Bus. Posting Group" := SalesInvLine."Gen. Bus. Posting Group";
        // GatePassLine."Gen. Prod. Posting Group" := SalesInvLine."Gen. Prod. Posting Group";
        GatePassLine."Activity Date" := Rec."Activity Date";
        GatePassLine."Activity Time" := Rec."Activity Time";
        GatePassLine."Consignee Name" := TempManifest."Consignee Name";

        GatePassLine.Modify();
        //GetReceiptNo();

    end;
    //end of empty container

    procedure CheckPayments()
    var

        SalesInvLine: Record "Sales Invoice Line";
        EntryNo, LineNo : Integer;
        TempCustLedgEntry: Record "Cust. Ledger Entry" temporary;
        RecCustLedgEntry: Record "Cust. Ledger Entry";
        PageInvoiceStatus: Page InvoiceStatusList;
        PrevDocNo, PrevContainerNo : Code[20];
        CustledgEntry: Record "Cust. Ledger Entry";
        Customer: Record Customer;
        Overdue: Boolean;
        GPNo: Code[20];
        ManifestLine: Record "Manifest Line";
        ManifestLookup: Page "Manifest lookup";
        TempSelectedContainers: record "Manifest Line" temporary;


    begin
        CustledgEntry.Reset();
        CustledgEntry.SetRange("Customer No.", rec."Consignee No.");
        CustledgEntry.CalcFields("Remaining Amount");
        CustledgEntry.SetFilter("Remaining Amount", '>%1', 0);
        CustledgEntry.SetFilter("Due Date", '<=%1', Today);
        if CustledgEntry.FindSet() then
            Overdue := true;
        if not Overdue then begin
            if Customer.Get(rec."Consignee No.") then begin

                //if Customer.Get(CustledgEntry."Customer No.") then begin
                if Customer."Credit Limit (LCY)" > Customer."Balance (LCY)" then begin
                    Rec.Approved := true;
                    Rec.Modify();
                end;
            end;
        end else begin
            if not Rec.Approved then
                Error('Customer has overdue payments. Please check and try again');
        end;
        SalesInvLine.Reset();
        SalesInvLine.SetRange("BL No.", "BL No.");
        SalesInvLine.CalcFields(Cancelled);
        SalesInvLine.SetRange(Cancelled, false);
        if SalesInvLine.FindSet() then begin
            if not rec."Stripped Units" then begin
                LineNo := 0;
                repeat
                    EntryNo := 0;
                    //TempCustLedgEntry.DeleteAll();
                    IF PrevDocNo <> SalesInvLine."Document No." then begin
                        RecCustLedgEntry.Reset();
                        RecCustLedgEntry.SetRange("Document No.", SalesInvLine."Document No.");
                        if RecCustLedgEntry.FindFirst() then
                            repeat
                                //Message(Format(RecCustLedgEntry."Document No."));
                                TempCustLedgEntry.Init();
                                TempCustLedgEntry."Entry No." := RecCustLedgEntry."Entry No.";
                                TempCustLedgEntry."Document Type" := RecCustLedgEntry."Document Type";
                                TempCustLedgEntry."Document Date" := RecCustLedgEntry."Document Date";
                                TempCustLedgEntry."Document No." := RecCustLedgEntry."Document No.";
                                TempCustLedgEntry."Posting Date" := RecCustLedgEntry."Posting Date";
                                TempCustLedgEntry.Amount := RecCustLedgEntry.Amount;
                                TempCustLedgEntry."Customer No." := RecCustLedgEntry."Customer No.";
                                TempCustLedgEntry."Customer Name" := RecCustLedgEntry."Customer Name";
                                TempCustLedgEntry."Remaining Amount" := RecCustLedgEntry."Remaining Amount";
                                TempCustLedgEntry."Currency Code" := RecCustLedgEntry."Currency Code";
                                TempCustLedgEntry.Insert();

                            until RecCustLedgEntry.Next() = 0;

                        PrevDocNo := SalesInvLine."Document No.";
                    end;
                until SalesInvLine.Next() = 0;

                // if page.RunModal(50200, TempCustLedgEntry) = ACTION::LookupOK then begin
                // end;
                clear(PageInvoiceStatus);
                PageInvoiceStatus.SetTableView(TempCustLedgEntry);
                PageInvoiceStatus.SetRecord(TempCustLedgEntry);
                PageInvoiceStatus.GetGPNo(Rec."Gate Pass No.");
                PageInvoiceStatus.LookupMode(true);
                COMMIT;
                if PageInvoiceStatus.RunModal = ACTION::LookupOK then begin
                end;
            end else begin
                //Adding the stripped units flow for ones with the parent id

                ManifestLine.Reset();
                ManifestLine.SetRange("BL No.", SalesInvLine."BL No.");
                ManifestLine.SetFilter("Parent Container ID", '<>%1', '');
                ManifestLine.SetRange(Released, False);
                if ManifestLine.FindSet() then
                    repeat
                        TempSelectedContainers.init();
                        //TempSelectedContainers.TransferFields(ManifestLine);
                        TempSelectedContainers."Global Dimension 1 Code" := ManifestLine."Global Dimension 1 Code";
                        TempSelectedContainers."Global Dimension 2 Code" := ManifestLine."Global Dimension 2 Code";
                        TempSelectedContainers."Shortcut Dimension 3 Code" := ManifestLine."Shortcut Dimension 3 Code";
                        TempSelectedContainers."Shortcut Dimension 4 Code" := ManifestLine."Shortcut Dimension 4 Code";
                        TempSelectedContainers."Shortcut Dimension 5 Code" := ManifestLine."Shortcut Dimension 5 Code";
                        TempSelectedContainers."Shortcut Dimension 6 Code" := ManifestLine."Shortcut Dimension 6 Code";
                        TempSelectedContainers."Job File No." := ManifestLine."Job File No.";
                        TempSelectedContainers."BL No." := ManifestLine."BL No.";
                        TempSelectedContainers."Consignee No." := ManifestLine."Consignee No.";
                        TempSelectedContainers."Consignee Name" := ManifestLine."Consignee Name";
                        TempSelectedContainers."Parent Container ID" := ManifestLine."Parent Container ID";
                        TempSelectedContainers."Container/Chassis No." := ManifestLine."Container/Chassis No.";
                        TempSelectedContainers."Line No." := ManifestLine."Line No.";

                        TempSelectedContainers.Insert();
                    until ManifestLine.Next() = 0;
                clear(ManifestLookup);
                ManifestLookup.SetTableView(TempSelectedContainers);
                ManifestLookup.SetRecord(TempSelectedContainers);
                ManifestLookup.GetGPNo(Rec."Gate Pass No.");
                ManifestLookup.LookupMode(true);
                if ManifestLookup.RunModal = ACTION::LookupOK then begin

                end;
            end;

        end else
            Message('Invoice  not found');

    End;

    procedure InsertGatePassLines()
    var
        SalesInvHead: Record "Sales Invoice Header";
        LSalesInvLine, GSalesInvLine, SalesInvLine : Record "Sales Invoice Line";
        ContainerInvLine: Record "Sales Invoice Line";
        ContainerRec: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        GPLine, GatePassLine : Record "Gate Pass Out Line";
        PostedGateOutHead: Record "Posted Gate Pass Out";
        PostedGateOutLine: Record "Posted Gate Pass out Line";
        PaymentTerms, PaymentMethod : Code[20];
        Cust: Record Customer;
        BaseOn: Enum "Base On Enum";
        ChargeGroupHead: Record "Charge ID Group Header";
        ChargeGroupLine: Record "Charge ID Group Line";
        BilledStorageDays, RemainingDays, CurrentStorageDays, FreeDays, LineNo : Integer;
        InvoiceCount: Integer;
        ManifestLine: Record "Manifest Line";
        GManifestLine, TestManifestLine : Record "Manifest Line";
        ClosedCont: Integer;

        StorageStartDate: Date;
        PrevDocNo, PrevContainerNo : Code[20];
    begin

        LineNo := 0;
        InvoiceCount := 0;
        ClosedCont := 0;
        GPLine.Reset();
        GPLine.SetRange("Gate Pass No.", rec."Gate Pass No.");
        IF GPLine.FindSet() then begin
            IF Confirm('Do you want to delete the existing lines?', true) then
                GPLine.DeleteAll()
            else
                exit;
        end;

        SalesInvLine.Reset();
        SalesInvLine.SetCurrentKey("Shortcut Dimension 1 Code");
        SalesInvLine.SetAscending("Shortcut Dimension 1 Code", true);
        SalesInvLine.SetRange("BL No.", "BL No.");
        SalesInvLine.CalcFields(Cancelled);
        SalesInvLine.SetRange(Cancelled, false);
        if SalesInvLine.FindSet() then begin
            repeat
                // SalesInvHead.Reset();
                // SalesInvHead.SetRange("No.", SalesInvLine."Document No.");
                // if SalesInvHead.FindFirst() then begin
                //     SalesInvHead.CalcFields(Cancelled);
                //     if SalesInvHead.Cancelled then
                //         error('cancelled invoice');
                // end;

                IF PrevContainerNo <> SalesInvLine."Shortcut Dimension 1 Code" then begin
                    PrevContainerNo := SalesInvLine."Shortcut Dimension 1 Code";

                    PostedGateOutLine.Reset();
                    PostedGateOutLine.SetRange("BL No.", "BL No.");
                    PostedGateOutLine.SetRange("Invoice No.", SalesInvLine."Document No.");
                    PostedGateOutLine.SetRange("Global Dimension 1 Code", SalesInvLine."Shortcut Dimension 1 Code");
                    PostedGateOutLine.SetRange("Gate Pass Status", PostedGateOutLine."Gate Pass Status"::Active);
                    IF not PostedGateOutLine.FindFirst() then begin
                        SalesInvHead.Reset();
                        SalesInvHead.SetRange("No.", SalesInvLine."Document No.");
                        IF SalesInvHead.FindFirst() then begin
                            PaymentMethod := SalesInvHead."Payment Method Code";
                            PaymentTerms := SalesInvHead."Payment Terms Code";
                            SalesInvHead.CalcFields(Closed);
                            if not Rec.Approved then begin
                                if SalesInvHead.Closed <> true then
                                    Error('Invoice %1 is not paid. Please check and try again', SalesInvHead."No.");
                            end;
                        end else begin
                            PaymentMethod := '';
                            PaymentTerms := '';
                        end;
                        GLSetup.get();
                        ContainerRec.Reset();
                        ContainerRec.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
                        ContainerRec.SetRange(ContainerRec.Code, SalesInvLine."Shortcut Dimension 1 Code");
                        ContainerRec.SetRange("Container Status", ContainerRec."Container Status"::"In Stock");
                        if ContainerRec.FindFirst() then begin

                            //new code for extra
                            LSalesInvLine.Reset();
                            LSalesInvLine.SetRange("BL No.", "BL No.");
                            if LSalesInvLine.FindLast() then
                                If LSalesInvLine."Posting Date" <> Today then begin

                                    GSalesInvLine.Reset();
                                    GSalesInvLine.SetCurrentKey("Document No.");
                                    GSalesInvLine.SetRange("Shortcut Dimension 1 Code", PrevContainerNo);
                                    GSalesInvLine.SetFilter("Chargable Storage Days", '<>%1', 0);
                                    if GSalesInvLine.FindFirst() then begin
                                        repeat
                                            //FreeDays := GSalesInvLine."Free Days";
                                            //BilledStorageDays := GSalesInvLine."Chargable Storage Days";
                                            if PrevDocNo <> GSalesInvLine."Document No." then begin
                                                BilledStorageDays := GSalesInvLine."Storage Days" - GSalesInvLine."Free Days" + BilledStorageDays;
                                            end;
                                            PrevDocNo := GSalesInvLine."Document No.";
                                        until GSalesInvLine.Next() = 0;
                                    end;
                                    GSalesInvLine.Reset();
                                    GSalesInvLine.SetRange("Shortcut Dimension 1 Code", PrevContainerNo);
                                    if GSalesInvLine.FindFirst() then begin
                                        if ChargeGroupHead.Get(GSalesInvLine."Charge ID") then begin
                                            BaseOn := ChargeGroupHead."Base On";
                                            ChargeGroupLine.Reset();
                                            ChargeGroupLine.SetRange("Charge ID Group Code", ChargeGroupHead."Charge ID Group Code");
                                            ChargeGroupLine.Setfilter("Free Days", '<>%1', 0);
                                            if ChargeGroupLine.FindFirst() then
                                                FreeDays := ChargeGroupLine."Free Days"
                                            else
                                                FreeDays := 0;
                                        end;

                                        ManifestLine.Reset();
                                        ManifestLine.SetRange("Job File No.", GSalesInvLine."Job File No.");
                                        ManifestLine.SetRange("Global Dimension 1 Code", GSalesInvLine."Shortcut Dimension 1 Code");
                                        IF ManifestLine.FindFirst() then begin
                                            if BaseOn = BaseOn::"Received Date" then begin
                                                // TestManifestLine.Reset();
                                                // TestManifestLine.SetRange("Global Dimension 1 Code", GSalesInvLine."Shortcut Dimension 1 Code");
                                                // IF TestManifestLine.FindFirst() then begin
                                                StorageStartDate := ManifestLine."Date Received"
                                                // end;
                                            end;
                                            IF BaseOn = BaseOn::"ETA Date" then
                                                StorageStartDate := ManifestLine."Expected Arrival Date";
                                            IF BaseOn = BaseOn::"Last Sling Date" then
                                                StorageStartDate := ManifestLine."Last Sling Date";
                                            IF BaseOn = BaseOn::ActualDate then
                                                StorageStartDate := ManifestLine."Vessel Arrival Date";
                                        end;
                                        // IF StorageStartDate <> 0D then begin
                                        //     IF ChargeGroupHead."Start After" > 1 then
                                        //         AfterBaseOnDate := CalcDate(FORMAT(ChargeGroupHead."Start After") + 'D', StorageStartDate)
                                        //     else
                                        //         AfterBaseOnDate := StorageStartDate;
                                        // end;
                                        if StorageStartDate <> 0D then
                                            CurrentStorageDays := Today - StorageStartDate;
                                    end;

                                    if CurrentStorageDays > FreeDays then begin
                                        RemainingDays := CurrentStorageDays - FreeDays - BilledStorageDays;
                                        // if not Approved then
                                        error('Extra storage days to be billed: Please Contact Audit \ Total Storage Days %1,\ Free Days %2,\ Billed Storage Days %3,\ Remaining Days to be billed %4', CurrentStorageDays, FreeDays, BilledStorageDays, RemainingDays);
                                    end;
                                    //      else
                                    //        exit;
                                end;
                            //new code for extra storage

                            //for additional verification charges
                            CheckVerificationCharges(SalesInvLine."Shortcut Dimension 1 Code");
                            //for additional verification charges
                            //for additional storage
                            CheckAdditionalCharges(SalesInvLine."Shortcut Dimension 1 Code");
                            //for additional storage
                            GatePassLine.Reset();
                            GatePassLine.SetRange(GatePassLine."Gate Pass No.", Rec."Gate Pass No.");
                            IF GatePassLine.FindLast() then
                                LineNo := GatePassLine."Line No." + 10000;
                            GatePassLine.Init();
                            GatePassLine."Gate Pass No." := Rec."Gate Pass No.";
                            GatePassLine."Line No." := LineNo;
                            GatePassLine.Insert();
                            GatePassLine."Invoice No." := SalesInvLine."Document No.";
                            GatePassLine."Global Dimension 1 Code" := SalesInvLine."Shortcut Dimension 1 Code";
                            //
                            GManifestLine.Reset();
                            GManifestLine.SetRange("Global Dimension 1 Code", SalesInvLine."Shortcut Dimension 1 Code");
                            GManifestLine.SetRange("BL No.", SalesInvLine."BL No.");
                            if GManifestLine.FindFirst() then begin
                                GatePassLine."Global Dimension 2 Code" := GManifestLine."Global Dimension 2 Code";
                                GatePassLine."Shortcut Dimension 3 Code" := GManifestLine."Shortcut Dimension 3 Code";
                                GatePassLine."Shortcut Dimension 4 Code" := GManifestLine."Shortcut Dimension 4 Code";
                                GatePassLine."Shortcut Dimension 5 Code" := GManifestLine."Shortcut Dimension 5 Code";
                                GatePassLine."Shortcut Dimension 6 Code" := GManifestLine."Shortcut Dimension 6 Code";
                                GatePassLine."Job File No" := GManifestLine."Job File No.";
                                GatePassLine."Container /Chasis No." := GManifestLine."Container/Chassis No.";
                            end;

                            GatePassLine."Position ID" := SalesInvLine."Position ID";
                            // GatePassLine."Global Dimension 2 Code" := SalesInvLine."Shortcut Dimension 2 Code";
                            // GatePassLine."Shortcut Dimension 3 Code" := SalesInvLine."Shortcut Dimension 3 Code";
                            // GatePassLine."Shortcut Dimension 4 Code" := SalesInvLine."Shortcut Dimension 4 Code";
                            // GatePassLine."Shortcut Dimension 5 Code" := SalesInvLine."Shortcut Dimension 5 Code";
                            // GatePassLine."Shortcut Dimension 6 Code" := SalesInvLine."Shortcut Dimension 6 Code";
                            // GatePassLine."Job File No" := SalesInvLine."Job File No.";
                            GatePassLine."Position ID" := SalesInvLine."Position ID";
                            //GatePassLine."Container /Chasis No." := SalesInvLine."Container No./Chassis No.";
                            GatePassLine."BL No" := SalesInvLine."BL No.";
                            GatePassLine."Invoice Date" := SalesInvLine."Posting Date";
                            GatePassLine."Consignee No." := SalesInvLine."Sell-to Customer No.";
                            GatePassLine."Gen. Bus. Posting Group" := SalesInvLine."Gen. Bus. Posting Group";
                            GatePassLine."Gen. Prod. Posting Group" := SalesInvLine."Gen. Prod. Posting Group";
                            GatePassLine."Payment Method" := PaymentMethod;
                            GatePassLine."Payment Terms" := PaymentTerms;
                            GatePassLine."Activity Date" := rec."Activity Date";
                            GatePassLine."Activity Time" := rec."Activity Time";
                            if Cust.get(SalesInvLine."Sell-to Customer No.") then
                                GatePassLine."Consignee Name" := Cust.Name;
                            GatePassLine.modify;
                            InvoiceCount := InvoiceCount + 1;
                        end else
                            PrevContainerNo := SalesInvLine."Shortcut Dimension 1 Code";
                    end;
                end;
            until SalesInvLine.Next() = 0;
            GetReceiptNo();
        end else
            Message('Invoice does not found');

    end;

    procedure CheckVerificationCharges(l_ContID: code[20])
    var
        VerificationLog: Record VerificationLog;
    begin
        VerificationLog.Reset();
        VerificationLog.SetRange("Global Dimension 1 Code", l_ContID);
        VerificationLog.SetRange(Invoiced, false);
        if VerificationLog.FindFirst() then begin
            if VerificationLog."Verification Type" <> VerificationLog."Verification Type"::Sighting then
                Error('Unbilled verification Charges found. Please check and try again');
        end;
    end;

    procedure CheckAdditionalCharges(l_ContID: code[20])
    var
        SalesInvHead: Record "Sales Invoice Header";
        LSalesInvLine, GSalesInvLine, SalesInvLine : Record "Sales Invoice Line";
        ContainerInvLine: Record "Sales Invoice Line";
        ContainerRec: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        Cust: Record Customer;
        AddCharge: Record "Additional Charges - Receiving";
        InvoiceCount: Integer;
        GManifestLine, TestManifestLine : Record "Manifest Line";
        ClosedCont: Integer;
        PrevDocNo, PrevContainerNo : Code[20];
    begin

        InvoiceCount := 0;
        ClosedCont := 0;
        AddCharge.Reset();
        AddCharge.SetRange(AddCharge."Container ID", l_ContID);
        if AddCharge.FindFirst() then begin
            repeat
                SalesInvLine.Reset();
                SalesInvLine.SetCurrentKey("Shortcut Dimension 1 Code");
                SalesInvLine.SetAscending("Shortcut Dimension 1 Code", true);
                SalesInvLine.SetRange("Shortcut Dimension 1 Code", AddCharge."Container ID");
                SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
                SalesInvLine.SetRange("No.", AddCharge."Charges Code");
                SalesInvLine.CalcFields(Cancelled);
                SalesInvLine.SetRange(Cancelled, false);
                if not SalesInvLine.FindFirst() then
                    Error('Additional charges not billed for the Container ID %1. Please check and try again', AddCharge."Container ID");
            until AddCharge.Next() = 0;
        end;
    end;

    procedure GetReceiptNo()
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        ApplyCustLedgEntry: Record "Cust. Ledger Entry";
        GatePassLineRec: Record "Gate Pass Out Line";
    begin
        GatePassLineRec.Reset();
        GatePassLineRec.SetRange("Gate Pass No.", rec."Gate Pass No.");
        if GatePassLineRec.FindSet() then begin
            repeat
                CustLedgEntry.Reset();
                CustLedgEntry.SetRange("Document No.", GatePassLineRec."Invoice No.");
                CustLedgEntry.SetRange(Open, false);
                IF CustLedgEntry.FindFirst() then begin
                    ApplyCustLedgEntry.Reset();
                    ApplyCustLedgEntry.SetRange("Entry No.", CustLedgEntry."Closed by Entry No.");
                    if ApplyCustLedgEntry.FindFirst() then begin
                        GatePassLineRec."Receipt No." := ApplyCustLedgEntry."Document No.";
                        GatePassLineRec.Modify();
                    end;
                end else begin
                    Message('Receipt not found');
                    exit;
                end;
            //exit;
            until GatePassLineRec.next = 0;
        end;
    end;

    var
        GatePassLine: Record "Gate Pass Out Line";


}

