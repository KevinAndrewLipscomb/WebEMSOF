START TRANSACTION;

insert service set
  county_code = "1",
  affiliate_num = "02333",
  name = "Sturgeon VFD",
  charter_kind = "9",
  corpadmin_contact_name ="",
  corpadmin_primary_phone_num = "",
  be_emsof_participant = FALSE,
  coo_name = "",
  coo_work_phone_num = "",
  physical_street_address_line_1 = "",
  physical_city = "",
  physical_state = "",
  physical_zip_code = "",
  mail_address_line_1 = "",
  mail_city = "",
  mail_state = "",
  mail_zip_code = "",
  num_doh_licensed_vehicles = 0,
  num_ambulances = 0,
  be_qrs_unrecognized = FALSE,
  be_rescue_unrecognized = FALSE;

insert service_user set password_reset_email_address = "melandtimculley@comcast.net";

COMMIT;