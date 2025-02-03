using { procurement.db.master, procurement.db.transaction } from '../db/datamodel';

@path: 'procurement'
service CatalogService {
    entity businesspartner as projection on master.businesspartner;
    
    entity address as projection on master.address;

    entity purchaseorder as projection on transaction.purchaseorder;

    entity poitems as projection on transaction.poitems;

    entity product as projection on master.product;

     entity employee as projection on master.employee;
}
