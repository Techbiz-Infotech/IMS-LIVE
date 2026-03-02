pageextension 50129 InteractionLogEntriesExt extends "Interaction Log Entries"
{
    layout
    {
        addafter(Comment)
        {
            field("Comments 2"; rec."Comments 2")
            {
                ToolTip = 'Comments 2';
                ApplicationArea = All;
            }
            field("Interaction Comments"; rec."Interaction Comments")
            {
                ToolTip = 'Interaction Comments';
                ApplicationArea = All;
            }
        }
    }
}
