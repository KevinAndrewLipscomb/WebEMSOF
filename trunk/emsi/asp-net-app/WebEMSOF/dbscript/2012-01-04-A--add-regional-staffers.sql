START TRANSACTION
;
insert ignore regional_staffer (region_code,last_name,first_name) values
(1,"Kaufman","Rich"),
(1,"Strasbaugh","Jackie")
;
insert ignore regional_staffer_user (id,password_reset_email_address) values
(4,"rkaufman@emsi.org"),
(5,"jstrasbaugh@emsi.org")
;
insert ignore regional_staffer_group (name) values
("education-coordinator"),
("education-specialist")
;
insert ignore regional_staffer_role (group_id,user_id) values
((select id from regional_staffer_group where name = "education-coordinator"),(select id from regional_staffer_user where password_reset_email_address = "rkaufman@emsi.org")),
((select id from regional_staffer_group where name = "education-specialist"),(select id from regional_staffer_user where password_reset_email_address = "jstrasbaugh@emsi.org"))
;
COMMIT