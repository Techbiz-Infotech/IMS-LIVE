table 50135 ImportManifest
{
    Caption = 'ImportManifest';
    DataClassification = ToBeClassified;

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
        field(3; "BL No."; Code[30])
        {
            Caption = 'BL No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                //ContainerIdUpdate();
            end;

        }
        field(4; "Container/Chassis No."; Code[20])
        {
            Caption = 'Container/Chassis No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
                strtxt: text;
                ContDim: Code[20];
            begin


            end;

        }

        field(5; Marks; Text[30])
        {
            Caption = 'Marks';
            DataClassification = ToBeClassified;
        }

        field(6; "Container ID"; Code[20])
        {
            Caption = 'Container ID';
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            begin

            end;
        }

        field(7; "Container Type"; Code[20])
        {
            Caption = 'Container Type';
            DataClassification = ToBeClassified;
        }
        field(8; "Container size"; Code[20])
        {
            Caption = 'Container Size';
            DataClassification = ToBeClassified;
        }
        field(9; "Container lock"; Boolean)
        {
            Caption = 'Container lock';
            DataClassification = ToBeClassified;
        }
        field(10; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(11; "CBM Tonage"; Decimal)
        {
            Caption = 'CBM Tonage';
            DataClassification = ToBeClassified;

        }
        field(12; Weight; Decimal)
        {
            Caption = 'Weight';
            DataClassification = ToBeClassified;

        }
        field(13; "Port of Shipment"; Code[30])
        {
            Caption = 'Port of Shipment';
            DataClassification = ToBeClassified;

        }
        field(14; "Port of Discharge"; Code[30])
        {
            Caption = 'Port of Discharge';
            DataClassification = ToBeClassified;

        }
        field(15; "Destination Type"; Code[20])
        {
            Caption = 'Destination Type';
            DataClassification = ToBeClassified;
        }
        field(16; "Consignee Name"; Text[100])
        {
            Caption = 'Consignee Name';
            DataClassification = ToBeClassified;
        }
        field(17; "Clearing Agent"; Code[30])
        {
            Caption = 'Clearing Agent';
            DataClassification = ToBeClassified;

        }

        field(18; "Invoicing Party No."; Code[20])
        {
            Caption = 'Invoicing Party No.';

            DataClassification = ToBeClassified;
        }
        field(19; "Seal/Engine No."; Code[30])
        {
            Caption = 'Seal/Engine No.';
            DataClassification = ToBeClassified;
        }
        field(20; "Customs Seal No."; Code[30])
        {
            Caption = 'Customs Seal No.';
            DataClassification = ToBeClassified;
        }
        field(21; Remarks; Text[2000])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(22; "Consignee No."; code[20])
        {
            Caption = 'Consignee No.';
            DataClassification = ToBeClassified;
        }
        field(23; "Cargo Type"; code[20])
        {
            Caption = 'Cargo Type';
            DataClassification = ToBeClassified;
        }

        field(25; "Client Type"; Code[30])
        {
            Caption = 'Client Type';
            DataClassification = ToBeClassified;
        }
        field(26; "Sales Person"; Code[20])
        {
            Caption = 'Sales Person';
            DataClassification = ToBeClassified;
        }
        field(27; "Process Type"; code[20])
        {
            Caption = 'Process Type';
            DataClassification = ToBeClassified;
        }

        field(28; "Shipping Agent"; code[30])
        {
            Caption = 'Shipping Agent';
            DataClassification = ToBeClassified;
            // TableRelation = "Shipping Agent";
            trigger Onvalidate()
            var
                ShipAgentRec: Record "Shipping Agent";
            begin
                ShipAgentRec.get(rec."Shipping Agent");
                rec."Shipping Agent Name" := ShipAgentRec.Name;
            end;
        }
        field(29; "Shipping Agent Name"; text[40])
        {
            Caption = 'Shipping Agent Name';
            DataClassification = ToBeClassified;
            TableRelation = "Shipping Agent";
            Editable = false;
        }
        field(30; "Vessel Name"; Text[100])
        {
            Caption = 'Vessel Name';
            DataClassification = ToBeClassified;

        }
        field(31; "Voyage No."; code[30])
        {
            Caption = 'Voyage No.';
            DataClassification = ToBeClassified;
        }
        field(32; "Expected Arrival Date"; date)
        {
            Caption = 'Expected Arrival Date';
            DataClassification = ToBeClassified;
        }
        field(33; "Vessel Arrival Date"; date)
        {
            Caption = 'Vessel Arrival Date';
            DataClassification = ToBeClassified;
        }
        field(34; "Last Sling Date"; Date)
        {
            Caption = 'Last Sling Date';
            DataClassification = ToBeClassified;

        }
        field(35; "Vessel Arrival Time"; Time)
        {
            Caption = 'Vessel Arrival Time';
            DataClassification = ToBeClassified;
        }
        field(36; "Job File Date"; Date)
        {
            Caption = 'Job File Date';
            DataClassification = ToBeClassified;
            // Editable = false;
        }
        field(37; "Parent Container ID"; Code[20])
        {
            Caption = 'Parent Container ID';
            DataClassification = ToBeClassified;
            // TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

        }
        field(38; "TBL/MH"; Code[20])
        {
            Caption = 'TBL/MH';
            DataClassification = ToBeClassified;
            // TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

        }



    }
    keys
    {
        key(Pk1; "Job File No.", "Line No.")
        {
            Clustered = true;
        }

    }
    var
        ContainerId: Code[20];


    procedure ImportManifestProcess()
    var
        ImportWS: Record ImportManifest;
        strtxt: text;
        ContDim2, ContDim : Code[20];
        DimValue: Record "Dimension Value";
    begin
        ImportWS.Reset();
        // ImportWS.SetRange("Job File No.", JobFileNo);
        if ImportWS.FindFirst() then
            repeat
                if (ImportWS."BL No." <> '') and (ImportWS."Container/Chassis No." <> '') then begin
                    strtxt := ImportWS."Container/Chassis No.";
                    if strlen(strtxt) > 14 then
                        ContDim := CopyStr(strtxt, STRLEN(strtxt) - 13, 14) + '-' + CopyStr(ImportWS."BL No.", 1, 5)
                    else
                        ContDim := strtxt + '-' + CopyStr(ImportWS."BL No.", StrLen(ImportWS."BL No.") - 4, 5);
                end else
                    ContDim := '';
                if ContDim = '' then begin
                    if DimValue.FindFirst() then
                        if ImportWS.Remarks <> '' then
                            ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Container ID Can not be Created.'
                        else
                            ImportWS.Remarks := 'Container ID Can not be Created.';
                end;
                ImportWS.Validate("Container ID", ContDim);
                ImportWS.Modify();
            until ImportWS.Next() = 0;
    end;

    procedure ImportManifestValidate()
    var
        Lenth: Integer;
        SpecialCharsErr: Label 'You can not enter special characters';
        SpecialChars: Label '|!|@|#|$|%|&|*|(|)|_|-|+|=|?';
        Newstring: Text;
        i: Integer;
        Var2: Text;
        CustRec: Record Customer;
        ImportWS3, ImportWS2, ImportWS : Record ImportManifest;
        Alphabets: Label 'A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z';
        Numerics: Label '0|1|2|3|4|5|6|7|8|9';
        myInt: Integer;
        strtxt: text;
        ContDim2, ContDim : Code[20];
        Dimvalue: Record "Dimension Value";
        GLsetup: Record "General Ledger Setup";
        StyleExprTxt: Text;
        CustRec1: Record Customer;
        ShippingAgent: Record "Shipping Agent";
        ClearingAgent: Record "Clearing Agent";
        Port1, Port : Record Port;
        MFLine: Record "Manifest Line";

    begin
        Rec.ImportManifestProcess();
        ImportWS.Reset();
        //ImportWS.SetRange("Job File No.", JobFileNo);
        if ImportWS.FindFirst() then
            repeat
                ImportWS.Remarks := '';
                if ImportWS."Cargo Type" = 'CONTAINER' then begin
                    Var2 := CopyStr(ImportWS."Container/Chassis No.", 1, 4);
                    NewString := DELCHR(Var2, '=', Alphabets);
                    IF NewString <> '' THEN begin
                        if ImportWS.Remarks <> '' then
                            ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'First 4 letters must be alphabets'
                        else
                            ImportWS.Remarks := 'First 4 letters must be alphabets';
                    end;
                    Var2 := CopyStr(ImportWS."Container/Chassis No.", 5, 11);
                    Newstring := DelChr(Var2, '=', Numerics);
                    if Newstring <> '' then begin
                        if ImportWS.Remarks <> '' then
                            ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Remaining 7 shoulbe be numbers'
                        else
                            ImportWS.Remarks := 'Remaining 7 shoulbe be numbers';
                    end;
                    if StrLen(ImportWS."Container/Chassis No.") < 11 then begin
                        if ImportWS.Remarks <> '' then
                            ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Container/Chassis No.of digits should not be less than 11'
                        else
                            ImportWS.Remarks := 'No.of digits should not be less than 11';
                    end;
                    if StrLen(ImportWS."Container/Chassis No.") > 11 then begin
                        if ImportWS.Remarks <> '' then
                            ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Container/Chassis No.of digits should not be greater than 11'
                        else
                            ImportWS.Remarks := 'Container/Chassis No.of digits should not be greater than 11';
                    end;
                    CLEAR(Lenth);
                    Lenth := STRLEN(DELCHR(ImportWS."Container/Chassis No.", '=', DELCHR(ImportWS."Container/Chassis No.", '=', SpecialChars)));
                    IF Lenth > 0 THEN begin
                        if ImportWS.Remarks <> '' then
                            ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'You can not enter special characters'
                        else
                            ImportWS.Remarks := 'You can not enter special characters';
                    end;

                end;
                if ImportWS."BL No." = '' then begin
                    if ImportWS.Remarks <> '' then
                        ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'BL No. does not exist.'
                    else
                        ImportWS.Remarks := 'BL No. does not exist.'
                end;
                if ImportWS."Seal/Engine No." = '' then begin
                    if ImportWS.Remarks <> '' then
                        ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Seal/Engine No. does not exist.'
                    else
                        ImportWS.Remarks := 'Seal/Engine No. does not exist.';
                end;
                GLsetup.Get();
                DimValue.Reset();
                Dimvalue.SetRange("Dimension Code", GLsetup."Shortcut Dimension 4 Code");
                DimValue.SetRange(Code, ImportWS."Cargo Type");
                if not DimValue.FindFirst() then
                    //if ImportWS."Cargo Type" = '' then begin
                    if ImportWS.Remarks <> '' then
                        ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Cargo Type does not exist.'
                    else
                        ImportWS.Remarks := 'Cargo Type does not exist.';

                if ImportWS."Container/Chassis No." = '' then begin
                    if ImportWS.Remarks <> '' then
                        ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Container/Chassis No. does not exist.'
                    else
                        ImportWS.Remarks := 'Container/Chassis No. does not exist.';

                end;
                if ImportWS."Container Type" = '' then begin
                    if ImportWS.Remarks <> '' then
                        ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Container Type does not exist.'
                    else
                        ImportWS.Remarks := 'Container Type does not exist.'
                end;
                if StrPos(CompanyName, 'MICT') = 0 then begin
                    if ImportWS."TBL/MH" = '' then begin
                        if ImportWS.Remarks <> '' then
                            ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'TBL/MH does not exist.'
                        else
                            ImportWS.Remarks := 'TBL/MH does not exist.'
                    end;
                end;
                GLsetup.Get();
                DimValue.Reset();
                Dimvalue.SetRange("Dimension Code", GLsetup."Shortcut Dimension 5 Code");
                DimValue.SetRange(Code, ImportWS."Container size");
                if not DimValue.FindFirst() then
                    //if ImportWS."Container size" = '' then begin
                    if ImportWS.Remarks <> '' then
                        ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Container size does not exist.'
                    else
                        ImportWS.Remarks := 'Container size does not exist.';
                if ImportWS.Description = '' then begin
                    if ImportWS.Remarks <> '' then
                        ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Description does not exist.'
                    else
                        ImportWS.Remarks := 'Description does not exist.'
                end;

                if ImportWS."Port of Discharge" <> '' then begin
                    Port1.Reset();
                    Port1.SetRange("Port Code", rec."Port of Discharge");
                    if not Port1.FindFirst() then begin
                        if ImportWS.Remarks <> '' then
                            ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Port of Discharge does not exist.'
                        else
                            ImportWS.Remarks := 'Port of Discharge does not exist.'
                    end;
                end else begin
                    if ImportWS.Remarks <> '' then
                        ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Port of Discharge Should not be Empty.'
                    else
                        ImportWS.Remarks := 'Port of Discharge Should not be Empty.'
                end;

                if ImportWS."CBM Tonage" = 0 then begin
                    if ImportWS.Remarks <> '' then
                        ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'CBM Tonage does not exist.'
                    else
                        ImportWS.Remarks := 'CBM Tonage does not exist.'
                end;
                if ImportWS."Port of Shipment" <> '' then begin
                    Port.Reset();
                    Port.SetRange("Port Code", rec."Port of Shipment");
                    if not Port.FindFirst() then begin
                        if ImportWS.Remarks <> '' then
                            ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Port of Shipment does not exist.'
                        else
                            ImportWS.Remarks := 'Port of Shipment does not exist.';
                    end;
                end else begin
                    if ImportWS.Remarks <> '' then
                        ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Port of Shipment Should not be Empty.'
                    else
                        ImportWS.Remarks := 'Port of Shipment Should not be Empty.'
                end;
                if ImportWS."Destination Type" = '' then begin
                    if ImportWS.Remarks <> '' then
                        ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Destination Type does not exist.'
                    else
                        ImportWS.Remarks := 'Destination Type does not exist.'
                end;
                if ImportWS."Client Type" = '' then begin
                    if ImportWS.Remarks <> '' then
                        ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Client Type does not exist.'
                    else
                        ImportWS.Remarks := 'Client Type does not exist.'
                end;
                if ImportWS."Clearing Agent" <> '' then begin
                    ClearingAgent.Reset();
                    ClearingAgent.SetRange("Clearing Agent Code", ImportWS."Clearing Agent");
                    if not ClearingAgent.FindFirst() then begin
                        if ImportWS.Remarks <> '' then
                            ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Clearing Agent does not exist.'
                        else
                            ImportWS.Remarks := 'Clearing Agent does not exist.';
                    end;
                end else begin
                    if ImportWS.Remarks <> '' then
                        ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Clearing Agent Should not be Empty.'
                    else
                        ImportWS.Remarks := 'Clearing Agent Should not be Empty.';
                end;
                if ImportWS."Consignee No." <> '' then begin
                    CustRec.Reset();
                    CustRec.SetRange("No.", ImportWS."Consignee No.");
                    if not CustRec.FindFirst() then begin
                        if ImportWS.Remarks <> '' then
                            ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Consignee No. does not exist.'
                        else
                            ImportWS.Remarks := 'Consignee No. does not exist.';
                    end else
                        ImportWS."Consignee Name" := CustRec.Name;

                end else begin
                    if ImportWS.Remarks <> '' then
                        ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Consignee No. Should not be Empty.'
                    else
                        ImportWS.Remarks := 'Consignee No. Should not be Empty.';
                end;

                if ImportWS."Invoicing Party No." <> '' then begin
                    CustRec1.Reset();
                    CustRec1.SetRange("No.", ImportWS."Invoicing Party No.");
                    if not CustRec1.FindFirst() then begin
                        if ImportWS.Remarks <> '' then
                            ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Invoicing Party No. does not exist.'
                        else
                            ImportWS.Remarks := 'Invoicing Party No. does not exist.';
                    end;
                end else begin
                    if ImportWS.Remarks <> '' then
                        ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Invoicing Party No. Should not be Empty.'
                    else
                        ImportWS.Remarks := 'Invoicing Party No. Should not be Empty.';
                end;
                if ImportWS."Shipping Agent" <> '' then begin
                    ShippingAgent.Reset();
                    ShippingAgent.SetRange(code, ImportWS."Shipping Agent");
                    if not ShippingAgent.FindFirst() then begin
                        if ImportWS.Remarks <> '' then
                            ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Shipping Agent does not exist.'
                        else
                            ImportWS.Remarks := 'Shipping Agent does not exist.';
                    end;
                end else begin
                    if ImportWS.Remarks <> '' then
                        ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Shipping Agent Should not be Empty.'
                    else
                        ImportWS.Remarks := 'Shipping Agent Should not be Empty.';
                end;
                if ImportWS."Vessel Name" = '' then begin
                    if ImportWS.Remarks <> '' then
                        ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Vessel Name does not exist.'
                    else
                        ImportWS.Remarks := 'Vessel Name does not exist.'
                end;
                // if ImportWS."Voyage No." = '' then begin
                //     if ImportWS.Remarks <> '' then
                //         ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Voyage No. does not exist.'
                //     else
                //         ImportWS.Remarks := 'Voyage No. does not exist.'
                // end;
                if ImportWS."Process Type" = '' then begin
                    if ImportWS.Remarks <> '' then
                        ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Process Type does not exist.'
                    else
                        ImportWS.Remarks := 'Process Type does not exist.'
                end;
                // if ImportWS."Expected Arrival Date" = 0D then begin
                //     if ImportWS.Remarks <> '' then
                //         ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Expected Arrival Date does not exist.'
                //     else
                //         ImportWS.Remarks := 'Expected Arrival Date does not exist.'
                // end;
                if ImportWS."Vessel Arrival Date" = 0D then begin
                    if ImportWS.Remarks <> '' then
                        ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Vessel Arrival Date does not exist.'
                    else
                        ImportWS.Remarks := 'Vessel Arrival Date does not exist.'
                end;
                // if ImportWS."Vessel Arrival Time" = 0T then begin
                //     if ImportWS.Remarks <> '' then
                //         ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Vessel Arrival Time does not exist.'
                //     else
                //         ImportWS.Remarks := 'Vessel Arrival Time does not exist.'
                // end;
                // if ImportWS."Last Sling Date" = 0D then begin
                //     if ImportWS.Remarks <> '' then
                //         ImportWS.Remarks := ImportWS.Remarks + ' | ' + '"Last Sling Date" does not exist.'
                //     else
                //         ImportWS.Remarks := '"Last Sling Date" does not exist.'
                // end;

                if ImportWS.Weight = 0 then begin
                    if ImportWS.Remarks <> '' then
                        ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Weight does not exist.'
                    else
                        ImportWS.Remarks := 'Weight does not exist.'
                end;
                // if (ImportWS."BL No." <> '') and (ImportWS."Container/Chassis No." <> '') then begin
                //     strtxt := ImportWS."Container/Chassis No.";
                //     if strlen(strtxt) > 14 then
                //         ContDim := CopyStr(strtxt, STRLEN(strtxt) - 13, 14) + '-' + CopyStr(ImportWS."BL No.", 1, 5)
                //     else
                //         ContDim := strtxt + '-' + CopyStr(ImportWS."BL No.", 1, 5);
                // end else
                //     ContDim := '';
                // if ContDim = '' then begin
                //     if DimValue.FindFirst() then
                //         if ImportWS.Remarks <> '' then
                //             ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Container ID Can not be Created.'
                //         else
                //             ImportWS.Remarks := 'Container ID Can not be Created.';
                // end;
                // ImportWS.Validate("Container ID", ContDim);
                GLsetup.Get();
                DimValue.Reset();
                Dimvalue.SetRange("Dimension Code", GLsetup."Global Dimension 1 Code");
                DimValue.SetRange(Code, ContDim);
                if DimValue.FindFirst() then
                    if ImportWS.Remarks <> '' then
                        ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Container ID already exist.'
                    else
                        ImportWS.Remarks := 'Container ID already exist.';
                MFLine.Reset();
                MFLine.SetRange("Global Dimension 1 Code", ImportWS."Container ID");
                if MFLine.FindFirst() then begin
                    if ImportWS.Remarks <> '' then
                        ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Container ID already exist in another Manifest Line ' + MFLine."Job File No."
                    else
                        ImportWS.Remarks := 'Container ID already exist in another Manifest Line ' + MFLine."Job File No.";
                end;
                ImportWS2.Reset();
                ImportWS2.SetRange("Job File No.", ImportWS."Job File No.");
                ImportWS2.SetRange("Container ID", ImportWS."Container ID");
                if ImportWS2.Findset() then begin
                    if ImportWS2.Count > 1 then begin
                        if ImportWS.Remarks <> '' then
                            ImportWS.Remarks := ImportWS.Remarks + ' | ' + 'Container ID already exist in same import worksheet.'
                        else
                            ImportWS.Remarks := 'Container ID already exist in same import worksheet';
                    end;
                end;
                ImportWS.Modify();
            Until ImportWS.Next() = 0;
    end;

    procedure Createmanifest()
    var
        MFLine: Record "Manifest Line";
        NoSeriesMgt: Codeunit "No. Series";
        IMSSetup: Record "Ims Setup";
        LineNo: Integer;
        ImportWs, ImportWS2 : Record ImportManifest;
        JobFileNo: Code[20];
        BlNo: Code[20];
    begin
        IMSSetup.Get();
        ImportWs2.Reset();
        ImportWs2.SetFilter(Remarks, '<>%1', '');
        if ImportWs2.FindFirst() then
            Error('There are Remarks in the lines \\ Please correct them and try again');
        ImportWs.Reset();
        // ImportWs.SetRange("Job File No.", JobFileNo);
        if ImportWs.FindFirst() then
            repeat
                ImportWs.TestField("Job File No.");
                MFLine.Reset();
                MFLine.SetRange("Job File No.", ImportWs."Job File No.");
                if MFLine.FindLast() then
                    LineNo := MFLine."Line No." + 10000
                else
                    LineNo := 10000;
                MFLine.Init();
                MFLine.Validate("Job File No.", ImportWs."Job File No.");
                MFLine."Line No." := LineNo;
                MFLine.Insert();
                MFLine.Validate("BL No.", ImportWs."BL No.");
                MFLine.Validate(Manifested, true);
                MFLine.Validate("CBM Tonage", ImportWs."CBM Tonage");
                MFLine."Global Dimension 1 Code" := ImportWs."Container ID";
                MFLine."Job File Date" := ImportWs."Job File Date";
                //SH
                // MFLine.Validate("Global Dimension 2 Code", ImportWs."Client Type");
                //SH
                //MFLine.Validate("Shortcut Dimension 3 Code", ImportWs."Sales Person");
                MFLine.Validate("Shortcut Dimension 4 Code", ImportWs."Cargo Type");
                //MFLine.Validate("Shortcut Dimension 5 Code", ImportWs."Container size");
                MFLine.Validate("Shortcut Dimension 6 Code", ImportWs."Process Type");
                MFLine.Validate("Clearing Agent", ImportWs."Clearing Agent");
                MFLine.Validate("Consignee No.", ImportWs."Consignee No.");
                MFLine.Validate("Seal/Engine No.", ImportWs."Seal/Engine No.");
                Evaluate(MFLine."Destination Type", ImportWs."Destination Type");
                Evaluate(MFLine."Container Type", ImportWs."Container Type");
                Evaluate(MFLine."Global Dimension 2 Code", ImportWs."Client Type");
                MFLine.Validate(Weight, ImportWs.Weight);
                MFLine.Validate("Shortcut Dimension 5 Code", ImportWs."Container size");
                MFLine.Validate("Invoicing Party No.", ImportWs."Invoicing Party No.");
                MFLine.Validate("Port of Discharge", ImportWs."Port of Discharge");
                MFLine.Validate("Port of Shipment", ImportWs."Port of Shipment");
                MFLine.Validate("Container/Chassis No.", ImportWs."Container/Chassis No.");
                MFLine.Validate(Description, ImportWs.Description);
                MFLine.Validate("Shipping Agent", ImportWs."Shipping Agent");
                MFLine.Validate("Vessel Name", ImportWs."Vessel Name");
                MFLine.Validate("Voyage No.", ImportWs."Voyage No.");
                MFLine.Validate("Expected Arrival Date", ImportWs."Expected Arrival Date");
                MFLine.Validate("Vessel Arrival Date", ImportWs."Vessel Arrival Date");
                MFLine.Validate("Vessel Arrival Time", ImportWs."Vessel Arrival Time");
                MFLine.Validate("Last Sling Date", ImportWs."Last Sling Date");
                MFLine.Validate("Global Dimension 2 Code", ImportWs."Client Type");
                MFLine.Validate("Parent Container ID", ImportWs."Parent Container ID");
                Evaluate(MFLine."TBL/MH", ImportWs."TBL/MH");
                MFLine.Modify();
                InsertDimensionValues(ImportWs."Container ID", MFLine);
            until ImportWs.Next() = 0;
        ImportWs.DeleteAll();
    end;

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


    procedure ColourChangeCustomerNo() StyleExprTxt: Text
    var
        CustRec: Record Customer;
    begin
        CustRec.Reset();
        CustRec.SetRange("No.", Rec."Consignee No.");
        if not CustRec.FindFirst() then
            StyleExprTxt := 'Unfavorable';
    end;

    procedure ColourChangeRemarks() StyleExprTxtRemarks: Text;
    begin

        if Rec.Remarks <> '' then
            StyleExprTxtRemarks := 'Unfavorable';
    end;

    procedure ColourChangeInvoicingNo() StyleExprInvocingNo: Text;
    var
        CustRec1: Record Customer;
    begin
        CustRec1.Reset();
        CustRec1.SetRange("No.", Rec."Invoicing Party No.");
        if not CustRec1.FindFirst() then
            StyleExprInvocingNo := 'Unfavorable';
    end;

    procedure ColourChangeShippingagentNo() StyleExprShippingagent: Text;
    var
        Shippingagent: Record "Shipping Agent";
    begin
        Shippingagent.Reset();
        Shippingagent.SetRange(Code, Rec."Shipping Agent");
        if not Shippingagent.FindFirst() then
            StyleExprShippingagent := 'Unfavorable';
    end;

    procedure ColourCargoType() StyleExprTxtcargotype: Text;
    var
        DimValueRec: Record "Dimension Value";
    begin
        DimValueRec.Reset();
        DimValueRec.SetRange("Shortcut Dimension 4 Code", Rec."Cargo Type");
        if not DimValueRec.FindFirst() then
            StyleExprTxtcargotype := 'Unfavorable';
    end;

    procedure ColourChangeContainerSize() StyleExprTxtContainerSize: Text;
    var
        DimValueRec: Record "Dimension Value";
    begin
        DimValueRec.Reset();
        DimValueRec.SetRange("Shortcut Dimension 5 Code", Rec."Container size");
        if not DimValueRec.FindFirst() then
            StyleExprTxtContainersize := 'Unfavorable';
    end;

    procedure ColourProcessType() StyleExprTxtProcesstype: Text;
    var
        DimValueRec: Record "Dimension Value";
    begin
        DimValueRec.Reset();
        DimValueRec.SetRange("Shortcut Dimension 6 Code", Rec."Process Type");
        if not DimValueRec.FindFirst() then
            StyleExprTxtProcesstype := 'Unfavorable';
    end;



}
