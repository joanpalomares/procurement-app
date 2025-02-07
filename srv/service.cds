using {
    procurement.db.master,
    procurement.db.transaction
} from '../db/datamodel';

@path: 'procurement'
service CatalogService {
    entity businesspartner as projection on master.businesspartner;

    annotate CatalogService.businesspartner with @(Capabilities: {
        InsertRestrictions: {Insertable: false},
        UpdateRestrictions: {Updatable: false},
        DeleteRestrictions: {Deletable: false},
    });

    entity address         as projection on master.address;

    annotate CatalogService.address with @(Capabilities: {
        InsertRestrictions: {Insertable: false},
        UpdateRestrictions: {Updatable: false},
        DeleteRestrictions: {Deletable: false},
    });

    entity purchaseorder   as projection on transaction.purchaseorder;

      annotate transaction.purchaseorder with @(Capabilities: {
        InsertRestrictions: {Insertable: false},
        UpdateRestrictions: {Updatable: false},
        DeleteRestrictions: {Deletable: false},
    });

    annotate CatalogService.purchaseorder with @(Capabilities: {
        InsertRestrictions: {Insertable: false},
        UpdateRestrictions: {Updatable: false},
        DeleteRestrictions: {Deletable: false},
    });

    entity poitems         as projection on transaction.poitems;

    annotate CatalogService.poitems with @(Capabilities: {
        InsertRestrictions: {Insertable: false},
        UpdateRestrictions: {Updatable: false},
        DeleteRestrictions: {Deletable: false},
    });


    entity product         as projection on master.product;

    annotate CatalogService.product with @(Capabilities: {
        InsertRestrictions: {Insertable: false},
        UpdateRestrictions: {Updatable: false},
        DeleteRestrictions: {Deletable: false},
    });


    @readonly
    entity employee        as projection on master.employee;
}
