START TRANSACTION
;
ALTER TABLE `practitioner_level`
  ADD COLUMN `emsrs_code` TINYINT UNSIGNED NOT NULL
;
update ignore practitioner_level set emsrs_code = 0 where short_description = "FR"
;
update ignore practitioner_level set emsrs_code = 2 where short_description = "EMT"
;
update ignore practitioner_level set emsrs_code = 3 where short_description = "EMT-P"
;
update ignore practitioner_level set emsrs_code = 4 where short_description = "PHRN"
;
update ignore practitioner_level set emsrs_code = 5 where short_description = "HP"
;
ALTER TABLE `practitioner_level`
  ADD UNIQUE `emsrs_code` (`emsrs_code` ASC)
;
COMMIT