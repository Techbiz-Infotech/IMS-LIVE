tableextension 50119 PurchaseheadExt extends "Purchase Header"
{
    fields
    {
        field(50100; "Created By User ID"; Code[50])
        {
            Caption = 'Created By User ID';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(50101; "CU Number"; Code[50])
        {
            Caption = 'CU Number';
            DataClassification = ToBeClassified;
            //TableRelation = User."User Name";
        }

    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        "Created By User ID" := UserId;
    end;
}
