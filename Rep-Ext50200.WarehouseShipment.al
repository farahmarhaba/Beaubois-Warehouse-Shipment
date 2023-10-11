reportextension 50200 "Warehouse Shipment" extends "Whse. - Shipment"
{
    RDLCLayout = './Warehouse Whipment Navision.rdl';
    dataset
    {

        add("Warehouse Shipment Header")
        {
            column(CompanyInformationPicture; CompanyInformation.Picture)
            {
            }
            Column(CompanyAddress1; companyAddress[1])
            {

            }
            Column(CompanyAddress2; companyAddress[2])
            {

            }
            Column(CompanyAddress3; companyAddress[3])
            {

            }
            Column(CompanyAddress4; companyAddress[4])
            {

            }
            Column(CompanyAddress5; companyAddress[5])
            {

            }
            Column(CompanyAddress6; companyAddress[6])
            {

            }

            column(ShortcutFeatureCodeValue; "ShortcutFeatureCodeValue")
            {

            }

            column(ShortcutFeatureCodeCaption; "ShortcutFeatureCodeCaption")
            {

            }
            column(showLogo; showLogo)
            {

            }

            column(ProductionOrderNo_WarehouseShipmentLineCaption; ProductionOrderNo_WarehouseShipmentLineCaption)
            {

            }
            column(PackageQtyCaption; PackageQtyCaption)
            {

            }
            column(QtytoShip_WarehouseShipmentLineCaption; QtytoShip_WarehouseShipmentLineCaption)
            {

            }
            column(PackageQtyValue; PackageQtyValue)
            {

            }

            column(Notes; Notes)
            {

            }
            column(NotesLbl; NotesLbl)
            {

            }



        }

        modify("Warehouse Shipment Header")
        {

            trigger OnAfterAfterGetRecord()
            var
                RecordLink: record "Record Link";
                RecordLinkMng: Codeunit "Record Link Management";
                InStream: InStream;
                Note: Text;
                Lf: Text[1];

            begin
                Lf[1] := 10;
                clear(Notes);
                RecordLink.setrange("Record ID", "Warehouse Shipment Header".RecordId);
                RecordLink.setrange(Type, RecordLink.type::Note);
                if recordLink.findset() then
                    repeat
                        RecordLink.CalcFields(Note);
                        RecordLink.Note.CreateInStream(InStream);
                        InStream.ReadText(Note);
                        Note := DelStr(Note, 1, 1) + Lf;
                        Notes += Note;
                    until RecordLink.Next() = 0;
            end;

        }





        add("Warehouse Shipment Line")
        {
            column(Qty__to_Ship; "Qty. to Ship")
            {

            }



        }
        modify("Warehouse Shipment Line")
        {
            /* trigger OnAfterAfterGetRecord()
             begin
                 GetLocation("Location Code");
                 EXI-011+
                 CLEAR(ShortcutFeatureCode);
                 IF JobsSetup."Warehouse Shipment Feature No." <> 0 THEN BEGIN
                     CLEAR(JobPlanningLine);
                     JobPlanningLine.SETRANGE("Job No.", "Job No.");
                     JobPlanningLine.SETRANGE("Job Task No.", "Job Task No.");
                     JobPlanningLine.SETRANGE(Type, JobPlanningLine.Type::Item);
                     JobPlanningLine.SETRANGE("No.", "Item No.");
                     IF JobPlanningLine.FINDSET THEN
                         FeatureMgt.GetShortcutFeatures(JobPlanningLine."Feature Set ID", ShortcutFeatureCode);
                 END;
                 CLEAR(JobDeliveryLine);
                 JobDeliveryLine.SETRANGE("Job No.", "Job No.");
                 JobDeliveryLine.SETRANGE("Job Task No.", "Job Task No.");
                 JobDeliveryLine.SETRANGE("No.", "Item No.");
                 IF JobDeliveryLine.FINDSET THEN BEGIN
                     CLEAR(Package);
                     JobDeliveryLine.CALCFIELDS("Production Order No.");
                     Package.SETRANGE("Production Order No.", JobDeliveryLine."Production Order No.");
                     IF Package.FINDSET THEN
                         PackageQty := Package.COUNT;
                 END;
            job.SETRANGE("No.","Job No.");
            IF job.FINDSET THEN
                                   BEGIN
            featureSetEntry.SETRANGE("Feature Set ID", job."Feature Set ID");
            featureSetEntry.SETRANGE("Feature Code", 'SUPPLY');
            IF featureSetEntry.FINDSET THEN
             BEGIN
            IF UPPERCASE(featureSetEntry."Feature Value Code") = 'YES' THEN
            showLogo:=FALSE;
            END;
             END;
             END;


             end; */


        }

    }
    trigger OnPreReport()
    var
        FormatAddress: Codeunit "Format Address";
    begin
        CompanyInformation.GET();
        CompanyInformation.CALCFIELDS(Picture);
        FormatAddress.Company(CompanyAddress, CompanyInformation);
        showLogo := true;
    end;

    var
        Notes: Text;
        NotesLbl: Label 'Notes';
        CompanyInformation: record "Company Information";
        companyAddress: array[8] of Text[100];
        ShortcutFeatureCodeCaption: Label 'Room';
        ShortcutFeatureCodeValue: Integer;
        showLogo: boolean;
        ProductionOrderNo_WarehouseShipmentLineCaption: Label 'Production Order No.';
        PackageQtyCaption: Label 'Package Qty.';
        QtytoShip_WarehouseShipmentLineCaption: Label 'Qty. to Ship';
        QtytoShip_WarehouseShipmentLine: Integer;
        PackageQtyValue: Integer;


}
