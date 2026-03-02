table 50109 "CRM KPI Dashboard"
{
    Caption = 'CRM KPI Dashboard';
    DataClassification = ToBeClassified;

    fields
    {

        field(1; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = ToBeClassified;
            TableRelation = Date."Period Name" WHERE("Period Type" = FILTER(Year));
        }
        field(2; Month; Text[50])
        {
            Caption = 'Month';
            DataClassification = ToBeClassified;
            TableRelation = Date."Period Name" WHERE("Period Type" = FILTER(Month));
        }
        field(3; "No. of Client Visits"; Integer)
        {
            Caption = 'No. of Client Visits';
            FieldClass = FlowField;
            CalcFormula = Count("Interaction Log Entry" WHERE(Date = FIELD("Date Filter"), "Interaction Template Code" = FILTER('VISIT')));
        }
        field(4; "No. of Calls/Emails"; Integer)
        {
            Caption = 'No. of Calls/Emails';
            FieldClass = FlowField;
            CalcFormula = Count("Interaction Log Entry" WHERE(Date = FIELD("Date Filter"), "Interaction Template Code" = FILTER('EMAIL|PHONE')));
        }
        field(5; "No. Of Online Presentations"; Integer)
        {
            Caption = 'No. Of Online Presentations';
            DataClassification = ToBeClassified;
        }
        field(6; "No of new clients/prospects"; Integer)
        {
            Caption = 'No of new clients/prospects';
            DataClassification = ToBeClassified;
        }
        field(7; "No of containers (TEUs)"; Integer)
        {
            Caption = 'No of containers (TEUs)';
            DataClassification = ToBeClassified;
        }
        field(8; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(9; "Month Start"; Date)
        {
            Caption = 'Month Start';
            DataClassification = ToBeClassified;
        }
        field(10; "Month End"; Date)
        {
            Caption = 'Month End';
            DataClassification = ToBeClassified;
        }
        field(11; "Month No."; Integer)
        {
            Caption = 'Month No.';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Year, Month)
        {
            Clustered = true;
        }
        key(SK; "Month No.")
        {

        }
    }
}
