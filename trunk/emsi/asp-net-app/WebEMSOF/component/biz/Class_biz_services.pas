unit Class_biz_services;

interface

uses
  Class_db_appropriations,
  Class_db_services;

type
  TClass_biz_services = class
  strict private
    db_appropriations: TClass_db_appropriations;
    db_services: TClass_db_services;
  published
    constructor Create;
    function BeAdded
      (
      service_name: string;
      affiliate_num: string;
      password_reset_email_address: string;
      county_code: string
      )
      : boolean;
    function BeDistressed(id: string): boolean;
    function AffiliateNumOfId(id: string): string;
    function BeKnown(affiliate_num: string): boolean;
    function BeOkToDelete: boolean;
    function BeValidAndParticipating(id: string): boolean;
    function Bind
      (
      partial_affiliate_num: string;
      target: system.object
      )
      : boolean;
    procedure BindAnnualRespondents
      (
      sort_order: string;
      be_order_ascending: boolean;
      target: system.object
      );
    procedure BindListControl
      (
      county_user_id: string;
      target: system.object;
      be_unfiltered: boolean = FALSE;
      be_inclusive_of_invalids_and_nonparticipants: boolean = FALSE
      );
    function Delete(affiliate_num: string): boolean;
    function EmailTargetForCounty
      (
      county_id: string;
      be_filtered_by_emsof_participation: boolean = FALSE;
      be_emsof_participant: boolean = TRUE
      )
      : string;
    function Get
      (
      affiliate_num: string;
      out name: string;
      out county_code: string;
      out business_phone_num: string;
      out business_fax_num: string;
      out website_address: string;
      out charter_kind: string;
      out corpadmin_contact_name: string;
      out corpadmin_primary_phone_num: string;
      out corpadmin_secondary_phone_num: string;
      out corpadmin_email_address: string;
      out be_emsof_participant: boolean;
      out emsof_nonparticipation_reason: string;
      out emsof_contact_name: string;
      out emsof_contact_primary_phone_num: string;
      out emsof_contact_sms_phone_num: string;
      out coo_name: string;
      out coo_work_phone_num: string;
      out coo_home_phone_num: string;
      out coo_email_address: string;
      out coo_mobile_phone_or_pager_num: string;
      out md_name: string;
      out md_office_phone_num: string;
      out md_home_phone_num: string;
      out md_email_address: string;
      out md_mobile_phone_or_pager_num: string;
      out physical_street_address_line_1: string;
      out physical_street_address_line_2: string;
      out physical_city: string;
      out physical_state: string;
      out physical_zip_code: string;
      out mail_address_line_1: string;
      out mail_address_line_2: string;
      out mail_city: string;
      out mail_state: string;
      out mail_zip_code: string;
      out be_qrs: boolean;
      out be_bls_amb: boolean;
      out be_als_amb: boolean;
      out be_als_squad: boolean;
      out be_air_amb: boolean;
      out be_rescue: boolean;
      out be_pa_turnpike_contractor: boolean;
      out num_doh_licensed_vehicles: string;
      out num_ambulances: string;
      out be_dera: boolean;
      out charter_other_kind: string;
      out be_valid_profile: boolean;
      out federal_tax_id: string;
      out be_qrs_unrecognized: boolean;
      out be_rescue_unrecognized: boolean;
      out be_distressed: boolean
      )
      : boolean;
    procedure MarkProfilesStale;
    function NameOf(service_id: string): string;
    procedure &Set
      (
      affiliate_num: string;
      name: string;
      county_code: string;
      business_phone_num: string;
      business_fax_num: string;
      website_address: string;
      charter_kind: string;
      corpadmin_contact_name: string;
      corpadmin_primary_phone_num: string;
      corpadmin_secondary_phone_num: string;
      corpadmin_email_address: string;
      be_emsof_participant: boolean;
      emsof_nonparticipation_reason: string;
      emsof_contact_name: string;
      emsof_contact_primary_phone_num: string;
      emsof_contact_sms_phone_num: string;
      coo_name: string;
      coo_work_phone_num: string;
      coo_home_phone_num: string;
      coo_email_address: string;
      coo_mobile_phone_or_pager_num: string;
      md_name: string;
      md_office_phone_num: string;
      md_home_phone_num: string;
      md_email_address: string;
      md_mobile_phone_or_pager_num: string;
      physical_street_address_line_1: string;
      physical_street_address_line_2: string;
      physical_city: string;
      physical_state: string;
      physical_zip_code: string;
      mail_address_line_1: string;
      mail_address_line_2: string;
      mail_city: string;
      mail_state: string;
      mail_zip_code: string;
      be_qrs: boolean;
      be_bls_amb: boolean;
      be_als_amb: boolean;
      be_als_squad: boolean;
      be_air_amb: boolean;
      be_rescue: boolean;
      be_pa_turnpike_contractor: boolean;
      num_doh_licensed_vehicles: string;
      num_ambulances: string;
      be_dera: boolean;
      charter_other_kind: string;
      be_new_affirmation: boolean;
      be_valid_profile: boolean;
      federal_tax_id: string;
      be_qrs_unrecognized: boolean;
      be_rescue_unrecognized: boolean;
      be_distressed: boolean
      );
  end;

implementation

uses
  Class_biz_accounts,
  system.web;

constructor TClass_biz_services.Create;
begin
  inherited Create;
  db_appropriations := TClass_db_appropriations.Create;
  db_services := TClass_db_services.Create;
end;

function TClass_biz_services.AffiliateNumOfId(id: string): string;
begin
  AffiliateNumOfId := db_services.AffiliateNumOfId(id);
end;

function TClass_biz_services.BeAdded
  (
  service_name: string;
  affiliate_num: string;
  password_reset_email_address: string;
  county_code: string
  )
  : boolean;
begin
  BeAdded := db_services.BeAdded(service_name,affiliate_num,password_reset_email_address,county_code);
end;

function TClass_biz_services.BeDistressed(id: string): boolean;
begin
  BeDistressed := db_services.BeDistressed(id);
end;

function TClass_biz_services.BeKnown(affiliate_num: string): boolean;
begin
  BeKnown := db_services.BeKnown(affiliate_num);
end;

function TClass_biz_services.BeOkToDelete: boolean;
begin
  BeOkToDelete := httpcontext.current.user.IsInRole('director')
    or httpcontext.current.user.IsInRole('emsof-coordinator')
    or httpcontext.current.user.IsInRole('emsof-planner');
end;

function TClass_biz_services.BeValidAndParticipating(id: string): boolean;
begin
  BeValidAndParticipating := db_services.BeValidAndParticipating(id);
end;

function TClass_biz_services.Bind
  (
  partial_affiliate_num: string;
  target: system.object
  )
  : boolean;
begin
  Bind := db_services.Bind(partial_affiliate_num,target);
end;

procedure TClass_biz_services.BindAnnualRespondents
  (
  sort_order: string;
  be_order_ascending: boolean;
  target: system.object
  );
begin
  db_services.BindAnnualRespondents(sort_order,be_order_ascending,target);
end;

procedure TClass_biz_services.BindListControl
  (
  county_user_id: string;
  target: system.object;
  be_unfiltered: boolean = FALSE;
  be_inclusive_of_invalids_and_nonparticipants: boolean = FALSE
  );
begin
  db_services.BindListControl(county_user_id,target,be_unfiltered,be_inclusive_of_invalids_and_nonparticipants);
end;

function TClass_biz_services.Delete(affiliate_num: string): boolean;
begin
  Delete := db_services.Delete(affiliate_num);
end;

function TClass_biz_services.EmailTargetForCounty
  (
  county_id: string;
  be_filtered_by_emsof_participation: boolean = FALSE;
  be_emsof_participant: boolean = TRUE
  )
  : string;
begin
  EmailTargetForCounty := db_services.EmailTargetForCounty(county_id,be_filtered_by_emsof_participation,be_emsof_participant);
end;

function TClass_biz_services.Get
  (
  affiliate_num: string;
  out name: string;
  out county_code: string;
  out business_phone_num: string;
  out business_fax_num: string;
  out website_address: string;
  out charter_kind: string;
  out corpadmin_contact_name: string;
  out corpadmin_primary_phone_num: string;
  out corpadmin_secondary_phone_num: string;
  out corpadmin_email_address: string;
  out be_emsof_participant: boolean;
  out emsof_nonparticipation_reason: string;
  out emsof_contact_name: string;
  out emsof_contact_primary_phone_num: string;
  out emsof_contact_sms_phone_num: string;
  out coo_name: string;
  out coo_work_phone_num: string;
  out coo_home_phone_num: string;
  out coo_email_address: string;
  out coo_mobile_phone_or_pager_num: string;
  out md_name: string;
  out md_office_phone_num: string;
  out md_home_phone_num: string;
  out md_email_address: string;
  out md_mobile_phone_or_pager_num: string;
  out physical_street_address_line_1: string;
  out physical_street_address_line_2: string;
  out physical_city: string;
  out physical_state: string;
  out physical_zip_code: string;
  out mail_address_line_1: string;
  out mail_address_line_2: string;
  out mail_city: string;
  out mail_state: string;
  out mail_zip_code: string;
  out be_qrs: boolean;
  out be_bls_amb: boolean;
  out be_als_amb: boolean;
  out be_als_squad: boolean;
  out be_air_amb: boolean;
  out be_rescue: boolean;
  out be_pa_turnpike_contractor: boolean;
  out num_doh_licensed_vehicles: string;
  out num_ambulances: string;
  out be_dera: boolean;
  out charter_other_kind: string;
  out be_valid_profile: boolean;
  out federal_tax_id: string;
  out be_qrs_unrecognized: boolean;
  out be_rescue_unrecognized: boolean;
  out be_distressed: boolean
  )
  : boolean;
begin
  //
  Get := db_services.Get
    (
    affiliate_num,
    name,
    county_code,
    business_phone_num,
    business_fax_num,
    website_address,
    charter_kind,
    corpadmin_contact_name,
    corpadmin_primary_phone_num,
    corpadmin_secondary_phone_num,
    corpadmin_email_address,
    be_emsof_participant,
    emsof_nonparticipation_reason,
    emsof_contact_name,
    emsof_contact_primary_phone_num,
    emsof_contact_sms_phone_num,
    coo_name,
    coo_work_phone_num,
    coo_home_phone_num,
    coo_email_address,
    coo_mobile_phone_or_pager_num,
    md_name,
    md_office_phone_num,
    md_home_phone_num,
    md_email_address,
    md_mobile_phone_or_pager_num,
    physical_street_address_line_1,
    physical_street_address_line_2,
    physical_city,
    physical_state,
    physical_zip_code,
    mail_address_line_1,
    mail_address_line_2,
    mail_city,
    mail_state,
    mail_zip_code,
    be_qrs,
    be_bls_amb,
    be_als_amb,
    be_als_squad,
    be_air_amb,
    be_rescue,
    be_pa_turnpike_contractor,
    num_doh_licensed_vehicles,
    num_ambulances,
    be_dera,
    charter_other_kind,
    be_valid_profile,
    federal_tax_id,
    be_qrs_unrecognized,
    be_rescue_unrecognized,
    be_distressed
    );
  //
end;

procedure TClass_biz_services.MarkProfilesStale;
begin
  db_services.MarkProfilesStale;
end;

function TClass_biz_services.NameOf(service_id: string): string;
begin
  NameOf := db_services.NameOf(service_id);
end;

procedure TClass_biz_services.&Set
  (
  affiliate_num: string;
  name: string;
  county_code: string;
  business_phone_num: string;
  business_fax_num: string;
  website_address: string;
  charter_kind: string;
  corpadmin_contact_name: string;
  corpadmin_primary_phone_num: string;
  corpadmin_secondary_phone_num: string;
  corpadmin_email_address: string;
  be_emsof_participant: boolean;
  emsof_nonparticipation_reason: string;
  emsof_contact_name: string;
  emsof_contact_primary_phone_num: string;
  emsof_contact_sms_phone_num: string;
  coo_name: string;
  coo_work_phone_num: string;
  coo_home_phone_num: string;
  coo_email_address: string;
  coo_mobile_phone_or_pager_num: string;
  md_name: string;
  md_office_phone_num: string;
  md_home_phone_num: string;
  md_email_address: string;
  md_mobile_phone_or_pager_num: string;
  physical_street_address_line_1: string;
  physical_street_address_line_2: string;
  physical_city: string;
  physical_state: string;
  physical_zip_code: string;
  mail_address_line_1: string;
  mail_address_line_2: string;
  mail_city: string;
  mail_state: string;
  mail_zip_code: string;
  be_qrs: boolean;
  be_bls_amb: boolean;
  be_als_amb: boolean;
  be_als_squad: boolean;
  be_air_amb: boolean;
  be_rescue: boolean;
  be_pa_turnpike_contractor: boolean;
  num_doh_licensed_vehicles: string;
  num_ambulances: string;
  be_dera: boolean;
  charter_other_kind: string;
  be_new_affirmation: boolean;
  be_valid_profile: boolean;
  federal_tax_id: string;
  be_qrs_unrecognized: boolean;
  be_rescue_unrecognized: boolean;
  be_distressed: boolean
  );
begin
  db_services.&Set
    (
    affiliate_num,
    name,
    county_code,
    business_phone_num,
    business_fax_num,
    website_address,
    charter_kind,
    corpadmin_contact_name,
    corpadmin_primary_phone_num,
    corpadmin_secondary_phone_num,
    corpadmin_email_address,
    be_emsof_participant,
    emsof_nonparticipation_reason,
    emsof_contact_name,
    emsof_contact_primary_phone_num,
    emsof_contact_sms_phone_num,
    coo_name,
    coo_work_phone_num,
    coo_home_phone_num,
    coo_email_address,
    coo_mobile_phone_or_pager_num,
    md_name,
    md_office_phone_num,
    md_home_phone_num,
    md_email_address,
    md_mobile_phone_or_pager_num,
    physical_street_address_line_1,
    physical_street_address_line_2,
    physical_city,
    physical_state,
    physical_zip_code,
    mail_address_line_1,
    mail_address_line_2,
    mail_city,
    mail_state,
    mail_zip_code,
    be_qrs,
    be_bls_amb,
    be_als_amb,
    be_als_squad,
    be_air_amb,
    be_rescue,
    be_pa_turnpike_contractor,
    num_doh_licensed_vehicles,
    num_ambulances,
    be_dera,
    charter_other_kind,
    be_valid_profile,
    federal_tax_id,
    be_qrs_unrecognized,
    be_rescue_unrecognized,
    be_distressed
    );
  db_appropriations.ApplyToExisting(affiliate_num,be_distressed);
end;

end.
