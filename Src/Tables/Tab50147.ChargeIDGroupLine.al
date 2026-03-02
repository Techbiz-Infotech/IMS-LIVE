table 50147 "Charge ID Group Line"
{
    Caption = 'Charge ID Group Line';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Charge ID Group Code"; code[20])
        {
            Caption = 'Charge ID Group Code';
            DataClassification = ToBeClassified;
        }
        field(3; Charge; Code[20])
        {
            Caption = 'Charge';
            DataClassification = ToBeClassified;
            TableRelation = Item;
            trigger Onvalidate()
            var
                ChargeRec: Record "Charge ID Group Line";
                ItemRec: Record Item;
            begin
                if ItemRec.get(Charge) then
                    "Charge Description " := ItemRec.Description;
                Rec.TestStatusOpen();
            end;
        }
        field(4; "Charge Description "; Text[50])
        {
            Caption = 'Charge Description';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec.TestStatusOpen();
            end;
        }
        field(5; "First Interval"; Decimal)
        {
            Caption = 'First Interval';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec.TestStatusOpen();
            end;
        }
        field(6; "Second Interval"; Decimal)
        {
            Caption = 'Second Interval';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec.TestStatusOpen();
            end;
        }
        field(7; "Third Interval"; Decimal)
        {
            Caption = 'Third Interval';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec.TestStatusOpen();
            end;
        }
        field(8; "HenceForth"; Decimal)
        {
            Caption = 'Hence Forth';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec.TestStatusOpen();
            end;
        }
        field(9; "Free Days"; Decimal)
        {
            Caption = 'Free Days';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec.TestStatusOpen();
            end;
        }
        field(10; "Based On CBM/ Weight"; Boolean)
        {
            Caption = 'Based On CBM/ Weight';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec.TestStatusOpen();
            end;
        }
        field(11; "Rely On Storage"; Boolean)
        {
            Caption = 'Rely On Storage';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec.TestStatusOpen();
            end;
        }
        field(12; "Active/In-Active"; Enum "Active/In-Active Enum")
        {
            Caption = 'Active/In-Active';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec.TestStatusOpen();
            end;
        }
        field(13; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(14; "Calculate if Storage Days"; Boolean)
        {
            Caption = 'Calculate if Storage Days';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec.TestStatusOpen();
            end;
        }
        field(15; "Charge Category"; Code[20])
        {
            Caption = 'Charge Category';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(item."Item Category Code" where("No." = field(charge)));
            trigger OnValidate()
            begin
                Rec.TestStatusOpen();
            end;
        }
    }
    keys
    {
        key(PK; "Charge ID Group Code", "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        Rec."User ID" := UserId;
    end;

    trigger OnDelete()
    begin
        TestStatusOpen();
    end;

    procedure TestStatusOpen()
    var
        ChargeGrpHdr: Record "Charge ID Group Header";
    begin
        if ChargeGrpHdr.Get("Charge ID Group Code") then
            ChargeGrpHdr.TestField(Status, ChargeGrpHdr.Status::Open);
    end;
}
