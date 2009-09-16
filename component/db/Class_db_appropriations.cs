using Class_db;
using Class_db_trail;
using Class_biz_fiscal_years;
using Class_biz_match_level;
using Class_biz_regional_staffers;
using kix;
using MySql.Data.MySqlClient;
using System;

namespace Class_db_appropriations
{
    public class TClass_db_appropriations: TClass_db
    {
        private TClass_biz_fiscal_years biz_fiscal_years = null;
        private TClass_biz_regional_staffers biz_regional_staffers = null;
        private TClass_db_trail db_trail = null;
        //Constructor  Create()
        public TClass_db_appropriations() : base()
        {
            // TODO: Add any constructor code here
            biz_fiscal_years = new TClass_biz_fiscal_years();
            biz_regional_staffers = new TClass_biz_regional_staffers();
            db_trail = new TClass_db_trail();
        }
        public void ApplyToExisting(string affiliate_num, bool be_distressed)
        {
            string match_level_id_expression;
            if (be_distressed)
            {
                match_level_id_expression = "(select id from match_level where factor = 1)";
            }
            else
            {
                match_level_id_expression = "region_dictated_appropriation.match_level_id";
            }
            this.Open();
            new MySqlCommand(db_trail.Saved("update county_dictated_appropriation" + " join region_dictated_appropriation" + " on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)" + " join state_dictated_appropriation" + " on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)" + " join fiscal_year on (fiscal_year.id=state_dictated_appropriation.fiscal_year_id)" + " join service on (service.id=county_dictated_appropriation.service_id)" + " set county_dictated_appropriation.match_level_id = " + match_level_id_expression + " where service_id = (select id from service where affiliate_num = \"" + affiliate_num + "\")" + " and fiscal_year_id = (select max(id) from fiscal_year)"), this.connection).ExecuteNonQuery();
            this.Close();

        }

        public bool BeAnyCurrentToService(string affiliate_num)
        {
            bool result;
            this.Open();
            result = "0" != new MySqlCommand("select count(*)" + " from county_dictated_appropriation" + " join region_dictated_appropriation" + " on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)" + " join state_dictated_appropriation" + " on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)" + " join service on (service.id=county_dictated_appropriation.service_id)" + " where fiscal_year_id = \"" + biz_fiscal_years.IdOfCurrent() + "\"" + " and affiliate_num = \"" + affiliate_num + "\"", this.connection).ExecuteScalar().ToString();
            this.Close();
            return result;
        }

        public string CountyCodeOfCountyDictum(string county_dictum_id)
        {
            string result;
            this.Open();
            result = new MySqlCommand("select county_code" + " from county_dictated_appropriation" + " join region_dictated_appropriation" + " on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)" + " where county_dictated_appropriation.id = " + county_dictum_id, this.connection).ExecuteScalar().ToString();
            this.Close();
            return result;
        }

        public uint FundingRoundsGenerated(string regional_staffer_id, string amendment_num_string)
        {
            uint result;
            this.Open();
            result = (uint)(new MySqlCommand("select funding_rounds_generated" + " from state_dictated_appropriation" + " where fiscal_year_id = " + biz_fiscal_years.IdOfCurrent() + " and region_code = " + biz_regional_staffers.RegionCodeOf(regional_staffer_id) + " and amendment_num = " + amendment_num_string, this.connection).ExecuteScalar().GetHashCode());
            this.Close();
            return result;
        }

        public void IncFundingRoundsGenerated(string regional_staffer_id, string amendment_num_string)
        {
            this.Open();
            new MySqlCommand(db_trail.Saved("update state_dictated_appropriation" + " set funding_rounds_generated = funding_rounds_generated + 1" + " where fiscal_year_id = " + biz_fiscal_years.IdOfCurrent() + " and region_code = " + biz_regional_staffers.RegionCodeOf(regional_staffer_id) + " and amendment_num = " + amendment_num_string), this.connection).ExecuteNonQuery();
            this.Close();
        }

        public decimal MatchFactorOf(string county_dictum_id)
        {
            decimal result;
            this.Open();
            result = (decimal)(new MySqlCommand("select factor" + " from county_dictated_appropriation" + " join match_level on (match_level.id=county_dictated_appropriation.match_level_id)" + " where county_dictated_appropriation.id = " + county_dictum_id, this.connection).ExecuteScalar());
            this.Close();
            return result;
        }

        public uint MatchLevelIdOf(string county_dictum_id)
        {
            uint result;
            this.Open();
            result = uint.Parse(new MySqlCommand("select match_level_id" + " from county_dictated_appropriation" + " where county_dictated_appropriation.id = " + county_dictum_id, this.connection).ExecuteScalar().ToString());
            this.Close();
            return result;
        }

        public uint MatchLevelIdOfRegionDictum(string region_dictum_id)
        {
            uint result;
            this.Open();
            result = uint.Parse(new MySqlCommand("select match_level_id" + " from region_dictated_appropriation" + " where region_dictated_appropriation.id = " + region_dictum_id, this.connection).ExecuteScalar().ToString());
            this.Close();
            return result;
        }

        public uint NumActiveAmendments(string regional_staffer_id)
        {
            uint result;
            this.Open();
            result =  (uint)(-1 + new MySqlCommand("select count(id)" + " from state_dictated_appropriation" + " where fiscal_year_id = " + biz_fiscal_years.IdOfCurrent() + " and region_code = " + biz_regional_staffers.RegionCodeOf(regional_staffer_id), this.connection).ExecuteScalar().GetHashCode());
            this.Close();
            return result;
        }

        public decimal ParentAppropriationOfEmsofRequest(string master_id)
        {
            decimal result;
            this.Open();
            result = (decimal)(new MySqlCommand("select county_dictated_appropriation.amount" + " from county_dictated_appropriation" + " join emsof_request_master on (emsof_request_master.county_dictated_appropriation_id=county_dictated_appropriation.id)" + " where emsof_request_master.id = " + master_id, this.connection).ExecuteScalar());
            this.Close();
            return result;
        }

        public void ReduceBy(decimal delta, string county_dictum_id)
        {
            this.Open();
            new MySqlCommand(db_trail.Saved("update county_dictated_appropriation" + " set amount = amount - " + delta.ToString() + " where id = " + county_dictum_id), this.connection).ExecuteNonQuery();
            this.Close();
        }

        public string RegionCodeOfCountyDictum(string county_dictum_id)
        {
            string result;
            this.Open();
            result = new MySqlCommand("select region_code" + " from county_dictated_appropriation" + " join region_dictated_appropriation" + " on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)" + " join state_dictated_appropriation" + " on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)" + " where county_dictated_appropriation.id = " + county_dictum_id, this.connection).ExecuteScalar().ToString();
            this.Close();
            return result;
        }

        public void SetNewStateToRegion(decimal amount)
        {
            string settings;
            settings = " region_code = 1" + " , fiscal_year_id = (select max(id) from fiscal_year)" + " , amount = \"" + amount.ToString() + "\"";
            this.Open();
            new MySqlCommand(db_trail.Saved("insert state_dictated_appropriation" + " set " + settings + " on duplicate key update " + settings), this.connection).ExecuteNonQuery();
            this.Close();
        }

        public void SetServiceToCountySubmissionDeadline(string id, string deadline)
        {
            this.Open();
            new MySqlCommand(db_trail.Saved("update region_dictated_appropriation" + " set service_to_county_submission_deadline = \"" + deadline + "\"" + " where id = " + id), this.connection).ExecuteNonQuery();
            this.Close();
        }

        public decimal SumOfAppropriationsFromSpecificParent(string parent_id, string recipient_kind, string recipient_id, string fy_id)
        {
            decimal result;
            string cmdText = k.EMPTY;
            if (recipient_kind == "service")
            {
                cmdText = "select sum(county_dictated_appropriation.amount)" + " from county_dictated_appropriation" + " join region_dictated_appropriation" + " on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)" + " join state_dictated_appropriation" + " on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)" + " where service_id = " + recipient_id + " and county_code = " + parent_id + " and fiscal_year_id = " + fy_id;
            }
            else if (recipient_kind == "county")
            {
                cmdText = "select sum(region_dictated_appropriation.amount)" + " from region_dictated_appropriation" + " join state_dictated_appropriation" + " on (state_dictated_appropriation.region_code=region_dictated_appropriation.state_dictated_appropriation_id)" + " where county_code = " + recipient_id + " and region_code = " + parent_id + " and fiscal_year_id = " + fy_id;
            }
            this.Open();
            result = (decimal)(new MySqlCommand(cmdText, this.connection).ExecuteScalar());
            this.Close();
            return result;
        }

        public decimal SumOfAppropriationsFromOnlyParent(string recipient_kind, string recipient_id, string fy_id)
        {
            decimal result;
            string cmdText = k.EMPTY;
            if (recipient_kind == "regional_staffer")
            {
                cmdText = "select sum(state_dictated_appropriation.amount)" + " from state_dictated_appropriation" + " join regional_staffer on (regional_staffer.region_code=state_dictated_appropriation.region_code)" + " where regional_staffer.id = " + recipient_id + " and fiscal_year_id = " + fy_id;
            }
            else if (recipient_kind == "county")
            {
                cmdText = "select sum(region_dictated_appropriation.amount)" + " from region_dictated_appropriation" + " join state_dictated_appropriation" + " on (state_dictated_appropriation.region_code=region_dictated_appropriation.state_dictated_appropriation_id)" + " where county_code = " + recipient_id + " and fiscal_year_id = " + fy_id;
            }
            this.Open();
            result = (decimal)(new MySqlCommand(cmdText, this.connection).ExecuteScalar());
            this.Close();
            return result;
        }

        public decimal SumOfAppropriationsToServicesInRegion(string region_id, string fy_id)
        {
            decimal result;
            object sum_obj;
            this.Open();
            sum_obj = new MySqlCommand("select sum(county_dictated_appropriation.amount)" + " from county_dictated_appropriation" + " join region_dictated_appropriation" + " on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)" + " join state_dictated_appropriation" + " on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)" + " where region_code = " + region_id + " and fiscal_year_id = " + fy_id, this.connection).ExecuteScalar();
            if (sum_obj == DBNull.Value)
            {
                result = 0;
            }
            else
            {
                result = (decimal)(sum_obj);
            }
            this.Close();
            return result;
        }

        public decimal SumOfSelfDictatedAppropriations(string self_kind, string self_id, string fy_id)
        {
            decimal result;
            string cmdText = k.EMPTY;
            object sum_obj;
            if (self_kind == "regional_staffer")
            {
                cmdText = "select sum(region_dictated_appropriation.amount)" + " from region_dictated_appropriation" + " join state_dictated_appropriation" + " on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)" + " join regional_staffer on (regional_staffer.region_code=state_dictated_appropriation.region_code)" + " where regional_staffer.id = " + self_id + " and fiscal_year_id = " + fy_id;
            }
            else if (self_kind == "county")
            {
                cmdText = "select sum(county_dictated_appropriation.amount)" + " from county_dictated_appropriation" + " join region_dictated_appropriation" + " on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)" + " join state_dictated_appropriation" + " on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)" + " where county_code = " + self_id + " and fiscal_year_id = " + fy_id;
            }
            this.Open();
            sum_obj = new MySqlCommand(cmdText, this.connection).ExecuteScalar();
            if (sum_obj == DBNull.Value)
            {
                result = 0;
            }
            else
            {
                result = (decimal)(sum_obj);
            }
            this.Close();

            return result;
        }

    } // end TClass_db_appropriations

}
