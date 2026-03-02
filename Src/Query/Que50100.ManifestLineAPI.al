query 50100 "Manifest Line API"
{
    APIGroup = 'apiGroup';
    APIPublisher = 'Techbizinfotech';
    APIVersion = 'v1.0';
    EntityName = 'ManifestLineAPI';
    EntitySetName = 'ManifestLineAPI';
    QueryType = API;

    elements
    {
        dataitem(manifestLine; "Manifest Line")
        {
            column(allocatedPosition; "Allocated Position")
            {
            }
            column(blNo; "BL No.")
            {
            }
            column(cbmTonage; "CBM Tonage")
            {
            }
            column(cbmWtDifference; "CBM-Wt Difference")
            {
            }
            column(chargeID; "Charge ID")
            {
            }
            column(clearingAgent; "Clearing Agent")
            {
            }
            column(clientReferenceNo; "Client Reference No.")
            {
            }
            column(consigneeName; "Consignee Name")
            {
            }
            column(consigneeNo; "Consignee No.")
            {
            }
            column(containerType; "Container Type")
            {
            }
            column(containerLock; "Container lock")
            {
            }
            column(containerChassisNo; "Container/Chassis No.")
            {
            }
            column(creditMemos; "Credit Memos")
            {
            }
            column(customEntryNo; "Custom Entry No.")
            {
            }
            column(customsSealNo; "Customs Seal No.")
            {
            }
            column(dateReceived; "Date Received")
            {
            }
            column(dateReleased; "Date Released")
            {
            }
            column(deliveryOrderNo; "Delivery Order No.")
            {
            }
            column(description; Description)
            {
            }
            column(destinationType; "Destination Type")
            {
            }
            column(dischargeDate; "Discharge Date")
            {
            }
            column(docsReceivedDate; "Docs Received Date")
            {
            }
            column(driverID; "Driver ID")
            {
            }
            column(driverName; "Driver Name")
            {
            }
            column(emptyContainer; "Empty Container")
            {
            }
            column(Container_Status; "Container Status")
            {

            }
            column(finalDestination; "Final Destination")
            {
            }
            column(gpDeliveryOrderNo; "GP Delivery Order No.")
            {
            }
            column(globalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(globalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(icdnInDate; "ICDN In-Date")
            {
            }
            column(invoices; Invoices)
            {
            }
            column(invoicingPartyNo; "Invoicing Party No.")
            {
            }
            column(jobFileDate; "Job File Date")
            {
            }
            column(jobFileNo; "Job File No.")
            {
            }
            column(landingDate; "Landing Date")
            {
            }
            column(landingTime; "Landing Time")
            {
            }
            column(lineNo; "Line No.")
            {
            }
            column(lockNo; "Lock No.")
            {
            }
            column(manifested; Manifested)
            {
            }
            column(marks; Marks)
            {
            }
            column(noOfBags; "No. of Bags")
            {
            }
            column(noOfBagsReleased; "No. of Bags Released")
            {
            }
            column(oppertunityNo; "Oppertunity No.")
            {
            }
            column(otherRemarks; "Other remarks")
            {
            }
            column(parentContainerID; "Parent Container ID")
            {
            }
            column(portOfDischarge; "Port of Discharge")
            {
            }
            column(portOfShipment; "Port of Shipment")
            {
            }
            column(railedDate; "Railed Date")
            {
            }
            column(received; Received)
            {
            }
            column(receivedBy; "Received By")
            {
            }
            column(receivedTime; "Received Time")
            {
            }
            column(released; Released)
            {
            }
            column(remainingBags; "Remaining Bags")
            {
            }
            column(sicdInDate; "SICD In-Date")
            {
            }
            column(salesQuoteNo; "Sales Quote No.")
            {
            }
            column(sealLocked; "Seal Locked?")
            {
            }
            column(sealTagged; "Seal Tagged?")
            {
            }
            column(sealEngineNo; "Seal/Engine No.")
            {
            }
            column(shortcutDimension3Code; "Shortcut Dimension 3 Code")
            {
            }
            column(shortcutDimension4Code; "Shortcut Dimension 4 Code")
            {
            }
            column(shortcutDimension5Code; "Shortcut Dimension 5 Code")
            {
            }
            column(shortcutDimension6Code; "Shortcut Dimension 6 Code")
            {
            }
            column(stripped; Stripped)
            {
            }
            column(strippingDate; "Stripping Date")
            {
            }
            column(strippingNotes; "Stripping Notes")
            {
            }
            column(strippingTime; "Stripping Time")
            {
            }
            column(tblMH; "TBL/MH")
            {
            }
            column(transporter; Transporter)
            {
            }
            column(transporterName; "Transporter Name")
            {
            }
            column(userID; "User ID")
            {
            }
            column(vehicle; Vehicle)
            {
            }
            column(verificationNotes; "Verification Notes")
            {
            }
            column(verificationPrintDate; "Verification Print Date")
            {
            }
            column(verificationTime; "Verification Time")
            {
            }
            column(verificationType; "Verification Type")
            {
            }
            column(verified; Verified)
            {
            }
            column(weight; Weight)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
