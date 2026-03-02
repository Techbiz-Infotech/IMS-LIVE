table 50146 "Charge ID Group Header"
{
    Caption = 'Charge ID Group Header';
    DataClassification = ToBeClassified;
    LookupPageId = 50150;
    DrillDownPageId = 50150;
    fields
    {
        field(1; "Charge ID Group Code"; Code[20])
        {
            Caption = 'Charge ID Group Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Charge Description"; Text[200])
        {
            Caption = 'Charge Description';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec.TestStatusOpen();
            end;
        }
        field(4; "First Bracket"; Decimal)
        {
            Caption = 'First Bracket';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec.TestStatusOpen();
            end;
        }
        field(5; "Second Bracket"; Decimal)
        {
            Caption = 'Second Bracket';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec.TestStatusOpen();
            end;
        }
        field(6; "Third Bracket"; Decimal)
        {
            Caption = 'Third Bracket';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec.TestStatusOpen();
            end;
        }

        field(7; "HenceForth"; Decimal)
        {
            Caption = 'HenceForth';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec.TestStatusOpen();
            end;
        }
        field(8; "Calculation Type"; Enum "Calculation TypeEnum")
        {
            Caption = 'Calculation Type';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec.TestStatusOpen();
            end;
        }
        field(9; "Start After"; Integer)
        {
            Caption = 'Start After';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec.TestStatusOpen();
            end;
        }

        field(10; "Base On"; Enum "Base On Enum")
        {
            Caption = 'Base On';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec.TestStatusOpen();
            end;
        }
        field(11; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
            trigger OnValidate()
            begin
                Rec.TestStatusOpen();
            end;
        }
        field(12; "Status"; Enum CGStatusEnum)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
        field(13; "Include Received Day"; Boolean)
        {
            Caption = 'Include Received Day';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec.TestStatusOpen();
            end;
        }
        field(14; "Charge Type"; Enum "Charge Type")
        {
            Caption = 'Charge Type';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                IMSSetup: Record "IMS Setup";
            begin
                Rec.TestStatusOpen();
                if Rec."Charge Type" = Rec."Charge Type"::Standard then begin
                    IMSSetup.Get();
                    Rec.CalcFields("Total Standard Charges amount");
                    if Rec."Total Standard Charges amount" < IMSSetup."Minimum Standard Charges" then
                        Error('Total standard charges are less than minimum standard changes. Please select special charge Type');
                end;
            end;
        }
        field(15; "Total Standard Charges amount"; Decimal)
        {
            Caption = 'Total Standard Charges amount';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Charge ID Group Line"."First Interval" where("Charge ID Group Code" = field("Charge ID Group Code"), "Calculate if Storage Days" = filter(false)));
        }
        field(16; "Free Days"; Decimal)
        {
            Caption = 'Free Days';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = min("Charge ID Group Line"."Free Days" where("Charge ID Group Code" = field("Charge ID Group Code"),"Rely On Storage" = const(true)));
        }


    }
    keys
    {
        key(PK; "Charge ID Group Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Charge ID Group Code", "Charge Description")
        {

        }
    }

    trigger OnInsert()
    var
        myInt: Integer;
    begin
        Rec."User ID" := UserId;
        "Base On" := "Base On"::"Received Date";
    end;

    trigger ondelete()
    var
        myInt: Integer;
        ChargeGroupLine: Record "Charge ID Group Line";
    begin
        ChargeGroupLine.reset;
        ChargeGroupLine.SetRange("Charge ID Group Code", "Charge ID Group Code");
        if ChargeGroupLine.FindSet() then
            ChargeGroupLine.DeleteAll();
    end;

    procedure TestStatusOpen()
    begin
        TestField(Status, Status::Open);
    end;

}
