tableextension 50115 InteractionLogext extends "Interaction Log Entry"
{
    fields
    {
        field(50100; "Description 2"; Text[1024])
        {
            Caption = 'Description 2';
            DataClassification = ToBeClassified;
        }
        field(50101; "Comments 2"; Text[1024])
        {
            Caption = 'Comments 2';
            DataClassification = ToBeClassified;
        }
        field(50102; "Interaction Comments"; Text[1024])
        {
            CalcFormula = lookup("Inter. Log Entry Comment Line".Comment WHERE("Entry No." = FIELD("Entry No.")));
            Caption = 'Interaction Comments';
            Editable = false;
            FieldClass = FlowField;
        }

    }
}
