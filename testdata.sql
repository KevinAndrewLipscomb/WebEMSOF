--
-- $Id$
--

insert into county_user (id,encoded_password,be_stale_password,password_reset_email_address)
values
  (1,sha('countypass'),FALSE,'kevin.lipscomb@kvrs.org'),
  (2,sha('countypass'),FALSE,'kevin.lipscomb@kvrs.org'),
  (3,sha('countypass'),FALSE,'kevin.lipscomb@kvrs.org'),
  (4,sha('countypass'),FALSE,'kevin.lipscomb@kvrs.org'),
  (5,sha('countypass'),FALSE,'kevin.lipscomb@kvrs.org'),
  (6,sha('countypass'),FALSE,'kevin.lipscomb@kvrs.org'),
  (7,sha('countypass'),FALSE,'kevin.lipscomb@kvrs.org'),
  (8,sha('countypass'),FALSE,'kevin.lipscomb@kvrs.org'),
  (9,sha('countypass'),FALSE,'kevin.lipscomb@kvrs.org'),
  (10,sha('countypass'),FALSE,'kevin.lipscomb@kvrs.org');

INSERT INTO fiscal_year (designator)
VALUES
  ('FY0607');

INSERT INTO fy_calendar (fiscal_year_id,milestone_code,value)
VALUES
  (2, 1, '2006-11-30 23:59:59'),
  (2, 2, '2007-01-31 23:59:59'),
  (2, 3, '2007-02-28 23:59:59'),
  (2, 4, '2007-05-31 23:59:59');

INSERT INTO state_dictated_appropriation (region_code,fiscal_year_id,amount)
VALUES
  (1,2,350172.02);

INSERT INTO region_dictated_appropriation (state_dictated_appropriation_id,county_code,amount)
VALUES
  (2,1,97368.02,'2006-11-16 23:59:59'),
  (2,2,19578.02,'2006-11-16 23:59:59'),
  (2,3,24998.02,'2006-11-16 23:59:59'),
  (2,4,35270.02,'2006-11-16 23:59:59'),
  (2,5,30140.02,'2006-11-16 23:59:59'),
  (2,6,13618.02,'2006-11-16 23:59:59'),
  (2,7,24329.02,'2006-11-16 23:59:59'),
  (2,8,16846.02,'2006-11-16 23:59:59'),
  (2,9,35959.02,'2006-11-16 23:59:59'),
  (2,10,52066.02,'2006-11-16 23:59:59');

INSERT INTO regional_staffer (region_code, last_name, first_name)
VALUES
  (1, 'McElree', 'Tom'),
  (1, 'Cameron', 'Amos P');

INSERT INTO regional_staffer_role (title, regional_staffer_id)
VALUES
  ('emsof-request-item-withdrawal-notice-recipient', 1),
  ('emsof-request-item-withdrawal-notice-recipient', 2),
  ('primary-emsof-coordinator', 2);

insert into service (county_code,affiliate_num,name)
values
  (1,'00001','Baldwin'),
  (1,'00002','Ross/Westview'),
  (10,'00003','Mutual Aid'),
  (5,'00004','Fayette'),
  (1,'00005','Seneca Area'),
  (1,'00006','EMSI QRS'),
  (9,'00007','Rostraver/Westnewton'),
  (1,'00008','Lower Valley'),
  (1,'00009','Foxwall'),
  (1,'00010','Pittsburgh');

insert into service_user (id,encoded_password,be_stale_password,password_reset_email_address)
values
  (1,sha('servicepass'),FALSE,'infotech@kvrs.org'),
  (2,sha('servicepass'),FALSE,'infotech@kvrs.org'),
  (3,sha('servicepass'),FALSE,'infotech@kvrs.org'),
  (4,sha('servicepass'),FALSE,'infotech@kvrs.org'),
  (5,sha('servicepass'),FALSE,'infotech@kvrs.org'),
  (6,sha('servicepass'),FALSE,'infotech@kvrs.org'),
  (7,sha('servicepass'),FALSE,'infotech@kvrs.org'),
  (8,sha('servicepass'),FALSE,'infotech@kvrs.org'),
  (9,sha('servicepass'),FALSE,'infotech@kvrs.org'),
  (10,sha('servicepass'),FALSE,'infotech@kvrs.org');
