report 50137 CustomerChargesReport
{
    ApplicationArea = All;
    Caption = 'Customer Charges Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Src/Reports/Layouts/CustomerChargesReport.rdlc';
    dataset
    {
        dataitem(ChargeIDAssignment; "Charge ID Assignment")
        {
            CalcFields = Status;
            
            column(CustomerNo; "Customer No.") { }
            column(GlobalDimension2Code; "Global Dimension 2 Code") { }
            column(ShortcutDimension5Code; "Shortcut Dimension 5 Code") { }
            column(Effective_From_Date;"Effective From Date"){}
            column(Effective_To_Date;"Effective To Date"){}
            column(Status;Status){}
            column(Assignment_Status;"Assignment Status"){}
            column(Charge_Id_Group_Code; "Charge Id Group Code") { }
            column(Custname; CustName) { }
            column(Freedays; Freedays) { }

            dataitem("Charge ID Group Line"; "Charge ID Group Line")
            {
                DataItemLink = "Charge ID Group Code" = field("Charge ID Group Code");
                DataItemTableView = SORTING("Charge ID Group Code") WHERE(Charge = FILTER(<> ''));
                column(Charge; Charge) { }
                column(Charge_Description_; "Charge Description ") { }
                column(First_Interval; "First Interval") { }
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;

            begin
                if CustRec.get("Customer No.") then
                    Custname := CustRec.Name
                else
                    Custname := '';

                ChargeGroupLine.Reset();
                ChargeGroupLine.SetRange("Charge ID Group Code", "Charge Id Group Code");
                ChargeGroupLine.SetFilter("Free Days", '<>%1', 0);
                if ChargeGroupLine.FindFirst() then
                    Freedays := ChargeGroupLine."Free Days"
                else
                    Freedays := 0;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        Custname: Text[100];
        CustRec: Record Customer;
        ChargeGroupLine: Record "Charge ID Group Line";
        Freedays: Decimal;
}
