start transaction;
INSERT INTO eligible_provider_equipment_list (fiscal_year_id, description, life_expectancy_years, be_eligible_als_amb, be_eligible_als_squad, be_eligible_bls_amb, be_eligible_qrs, allowable_cost, funding_level_nonrural, funding_level_rural) VALUES
(2, 'Ambulance FOR URBAN SERVICES ONLY', NULL, 1, 0, 1, 0, 30000.00, 15000.00, 0),
(2, 'Ambulance FOR RURAL SERVICES ONLY', NULL, 1, 0, 1, 0, 33333.33, 0, 20000.00);
update eligible_provider_equipment_list
  set allowable_cost = 15000
  where code = 19
    or code = 51;
commit;