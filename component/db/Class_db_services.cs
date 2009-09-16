using MySql.Data.MySqlClient;
using kix;
using System;

using System.Web.UI.WebControls;
using Class_biz_notifications;
using Class_db;
using Class_db_trail;
namespace Class_db_services
{
    public class TClass_db_services: TClass_db
    {
        private TClass_biz_notifications biz_notifications = null;
        private TClass_db_trail db_trail = null;
        //Constructor  Create()
        public TClass_db_services() : base()
        {
            biz_notifications = new TClass_biz_notifications();
            db_trail = new TClass_db_trail();
        }
        public string AffiliateNumOfId(string id)
        {
            string result;
            this.Open();
            result = new MySqlCommand("SELECT affiliate_num FROM service WHERE id = " + id, this.connection).ExecuteScalar().ToString();
            this.Close();
            return result;
        }

        public bool BeAdded(string service_name, string affiliate_num, string password_reset_email_address, string county_code)
        {
            bool result;
            result = false;
            this.Open();
            if ("1" != new MySqlCommand("select max(service_user.id) = max(service.id) from service_user, service", this.connection).ExecuteScalar().ToString())
            {
                biz_notifications.IssueCorruptionNotification("SERVICE", "BEFORE");
            }
            else
            {
                new MySqlCommand(db_trail.Saved("SET FOREIGN_KEY_CHECKS=0; SET AUTOCOMMIT=0; START TRANSACTION" + ";" + " insert service" + " set county_code = \"" + county_code + "\"" + " , affiliate_num = \"" + affiliate_num + "\"" + " , name = \"" + service_name + "\"" + " , charter_kind = \"9\"" + " , corpadmin_contact_name =\"\"" + " , corpadmin_primary_phone_num = \"\"" + " , be_emsof_participant = FALSE" + " , coo_name = \"\"" + " , coo_work_phone_num = \"\"" + " , physical_street_address_line_1 = \"\"" + " , physical_city = \"\"" + " , physical_state = \"\"" + " , physical_zip_code = \"\"" + " , mail_address_line_1 = \"\"" + " , mail_city = \"\"" + " , mail_state = \"\"" + " , mail_zip_code = \"\"" + " , num_doh_licensed_vehicles = 0" + " , num_ambulances = 0" + " , be_qrs_unrecognized = FALSE" + " , be_rescue_unrecognized = FALSE" + ";" + " insert service_user set password_reset_email_address = \"" + password_reset_email_address + "\"" + ";" + " SET FOREIGN_KEY_CHECKS=1; COMMIT"), this.connection).ExecuteNonQuery();
                if ("1" != new MySqlCommand("select max(service_user.id) = max(service.id) from service_user, service", this.connection).ExecuteScalar().ToString())
                {
                    biz_notifications.IssueCorruptionNotification("SERVICE", "AFTER");
                }
                else
                {
                    result = true;
                }
            }
            this.Close();

            return result;
        }

        public bool BeDistressed(string id)
        {
            bool result;
            this.Open();
            result = "1" == new MySqlCommand("select be_distressed from service where id = \"" + id + "\"", this.connection).ExecuteScalar().ToString();
            this.Close();
            return result;
        }

        public bool BeKnown(string affiliate_num)
        {
            bool result;
            this.Open();
            result = null != new MySqlCommand("select 1 from service where affiliate_num = \"" + affiliate_num + "\"", this.connection).ExecuteScalar();
            this.Close();
            return result;
        }

        public bool BeValidAndParticipating(string id)
        {
            bool result;
            this.Open();
            result = null != new MySqlCommand("select be_valid_profile and be_emsof_participant from service where id = \"" + id + "\"", this.connection).ExecuteScalar();
            this.Close();
            return result;
        }

        public bool Bind(string partial_affiliate_num, object target)
        {
            bool result;
            MySqlDataReader dr;
            this.Open();
            ((target) as ListControl).Items.Clear();
            dr = new MySqlCommand("SELECT affiliate_num" + " , name" + " , concat(affiliate_num,\" - \",name) as descriptor" + " FROM service" + " WHERE concat(affiliate_num,\" - \",name) like \"%" + partial_affiliate_num + "%\"" + " order by name", this.connection).ExecuteReader();
            while (dr.Read())
            {
                ((target) as ListControl).Items.Add(new ListItem(dr["descriptor"].ToString(), dr["affiliate_num"].ToString()));
            }
            dr.Close();
            this.Close();
            result = ((target) as ListControl).Items.Count > 0;
            return result;
        }

        public void BindAnnualRespondents(string sort_order, bool be_order_ascending, object target)
        {
            if (be_order_ascending)
            {
                sort_order = sort_order.Replace("%", " asc");
            }
            else
            {
                sort_order = sort_order.Replace("%", " desc");
            }
            this.Open();
            ((target) as BaseDataList).DataSource = new MySqlCommand("select affiliate_num" + " , service.name as service_name" + " , county_code_name_map.name as county_name" + " , IF(be_emsof_participant,\"YES\",\"no\") as be_emsof_participant" + " from service" + " join county_code_name_map on (county_code_name_map.code=service.county_code)" + " where be_valid_profile" + " order by " + sort_order, this.connection).ExecuteReader();
            ((target) as BaseDataList).DataBind();
            this.Close();
        }

        public void BindListControl(string county_user_id, object target, bool be_unfiltered, bool be_inclusive_of_invalids_and_nonparticipants)
        {
            MySqlDataReader dr;
            string cmdText;
            this.Open();
            ((target) as ListControl).Items.Clear();
            ((target) as ListControl).Items.Add(new ListItem("-- Select --", "0"));
            cmdText = "SELECT id,name FROM service_user JOIN service using (id) WHERE be_active";
            if (!be_unfiltered)
            {
                cmdText = cmdText + " and county_code = \"" + county_user_id + "\"";
            }
            if (!be_inclusive_of_invalids_and_nonparticipants)
            {
                cmdText = cmdText + " and be_valid_profile and be_emsof_participant";
            }
            cmdText = cmdText + " ORDER BY name";
            dr = new MySqlCommand(cmdText, this.connection).ExecuteReader();
            while (dr.Read())
            {
                ((target) as ListControl).Items.Add(new ListItem(dr["name"].ToString(), dr["id"].ToString()));
            }
            dr.Close();
            this.Close();
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
            result = true;
            this.Open();
            try {
                new MySqlCommand(db_trail.Saved("delete from service where affiliate_num = " + affiliate_num), this.connection).ExecuteNonQuery();
            }
            catch(System.Exception e) {
                if (e.Message.StartsWith("Cannot delete or update a parent row: a foreign key constraint fails", true, null))
                {
                    result = false;
                }
                else
                {
                    throw e;
                }
            }
            this.Close();
            return result;
        }

        public string EmailTargetForCounty(string county_id, bool be_filtered_by_emsof_participation, bool be_emsof_participant)
        {
            string result;
            MySqlDataReader dr;
            string email_target;
            string sql;
            email_target = k.EMPTY;
            sql = "select password_reset_email_address" + " from service_user" + " join service using (id)" + " where county_code = \"" + county_id + "\"";
            if (be_filtered_by_emsof_participation)
            {
                sql = sql + " and be_emsof_participant = " + be_emsof_participant.ToString();
            }
            this.Open();
            dr = new MySqlCommand(sql, this.connection).ExecuteReader();
            while (dr.Read())
            {
                email_target = email_target + dr["password_reset_email_address"].ToString() + k.COMMA_SPACE;
            }
            this.Close();
            result = email_target.TrimEnd(new char[] {k.COMMA, k.SPACE});
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
            MySqlDataReader dr;

            name = k.EMPTY;
            county_code = k.EMPTY;
            business_phone_num = k.EMPTY;
            business_fax_num = k.EMPTY;
            website_address = k.EMPTY;
            charter_kind = k.EMPTY;
            corpadmin_contact_name = k.EMPTY;
            corpadmin_primary_phone_num = k.EMPTY;
            corpadmin_secondary_phone_num = k.EMPTY;
            corpadmin_email_address = k.EMPTY;
            be_emsof_participant = false;
            emsof_nonparticipation_reason = k.EMPTY;
            emsof_contact_name = k.EMPTY;
            emsof_contact_primary_phone_num = k.EMPTY;
            emsof_contact_sms_phone_num = k.EMPTY;
            coo_name = k.EMPTY;
            coo_work_phone_num = k.EMPTY;
            coo_home_phone_num = k.EMPTY;
            coo_email_address = k.EMPTY;
            coo_mobile_phone_or_pager_num = k.EMPTY;
            md_name = k.EMPTY;
            md_office_phone_num = k.EMPTY;
            md_home_phone_num = k.EMPTY;
            md_email_address = k.EMPTY;
            md_mobile_phone_or_pager_num = k.EMPTY;
            physical_street_address_line_1 = k.EMPTY;
            physical_street_address_line_2 = k.EMPTY;
            physical_city = k.EMPTY;
            physical_state = k.EMPTY;
            physical_zip_code = k.EMPTY;
            mail_address_line_1 = k.EMPTY;
            mail_address_line_2 = k.EMPTY;
            mail_city = k.EMPTY;
            mail_state = k.EMPTY;
            mail_zip_code = k.EMPTY;
            be_qrs = false;
            be_bls_amb = false;
            be_als_amb = false;
            be_als_squad = false;
            be_air_amb = false;
            be_rescue = false;
            be_pa_turnpike_contractor = false;
            num_doh_licensed_vehicles = k.EMPTY;
            num_ambulances = k.EMPTY;
            be_dera = false;
            charter_other_kind = k.EMPTY;
            be_valid_profile = false;
            federal_tax_id = k.EMPTY;
            be_qrs_unrecognized = false;
            be_rescue_unrecognized = false;
            be_distressed = false;
            result = false;
            this.Open();
            dr = new MySqlCommand("select * from service where CAST(affiliate_num AS CHAR) = \"" + affiliate_num + "\"", this.connection).ExecuteReader();
            if (dr.Read())
            {
                affiliate_num = dr["affiliate_num"].ToString();
                name = dr["name"].ToString();
                county_code = dr["county_code"].ToString();
                business_phone_num = dr["business_phone_num"].ToString();
                business_fax_num = dr["business_fax_num"].ToString();
                website_address = dr["website_address"].ToString();
                charter_kind = dr["charter_kind"].ToString();
                corpadmin_contact_name = dr["corpadmin_contact_name"].ToString();
                corpadmin_primary_phone_num = dr["corpadmin_primary_phone_num"].ToString();
                corpadmin_secondary_phone_num = dr["corpadmin_secondary_phone_num"].ToString();
                corpadmin_email_address = dr["corpadmin_email_address"].ToString();
                be_emsof_participant = (dr["be_emsof_participant"].ToString() == "1");
                emsof_nonparticipation_reason = dr["emsof_nonparticipation_reason"].ToString();
                emsof_contact_name = dr["emsof_contact_name"].ToString();
                emsof_contact_primary_phone_num = dr["emsof_contact_primary_phone_num"].ToString();
                emsof_contact_sms_phone_num = dr["emsof_contact_sms_phone_num"].ToString();
                coo_name = dr["coo_name"].ToString();
                coo_work_phone_num = dr["coo_work_phone_num"].ToString();
                coo_home_phone_num = dr["coo_home_phone_num"].ToString();
                coo_email_address = dr["coo_email_address"].ToString();
                coo_mobile_phone_or_pager_num = dr["coo_mobile_phone_or_pager_num"].ToString();
                md_name = dr["md_name"].ToString();
                md_office_phone_num = dr["md_office_phone_num"].ToString();
                md_home_phone_num = dr["md_home_phone_num"].ToString();
                md_email_address = dr["md_email_address"].ToString();
                md_mobile_phone_or_pager_num = dr["md_mobile_phone_or_pager_num"].ToString();
                physical_street_address_line_1 = dr["physical_street_address_line_1"].ToString();
                physical_street_address_line_2 = dr["physical_street_address_line_2"].ToString();
                physical_city = dr["physical_city"].ToString();
                physical_state = dr["physical_state"].ToString();
                physical_zip_code = dr["physical_zip_code"].ToString();
                mail_address_line_1 = dr["mail_address_line_1"].ToString();
                mail_address_line_2 = dr["mail_address_line_2"].ToString();
                mail_city = dr["mail_city"].ToString();
                mail_state = dr["mail_state"].ToString();
                mail_zip_code = dr["mail_zip_code"].ToString();
                be_qrs = (dr["be_qrs"].ToString() == "1");
                be_bls_amb = (dr["be_bls_amb"].ToString() == "1");
                be_als_amb = (dr["be_als_amb"].ToString() == "1");
                be_als_squad = (dr["be_als_squad"].ToString() == "1");
                be_air_amb = (dr["be_air_amb"].ToString() == "1");
                be_rescue = (dr["be_rescue"].ToString() == "1");
                be_pa_turnpike_contractor = (dr["be_pa_turnpike_contractor"].ToString() == "1");
                num_doh_licensed_vehicles = dr["num_doh_licensed_vehicles"].ToString();
                num_ambulances = dr["num_ambulances"].ToString();
                be_dera = (dr["be_dera"].ToString() == "1");
                charter_other_kind = dr["charter_other_kind"].ToString();
                be_valid_profile = (dr["be_valid_profile"].ToString() == "1");
                federal_tax_id = dr["federal_tax_id_num"].ToString();
                be_qrs_unrecognized = (dr["be_qrs_unrecognized"].ToString() == "1");
                be_rescue_unrecognized = (dr["be_rescue_unrecognized"].ToString() == "1");
                be_distressed = (dr["be_distressed"].ToString() == "1");
                result = true;
            }
            dr.Close();
            this.Close();
            return result;
        }

        public void MarkProfilesStale()
        {
            this.Open();
            new MySqlCommand(db_trail.Saved("update service set be_valid_profile = FALSE"), this.connection).ExecuteNonQuery();
            this.Close();
        }

        public string MdNameOf(string service_id)
        {
            string result;
            this.Open();
            result = new MySqlCommand("select md_name from service where id = " + service_id, this.connection).ExecuteScalar().ToString();
            this.Close();
            return result;
        }

        public string NameOf(string service_id)
        {
            string result;
            this.Open();
            result = new MySqlCommand("select name from service where id = " + service_id, this.connection).ExecuteScalar().ToString();
            this.Close();
            return result;
        }

        public uint NumAmbulancesOf(string service_id)
        {
            uint result;
            this.Open();
            result = uint.Parse(new MySqlCommand("select num_ambulances from service where id = " + service_id, this.connection).ExecuteScalar().ToString());
            this.Close();
            return result;
        }

        public uint NumDohLicensedVehiclesOf(string service_id)
        {
            uint result;
            this.Open();
            result = uint.Parse(new MySqlCommand("select num_doh_licensed_vehicles from service where id = " + service_id, this.connection).ExecuteScalar().ToString());
            this.Close();
            return result;
        }

        public void Set(string affiliate_num, string name, string county_code, string business_phone_num, string business_fax_num, string website_address, string charter_kind, string corpadmin_contact_name, string corpadmin_primary_phone_num, string corpadmin_secondary_phone_num, string corpadmin_email_address, bool be_emsof_participant, string emsof_nonparticipation_reason, string emsof_contact_name, string emsof_contact_primary_phone_num, string emsof_contact_sms_phone_num, string coo_name, string coo_work_phone_num, string coo_home_phone_num, string coo_email_address, string coo_mobile_phone_or_pager_num, string md_name, string md_office_phone_num, string md_home_phone_num, string md_email_address, string md_mobile_phone_or_pager_num, string physical_street_address_line_1, string physical_street_address_line_2, string physical_city, string physical_state, string physical_zip_code, string mail_address_line_1, string mail_address_line_2, string mail_city, string mail_state, string mail_zip_code, bool be_qrs, bool be_bls_amb, bool be_als_amb, bool be_als_squad, bool be_air_amb, bool be_rescue, bool be_pa_turnpike_contractor, string num_doh_licensed_vehicles, string num_ambulances, bool be_dera, string charter_other_kind, bool be_valid_profile, string federal_tax_id, bool be_qrs_unrecognized, bool be_rescue_unrecognized, bool be_distressed)
        {
            string childless_field_assignments_clause;
            childless_field_assignments_clause = " name = NULLIF(\"" + name + "\",\"\")" + " , county_code = NULLIF(\"" + county_code + "\",\"\")" + " , business_phone_num = NULLIF(\"" + business_phone_num + "\",\"\")" + " , business_fax_num = NULLIF(\"" + business_fax_num + "\",\"\")" + " , website_address = NULLIF(\"" + website_address + "\",\"\")" + " , charter_kind = NULLIF(\"" + charter_kind + "\",\"\")" + " , corpadmin_contact_name = NULLIF(\"" + corpadmin_contact_name + "\",\"\")" + " , corpadmin_primary_phone_num = NULLIF(\"" + corpadmin_primary_phone_num + "\",\"\")" + " , corpadmin_secondary_phone_num = NULLIF(\"" + corpadmin_secondary_phone_num + "\",\"\")" + " , corpadmin_email_address = NULLIF(\"" + corpadmin_email_address + "\",\"\")" + " , be_emsof_participant = " + be_emsof_participant.ToString() + " , emsof_nonparticipation_reason = NULLIF(\"" + emsof_nonparticipation_reason + "\",\"\")" + " , emsof_contact_name = NULLIF(\"" + emsof_contact_name + "\",\"\")" + " , emsof_contact_primary_phone_num = NULLIF(\"" + emsof_contact_primary_phone_num + "\",\"\")" + " , emsof_contact_sms_phone_num = NULLIF(\"" + emsof_contact_sms_phone_num + "\",\"\")" + " , coo_name = NULLIF(\"" + coo_name + "\",\"\")" + " , coo_work_phone_num = NULLIF(\"" + coo_work_phone_num + "\",\"\")" + " , coo_home_phone_num = NULLIF(\"" + coo_home_phone_num + "\",\"\")" + " , coo_email_address = NULLIF(\"" + coo_email_address + "\",\"\")" + " , coo_mobile_phone_or_pager_num = NULLIF(\"" + coo_mobile_phone_or_pager_num + "\",\"\")" + " , md_name = NULLIF(\"" + md_name + "\",\"\")" + " , md_office_phone_num = NULLIF(\"" + md_office_phone_num + "\",\"\")" + " , md_home_phone_num = NULLIF(\"" + md_home_phone_num + "\",\"\")" + " , md_email_address = NULLIF(\"" + md_email_address + "\",\"\")" + " , md_mobile_phone_or_pager_num = NULLIF(\"" + md_mobile_phone_or_pager_num + "\",\"\")" + " , physical_street_address_line_1 = NULLIF(\"" + physical_street_address_line_1 + "\",\"\")" + " , physical_street_address_line_2 = NULLIF(\"" + physical_street_address_line_2 + "\",\"\")" + " , physical_city = NULLIF(\"" + physical_city + "\",\"\")" + " , physical_state = NULLIF(\"" + physical_state + "\",\"\")" + " , physical_zip_code = NULLIF(\"" + physical_zip_code + "\",\"\")" + " , mail_address_line_1 = NULLIF(\"" + mail_address_line_1 + "\",\"\")" + " , mail_address_line_2 = NULLIF(\"" + mail_address_line_2 + "\",\"\")" + " , mail_city = NULLIF(\"" + mail_city + "\",\"\")" + " , mail_state = NULLIF(\"" + mail_state + "\",\"\")" + " , mail_zip_code = NULLIF(\"" + mail_zip_code + "\",\"\")" + " , be_qrs = " + be_qrs.ToString() + " , be_bls_amb = " + be_bls_amb.ToString() + " , be_als_amb = " + be_als_amb.ToString() + " , be_als_squad = " + be_als_squad.ToString() + " , be_air_amb = " + be_air_amb.ToString() + " , be_rescue = " + be_rescue.ToString() + " , be_pa_turnpike_contractor = " + be_pa_turnpike_contractor.ToString() + " , num_doh_licensed_vehicles = NULLIF(\"" + num_doh_licensed_vehicles + "\",\"\")" + " , num_ambulances = NULLIF(\"" + num_ambulances + "\",\"\")" + " , be_dera = " + be_dera.ToString() + " , charter_other_kind = NULLIF(\"" + charter_other_kind + "\",\"\")" + " , be_valid_profile = " + be_valid_profile.ToString() + " , federal_tax_id_num = NULLIF(\"" + federal_tax_id + "\",\"\")" + " , be_qrs_unrecognized = " + be_qrs_unrecognized.ToString() + " , be_rescue_unrecognized = " + be_rescue_unrecognized.ToString() + " , be_distressed = " + be_distressed.ToString();
            this.Open();
            new MySqlCommand(db_trail.Saved("insert service" + " set affiliate_num = NULLIF(\"" + affiliate_num + "\",\"\")" + " , " + childless_field_assignments_clause + " on duplicate key update " + childless_field_assignments_clause), this.connection).ExecuteNonQuery();
            this.Close();

        }

    } // end TClass_db_services

}
