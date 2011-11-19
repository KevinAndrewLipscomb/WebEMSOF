DROP TABLE IF EXISTS practitioner;
CREATE TABLE IF NOT EXISTS practitioner (
  id SERIAL,
  last_name VARCHAR(31) NOT NULL,
  first_name VARCHAR(31) NOT NULL,
  middle_name VARCHAR(31),
  email_address VARCHAR(127),
  new_emso_user_id BIGINT UNSIGNED,
  county_code TINYINT UNSIGNED NOT NULL,
  street_address VARCHAR(127),
  city VARCHAR(31),
  zip CHAR(5),
  birth_date DATE,
  PRIMARY KEY(id),
  UNIQUE (new_emso_user_id)
)
ENGINE = InnoDB;
