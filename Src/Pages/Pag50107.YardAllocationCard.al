page 50107 YardAllocationCard
{
    Caption = 'Yard Allocation Card';
    PageType = Card;
    SourceTable = YardAllocation;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Yard Allocation No."; Rec."Yard Allocation No.")
                {
                    ToolTip = 'Specifies the value of the Yard Allocation No. field.';
                    ApplicationArea = all;

                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                    begin
                        if rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Allocation Date"; Rec."Allocation Date")
                {
                    ToolTip = 'Specifies the value of the Machine Operator field.';
                    ApplicationArea = All;
                }
                field("Allocation Time"; rec."Allocation Time")
                {
                    ToolTip = 'Specifies the value of the Machine Operator field.';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    //TableRelation = "Manifest Line";
                    //Lookup = true;
                    // trigger OnLookup(var text: text): Boolean
                    // var
                    //     ManiLine: Record "Manifest Line";
                    // begin
                    //     ManiLine.Reset();
                    //     ManiLine.SetRange("Container lock", false);
                    //     ManiLine.SetRange(Received, true);
                    //     ManiLine.SetRange(Manifested, true);
                    //     ManiLine.SetRange(Verified, false);
                    //     ManiLine.SetRange(Released, false);
                    //     ManiLine.SetRange("Allocated Position", '');
                    //     if page.RunModal(50140, ManiLine) = Action::LookupOK then begin
                    //         Rec."Global Dimension 1 Code" := ManiLine."Global Dimension 1 Code";
                    //         CurrPage.Update(false);
                    //     end;
                    // end;

                }
                field("Container No./Chassis No."; rec."Container No./Chassis No.")
                {
                    ToolTip = 'Specifies the value of the Container No. field.';
                    ApplicationArea = All;
                }
                field(Position; Rec.Position)
                {
                    ToolTip = 'Specifies the value of the Position field.';
                    ApplicationArea = All;
                }
                field("Machine No."; Rec."Machine No.")
                {
                    ToolTip = 'Specifies the value of the Machine No. field.';
                    ApplicationArea = All;
                }
                field("Machine Operator"; Rec."Machine Operator")
                {
                    ToolTip = 'Specifies the value of the Machine Operator field.';
                    ApplicationArea = All;
                }
                field("User ID"; rec."User ID")
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(Allocation)
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    rec.TestField("Container No./Chassis No.");
                    IF Confirm('Do you want to Allocate the Position?', true) then begin
                        InsertPoslog;
                        InsertYardLoclog;
                        UpdatePosition();
                        UpdateManifestLine;
                        UpdateDimensionPosition;
                        rec.Delete();
                        Message('Allocation Successfully Completed');
                    end else
                        exit;
                end;
            }
        }
    }

    procedure InsertPoslog()
    var
        myInt: Integer;
        PosRec: Record "Position Log";
        EntryNo: Integer;
        YardAlctRec: Record YardAllocation;
    begin
        YardAlctRec.Get(Rec."Yard Allocation No.");

        IF PosRec.FindLast() then
            EntryNo := PosRec."Entry No." + 1
        else
            EntryNo := 1;

        PosRec.Init();
        PosRec."Entry No." := EntryNo;
        PosRec."Position Code" := YardAlctRec.Position;
        PosRec."Entry Type" := PosRec."Entry Type"::"Yard Allocation";
        PosRec."Document No." := YardAlctRec."Yard Allocation No.";
        PosRec.Qunatity := 1;
        PosRec."Global Dimension 1 Code" := YardAlctRec."Global Dimension 1 Code";
        PosRec."Container No./Chassis No." := YardAlctRec."Container No./Chassis No.";
        PosRec."Acitivity Date" := WorkDate();
        PosRec."Acitivity Time" := "Time";
        PosRec."Machine No." := YardAlctRec."Machine No.";
        PosRec."Machine Operater No." := YardAlctRec."Machine Operator";
        PosRec.Insert();
    end;

    local procedure UpdatePosition()
    var
        PositionRec: Record Position;
    begin
        IF PositionRec.Get(rec.Position) then begin
            PositionRec.Status := PositionRec.Status::Allocated;
            PositionRec."Global Dimension 1 Code" := rec."Global Dimension 1 Code";
            PositionRec."Container No./Chassis No." := Rec."Container No./Chassis No.";
            PositionRec.Modify();
        end
    end;

    local procedure UpdateManifestLine()
    var
        ManifestLineRec: Record "Manifest Line";
    begin
        ManifestLineRec.Reset();
        ManifestLineRec.SetRange(ManifestLineRec."Global Dimension 1 Code", rec."Global Dimension 1 Code");
        if ManifestLineRec.FindFirst() then begin
            ManifestLineRec."Allocated Position" := Rec.Position;
            ManifestLineRec.Modify();
        end;
    end;

    procedure InsertYardLoclog()
    var
        myInt: Integer;
        YardAllocaLogRec: Record YardAllocationLog;
        EntryNo: Integer;
        YardAltRec: Record YardAllocation;
    begin
        YardAltRec.Get(Rec."Yard Allocation No.");
        IF YardAllocaLogRec.FindLast() then
            EntryNo := YardAllocaLogRec."Entry No." + 1
        else
            EntryNo := 1;
        YardAllocaLogRec.Init();
        YardAllocaLogRec."Entry No." := EntryNo;
        YardAllocaLogRec."Yard Allocation No." := YardAltRec."Yard Allocation No.";
        YardAllocaLogRec.Position := YardAltRec.Position;
        YardAllocaLogRec."Global Dimension 1 Code" := YardAltRec."Global Dimension 1 Code";
        YardAllocaLogRec."Container No./Chassis No." := YardAltRec."Container No./Chassis No.";
        YardAllocaLogRec."Machine No." := YardAltRec."Machine No.";
        YardAllocaLogRec."Machine Operator" := YardAltRec."Machine Operator";
        YardAllocaLogRec."Allocation Date" := WorkDate();
        YardAllocaLogRec."Allocation Time" := "Time";
        YardAllocaLogRec.Insert();
    end;

    procedure UpdateDimensionPosition()
    var
        DimValRec: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.get();
        DimValRec.Reset();
        DimValRec.setrange("Dimension Code", GLSetup."Global Dimension 1 Code");
        DimValRec.SetRange(code, rec."Global Dimension 1 Code");
        if DimValRec.FindFirst() then begin
            DimValRec."Position No." := rec.Position;
            DimValRec.Modify();
        end;
    end;
}
