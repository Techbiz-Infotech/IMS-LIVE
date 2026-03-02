table 50118 "ReceivingLog ModificationLog"
{
    Caption = 'Receiving Info Modification log';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No';
            DataClassification = ToBeClassified;
        }
        field(2; "Receiving Log Entry No."; Integer)
        {
            Caption = 'Receiving Log Entry No';
            DataClassification = ToBeClassified;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(4; "Job File No."; Code[20])
        {
            Caption = 'Job File No.';
            DataClassification = ToBeClassified;
        }
        field(5; "BL No."; Code[20])
        {
            Caption = 'BL No.';
            DataClassification = ToBeClassified;
        }
        field(6; "Container No./Chassis No."; code[30])
        {
            Caption = 'Container No./Chassis No.';
            DataClassification = ToBeClassified;
        }
        field(7; "Container Type"; Enum ContainerTypeEnum)
        {
            Caption = 'Container Type';
            DataClassification = ToBeClassified;
        }
        // field(8; "Container Size"; Enum ContainerSizeEnum)
        // {
        //     Caption = 'Container Size';
        //     DataClassification = ToBeClassified;
        // }
        field(8; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
        }

        field(9; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(10; Vehicle; Code[30])
        {
            Caption = 'Vehicle';
            DataClassification = ToBeClassified;
        }
        field(11; "Driver Name"; Text[30])
        {
            Caption = 'Driver Name';
            DataClassification = ToBeClassified;
        }
        field(12; "Driver ID"; Text[20])
        {
            Caption = 'Driver ID';
            DataClassification = ToBeClassified;
        }
        field(13; "DO No."; Text[20])
        {
            Caption = 'DO No.';
            DataClassification = ToBeClassified;
        }
        field(14; "Time In"; Time)
        {
            Caption = 'Time In';
            DataClassification = ToBeClassified;
        }
        field(15; Recieived; Boolean)
        {
            Caption = 'Recieived';
            DataClassification = ToBeClassified;
        }
        field(16; "Received Date"; Date)
        {
            Caption = 'Received Date';
            DataClassification = ToBeClassified;
        }
        field(17; Transporter; Text[40])
        {
            Caption = 'Transporter';
            DataClassification = ToBeClassified;
        }
        field(18; "Vehicle Type"; Enum VehicleTypeEnum)
        {
            Caption = 'Vehicle Type';
            DataClassification = ToBeClassified;
        }
        field(19; "Truck /Wagon No."; Code[20])
        {
            Caption = 'Truck /Wagon No.';
            DataClassification = ToBeClassified;
        }
        field(20; "Trailer No."; Code[20])
        {
            Caption = 'Trailer No.';
            DataClassification = ToBeClassified;
        }
        field(21; "Shipper Seal No."; Code[20])
        {
            Caption = 'Shipper Seal No.';
            DataClassification = ToBeClassified;
        }
        field(22; "Container Structural Status"; Enum ContainerStructuralStatusEnum)
        {
            Caption = 'Container Structural Status';
            DataClassification = ToBeClassified;
        }
        field(23; "Releasing Clerk Details"; Text[40])
        {
            Caption = 'Releasing Clerk Details';
            DataClassification = ToBeClassified;
        }
        field(24; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(26; "Manifest Line No."; Integer)
        {
            Caption = 'Manifest Line No.';
            DataClassification = ToBeClassified;
        }
        field(25; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(27; "Modified User ID"; Code[50])
        {
            Caption = 'Modified User ID';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(28; "Modified Date"; Date)
        {
            Caption = 'Modified Date';
            DataClassification = ToBeClassified;

        }
        field(29; "Modified Time"; time)
        {
            Caption = 'Modified Time';
            DataClassification = ToBeClassified;

        }
        field(39; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(40; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
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

    }
    keys
    {
        key(PK; "Entry No.")
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
}
