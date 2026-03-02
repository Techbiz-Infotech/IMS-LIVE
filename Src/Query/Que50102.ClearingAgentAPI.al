query 50102 "Clearing Agent API"
{
    APIGroup = 'apiGroup';
    APIPublisher = 'Techbizinfotech';
    APIVersion = 'v1.0';
    EntityName = 'ClearingAgentAPI';
    EntitySetName = 'ClearingAgentAPI';
    QueryType = API;

    elements
    {
        dataitem(clearingAgent; "Clearing Agent")
        {
            column(clearingAgentCode; "Clearing Agent Code")
            {
            }
            column(clearingAgentName; "Clearing Agent Name")
            {
            }
            column(Address; Address)
            {

            }
            column(E_mail; "E-mail")
            { }
            column(Contact_Person_Email; "Contact-Person Email")
            {

            }

        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
