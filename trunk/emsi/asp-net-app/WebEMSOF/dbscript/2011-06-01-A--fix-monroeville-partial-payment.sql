START TRANSACTION
;
update county_dictated_appropriation
set amount = 1114
where id = 608
;
update emsof_request_master
set value = 1114
, actual_value = 1114
where id = 608
;
update emsof_request_detail
set actual_emsof_ante = 445.63
where master_id = 608 and priority = 3
;
COMMIT