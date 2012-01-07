START TRANSACTION
;
ALTER TABLE `practitioner`
  ADD COLUMN `street_address_1` VARCHAR(127) NULL
,
  ADD COLUMN `street_address_2` VARCHAR(127) NULL
,
  ADD COLUMN `city_state_zip` VARCHAR(127) NULL
;
COMMIT