START TRANSACTION;

update county_user
set password_reset_email_address = concat("County",id,"@frompaper2web.com");

update regional_staffer_user
set password_reset_email_address = concat("RegionalStaffer",id,"@frompaper2web.com");

update service_user
set password_reset_email_address = concat("Service",id,"@frompaper2web.com");

COMMIT