table 50154 "Field Edit Permission"
{
    Caption = 'Field Edit Permission';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = user."User Name";
            ValidateTableRelation = false;
            trigger OnValidate()
            var
                UserSelection: Codeunit "User Selection";
            begin
                UserSelection.ValidateUserName("User ID");
                "Page ID" := 50300;
                "Table ID" := 50107;
            end;
        }
        field(2; "Page ID"; Integer)
        {
            Caption = 'Page ID';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Page));

        }
        field(3; "Table ID"; Integer)
        {
            DataClassification = SystemMetadata;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Table));
        }
        field(4; "Field No."; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = Field."No." where(TableNo = field("Table ID"));
        }
        field(5; "Field Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Field.FieldName where(TableNo = field("Table ID"), "No." = field("Field No.")));
            Editable = false;
        }
        field(6; "Can Edit"; Boolean)
        {
            DataClassification = SystemMetadata;
        }
    }
    keys
    {
        key(PK; "User ID", "Page ID", "Table ID", "Field No.")
        {
            Clustered = true;
        }
    }
}
page 50299 "Field Edit Permission List"
{
    PageType = List;
    SourceTable = "Field Edit Permission";
    ApplicationArea = All;
    // UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Page ID"; Rec."Page ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Field No."; Rec."Field No.")
                {
                    ApplicationArea = All;
                    LookupPageId = "Field Lookup Page";
                }
                field("Field Name"; Rec."Field Name")
                {
                    ApplicationArea = All;
                }
                field("Can Edit"; Rec."Can Edit")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        IF (UserId <> 'GROUP.AUDIT') and (UserId <> 'TECHBIZINFOTECH') then
            error('You are not Authorized to view this area. Please contact Group Audit');
    end;
}
codeunit 50104 "Field Permission Helper"
{
    procedure CanUserEditField(UserID: Code[50]; PageID: Integer; TableID: Integer; FieldName: Integer): Boolean
    var
        Perm: Record "Field Edit Permission";
    begin
        if Perm.Get(UserID, PageID, TableID, FieldName) then
            exit(Perm."Can Edit");
        exit(false);
    end;
}
page 50059 "Field Lookup Page"
{
    PageType = List;
    SourceTable = Field;
    ApplicationArea = All;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table No."; Rec.TableNo) { }
                field("Field Name"; Rec.FieldName) { }
                field("No."; Rec."No.") { }
                field("Field Type"; Rec."Type Name") { }
            }
        }
    }
}
