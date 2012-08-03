START TRANSACTION
;
update service_user join service using (id)
set be_active = FALSE
where name in ("Duquesne EMS","Avonmore Life Savers EMS Inc.")
;
COMMIT