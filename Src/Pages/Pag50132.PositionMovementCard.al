page 50132 "Position Movement Card"
{
    Caption = 'Position Movement';
    PageType = Card;
    SourceTable = "Position Movement";
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Position Movement No."; Rec."Position Movement No.")
                {
                    ToolTip = 'Specifies the value of the Position Movement No. field.';
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                    begin

                        if rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Movement Date"; Rec."Movement Date")
                {
                    ToolTip = 'Specifies the value of the Movement Date field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Movement Time"; Rec."Movement Time")
                {
                    ToolTip = 'Specifies the value of the Movement Time field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;

                }
                field("Container No./Chassis No."; rec."Container No./Chassis No.")
                {
                    ToolTip = 'Specifies the value of the Container No. field.';
                    ApplicationArea = All;
                }

                field("Position From"; Rec."Position From")
                {
                    ToolTip = 'Specifies the value of the Position From field.';
                    ApplicationArea = All;
                }
                field("Position To"; Rec."Position To")
                {
                    ToolTip = 'Specifies the value of the Position To field.';
                    ApplicationArea = All;
                }
                field(Machine; Rec.Machine)
                {
                    ToolTip = 'Specifies the value of the Machine field.';
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
            action(Post)
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    //myInt: Integer;
                    PmRec: Record "Position Movement";

                begin
                    rec.TestField("Container No./Chassis No.");
                    InsertLog();
                    UpdatePosition();
                    rec.UpdateContainer();
                    rec.UpadateManifestLinePosition();
                    rec.Delete();
                end;
            }
        }
    }
    procedure InsertLog()
    var
        PmRec: Record "Position Movement";
        PosLog: Record "Position Log";
        EntryNo: Integer;
    begin
        IF PosLog.FindLast() then
            EntryNo := PosLog."Entry No." + 1
        else
            EntryNo := 1;
        PosLog.Init();
        PosLog."Entry No." := EntryNo;
        PosLog."Acitivity Date" := WorkDate();
        PosLog."Acitivity Time" := time;
        PosLog."Activity Type" := PosLog."Activity Type"::Pick;
        PosLog.Qunatity := -1;
        PosLog."Position Code" := Rec."Position From";
        PosLog."Global Dimension 1 Code" := rec."Global Dimension 1 Code";
        PosLog."Container No./Chassis No." := Rec."Container No./Chassis No.";
        PosLog."Entry Type" := PosLog."Entry Type"::"Position Movement";
        PosLog."Document No." := rec."Position Movement No.";
        PosLog."Machine No." := rec.Machine;
        PosLog."Machine Operater No." := rec."Machine Operator";

        IF PosLog.Insert() then begin
            PosLog.Init();
            PosLog."Entry No." := EntryNo + 1;
            PosLog."Acitivity Date" := WorkDate();
            PosLog."Acitivity Time" := time;
            PosLog."Activity Type" := PosLog."Activity Type"::Put;
            PosLog.Qunatity := 1;
            PosLog."Position Code" := Rec."Position To";
            PosLog."Global Dimension 1 Code" := rec."Global Dimension 1 Code";
            PosLog."Container No./Chassis No." := Rec."Container No./Chassis No.";
            PosLog."Entry Type" := PosLog."Entry Type"::"Position Movement";
            PosLog."Document No." := rec."Position Movement No.";
            PosLog."Machine No." := rec.Machine;
            PosLog."Machine Operater No." := rec."Machine Operator";
            PosLog.Insert();
        end;
        Message('Position movement Recorded');
    end;

    local procedure UpdatePosition()
    var
        PositionRec: Record Position;
    begin
        IF PositionRec.Get(Rec."Position From") then begin
            PositionRec.Status := PositionRec.Status::Open;
            PositionRec."Global Dimension 1 Code" := '';
            PositionRec."Container No./Chassis No." := '';
            PositionRec.Modify();
        end;
        IF PositionRec.Get(Rec."Position To") then begin
            PositionRec.Status := PositionRec.Status::Allocated;
            PositionRec."Global Dimension 1 Code" := rec."Global Dimension 1 Code";
            PositionRec."Container No./Chassis No." := Rec."Container No./Chassis No.";
            PositionRec.Modify();
        end
    end;



}
