START TRANSACTION
;
ALTER TABLE `coned_sponsor_user` ADD COLUMN `encoded_password_hash` CHAR(40) NULL DEFAULT NULL  AFTER `encoded_password`
;
update coned_sponsor_user set encoded_password_hash = SHA1(encoded_password)
;
ALTER TABLE `coned_sponsor_user` DROP COLUMN `encoded_password`
;
ALTER TABLE `county_user` ADD COLUMN `encoded_password_hash` CHAR(40) NULL DEFAULT NULL  AFTER `encoded_password`
;
update county_user set encoded_password_hash = SHA1(encoded_password)
;
ALTER TABLE `county_user` DROP COLUMN `encoded_password`
;
ALTER TABLE `regional_staffer_user` ADD COLUMN `encoded_password_hash` CHAR(40) NULL DEFAULT NULL  AFTER `encoded_password`
;
update regional_staffer_user set encoded_password_hash = SHA1(encoded_password)
;
ALTER TABLE `regional_staffer_user` DROP COLUMN `encoded_password`
;
ALTER TABLE `service_user` ADD COLUMN `encoded_password_hash` CHAR(40) NULL DEFAULT NULL  AFTER `encoded_password`
;
update service_user set encoded_password_hash = SHA1(encoded_password)
;
ALTER TABLE `service_user` DROP COLUMN `encoded_password`
;
COMMIT