START TRANSACTION;

update county_dictated_appropriation
set service_id = 166
where service_id = 1;

delete from service_user where id = 1;
delete from service where id = 1;

COMMIT