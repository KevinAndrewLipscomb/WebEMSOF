ALTER TABLE emsof_purchase_payment CHANGE COLUMN `date` `date_of` DATE NOT NULL
, DROP INDEX `date`,
 ADD INDEX `date_of` USING BTREE(`date_of`)
, ENGINE = InnoDB;
