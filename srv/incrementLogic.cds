using {procurement.db.master} from '../db/datamodel';


service incrementService {

    entity employee as projection on master.employee;
    action hike(ID : UUID)

}
