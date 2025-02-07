namespace procurement.db;

using {
    procurement.db.master,
    procurement.db.transaction
} from './datamodel';

context cdsview {
    define view ![podetails] as
        select from transaction.purchaseorder {
            key po_id                             as ![PurchaseOrders],
                partner_guid.bp_id                as ![Vendorid],
                partner_guid.company_name         as ![CompanyName],
                gross_amount                      as ![PoGrossAmount],
                currency_code                     as ![PoCurrency],
            key items.po_item_pos                 as ![ItemPosition],
                items.product_guid.product_id     as ![ProductId],
                items.product_guid.description    as ![ProductDesc],
                partner_guid.address_guid.city    as ![City],
                partner_guid.address_guid.country as ![Country],
                items.gross_amount                as ![ItemGrossAmount],
                items.net_amount                  as ![ItemNetAmount]
        }

    // another view
    define view ![itemview] as
        select from transaction.poitems {
            key parent_key.partner_guid.node_key as ![Vendor],
                product_guid.node_key            as ![ProductID],
                currency_code                    as ![CurrencyCode],
                net_amount                       as ![NetAmount],
                tax_amount                       as ![TaxAmount],
                parent_key.overall_status        as ![POStatus]
        }

    // using Aggregation
    define view productsum as
        select from master.product as prod {
            key product_id as ![ProductID],
            texts.description as ![Description],
            (select from transaction.poitems as a {
                SUM(a.gross_amount) as SUM
            
            } where a.product_guid.node_key = prod.node_key
            )as PO_SUM : Decimal(10, 2)
        }

}
