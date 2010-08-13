START TRANSACTION;

DROP TABLE IF EXISTS `emsof_extra_service_county_dependency`;
CREATE  TABLE `emsof_extra_service_county_dependency`
  (
  `service_id` SMALLINT UNSIGNED NOT NULL ,
  `county_code` TINYINT UNSIGNED NOT NULL ,
  PRIMARY KEY (`service_id`,`county_code`),
  INDEX `service_id` (`service_id` ASC) ,
  INDEX `county_code` (`county_code` ASC) ,
  CONSTRAINT `emsof_extra_dependency_service_id` FOREIGN KEY (`service_id` ) REFERENCES `service` (`id` ) ON DELETE CASCADE,
  CONSTRAINT `emsof_extra_dependency_county_code` FOREIGN KEY (`county_code` ) REFERENCES `county_code_name_map` (`code` )
  );

insert ignore emsof_extra_service_county_dependency
select distinct service.id as service_id,county_code_name_map.code as county_code
from county_dictated_appropriation
  join service on (service.id=county_dictated_appropriation.service_id)
  join region_dictated_appropriation on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)
  join county_code_name_map on (county_code_name_map.code=region_dictated_appropriation.county_code)
where
  (
    service.name like "%Rostraver%"
  or
    service.name like "%Brownsville%"
  or
    service.name like "%Monessen%"
  or
    service.name like "%Jefferson%"
  or
    service.name like "%SouthBridge%"
  or
    service.name like "%EMS Southwest%"
  )
  and county_code_name_map.code <> service.county_code;

COMMIT