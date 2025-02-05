namespace procurement.db;

using {
    procurement.db.master,
    procurement.db.transaction
} from './datamodel';

context CDSViews {
    define view ![PODetails] as
        select from transaction.purchaseorder {
            key po_id                             as ![PurchaseOrders],
                partner_guid.bp_id                as ![VendorID],
                partner_guid.company_name         as ![companyName],
                gross_amount                      as ![POGrossAmount],
                currency_code                     as ![POCurrency],
            key items.po_item_pos                 as ![ItemPosition],
                items.product_guid.product_id     as ![ProductID],
                items.product_guid.description    as ![ProductDesc],
                partner_guid.address_guid.city    as ![City],
                partner_guid.address_guid.country as ![Country],
                items.gross_amount                as ![ItemGrossAmount],
                items.net_amount                  as ![ItemNetAmount]
        }

    // another view
    define view ![ItemView] as
        select from transaction.poitems {
            key parent_key.partner_guid.node_key as ![Vendor],
                product_guid.node_key            as ![ProductID],
                currency_code                    as ![CurrencyCode],
                net_amount                       as ![NetAmount],
                tax_amount                       as ![TaxAmount],
                parent_key.overall_status        as ![POStatus]
        }

    // using Aggregation
    define view ProductSum as
        select from master.product as prod {
            key product_id as ![ProductID],
            texts.description as ![Description],
            (select from transaction.poitems as a {
                SUM(a.gross_amount) as SUM
            
            } where a.product_guid.node_key = prod.node_key
            )as PO_SUM : Decimal(10, 2)
        }

}
