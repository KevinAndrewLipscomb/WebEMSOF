select county_code_name_map.name as county_name
, service.short_name as service_name
, fiscal_year.designator as fiscal_year
, county_dictated_appropriation.amount as allocation
, emsof_request_master.actual_value as purchases
, IF(request_status_code_description_map.description in ('DEPLOYED','ARCHIVED'),FORMAT(100*emsof_request_master.actual_value/county_dictated_appropriation.amount,0),request_status_code_description_map.description) as percent_used_or_outcome
, GROUP_CONCAT(concat(emsof_request_detail.quantity,' x "',eligible_provider_equipment_list.description,'"') SEPARATOR ', ') as items
from emsof_request_master
  join county_dictated_appropriation on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)
  join region_dictated_appropriation on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)
  join state_dictated_appropriation on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)
  join fiscal_year on (fiscal_year.id=state_dictated_appropriation.fiscal_year_id)
  join county_code_name_map on (county_code_name_map.code=region_dictated_appropriation.county_code)
  join service on (service.id=county_dictated_appropriation.service_id)
  join request_status_code_description_map on (request_status_code_description_map.code=emsof_request_master.status_code)
  join emsof_request_detail on (emsof_request_detail.master_id=emsof_request_master.id)
  join eligible_provider_equipment_list on (eligible_provider_equipment_list.code=emsof_request_detail.equipment_code)
where fiscal_year.id >= (select max(id) from fiscal_year) - 5
group by emsof_request_master.id
order by county_name, service_name, fiscal_year
