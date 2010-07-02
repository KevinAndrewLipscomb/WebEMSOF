START TRANSACTION;

ALTER TABLE `service` ADD COLUMN `num_staff_typical_als_08_16` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_staff_typical_als_16_00` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_staff_typical_als_00_08` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_staff_typical_bls_08_16` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_staff_typical_bls_16_00` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_staff_typical_bls_00_08` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_units_typical_als_08_16` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_units_typical_als_16_00` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_units_typical_als_00_08` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_units_typical_bls_08_16` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_units_typical_bls_16_00` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_units_typical_bls_00_08` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_n95_masks` INT UNSIGNED NULL
 , ADD COLUMN `num_scba` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_pfd` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_portable_vents` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_infusion_pumps` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_bariatric_stretchers` TINYINT UNSIGNED NULL
 , ADD COLUMN `num_golf_carts` TINYINT UNSIGNED NULL
 , ADD COLUMN `num_gators` TINYINT UNSIGNED NULL
 , ADD COLUMN `num_quads` TINYINT UNSIGNED NULL
 , ADD COLUMN `num_mci_special_event_trailers` TINYINT UNSIGNED NULL
 , ADD COLUMN `num_bariatric_equipped_units` TINYINT UNSIGNED NULL
 , ADD COLUMN `num_wheelchair_vans` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_opensky_radios` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_uhf_portables` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_uhf_mobiles` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_vhf_portables` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_vhf_mobiles` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_trunked_radios` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_gps_receivers` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_mark_1_kits` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_cases_potable_h2o` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_recognized_rescue_units` TINYINT UNSIGNED NULL
 , ADD COLUMN `num_4wd_ambulances` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_recognized_qrs_units` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_unrecognized_qrs_units` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_boats` TINYINT UNSIGNED NULL
 , ADD COLUMN `num_ballistic_vests` SMALLINT UNSIGNED NULL
 , ADD COLUMN `num_cases_mre` SMALLINT UNSIGNED NULL
 , ADD COLUMN `inventory_memo` TEXT NULL
 , ADD COLUMN `key_cell_phone_1_num` VARCHAR(10)
 , ADD COLUMN `key_cell_phone_1_assignee` VARCHAR(63)
 , ADD COLUMN `key_cell_phone_2_num` VARCHAR(10)
 , ADD COLUMN `key_cell_phone_2_assignee` VARCHAR(63)
 , ADD COLUMN `key_cell_phone_3_num` VARCHAR(10)
 , ADD COLUMN `key_cell_phone_3_assignee` VARCHAR(63)
 , ADD COLUMN `key_cell_phone_4_num` VARCHAR(10)
 , ADD COLUMN `key_cell_phone_4_assignee` VARCHAR(63)
 , ADD COLUMN `key_cell_phone_5_num` VARCHAR(10)
 , ADD COLUMN `key_cell_phone_5_assignee` VARCHAR(63)
 , ADD COLUMN `key_cell_phone_6_num` VARCHAR(10)
 , ADD COLUMN `key_cell_phone_6_assignee` VARCHAR(63)
 , ADD COLUMN `radio_channel_1` VARCHAR(127)
 , ADD COLUMN `radio_channel_2` VARCHAR(127)
 , ADD COLUMN `radio_channel_3` VARCHAR(127)
 , ADD COLUMN `radio_channel_4` VARCHAR(127)
 , ADD COLUMN `radio_channel_5` VARCHAR(127)
 , ADD COLUMN `radio_channel_6` VARCHAR(127)
 ;

ALTER TABLE `journal` CHANGE COLUMN `action` `action` VARCHAR(16382) NOT NULL;

COMMIT