START TRANSACTION;

insert fiscal_year
set designator = 'FY0809';

insert state_dictated_appropriation
set region_code = 1,
  fiscal_year_id = (select id from fiscal_year where designator = 'FY0809'),
  amount = 370000;

insert fy_calendar (fiscal_year_id,milestone_code,`value`) VALUES
((select id from fiscal_year where designator = 'FY0809'),1,'2008-11-28 23:59:59'),
((select id from fiscal_year where designator = 'FY0809'),2,'2009-01-30 23:59:59'),
((select id from fiscal_year where designator = 'FY0809'),3,'2009-02-27 23:59:59'),
((select id from fiscal_year where designator = 'FY0809'),4,'2009-05-29 23:59:59'),
((select id from fiscal_year where designator = 'FY0809'),5,'2009-06-30 23:59:59');

insert region_dictated_appropriation (state_dictated_appropriation_id,county_code,amount,service_to_county_submission_deadline,match_level_id) VALUES
((select max(id) from state_dictated_appropriation),1,101462,'2008-11-14 23:59:59',1),
((select max(id) from state_dictated_appropriation),2,20509,'2008-11-14 23:59:59',2),
((select max(id) from state_dictated_appropriation),3,26299,'2008-11-14 23:59:59',1),
((select max(id) from state_dictated_appropriation),4,38020,'2008-11-14 23:59:59',2),
((select max(id) from state_dictated_appropriation),5,32022,'2008-11-14 23:59:59',2),
((select max(id) from state_dictated_appropriation),6,14360,'2008-11-14 23:59:59',2),
((select max(id) from state_dictated_appropriation),7,25704,'2008-11-14 23:59:59',2),
((select max(id) from state_dictated_appropriation),8,17700,'2008-11-14 23:59:59',2),
((select max(id) from state_dictated_appropriation),9,38611,'2008-11-14 23:59:59',2),
((select max(id) from state_dictated_appropriation),10,55313,'2008-11-14 23:59:59',1);

INSERT eligible_provider_equipment_list (fiscal_year_id,description,life_expectancy_years,be_eligible_als_amb,be_eligible_als_squad,be_eligible_bls_amb,be_eligible_qrs,allowable_cost,funding_level_nonrural,funding_level_rural) VALUES
((select id from fiscal_year where designator = 'FY0809'), 'EKG monitor/defibrillator w/pacer', 5, 1, 1, 0, 0, 12000.00, 6000.00, 7200.00),
((select id from fiscal_year where designator = 'FY0809'), '12 lead EKG', 5, 1, 1, 0, 0, 20000.00, 10000.00, 12000.00),
((select id from fiscal_year where designator = 'FY0809'), 'AED', 5, 0, 0, 1, 1, 1500.00, 750.00, 900.00),
((select id from fiscal_year where designator = 'FY0809'), 'Oxygen system parts', 5, 1, 1, 1, 1, 500.00, 250.00, 300.00),
((select id from fiscal_year where designator = 'FY0809'), 'Capnography', 3, 1, 1, 0, 0, 3000.00, 1500.00, 1800.00),
((select id from fiscal_year where designator = 'FY0809'), 'CPAP', 5, 1, 1, 0, 0, 1500.00, 750.00, 900.00),
((select id from fiscal_year where designator = 'FY0809'), 'Pulse oximeter', 5, 1, 1, 1, 0, 700.00, 350.00, 420.00),
((select id from fiscal_year where designator = 'FY0809'), 'Nitrous oxide delivery system', 5, 1, 1, 0, 0, 2000.00, 1000.00, 1200.00),
((select id from fiscal_year where designator = 'FY0809'), 'IV infusion pump', 5, 1, 1, 0, 0, 2000.00, 1000.00, 1000.00),
((select id from fiscal_year where designator = 'FY0809'), 'Intubation, durable', 5, 1, 1, 0, 0, 600.00, 300.00, 360.00),
((select id from fiscal_year where designator = 'FY0809'), 'Transtracheal jet insufflators', 5, 1, 1, 0, 0, 200.00, 100.00, 120.00),
((select id from fiscal_year where designator = 'FY0809'), 'Splinting/immobilization devices', 3, 1, 1, 1, 1, 500.00, 250.00, 300.00),
((select id from fiscal_year where designator = 'FY0809'), 'Stairchair 300 lb capacity', 3, 1, 0, 1, 0, 2000.00, 1000.00, 1200.00),
((select id from fiscal_year where designator = 'FY0809'), 'Stairchair 500 lb capacity', 5, 1, 0, 1, 0, 2650.00, 1325.00, 1590.00),
((select id from fiscal_year where designator = 'FY0809'), 'Stretcher 300 lb capacity', 5, 1, 0, 1, 0, 4000.00, 2000.00, 2400.00),
((select id from fiscal_year where designator = 'FY0809'), 'Stretcher 700 lb capacity', 5, 1, 0, 1, 0, 11500.00, 5750.00, 6900.00),
((select id from fiscal_year where designator = 'FY0809'), 'Stretcher/chair combination', 5, 1, 0, 1, 0, 700.00, 350.00, 420.00),
((select id from fiscal_year where designator = 'FY0809'), 'Suction, portable, battery operated', 3, 1, 1, 1, 1, 900.00, 450.00, 540.00),
((select id from fiscal_year where designator = 'FY0809'), 'Ventilator, automatic', 5, 1, 1, 1, 1, 3000.00, 1500.00, 1800.00),
((select id from fiscal_year where designator = 'FY0809'), 'Ambulance w/chevron FOR URBAN SERVICES ONLY', NULL, 1, 0, 1, 0, 30000.00, 15000.00, 0.00),
((select id from fiscal_year where designator = 'FY0809'), 'Ambulance w/chevron FOR RURAL SERVICES ONLY', NULL, 1, 0, 1, 0, 33333.33, 0.00, 20000.00),
((select id from fiscal_year where designator = 'FY0809'), 'Chevron', NULL, 1, 1, 1, 1, 1500.00, 750.00, 900.00),
((select id from fiscal_year where designator = 'FY0809'), 'Squad/response vehicle w/chevron', NULL, 0, 1, 0, 1, 15000.00, 7500.00, 9000.00),
((select id from fiscal_year where designator = 'FY0809'), 'Data collection software/technology', NULL, 1, 1, 1, 1, 1700.00, 850.00, 1020.00),
((select id from fiscal_year where designator = 'FY0809'), 'Data collection hardware', 3, 1, 1, 1, 1, 2000.00, 1000.00, 1200.00),
((select id from fiscal_year where designator = 'FY0809'), 'Radio, mobile (up to 2/vehicle)', 5, 1, 1, 1, 1, 5000.00, 2500.00, 3000.00),
((select id from fiscal_year where designator = 'FY0809'), 'Radio, portable (1/vehicle)', 5, 1, 1, 1, 1, 5000.00, 2500.00, 3000.00),
((select id from fiscal_year where designator = 'FY0809'), 'Triage vest, reflective, ANSI-std', 5, 1, 1, 1, 1, 150.00, 75.00, 90.00),
((select id from fiscal_year where designator = 'FY0809'), 'Triage system', 5, 1, 1, 1, 1, 750.00, 375.00, 450.00),
((select id from fiscal_year where designator = 'FY0809'), 'Alerting (up to 5)', 5, 1, 1, 1, 1, 400.00, 200.00, 240.00),
((select id from fiscal_year where designator = 'FY0809'), 'Vehicle safety monitoring system', 5, 1, 1, 1, 1, 3500.00, 1750.00, 2100.00),
((select id from fiscal_year where designator = 'FY0809'), 'PPE/turnout gear/vest/respiratory', 5, 1, 1, 1, 1, 1200.00, 600.00, 720.00),
((select id from fiscal_year where designator = 'FY0809'), 'Protective ballistic vest', 5, 1, 1, 1, 1, 1000.00, 500.00, 600.00),
((select id from fiscal_year where designator = 'FY0809'), 'GPS receiver (1/vehicle)', 5, 1, 1, 1, 1, 500.00, 250.00, 275.00),
((select id from fiscal_year where designator = 'FY0809'), 'Traffic safety', 5, 1, 1, 1, 1, 2500.00, 1250.00, 1500.00),
((select id from fiscal_year where designator = 'FY0809'), 'Large patient moving/carrying device', 10, 1, 1, 1, 1, 3000.00, 1500.00, 1800.00),
((select id from fiscal_year where designator = 'FY0809'), 'SCBA (up to 2/licensed vehicle)', 10, 1, 1, 1, 1, 3000.00, 1500.00, 1800.00),
((select id from fiscal_year where designator = 'FY0809'), 'EMT-P Written Test', NULL, 1, 1, 0, 0, 300.00, 300.00, 300.00),
((select id from fiscal_year where designator = 'FY0809'), 'Other - with attached documentation', NULL, 1, 1, 1, 1, NULL, NULL, NULL);

COMMIT