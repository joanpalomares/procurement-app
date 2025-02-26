namespace procurement.db;

using {
    cuid,
    managed
} from '@sap/cds/common';

using {procurement.customAspect} from './customAspect';


context master {

    entity employee : cuid, managed {
        firstName    : String(30);
        lastName     : String(30);
        gender       : customAspect.Gender;
        phoneNumber  : customAspect.phoneNumber;
        email        : customAspect.email;
        currency     : String(3);
        salaryAmount : Decimal(10,2);
    }

    entity businesspartner {
        key node_key      : String(50);
            bp_role       : Integer;
            email_address : String(50);
            phone_Number  : customAspect.phoneNumber;
            fax_number    : customAspect.faxNumber;
            web_address   : String(100);
            address_guid  : Association to one address;
            bp_id         : String(16);
            company_name  : String(30);
    }

    annotate businesspartner with {
        node_key      @title: '{i18n>bp_key}';
        bp_role       @title: '{i18n>bp_role}';
        email_address @title: '{i18n>email_address}';
        phone_Number  @title: '{i18n>phone_number}';
        fax_number    @title: '{i18n>fax_number}';
        web_address   @title: '{i18n>web_address}';
        bp_id         @title: '{i18n>bp_id}';
        company_name  @title: '{i18n>company_name}';
    }


    entity address {
        key node_key        : String(50);
            city            : String(40);
            postal_code     : String(8);
            street          : String(45);
            building        : String(50);
            country         : String(40);
            address_type    : String(44);
            val_start_date  : Date;
            val_end_date    : Date;
            latitude        : Decimal;
            longitude       : Decimal;
            businesspartner : Association to one businesspartner
                                  on businesspartner.address_guid = $self;
    }

    entity product {
        key node_key        : String(50);
            product_id      : String(50);
            type_code       : String(2);
            category        : String(30);
            description     : localized String(35);
            supplier_guid   : Association to one businesspartner;
            tax_tariff_code : Integer;
            measure_unit    : String(2);
            weight_measure  : Decimal;
            weight_unit     : String(2);
            currency_code   : String(2);
            price           : Decimal;
            width           : Decimal;
            depth           : Decimal;
            height          : Decimal;
            dim_unit        : String(2);
    }
}

context transaction {
    entity purchaseorder : customAspect.Amount {
        key node_key         : String(50);
            po_id            : String(24);
            partner_guid     : Association to one master.businesspartner;
            lifecycle_status : String(1);
            overall_status   : String(1);
            items            : Association to many poitems
                                   on items.parent_key = $self;
    }

    entity poitems : customAspect.Amount {
        key node_key     : String(50);
            parent_key   : Association to one purchaseorder;
            po_item_pos  : Integer;
            product_guid : Association to one master.product;
    }
}
