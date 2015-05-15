select concat('W',master_id,if(be_reopened_after_going_to_state,'*','')) as note
, service.name as service_name
, if((be_als_amb or be_als_squad or be_air_amb),'ALS',if(be_bls_amb,'BLS',if(be_rescue,'RESCUE','QRS'))) as life_support_level
, priority
, CONCAT(description,' - ',make_model) as equipment_description
, quantity
, unit_cost
, @total_cost := quantity*unit_cost as total_cost
, emsof_ante as emsof_ante
, @provider_match := quantity*unit_cost - emsof_ante as provider_match
, 'X' as recommendation
, if(emsof_request_master.status_code is null,'e/5',if(emsof_request_master.status_code = 16,'c/3','')) as discouragement_code
, match_level.name as match_level
, actual_quantity
, actual_subtotal_cost
, actual_emsof_ante
, @actual_provider_match := actual_subtotal_cost - actual_emsof_ante as actual_provider_match
, CAST(actual_quantity AS SIGNED) - CAST(quantity AS SIGNED) as quantity_variance
, CAST(actual_subtotal_cost - @total_cost AS DECIMAL(10,2)) as cost_variance
, CAST(actual_emsof_ante - emsof_ante AS DECIMAL(10,2)) as emsof_ante_variance
, CAST(@actual_provider_match - @provider_match AS DECIMAL(10,2)) as provider_match_variance
from emsof_request_master
  left join emsof_request_detail on (emsof_request_detail.master_id=emsof_request_master.id)
  join county_dictated_appropriation on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)
  join region_dictated_appropriation on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)
  join state_dictated_appropriation on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)
  join fiscal_year on (fiscal_year.id=state_dictated_appropriation.fiscal_year_id)
  left join eligible_provider_equipment_list on (eligible_provider_equipment_list.code=emsof_request_detail.equipment_code)
  right join service on (service.id=county_dictated_appropriation.service_id)
  left join match_level on (match_level.id=county_dictated_appropriation.match_level_id)
where fiscal_year.designator = 'FY1415'
    and region_code = '1'
order by service_name, master_id, priority
