START TRANSACTION;

update emsof_request_master set status_code = 14 where status_code = 13;

update emsof_request_master set status_code = 16 where status_code < 10;

update emsof_request_master 
set emsof_request_master.status_code = 15
where id in (72,74,83,90,128,137);

update service set be_valid_profile = FALSE;

COMMIT