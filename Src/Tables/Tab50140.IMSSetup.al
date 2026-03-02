table 50140 "IMS Setup"
{
    Caption = 'IMS Setup';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; "Job File Nos"; Code[20])
        {
            Caption = 'Job File Nos';
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(3; "Verification Nos"; Code[20])
        {
            Caption = 'Verification Nos';
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(4; "Position Nos"; Code[20])
        {
            Caption = 'Position Nos';
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(5; "Yard Allocation Nos"; Code[20])
        {
            Caption = 'Yard Allocation Nos';
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(6; "Postion Movement Nos"; Code[20])
        {
            Caption = 'Postion Movement Nos';
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(7; "Out Gate Pass Nos"; Code[20])
        {
            Caption = 'Out Gate Pass Nos';
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(8; "Charge ID for Stripping"; Code[20])
        {
            Caption = 'Charge ID for Stripping';
            TableRelation = Item;
            DataClassification = ToBeClassified;
        }
        field(9; "Machine Nos"; Code[20])
        {
            Caption = 'Machine Nos';
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(10; "Machine Operator Nos"; Code[20])
        {
            Caption = 'Machine Operator Nos';
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(11; "Vessel Nos"; Code[20])
        {
            Caption = 'Vessel Nos';
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(12; "Port Nos"; Code[20])
        {
            Caption = 'Port Nos';
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(13; "Vehicle Nos"; Code[20])
        {
            Caption = 'Vehicle Nos';
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(14; "Purchase Prepayment From"; Code[20])
        {
            Caption = 'Purchase Prepayment From';
            TableRelation = "G/L Account";
            DataClassification = ToBeClassified;
        }
        field(15; "Purchase Prepayment To"; Code[20])
        {
            Caption = 'Purchase Prepayment To';
            TableRelation = "G/L Account";
            DataClassification = ToBeClassified;
        }
        field(16; "Charge ID 20FT Verification"; Code[20])
        {
            Caption = 'Charge ID 20FT Verification';
            TableRelation = Item;
            DataClassification = ToBeClassified;
        }
        field(17; "Charge ID 40FT Verification"; Code[20])
        {
            Caption = 'Charge ID 40FT Verification';
            TableRelation = Item;
            DataClassification = ToBeClassified;
        }
        field(18; "Default HS Code"; Code[20])
        {
            Caption = 'Default HS Code';
            //TableRelation = Item;
            DataClassification = ToBeClassified;
        }
        field(19; "Purchase Prepayment Wharfage"; Code[20])
        {
            Caption = 'Purchase Prepayment Wharfage';
            TableRelation = "G/L Account";
            DataClassification = ToBeClassified;
        }
        field(20; "Purchase Prepayment Transport"; Code[20])
        {
            Caption = 'Purchase Prepayment Transport';
            TableRelation = "G/L Account";
            DataClassification = ToBeClassified;
        }
        field(21; "Category Code for Transport"; Code[20])
        {
            Caption = 'Category Code for Transport';
            TableRelation = "Item Category";
            DataClassification = ToBeClassified;
        }
        field(22; "Category Code for Storage"; Code[20])
        {
            Caption = 'Category Code for Storage';
            TableRelation = "Item Category";
            DataClassification = ToBeClassified;
        }
        field(23; "Default Charge ID Reefer"; Code[20])
        {
            Caption = 'Default Charge ID Reefer';
            TableRelation = Item;
            DataClassification = ToBeClassified;
        }
        field(24; "Full Verification Rate"; Decimal)
        {
            Caption = 'Full Verification Rate';
            ObsoleteState = Removed;
            ObsoleteReason = 'created other fields for the same';
        }
        field(25; "Partial Verification Rate"; Decimal)
        {
            Caption = 'Partial Verification Rate';
            DataClassification = ToBeClassified;
        }
        field(26; "Sighting Verification Rate"; Decimal)
        {
            Caption = 'Sighting Verification Rate';
            DataClassification = ToBeClassified;
        }
        field(27; "20FT Full Verification Rate"; Decimal)
        {
            Caption = '20FT Full Verification Rate';
            DataClassification = ToBeClassified;
        }
        field(28; "40FT Full Verification Rate"; Decimal)
        {
            Caption = '40FT Full Verification Rate';
            DataClassification = ToBeClassified;
        }
        field(29; "Category Code for CFS Handling"; Code[20])
        {
            Caption = 'Category Code for CFS Handling';
            TableRelation = "Item Category";
            DataClassification = ToBeClassified;
        }
        field(30; "Cancel Gatepass Nos"; Code[20])
        {
            Caption = 'Cancel Gatepass Nos';
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(31; "Parent Gatepass Nos"; Code[20])
        {
            Caption = 'Parent Gatepass Nos';
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(32; "Category for Shorehandling"; Code[20])
        {
            Caption = 'Category Code for Shorehandling';
            TableRelation = "Item Category";
            DataClassification = ToBeClassified;
        }
        field(33; "40FT Partial Verification Rate"; Decimal)
        {
            Caption = '40FT Partial Verification Rate';
            DataClassification = ToBeClassified;
        }
        field(34; "Default HS Code Zero rated"; Code[20])
        {
            Caption = 'Default HS Code Zero rated';
            DataClassification = ToBeClassified;
        }
        field(35; "Skip KPA Charges on Invoice"; Boolean)
        {
            Caption = 'Skip KPA Charges on Invoice';
            DataClassification = ToBeClassified;
        }
        field(36; "Minimum Standard Charges"; Decimal)
        {
            Caption = 'Minimum Standard Charges';
            DataClassification = ToBeClassified;
        }
        field(37; "Rebate No."; Code[20])
        {
            Caption = 'Rebate No.';
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(38; Position; Boolean)
        {
            Caption = 'Position';
            DataClassification = ToBeClassified;
        }

        field(39; "KPA Receive Manditory"; Boolean)
        {
            Caption = 'KPA Receive Manditory';
            DataClassification = ToBeClassified;
        }
        field(40; "Category Code for Rebate"; Code[20])
        {
            Caption = 'Category Code for Rebate';
            TableRelation = "Item Category";
            DataClassification = ToBeClassified;
        }

        field(41; "Cargo Job File No."; Code[20])
        {
            Caption = 'Cargo Job File Nos';
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(42; "Category Code Wharfage"; Code[20])
        {
            Caption = 'Category Code for Wharfage';
            TableRelation = "Item Category";
            DataClassification = ToBeClassified;
        }
        field(43; "Category Code for IMCO"; Code[20])
        {
            Caption = 'Category Code for IMCO';
            TableRelation = "Item Category";
            DataClassification = ToBeClassified;
        }
        field(44; "Category Code forIMCO MSA TOLL"; Code[20])
        {
            Caption = 'Category Code for IMCO MSA TOLL';
            TableRelation = "Item Category";
            DataClassification = ToBeClassified;
        }
        field(45; "Category Code for TOLL"; Code[20])
        {
            Caption = 'Category Code for TOLL';
            TableRelation = "Item Category";
            DataClassification = ToBeClassified;
        }


    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
