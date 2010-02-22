START TRANSACTION;

ALTER TABLE `emsof_request_detail`
 ADD COLUMN `attachment_key` CHAR(19),
 ADD UNIQUE INDEX `attachment_key`(`attachment_key`);

COMMIT