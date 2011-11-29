START TRANSACTION
;
ALTER TABLE `practitioner` ADD COLUMN `email_address` VARCHAR(127) AFTER birth_date
;
COMMIT
