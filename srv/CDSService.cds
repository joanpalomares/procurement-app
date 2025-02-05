using { procurement.db.CDSViews } from '../db/CDSViews';

@path: 'CDSViewSrv'
service CDSViewSrv {
  entity PODetails as projection on CDSViews.PODetails;
}
