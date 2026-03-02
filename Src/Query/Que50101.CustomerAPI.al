query 50101 "Customer API"
{
    APIGroup = 'apiGroup';
    APIPublisher = 'Techbizinfotech';
    APIVersion = 'v1.0';
    EntityName = 'CustomerAPI';
    EntitySetName = 'CustomerAPI';
    QueryType = API;

    elements
    {
        dataitem(customer; Customer)
        {
            column(address; Address)
            {
            }
            column(address2; "Address 2")
            {
            }

            column(contact; Contact)
            {
            }
            column(contactID; "Contact ID")
            {
            }
            column(contactType; "Contact Type")
            {
            }
            column(eMail; "E-Mail")
            {
            }
            column(name; Name)
            {
            }
            column(name2; "Name 2")
            {
            }
            column(no; "No.")
            {
            }
            column(salespersonCode; "Salesperson Code")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
