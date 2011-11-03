START TRANSACTION
;
ALTER TABLE `journal`
  ADD COLUMN `imitator` VARCHAR(31) NULL AFTER `timestamp`
, ADD INDEX `imitator` (`imitator` ASC)
;
COMMIT