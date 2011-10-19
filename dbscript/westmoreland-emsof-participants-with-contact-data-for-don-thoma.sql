SELECT distinct name
, emsof_contact_name
, password_reset_email_address
, emsof_contact_primary_phone_num
FROM service_user
  JOIN service using (id)
left join emsof_extra_service_county_dependency on (emsof_extra_service_county_dependency.service_id=service.id)
WHERE be_active
  and '10' in (service.county_code,emsof_extra_service_county_dependency.county_code)
  and be_valid_profile and be_emsof_participant
ORDER BY name
