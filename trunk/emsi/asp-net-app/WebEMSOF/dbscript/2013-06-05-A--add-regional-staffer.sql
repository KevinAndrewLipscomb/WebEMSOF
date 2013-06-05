START TRANSACTION
;
insert ignore regional_staffer (region_code,last_name,first_name) values
((select code from region_code_name_map where name = 'EMSI'),"Shaw","Brian")
;
insert ignore regional_staffer_user (id,password_reset_email_address) values
((select id from regional_staffer where region_code = '1' and last_name = 'Shaw' and first_name = 'Brian'),"bshaw@emsi.org")
;
insert ignore regional_staffer_role (group_id,user_id) values
((select id from regional_staffer_group where name = "director"),(select id from regional_staffer_user where password_reset_email_address = "bshaw@emsi.org"))
;
COMMIT