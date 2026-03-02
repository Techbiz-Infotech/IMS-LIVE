pageextension 50128 CreateInteractionExt extends "Create Interaction"
{
    layout
    {
        addafter(Description)
        {
            field("Description 2"; rec."Description 2")
            {
                ApplicationArea = all;
                Caption = 'Description 2';
            }
        }

    }
}

