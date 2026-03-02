xmlport 50100 "Manifest Line Import"
{
    Caption = 'Manifest Line Import';
    Direction = Import;
    Format = VariableText;
    TableSeparator = '<NewLine>';
    TextEncoding = UTF8;
    UseRequestPage = false;
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(ManifestLine; "Manifest Line")
            {
                XmlName = 'ManifestLine';


                fieldelement(BLNo; ManifestLine."BL No.")
                {
                }
                fieldelement(ContainerNo; ManifestLine."Container/Chassis No.")
                {
                }
                fieldelement(SealEngineNo; ManifestLine."Seal/Engine No.")
                {
                }
                fieldelement(CargoType; ManifestLine."Shortcut Dimension 4 Code")
                {
                }
                fieldelement(Marks; ManifestLine.Marks)
                {
                }
                fieldelement(ContainerType; ManifestLine."Container Type")
                {
                }
                fieldelement(ContainerSize; ManifestLine."Shortcut Dimension 5 Code")
                {
                }
                fieldelement(Description; ManifestLine.Description)
                {
                }
                fieldelement(CBMTonage; ManifestLine."CBM Tonage")
                {
                }
                fieldelement(Weight; ManifestLine.Weight)
                {
                }
                fieldelement(PortofShipment; ManifestLine."Port of Shipment")
                {
                }
                fieldelement(PortofDischarge; ManifestLine."Port of Discharge")
                {
                }
                fieldelement(DestinationType; ManifestLine."Destination Type")
                {
                }
                fieldelement(ClearingAgent; ManifestLine."Clearing Agent")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Consignee; ManifestLine."Consignee No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(InvoicingPartyNo; ManifestLine."Invoicing Party No.")
                {
                    MinOccurs = Zero;
                }
                trigger OnBeforeInsertRecord()
                var
                    //ManifestHeadeRec: Record "Manifest Header";
                    ManifestLineRec: Record "Manifest Line";
                begin
                    ManifestLine."Job File No." := JFNo;
                    ManifestLinerec.Reset();
                    ManifestLinerec.SetRange("Job File No.", ManifestLine."Job File No.");
                    IF ManifestLinerec.FindLast() then
                        ManifestLine."Line No." := ManifestLinerec."Line No." + 10000
                    Else
                        ManifestLine."Line No." := 10000;
                End;
            }
        }
    }
    var
        LineNo_gInt: Integer;
        JFNo: Code[20];

    procedure GetJobfileNo(var NewJobfileNo: code[20])
    var
        myInt: Integer;
    begin
        JFNo := NewJobfileNo;
    end;
}