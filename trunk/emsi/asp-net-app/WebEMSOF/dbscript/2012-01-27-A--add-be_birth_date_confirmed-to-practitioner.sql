START TRANSACTION
;
ALTER TABLE `practitioner`
  ADD COLUMN `be_birth_date_confirmed` TINYINT(1) NOT NULL DEFAULT 0 AFTER birth_date
;
update practitioner set be_birth_date_confirmed = TRUE where birth_date is not null
;
COMMIT