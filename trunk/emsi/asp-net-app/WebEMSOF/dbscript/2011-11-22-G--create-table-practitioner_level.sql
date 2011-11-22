START TRANSACTION
;
DROP TABLE IF EXISTS practitioner_level
;
CREATE TABLE IF NOT EXISTS practitioner_level (
  id SERIAL,
  short_description VARCHAR(15) NOT NULL,
  emsrs_practitioner_level_description VARCHAR(31) NOT NULL,
  be_hereafter_valid BOOLEAN NOT NULL DEFAULT TRUE,
  pecking_order TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY(id),
  UNIQUE(short_description),
  UNIQUE(emsrs_practitioner_level_description),
  UNIQUE(pecking_order),
  INDEX(be_hereafter_valid)
)
ENGINE = InnoDB
;
insert ignore practitioner_level (short_description,emsrs_practitioner_level_description,pecking_order) values
("FR","First Responder",20),
("EMT","EMT",40),
("PHRN","PHRN",60),
("EMT-P","Paramedic",80),
("HP","Pre-Hospital Physician",100)
;
COMMIT