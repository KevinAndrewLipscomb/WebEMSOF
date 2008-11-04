START TRANSACTION;

CREATE TABLE `emsof_request_return_comment` (
  `id` SERIAL NOT NULL DEFAULT NULL AUTO_INCREMENT,
  `emsof_request_master_id` BIGINT UNSIGNED NOT NULL,
  `demoter` VARCHAR(63) NOT NULL,
  `timestamp` TIMESTAMP NOT NULL,
  `content` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `emsof_request_master_id`(`emsof_request_master_id`),
  CONSTRAINT `emsof_request_return_comment_master_id` FOREIGN KEY `emsof_request_return_comment_master_id` (`emsof_request_master_id`)
    REFERENCES `emsof_request_master` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
)
ENGINE = InnoDB;

COMMIT