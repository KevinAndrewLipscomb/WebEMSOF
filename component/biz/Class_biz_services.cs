using System;

using System.Web;
using Class_db_appropriations;
using Class_db_services;
using Class_biz_accounts;
namespace Class_biz_services
{
    public class TClass_biz_services
    {
        private TClass_db_appropriations db_appropriations = null;
        private TClass_db_services db_services = null;
        //Constructor  Create()
        public TClass_biz_services() : base()
        {
            db_appropriations = new TClass_db_appropriations();
            db_services = new TClass_db_services();
        }
        public string AffiliateNumOfId(string id)
        {
            string result;
            result = db_services.AffiliateNumOfId(id);
            return result;
        }

        public bool BeAdded(string service_name, string affiliate_num, string password_reset_email_address, string county_code)
        {
            bool result;
            result = db_services.BeAdded(service_name, affiliate_num, password_reset_email_address, county_code);
            return result;
        }

        public bool BeDistressed(string id)
        {
            bool result;
            result = db_services.BeDistressed(id);
            return result;
        }

        public bool BeKnown(string affiliate_num)
        {
            bool result;
            result = db_services.BeKnown(affiliate_num);
            return result;
        }

        public bool BeOkToDelete()
        {
            bool result;
            result = HttpContext.Current.User.IsInRole("director") || HttpContext.Current.User.IsInRole("emsof-coordinator") || HttpContext.Current.User.IsInRole("emsof-planner");
            return result;
        }

        public bool BeValidAndParticipating(string id)
        {
            bool result;
            result = db_services.BeValidAndParticipating(id);
            return result;
        }

        public bool Bind(string partial_affiliate_num, object target)
        {
            bool result;
            result = db_services.Bind(partial_affiliate_num, target);
            return result;
        }

        public void BindAnnualRespondents(string sort_order, bool be_order_ascending, object target)
        {
            db_services.BindAnnualRespondents(sort_order, be_order_ascending, target);
        }

        public void BindListControl(string county_user_id, object target, bool be_unfiltered, bool be_inclusive_of_invalids_and_nonparticipants)
        {
            db_services.BindListControl(county_user_id, target, be_unfiltered, be_inclusive_of_invalids_and_nonparticipants);
        }

        public void BindListControl(string county_user_id, object target)
        {
            BindListControl(county_user_id, target, false);
        }

        public void BindListControl(string county_user_id, object target, bool be_unfiltered)
        {
            BindListControl(county_user_id, target, be_unfiltered, false);
        }

        public bool Delete(string affiliate_num)
        {
            bool result;
            result = db_services.Delete(affiliate_num);
            return result;
        }

        public string EmailTargetForCounty(string county_id, bool be_filtered_by_emsof_participation, bool be_emsof_participant)
        {
            string result;
            result = db_services.EmailTargetForCounty(county_id, be_filtered_by_emsof_participation, be_emsof_participant);
            return result;
        }

        public string EmailTargetForCounty(string county_id)
        {
            return EmailTargetForCounty(county_id, false);
        }

        public string EmailTargetForCounty(string county_id, bool be_filtered_by_emsof_participation)
        {
            return EmailTargetForCounty(county_id, be_filtered_by_emsof_participation, true);
        }

        public bool Get(string affiliate_num, out string name, out string county_code, out string business_phone_num, out string business_fax_num, out string website_address, out string charter_kind, out string corpadmin_contact_name, out string corpadmin_primary_phone_num, out string corpadmin_secondary_phone_num, out string corpadmin_email_address, out bool be_emsof_participant, out string emsof_nonparticipation_reason, out string emsof_contact_name, out string emsof_contact_primary_phone_num, out string emsof_contact_sms_phone_num, out string coo_name, out string coo_work_phone_num, out string coo_home_phone_num, out string coo_email_address, out string coo_mobile_phone_or_pager_num, out string md_name, out string md_office_phone_num, out string md_home_phone_num, out string md_email_address, out string md_mobile_phone_or_pager_num, out string physical_street_address_line_1, out string physical_street_address_line_2, out string physical_city, out string physical_state, out string physical_zip_code, out string mail_address_line_1, out string mail_address_line_2, out string mail_city, out string mail_state, out string mail_zip_code, out bool be_qrs, out bool be_bls_amb, out bool be_als_amb, out bool be_als_squad, out bool be_air_amb, out bool be_rescue, out bool be_pa_turnpike_contractor, out string num_doh_licensed_vehicles, out string num_ambulances, out bool be_dera, out string charter_other_kind, out bool be_valid_profile, out string federal_tax_id, out bool be_qrs_unrecognized, out bool be_rescue_unrecognized, out bool be_distressed)
        {
            bool result;
            result = db_services.Get(affiliate_num, out name, out county_code, out business_phone_num, out business_fax_num, out website_address, out charter_kind, out corpadmin_contact_name, out corpadmin_primary_phone_num, out corpadmin_secondary_phone_num, out corpadmin_email_address, out be_emsof_participant, out emsof_nonparticipation_reason, out emsof_contact_name, out emsof_contact_primary_phone_num, out emsof_contact_sms_phone_num, out coo_name, out coo_work_phone_num, out coo_home_phone_num, out coo_email_address, out coo_mobile_phone_or_pager_num, out md_name, out md_office_phone_num, out md_home_phone_num, out md_email_address, out md_mobile_phone_or_pager_num, out physical_street_address_line_1, out physical_street_address_line_2, out physical_city, out physical_state, out physical_zip_code, out mail_address_line_1, out mail_address_line_2, out mail_city, out mail_state, out mail_zip_code, out be_qrs, out be_bls_amb, out be_als_amb, out be_als_squad, out be_air_amb, out be_rescue, out be_pa_turnpike_contractor, out num_doh_licensed_vehicles, out num_ambulances, out be_dera, out charter_other_kind, out be_valid_profile, out federal_tax_id, out be_qrs_unrecognized, out be_rescue_unrecognized, out be_distressed);

            return result;
        }

        public void MarkProfilesStale()
        {
            db_services.MarkProfilesStale();
        }

        public string NameOf(string service_id)
        {
            string result;
            result = db_services.NameOf(service_id);
            return result;
        }

        public void Set(string affiliate_num, string name, string county_code, string business_phone_num, string business_fax_num, string website_address, string charter_kind, string corpadmin_contact_name, string corpadmin_primary_phone_num, string corpadmin_secondary_phone_num, string corpadmin_email_address, bool be_emsof_participant, string emsof_nonparticipation_reason, string emsof_contact_name, string emsof_contact_primary_phone_num, string emsof_contact_sms_phone_num, string coo_name, string coo_work_phone_num, string coo_home_phone_num, string coo_email_address, string coo_mobile_phone_or_pager_num, string md_name, string md_office_phone_num, string md_home_phone_num, string md_email_address, string md_mobile_phone_or_pager_num, string physical_street_address_line_1, string physical_street_address_line_2, string physical_city, string physical_state, string physical_zip_code, string mail_address_line_1, string mail_address_line_2, string mail_city, string mail_state, string mail_zip_code, bool be_qrs, bool be_bls_amb, bool be_als_amb, bool be_als_squad, bool be_air_amb, bool be_rescue, bool be_pa_turnpike_contractor, string num_doh_licensed_vehicles, string num_ambulances, bool be_dera, string charter_other_kind, bool be_new_affirmation, bool be_valid_profile, string federal_tax_id, bool be_qrs_unrecognized, bool be_rescue_unrecognized, bool be_distressed)
        {
            db_services.Set(affiliate_num, name, county_code, business_phone_num, business_fax_num, website_address, charter_kind, corpadmin_contact_name, corpadmin_primary_phone_num, corpadmin_secondary_phone_num, corpadmin_email_address, be_emsof_participant, emsof_nonparticipation_reason, emsof_contact_name, emsof_contact_primary_phone_num, emsof_contact_sms_phone_num, coo_name, coo_work_phone_num, coo_home_phone_num, coo_email_address, coo_mobile_phone_or_pager_num, md_name, md_office_phone_num, md_home_phone_num, md_email_address, md_mobile_phone_or_pager_num, physical_street_address_line_1, physical_street_address_line_2, physical_city, physical_state, physical_zip_code, mail_address_line_1, mail_address_line_2, mail_city, mail_state, mail_zip_code, be_qrs, be_bls_amb, be_als_amb, be_als_squad, be_air_amb, be_rescue, be_pa_turnpike_contractor, num_doh_licensed_vehicles, num_ambulances, be_dera, charter_other_kind, be_valid_profile, federal_tax_id, be_qrs_unrecognized, be_rescue_unrecognized, be_distressed);
            db_appropriations.ApplyToExisting(affiliate_num, be_distressed);
        }

    } // end TClass_biz_services

}
