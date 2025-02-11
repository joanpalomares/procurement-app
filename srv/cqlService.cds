using {procurement.db.master} from '../db/datamodel';

service NewCQLService {

    @readonly
    entity readEmployee   as projection on master.employee;

    @insertonly
    entity insertEmployee as projection on master.employee;

}
