START TRANSACTION
;
update service
set corpadmin_email_address = NULL
where length(corpadmin_email_address) = 0
;
update service
set coo_email_address = NULL
where length(coo_email_address) = 0
;
update service
set md_email_address = NULL
where length(md_email_address) = 0
;
COMMIT