using { procurement.db.cdsview } from '../db/cdsViews.cds';

@path: 'cdsviewsrv'
service CdsViewsrv {
  entity podetails as projection on cdsview.podetails;
  entity itemview as projection on cdsview.itemview;
  entity productsum as projection on cdsview.productsum;
}
