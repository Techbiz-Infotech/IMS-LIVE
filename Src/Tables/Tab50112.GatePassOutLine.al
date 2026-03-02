table 50112 "Gate Pass Out Line"
{
    Caption = 'Gate Pass Out Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Gate Pass No."; Code[20])
        {
            Caption = 'Gate Pass No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Invoice No."; Code[20])
        {
            Caption = 'Invoice No.';
            DataClassification = ToBeClassified;
            //TableRelation = "Sales Invoice Header";
            //Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                // GetInvoiceDetails();
                // GetReceiptNo();
            end;


        }
        field(4; "Invoice Date"; Date)
        {
            Caption = 'Invoice Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Receipt No."; Code[20])
        {
            Caption = 'Receipt No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Container /Chasis No."; Code[20])
        {
            Caption = 'Container /Chasis No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Gate Pass Status"; Enum "Active/In-Active Enum")
        {
            Caption = 'Gate Pass Status';
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(8; "No. Of Bags"; Decimal)
        {
            Caption = 'No. Of Bags';
            DataClassification = ToBeClassified;
        }
        field(9; "Truck No."; Code[20])
        {
            Caption = 'Truck No.';
            DataClassification = ToBeClassified;
        }
        field(10; "Agent Name"; Text[20])
        {
            Caption = 'Agent Name';
            DataClassification = ToBeClassified;
        }
        field(11; "Agent Port Pass"; Code[20])
        {
            Caption = 'Agent Port Pass';
            DataClassification = ToBeClassified;
        }
        field(12; "Tranporter/Driver Name"; Text[40])
        {
            Caption = 'Tranporter/Driver Name';
            DataClassification = ToBeClassified;
        }
        field(13; Remarks; Text[100])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(14; "Trailer No."; Code[20])
        {
            Caption = 'Trailer No.';
            DataClassification = ToBeClassified;
        }
        field(15; "Position ID"; code[20])
        {
            Caption = 'Position ID';
            DataClassification = ToBeClassified;
            TableRelation = Position." Position ID" where(Status = const(Allocated));
            Editable = false;
        }
        field(16; "No.Series"; code[20])
        {
            Caption = 'No.Series';
            DataClassification = ToBeClassified;
        }
        field(17; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            Editable = false;
        }
        field(18; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            Editable = false;
        }
        field(19; "Global Dimension 1 Filter"; Code[20])
        {
            Caption = 'Global Dimension 1 Filter';

            FieldClass = FlowFilter;
            CaptionClass = '1,3,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(20; "Global Dimension 2 Filter"; Code[20])
        {
            Caption = 'Global Dimension 1 Filter';

            FieldClass = FlowFilter;
            CaptionClass = '1,3,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(21; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(22; "Consignee No."; Code[20])
        {
            Caption = 'Consignee No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer;
            Editable = false;
        }
        field(23; "Consignee Name"; Text[100])
        {
            Caption = 'Consignee Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(24; "BL No"; Code[20])
        {
            Caption = 'BL No';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "Job File No"; code[20])
        {
            Caption = 'Job File No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(27; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(28; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
            Editable = false;
        }
        field(29; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
            Editable = false;
        }
        field(30; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
            Editable = false;
        }
        field(31; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
            Editable = false;
        }
        field(32; "Custom Entry No."; Text[50])
        {
            Caption = 'Custom Entry No.';
            DataClassification = ToBeClassified;

        }
        field(33; "Payment Method"; Code[20])
        {
            Caption = 'Payment Method';
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";

        }
        field(34; "Delivery Order No."; Code[30])
        {
            Caption = 'Delivery Order No.';
            DataClassification = ToBeClassified;
        }
        
        field(35; "Payment Terms"; Code[20])
        {
            Caption = 'Payment Terms';
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms";

        }
        field(36; "Clearing Agent"; Code[20])
        {
            Caption = 'Clearing Agent';
            DataClassification = ToBeClassified;
            TableRelation = "Clearing Agent";
            trigger OnValidate()
            var
                ClearingAgent: Record "Clearing Agent";
            begin
                // if ClearingAgent.get("Clearing Agent") then
                //     "Agent Name" := ClearingAgent."Clearing Agent Name"
                // else
                //     "Agent Name" := '';
            end;
        }
        field(37; "Activity Date"; Date)
        {
            Caption = 'Activity Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(38; "Activity Time"; Time)
        {
            Caption = 'Activity Time';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(39; "Container Structural Status"; Enum ContainerStructuralStatusEnum)
        {
            Caption = 'Container Structural Status';
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup(ReceivingLog."Container Structural Status" where("Global Dimension 1 Code" = FIELD("Global Dimension 1 Code")));
        }
        field(40; "DO No. Expiry date"; Date)
        {
            Caption = 'DO No. Expiry Date';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Gate Pass No.", "Line No.")
        {
            Clustered = true;
        }
        key(k2; "Global Dimension 1 Code")
        {
        }
    }

    procedure GetInvoiceDetails()
    var
        SalesInvHead: Record "Sales Invoice Header";
        ContainerRec: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
    begin

        SalesInvHead.Reset();
        SalesInvHead.SetRange("No.", "Invoice No.");
        if SalesInvHead.FindFirst() then begin
            "Job File No" := SalesInvHead."Job File No.";
            "BL No" := SalesInvHead."BL No.";
            "Position ID" := SalesInvHead."Position ID";
            "Global Dimension 1 Code" := SalesInvHead."Shortcut Dimension 1 Code";
            "Container /Chasis No." := SalesInvHead."Container No./Chassis No.";
            "Invoice Date" := SalesInvHead."Posting Date";
            "Consignee No." := SalesInvHead."Sell-to Customer No.";
            "Consignee Name" := SalesInvHead."Sell-to Customer Name";
            GLSetup.get();
            ContainerRec.Reset();
            ContainerRec.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
            ContainerRec.SetRange(Code, SalesInvHead."Shortcut Dimension 1 Code");
            ContainerRec.SetRange("Container Status", ContainerRec."Container Status"::"In Stock");
            if NOT ContainerRec.FindFirst() then
                Error('Container is already released');
            //else
            // modify;
        end else begin
            "Job File No" := '';
            "BL No" := '';
            "Position ID" := '';
            "Global Dimension 1 Code" := '';
            "Container /Chasis No." := '';
            "Invoice Date" := 0D;
            //modify;
            Message('Invoice Does not found');
        end;


    end;

    procedure GetReceiptNo()
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        ApplyCustLedgEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgEntry.Reset();
        CustLedgEntry.SetRange("Document No.", "Invoice No.");
        CustLedgEntry.SetRange(Open, false);
        IF CustLedgEntry.FindFirst() then begin
            ApplyCustLedgEntry.Reset();
            ApplyCustLedgEntry.SetRange("Entry No.", CustLedgEntry."Closed by Entry No.");
            if ApplyCustLedgEntry.FindFirst() then begin
                "Receipt No." := ApplyCustLedgEntry."Document No.";
                Modify();
            end;
        end else
            error('Receipt No. not found');
    end;



}
