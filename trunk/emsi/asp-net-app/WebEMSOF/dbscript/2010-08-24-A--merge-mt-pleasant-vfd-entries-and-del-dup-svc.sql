START TRANSACTION;

update county_dictated_appropriation
set service_id = 101
where service_id = 170;

delete from service_user where id = 170;
delete from service where id = 170;

update service
set affiliate_num = 63323
where id = 101;

COMMIT