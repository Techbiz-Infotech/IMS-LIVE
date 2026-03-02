table 50152 "CFS Budget Header"
{
    Caption = 'CFS Budget Header';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Budget Year"; Integer)
        {
            Caption = 'Budget Year';
            DataClassification = ToBeClassified;
        }
        field(2; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));

            trigger OnValidate()
            var

            begin
                if xRec."Shortcut Dimension 3 Code" <> '' then
                    Error('You Can not change Sales Person Code');
            end;
        }
        field(3; "Budget Type"; Enum "CFS Budget type")
        {
            Caption = 'Budget Type';
            DataClassification = ToBeClassified;
        }


    }
    keys
    {
        key(Pk; "Budget Year", "Shortcut Dimension 3 Code", "Budget Type")
        {
            Clustered = true;
        }
    }
    procedure InitValues()
    var
        Dim2, Dim : Record Dimension;
        DimValue2, DimValue : Record "Dimension Value";
        BudgetLine2, BudgetLine : Record "CFS Budget Line";
        LineNo: Integer;
        GLSetup: Record "General Ledger Setup";
    begin
        Clear(LineNo);
        GLSetup.Get();
        Dim.Reset();
        Dim.SetRange(Code, GLSetup."Shortcut Dimension 4 Code");
        if Dim.FindFirst() then begin
            DimValue.Reset();
            DimValue.SetRange("Dimension Code", Dim.Code);
            if DimValue.FindFirst() then
                repeat
                    Dim2.Reset();
                    Dim2.SetRange(Code, GLSetup."Shortcut Dimension 5 Code");
                    if Dim2.FindFirst() then begin
                        DimValue2.Reset();
                        DimValue2.SetRange("Dimension Code", Dim2.Code);
                        DimValue2.SetRange("Cargo Type", DimValue.Code);
                        if DimValue2.FindFirst() then
                            repeat
                                BudgetLine2.Reset();
                                BudgetLine2.SetRange("Budget Year", Rec."Budget Year");
                                BudgetLine2.SetRange("Shortcut Dimension 3 Code", rec."Shortcut Dimension 3 Code");
                                BudgetLine2.SetRange("Budget Type", Rec."Budget Type");
                                if BudgetLine2.FindLast() then
                                    LineNo := BudgetLine2."Line No." + 10000
                                else
                                    LineNo := 10000;
                                BudgetLine.Init();
                                BudgetLine."Budget Year" := Rec."Budget Year";
                                BudgetLine."Shortcut Dimension 3 Code" := rec."Shortcut Dimension 3 Code";
                                BudgetLine."Budget Type" := Rec."Budget Type";
                                BudgetLine."Line No." := LineNo;
                                BudgetLine."Shortcut Dimension 4 Code" := DimValue.Code;
                                BudgetLine."Shortcut Dimension 5 Code" := DimValue2.Code;
                                BudgetLine.Insert();
                            until DimValue2.Next = 0;
                    end;
                until DimValue.Next = 0;

        end;

    end;

    procedure UpdateSalesPersoninLines()
    var
        BudgetLine: Record "CFS Budget Line";
    begin
        BudgetLine.Reset();
        BudgetLine.SetRange("Budget Year", rec."Budget Year");
        BudgetLine.SetRange("Shortcut Dimension 3 Code", Rec."Shortcut Dimension 3 Code");
        if not BudgetLine.FindFirst() then
            Rec.InitValues();
    end;

    trigger OnInsert()
    begin
        TestField("Budget Type");
        TestField("Shortcut Dimension 3 Code");
        rec.InitValues();
    end;

    // trigger OnModify()
    // begin
    //     Rec.UpdateSalesPersoninLines();
    // end;
    trigger OnDelete()
    var
        BudgetLine: Record "CFS Budget Line";
    begin
        BudgetLine.Reset();
        BudgetLine.SetRange("Budget Year", rec."Budget Year");
        BudgetLine.SetRange("Shortcut Dimension 3 Code", Rec."Shortcut Dimension 3 Code");
        BudgetLine.SetRange("Budget Type", Rec."Budget Type");
        if BudgetLine.FindFirst() then
            repeat
                BudgetLine.DeleteAll();
            //Rec.InitValues();
            until BudgetLine.Next() = 0;

    end;
}