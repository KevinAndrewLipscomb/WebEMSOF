--
-- Report showing sum of service contributions by EMSOF cycle, for use in budgeting.
--
SELECT
  designator as fiscal_year
  ,sum(actual_subtotal_cost) as costs
  ,sum(actual_emsof_ante) as emsof
  ,sum(actual_subtotal_cost - actual_emsof_ante)
    as service_contributions
FROM emsof_request_detail
  JOIN emsof_request_master on
    (emsof_request_master.id=emsof_request_detail.master_id)
  JOIN county_dictated_appropriation ON
    (county_dictated_appropriation.id=emsof_request_detail.master_id)
  JOIN region_dictated_appropriation ON
    (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)
  JOIN state_dictated_appropriation ON
    (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)
  JOIN fiscal_year ON
    (fiscal_year.id=state_dictated_appropriation.fiscal_year_id)
WHERE emsof_request_master.status_code in
  (10,13,14)
GROUP BY fiscal_year.designator
