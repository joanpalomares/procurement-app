using { procurement.db.CDSViews } from '../db/CDSViews';

@path: 'CDSViewSrv'
service CDSViewSrv {
  entity PODetails as projection on CDSViews.PODetails;
  entity ItemView as projection on CDSViews.ItemView;
  entity ProductSum as projection on CDSViews.ProductSum;
}
