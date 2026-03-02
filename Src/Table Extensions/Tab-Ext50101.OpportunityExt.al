tableextension 50101 OpportunityExt extends Opportunity
{
    fields
    {

        field(50100; "20Ft Container"; Integer)
        {
            Caption = '20Ft Container';
            DataClassification = ToBeClassified;
        }
        field(50101; "40Ft Container"; Integer)
        {
            Caption = '40Ft Container';
            DataClassification = ToBeClassified;
        }
        field(50102; "BL No."; Code[30])
        {
            Caption = 'BL No.';
            DataClassification = ToBeClassified;
        }
        field(50103; "20Ft Container Manifested"; Integer)
        {
            Caption = '20Ft Container Manifested';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count("Manifest Line" where("BL No." = FIELD("BL No."), "Shortcut Dimension 5 Code" = FILTER('20FT'), Manifested = FILTER(true)));
        }
        field(50104; "40Ft Container Manifested"; Integer)
        {
            Caption = '40Ft Container Manifested';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count("Manifest Line" where("BL No." = FIELD("BL No."), "Shortcut Dimension 5 Code" = FILTER('40FT'), Manifested = FILTER(true)));
        }
        field(50105; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
            trigger onvalidate()
            var
                myInt: Integer;
            begin
                //rec.ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(50106; Quantity; decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }


    }
}
