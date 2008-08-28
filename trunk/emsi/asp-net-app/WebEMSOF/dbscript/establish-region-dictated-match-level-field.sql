START TRANSACTION;

ALTER TABLE `region_dictated_appropriation`
  ADD COLUMN `match_level_id` TINYINT UNSIGNED DEFAULT 1,
  ADD CONSTRAINT `region_dictated_appropriation_match_level` FOREIGN KEY `region_dictated_appropriation_match_level`
    (`match_level_id`) REFERENCES `match_level` (`id`);

COMMIT