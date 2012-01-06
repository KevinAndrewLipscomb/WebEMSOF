START TRANSACTION
;
DROP TABLE IF EXISTS coned_sponsor_user
;
CREATE TABLE coned_sponsor_user
  (
  id bigint unsigned NOT NULL,
  encoded_password char(40) DEFAULT NULL,
  be_stale_password tinyint(1) NOT NULL DEFAULT '1',
  password_reset_email_address varchar(255) NOT NULL,
  be_active tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (id),
  CONSTRAINT coned_sponsor_user_teaching_entity FOREIGN KEY (id) REFERENCES teaching_entity (id)
  )
  ENGINE=InnoDB
;
COMMIT