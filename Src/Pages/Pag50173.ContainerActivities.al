page 50173 "Container Activities"
{
    Caption = 'Container Activities';
    PageType = CardPart;
    SourceTable = "Containers Cue";

    layout
    {
        area(content)
        {
            cuegroup(Containers)
            {
                Caption = 'Containers';
                field("Received Containers Today"; Rec."Received Containers Today")
                {
                    DrillDownPageID = "Manifest Lines";
                    ToolTip = 'Specifies the value of the Containers Received Today field.';
                    ApplicationArea = All;
                    Visible = SICDContainerCUesVisible;
                }
                field("Released Containers Today"; Rec."Released Containers Today")
                {
                    DrillDownPageID = "Manifest Lines";
                    ToolTip = 'Specifies the value of the Containers Released Today field.';
                    ApplicationArea = All;
                 Visible = SICDContainerCUesVisible;
                }
                field("Stock 20FT"; Rec."Stock 20FT")
                {
                    DrillDownPageID = "Manifest Lines";
                    ToolTip = 'Specifies the value of the Stock 20FT field.';
                    ApplicationArea = All;
                    Visible = SICDContainerCUesVisible;
                }
                field("Stock 40FT"; Rec."Stock 40FT")
                {
                    DrillDownPageID = "Manifest Lines";
                    ToolTip = 'Specifies the value of the Stock 40FT field.';
                    ApplicationArea = All;
                    Visible = SICDContainerCUesVisible;
                }
                field("Container Stock"; rec."Container Stock")
                {
                    DrillDownPageID = "Manifest Lines";
                    ToolTip = 'Specifies the value of the Stock 40FT & 20FT field.';
                    ApplicationArea = All;
                    Visible = SICDContainerCUesVisible;
                }
                cuegroup("EMPTY CONTAINER")
                {
                    Caption = 'EMPTY CONTAINER';
                    Visible = ProcessTypeVisible;
                    field("EMPTYCTR Rcvd Containers Today"; Rec."EMPTYCTR Rcvd Containers Today")
                    {
                        DrillDownPageID = "Manifest Lines";
                        ToolTip = 'Specifies the value of the Empty Containers Received Today field.';
                        ApplicationArea = All;
                    }
                    field("EMPTYCTR Reld Containers Today"; Rec."EMPTYCTR Reld Containers Today")
                    {
                        DrillDownPageID = "Manifest Lines";
                        ToolTip = 'Specifies the value of the Empty Containers Released Today field.';
                        ApplicationArea = All;
                    }
                    field("EMPTYCTR Stock 20FT"; Rec."EMPTYCTR Stock 20FT")
                    {
                        DrillDownPageID = "Manifest Lines";
                        ToolTip = 'Specifies the value of the Empty Container Stock 20FT field.';
                        ApplicationArea = All;
                    }
                    field("EMPTYCTR Stock 40FT"; Rec."EMPTYCTR Stock 40FT")
                    {
                        DrillDownPageID = "Manifest Lines";
                        ToolTip = 'Specifies the value of the Empty Container Stock 40FT field.';
                        ApplicationArea = All;
                    }
                    field("EMPTYCTR Container Stock"; Rec."EMPTYCTR Container Stock")
                    {
                        DrillDownPageID = "Manifest Lines";
                        ToolTip = 'Specifies the value of the Empty Container Stock 40FT & 20FT field.';
                        ApplicationArea = All;
                    }
                }
                cuegroup(EXPORT)
                {
                    Caption = 'EXPORT';
                    Visible = ProcessTypeVisible;
                    field("EXPORT Rcvd Containers Today"; Rec."EXPORT Rcvd Containers Today")
                    {
                        DrillDownPageID = "Manifest Lines";
                        ToolTip = 'Specifies the value of the Export Containers Received Today field.';
                        ApplicationArea = All;
                    }
                    field("EXPORT Reld Containers Today"; Rec."EXPORT Reld Containers Today")
                    {
                        DrillDownPageID = "Manifest Lines";
                        ToolTip = 'Specifies the value of the Export Containers Released Today field.';
                        ApplicationArea = All;
                    }
                    field("EXPORT Stock 20FT"; Rec."EXPORT Stock 20FT")
                    {
                        DrillDownPageID = "Manifest Lines";
                        ToolTip = 'Specifies the value of the Export Container Stock 20FT field.';
                        ApplicationArea = All;
                    }
                    field("EXPORT Stock 40FT"; Rec."EXPORT Stock 40FT")
                    {
                        DrillDownPageID = "Manifest Lines";
                        ToolTip = 'Specifies the value of the Export Container Stock 40FT field.';
                        ApplicationArea = All;
                    }
                    field("EXPORT Container Stock"; Rec."EXPORT Container Stock")
                    {
                        DrillDownPageID = "Manifest Lines";
                        ToolTip = 'Specifies the value of the Export Container Stock 40FT & 20FT field.';
                        ApplicationArea = All;
                    }
                }
                cuegroup(IMPORT)
                {
                    Caption = 'IMPORT';
                    Visible = ProcessTypeVisible;
                    field("IMPORT Rcvd Containers Today"; Rec."IMPORT Rcvd Containers Today")
                    {
                        DrillDownPageID = "Manifest Lines";
                        ToolTip = 'Specifies the value of the Import Containers Received Today field.';
                        ApplicationArea = All;
                    }
                    field("IMPORT Reld Containers Today"; Rec."IMPORT Reld Containers Today")
                    {
                        DrillDownPageID = "Manifest Lines";
                        ToolTip = 'Specifies the value of the Import Containers Released Today field.';
                        ApplicationArea = All;
                    }
                    field("IMPORT Stock 20FT"; Rec."IMPORT Stock 20FT")
                    {
                        DrillDownPageID = "Manifest Lines";
                        ToolTip = 'Specifies the value of the Import Container Stock 20FT field.';
                        ApplicationArea = All;
                    }
                    field("IMPORT Stock 40FT"; Rec."IMPORT Stock 40FT")
                    {
                        DrillDownPageID = "Manifest Lines";
                        ToolTip = 'Specifies the value of the Import Container Stock 40FT field.';
                        ApplicationArea = All;
                    }
                    field("IMPORT Container Stock"; Rec."IMPORT Container Stock")
                    {
                        DrillDownPageID = "Manifest Lines";
                        ToolTip = 'Specifies the value of the Import Container Stock 40FT & 20FT field.';
                        ApplicationArea = All;
                    }
                }
                cuegroup("OVERLAND EXPORT")
                {
                    Caption = 'OVERLAND EXPORT';
                    Visible = ProcessTypeVisible;
                    field("OVERLAND EXPORT Rcvd Containers Today"; Rec."OVER EX Rcvd Containers Today")
                    {
                        DrillDownPageID = "Manifest Lines";
                        ToolTip = 'Specifies the value of the Overland Export Containers Received Today field.';
                        ApplicationArea = All;
                    }
                    field("OVER EX Reld Containers Today"; Rec."OVER EX Reld Containers Today")
                    {
                        DrillDownPageID = "Manifest Lines";
                        ToolTip = 'Specifies the value of the Overland Export Containers Released Today field.';
                        ApplicationArea = All;
                    }
                    field("OVERLAND EXP Stock 20FT"; Rec."OVERLAND EXP Stock 20FT")
                    {
                        DrillDownPageID = "Manifest Lines";
                        ToolTip = 'Specifies the value of the Overland Export Container Stock 20FT field.';
                        ApplicationArea = All;
                    }
                    field("OVERLAND EX Stock 40FT"; Rec."OVERLAND EX Stock 40FT")
                    {
                        DrillDownPageID = "Manifest Lines";
                        ToolTip = 'Specifies the value of the Overland Export Container Stock 40FT field.';
                        ApplicationArea = All;
                    }
                    field("OVERLAND EXP Container Stock"; Rec."OVERLAND EXP Container Stock")
                    {
                        DrillDownPageID = "Manifest Lines";
                        ToolTip = 'Specifies the value of the Overland Export Containers Stock field.';
                        ApplicationArea = All;
                    }
                }
                cuegroup(TRANSHIPMENT)
                {
                    Caption = 'TRANSHIPMENT';
                    Visible = ProcessTypeVisible;
                    field("TRANSHIP Rcvd Containers Today"; rec."TRANSHIP Rcvd Containers Today")
                    {
                        DrillDownPageID = "Manifest Lines";
                        ToolTip = 'Specifies the value of the TRANSHIP Rcvd Containers Today field.';
                        ApplicationArea = All;
                    }
                    field("TRANSHIP Reld Containers Today"; Rec."TRANSHIP Reld Containers Today")
                    {
                        DrillDownPageID = "Manifest Lines";
                        ToolTip = 'Specifies the value of the TRANSHIP Reld Containers Today field.';
                        ApplicationArea = All;
                    }
                    field("TRANSHIPMENT Stock 20FT"; Rec."TRANSHIPMENT Stock 20FT")
                    {
                        DrillDownPageID = "Manifest Lines";
                        ToolTip = 'Specifies the value of the TRANSHIPMENT Stock 20FT field.';
                        ApplicationArea = All;
                    }
                    field("TRANSHIPMENT Stock 40FT"; Rec."TRANSHIPMENT Stock 40FT")
                    {
                        DrillDownPageID = "Manifest Lines";
                        ToolTip = 'Specifies the value of the TRANSHIPMENT Stock 40FT field.';
                        ApplicationArea = All;
                    }
                    field("TRANSHIPMENT Container Stock"; Rec."TRANSHIPMENT Container Stock")
                    {
                        DrillDownPageID = "Manifest Lines";
                        ToolTip = 'Specifies the value of the TRANSHIPMENT Container Stock field.';
                        ApplicationArea = All;
                    }
                }
            }
            cuegroup(Units)
            {
                Caption = 'Units';
                field("Received Units Today"; Rec."Received Units Today")
                {
                    DrillDownPageID = "Manifest Lines";
                    ToolTip = 'Specifies the value of the Units Received Today field.';
                    ApplicationArea = All;
                }
                field("Released Units Today"; Rec."Released Units Today")
                {
                    DrillDownPageID = "Manifest Lines";
                    ToolTip = 'Specifies the value of the Units Released Today field.';
                    ApplicationArea = All;
                }
                field("Stock 1.5MT"; rec."Stock 1.5MT")
                {
                    DrillDownPageID = "Manifest Lines";
                    ToolTip = 'Specifies the value of the Stock 1.5MT field.';
                    ApplicationArea = All;
                }
                field("Stock 2.0MT"; rec."Stock 2.0MT")
                {
                    DrillDownPageID = "Manifest Lines";
                    ToolTip = 'Specifies the value of the Stock 2.0MT field.';
                    ApplicationArea = All;
                }
                field("Stock 5.0MT"; rec."Stock 5.0MT")
                {
                    DrillDownPageID = "Manifest Lines";
                    ToolTip = 'Specifies the value of the Stock 5.0MT field.';
                    ApplicationArea = All;
                }
                field("Stock 10MT"; rec."Stock 10MT")
                {
                    DrillDownPageID = "Manifest Lines";
                    ToolTip = 'Specifies the value of the Stock 10MT field.';
                    ApplicationArea = All;
                }
                field("Stock OVER 10MT"; rec."Stock OVER 10MT")
                {
                    DrillDownPageID = "Manifest Lines";
                    ToolTip = 'Specifies the value of the Stock Over 10MT field.';
                    ApplicationArea = All;
                }

            }
            cuegroup(Loose)
            {
                Caption = 'Loose';
                field("Received Loose Today"; rec."Received Loose Today")
                {
                    DrillDownPageID = "Manifest Lines";
                    ToolTip = 'Specifies the value of the Loose Received Today field.';
                    ApplicationArea = All;
                }
                field("Released Loose Today"; rec."Released Loose Today")
                {
                    DrillDownPageID = "Manifest Lines";
                    ToolTip = 'Specifies the value of the Loose Released Today field.';
                    ApplicationArea = All;
                }
                field("Stock Loose"; rec."Stock Loose")
                {
                    DrillDownPageID = "Manifest Lines";
                    ToolTip = 'Specifies the value of the Stock Loose field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Set Up Cues")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Set Up Cues';
                Image = Setup;
                ToolTip = 'Set up the cues (status tiles) related to the role.';

                trigger OnAction()
                var
                    CuesAndKpis: Codeunit "Cues And KPIs";
                    CueRecordRef: RecordRef;
                begin
                    CueRecordRef.GetTable(Rec);
                    CuesAndKpis.OpenCustomizePageForCurrentUser(CueRecordRef.Number);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
    begin
        ProcessTypeCuesVisibility;
        SICDContainerCUesVisibility;
    end;

    trigger OnAfterGetCurrRecord()
    var
    begin
        ProcessTypeCuesVisibility;
        SICDContainerCUesVisibility;
    end;

    trigger OnOpenPage()
    var

    begin
        rec.Reset;
        if not rec.Get then begin
            rec.Init;
            rec.Insert;
        end;
        rec.SetFilter("Current Date Filter", '%1', WorkDate);
        ProcessTypeCuesVisibility;
        SICDContainerCUesVisibility;
    end;

    procedure ProcessTypeCuesVisibility()
    var
    begin

        if CompanyName <> 'SICD' then
            ProcessTypeVisible := false
        else
            ProcessTypeVisible := true;
    end;

    procedure SICDContainerCUesVisibility()
    var
    begin
        if CompanyName = 'SICD' then
            SICDContainerCUesVisible := false
        else
            SICDContainerCUesVisible := true;
    end;

    var
        ProcessTypeVisible, SICDContainerCUesVisible : Boolean;

}
