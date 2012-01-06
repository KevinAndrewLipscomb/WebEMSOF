START TRANSACTION
;
ALTER TABLE `coned_offering`
  ADD COLUMN `status_id` BIGINT UNSIGNED NOT NULL DEFAULT 1
,
  ADD INDEX `status_id` (`status_id` ASC)
,
  ADD CONSTRAINT `coned_offering_status_id` FOREIGN KEY (`status_id` ) REFERENCES `coned_offering_status` (`id` )
;
COMMIT