START TRANSACTION;

ALTER TABLE `journal`
  MODIFY COLUMN `action` VARCHAR(8190) NOT NULL;

ALTER TABLE `service`
  ADD COLUMN `be_qrs_unrecognized` BOOLEAN NOT NULL,
  ADD COLUMN `be_rescue_unrecognized` BOOLEAN NOT NULL;

update service set be_valid_profile = FALSE;

COMMIT