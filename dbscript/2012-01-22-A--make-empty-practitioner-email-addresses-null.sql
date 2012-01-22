START TRANSACTION
;
update practitioner
set email_address = null
where email_address = ''
;
COMMIT