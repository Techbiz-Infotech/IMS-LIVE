page 50154 "Pending Gate Pass Outs"
{

    Caption = 'Pending Gate Pass Out';
    PageType = Document;
    SourceTable = "Posted Gate Pass Out";
    SourceTableView = where(Released = const(false), "Gate Pass Status" = const(Active));
    //Editable = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Gate Pass No."; Rec."Gate Pass No.")
                {
                    ToolTip = 'Specifies the value of the Gate Pass No. field.';
                    ApplicationArea = All;
                }
                field("Activity Time"; rec."Activity Time")
                {
                    ApplicationArea = all;
                }
                field("Activity Date"; rec."Activity Date")
                {
                    ApplicationArea = all;
                }
                field("BL No."; Rec."BL No.")
                {
                    ToolTip = 'Specifies the value of the BL No. field.';
                    ApplicationArea = All;
                }
                field("Job File No."; Rec."Job File No.")
                {
                    ToolTip = 'Specifies the value of the Job File No. field.';
                    ApplicationArea = All;
                }

                field("Gate Pass Status"; rec."Gate Pass Status")
                {
                    ApplicationArea = all;
                }
            }

            part(GatePassLines; 50165)
            {
                ApplicationArea = all;
                SubPageLink = "Gate Pass No." = field("Gate Pass No.");
                UpdatePropagation = Both;
            }
            group(Others)
            {

                field("Storage Days"; Rec."Storage Days")
                {
                    ToolTip = 'Specifies the value of the Storage Days field.';
                    ApplicationArea = All;
                }
            }

        }
    }
    actions
    {
        area(Navigation)
        {
            action("Release Container")
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    myInt: Integer;
                    PostedGate: Record "Posted Gate Pass Out";
                begin

                    //GLEntryInsert();
                    Rec.Released := true;
                    Rec."Released Date" := today();
                    Rec."Released Time" := Time;
                    Rec.Modify();
                    //rec.ReversePrepayacc();
                    rec.UpdateManifest();
                    rec.UpdatePositionLog();
                    rec.UpdatePosition();
                    rec.UpdateContainer();
                    CurrPage.Update(false);

                end;
            }

        }


    }


}