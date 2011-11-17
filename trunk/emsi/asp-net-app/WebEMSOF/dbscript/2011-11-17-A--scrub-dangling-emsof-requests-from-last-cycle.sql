START TRANSACTION
;
update emsof_request_master set status_code = 14 where status_code = 10
;
COMMIT