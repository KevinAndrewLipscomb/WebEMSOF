START TRANSACTION
;
ALTER TABLE `practitioner_level` ADD COLUMN `econed_description` VARCHAR(31) NOT NULL
;
update practitioner_level set econed_description = "0 - FirstResponder" where short_description = "FR"
;
update practitioner_level set econed_description = "2 - EMT" where short_description = "EMT"
;
update practitioner_level set econed_description = "4 - PHRN" where short_description = "PHRN"
;
update practitioner_level set econed_description = "3 - Paramedic" where short_description = "EMT-P"
;
update practitioner_level set econed_description = "5 - HP" where short_description = "HP"
;
ALTER TABLE `practitioner_level` ADD UNIQUE INDEX `econed_description` (`econed_description` ASC)
;
COMMIT