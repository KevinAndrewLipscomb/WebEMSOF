START TRANSACTION
;
update county_user
set password_reset_email_address = concat("County",id,"@frompaper2web.com")
;
update regional_staffer_user
set password_reset_email_address = concat("RegionalStaffer",id,"@frompaper2web.com")
;
update service_user
set password_reset_email_address = concat("Service",id,"@frompaper2web.com")
;
update coned_sponsor_user
set password_reset_email_address = concat("ConedSponsor",id,"@frompaper2web.com")
;
update teaching_entity
set email = concat("TeachingEntity",id,"_Email@frompaper2web.com")
, contact_email = concat("TeachingEntity",id,"_ContactEmail@frompaper2web.com")
, public_contact_email = concat("TeachingEntity",id,"_PublicContactEmail@frompaper2web.com")
;
update coned_offering
set public_contact_email = concat("ConedOffering",id,"_PublicContactEmail@frompaper2web.com")
, location_email = concat("ConedOffering",id,"_LocationEmail@frompaper2web.com")
;
update practitioner
set email_address = concat("Practitioner",id,"@frompaper2web.com")
;
COMMIT