START TRANSACTION
;
ALTER TABLE `region_code_name_map` DROP INDEX `name`
, CHANGE COLUMN `name` `name` VARCHAR(31) NOT NULL
, ADD COLUMN emsrs_code TINYINT UNSIGNED NOT NULL
, ADD COLUMN `emsrs_active_practitioners_name` VARCHAR(63) NOT NULL
, ADD UNIQUE INDEX `name` (`name` ASC)
, ADD UNIQUE INDEX `emsrs_code` (`emsrs_code` ASC)
, ADD UNIQUE INDEX `emsrs_active_practitioners_name` (`emsrs_active_practitioners_name` ASC)
;
update region_code_name_map
set emsrs_code = 4
, emsrs_active_practitioners_name = "Emergency Medical Service Institute"
where name = "EMSI"
;
insert ignore region_code_name_map (name,emsrs_code,emsrs_active_practitioners_name) values
("Eastern",2,"Eastern PA EMS Council, Inc."),
("Federation",3,"EHS Federation, Inc."),
("Bradford Susquehanna",1,"Bradford Susquehanna EMS Council"),
("Northeastern",5,"EMS of Northeastern PA, Inc"),
("(RC06)",6,"(placeholder 6)"),
("LTS",7,"LTS EMS Council"),
("Seven Mountains",8,"Seven Mountains  EMS Council, Inc."),
("Southern Alleghenies",9,"Southern Alleghenies EMS Council, Inc."),
("Bucks County",10,"Bucks County Emergency Health Services"),
("Chester County",11,"Chester County EMS Council"),
("Delaware County",12,"Delaware County EHS Council, Inc."),
("Montgomery County",13,"Montgomery County Emergency Medical Services"),
("Philadelphia",14,"Philadelphia EMS Council"),
("Susquehanna",15,"Susquehanna EHS Council, Inc."),
("(RC16)",16,"(placeholder 16)"),
("(RC17)",17,"(placeholder 17)"),
("EMMCO West",18,"EMMCO West, Inc."),
("EMMCO East",19,"EMMCO East, Inc.")
;
COMMIT