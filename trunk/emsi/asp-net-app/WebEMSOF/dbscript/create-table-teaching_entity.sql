DROP TABLE IF EXISTS teaching_entity;
CREATE TABLE IF NOT EXISTS teaching_entity (
  id SERIAL,
  emsrs_id BIGINT UNSIGNED NOT NULL,
  date_created DATE,
  date_last_edited DATE,
  sponsor_number CHAR(7),
  training_ins_accred_num VARCHAR(9),
  name VARCHAR(127),
  short_name VARCHAR(63),
  address_1 VARCHAR(63),
  address_2 VARCHAR(63),
  city VARCHAR(31),
  state CHAR(2),
  zip VARCHAR(10),
  county_code TINYINT UNSIGNED,
  region TINYINT UNSIGNED,
  email VARCHAR(127),
  website VARCHAR(127),
  daytime_phone VARCHAR(31),
  evening_phone VARCHAR(31),
  fax VARCHAR(31),
  business_type_id BIGINT UNSIGNED,
  con_ed_level_id BIGINT UNSIGNED,
  certification_level BIGINT UNSIGNED,
  contact_first_name VARCHAR(31),
  contact_last_name VARCHAR(31),
  contact_title VARCHAR(63),
  contact_address_1 VARCHAR(63),
  contact_address_2 VARCHAR(63),
  contact_city VARCHAR(31),
  contact_state CHAR(2),
  contact_zip VARCHAR(10),
  contact_daytime_phone VARCHAR(31),
  contact_evening_phone VARCHAR(31),
  contact_fax VARCHAR(31),
  contact_email VARCHAR(127),
  public_contact_name VARCHAR(63),
  public_contact_phone VARCHAR(31),
  public_contact_email VARCHAR(127),
  public_contact_website VARCHAR(127),
  public_contact_notes VARCHAR(510),
  application_date DATE,
  application_received DATE,
  coned_sponsor_status_id BIGINT UNSIGNED,
  training_inst_status_id BIGINT UNSIGNED,
  issue_date DATE,
  prev_expiration_date DATE,
  expiration_date_sponsor DATE,
  expiration_date_training_inst DATE,
  process_date DATE,
  corrective_action TEXT,
  compliance_by_date DATE,
  initial_accred_date DATE,
  accepted_provisional_date DATE,
  completed_provisional_date DATE,
  withdrawal_challenge_due_date DATE,
  letter_for_expiration BOOLEAN,
  letter_f_for_ppwk_non_compliance BOOLEAN,
  other_letter BOOLEAN,
  history TEXT,
  PRIMARY KEY(id),
  UNIQUE (emsrs_id),
  UNIQUE (training_ins_accred_num)
)
ENGINE = InnoDB;
ALTER TABLE `teaching_entity`
  ADD INDEX `teaching_entity_coned_level` (`con_ed_level_id` ASC),
  ADD INDEX `teaching_entity_certification_level` (`certification_level` ASC),
  ADD INDEX `teaching_entity_coned_sponsor_status` (`coned_sponsor_status_id` ASC),
  ADD INDEX `teaching_entity_training_institute_status` (`training_inst_status_id` ASC),
  ADD INDEX `teaching_entity_business_type` (`business_type_id` ASC),
  ADD CONSTRAINT `teaching_entity_coned_level` FOREIGN KEY (`con_ed_level_id` ) REFERENCES `teaching_entity_level` (`id` ),
  ADD CONSTRAINT `teaching_entity_certification_level` FOREIGN KEY (`certification_level` ) REFERENCES `teaching_entity_level` (`id` ),
  ADD CONSTRAINT `teaching_entity_coned_sponsor_status` FOREIGN KEY (`coned_sponsor_status_id` ) REFERENCES `coned_sponsor_status` (`id` ),
  ADD CONSTRAINT `teaching_entity_training_institute_status` FOREIGN KEY (`training_inst_status_id` ) REFERENCES `training_institute_status` (`id` ),
  ADD CONSTRAINT `teaching_entity_business_type` FOREIGN KEY (`business_type_id` ) REFERENCES `teaching_entity_business_type` (`id` );
