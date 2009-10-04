using MySql.Data.MySqlClient;

using System.Configuration;


using kix;

using System;
using System.Collections;
using System.ComponentModel;
using System.Web;
using System.Web.SessionState;

using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;



using System.Web.UI;
using Class_db;
using Class_db_trail;
using Class_biz_equipment;
using Class_biz_fiscal_years;
namespace request_item_detail
{
    public partial class TWebForm_request_item_detail: ki_web_ui.page_class
    {
        private p_type p;
        protected System.Web.UI.WebControls.PlaceHolder PlaceHolder_precontent = null;
        protected System.Web.UI.WebControls.PlaceHolder PlaceHolder_postcontent = null;
        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            this.PreRender += this.TWebForm_request_item_detail_PreRender;
            //this.Load += this.Page_Load;
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            MySqlDataReader dr_factors;
            MySqlDataReader dr_services;
            MySqlDataReader dr_user_details;
            bool be_before_deadline;
            bool be_finalized;
            bool be_locked;
            bool be_new;
            TClass_biz_fiscal_years biz_fiscal_years;
            string cmdText;
            if (IsPostBack)
            {
                if ((Session["request_item_detail.p"] != null))
                {
                    p = (p_type)(Session["request_item_detail.p"]);
                }
                else
                {
                    Server.Transfer("~/timeout.aspx");
                }
            }
            else
            {
                if (Request.ServerVariables["URL"] == Request.CurrentExecutionFilePath)
                {
                    Session.Clear();
                    Server.Transfer("~/login.aspx");
                }
                Title.InnerText = Server.HtmlEncode(ConfigurationManager.AppSettings["application_name"]) + " - request_item_detail";
                biz_fiscal_years = new TClass_biz_fiscal_years();
                p.biz_equipment = new TClass_biz_equipment();
                p.db = new TClass_db();
                p.db_trail = new TClass_db_trail();
                p.db.Open();
                // Set default match_level.
                p.match_level = decimal.Parse(new MySqlCommand("select factor" + " from match_level join county_dictated_appropriation on (county_dictated_appropriation.match_level_id=match_level.id)" + " where county_dictated_appropriation.id = " + Session["county_dictated_appropriation_id"].ToString(), p.db.connection).ExecuteScalar().ToString());
                // Build cmdText_get_equipment_category_monetary_details
                p.cmdText_get_equipment_category_monetary_details = "select life_expectancy_years," + " allowable_cost,";
                if (decimal.Equals(p.match_level,0.60))
                {
                    p.cmdText_get_equipment_category_monetary_details = p.cmdText_get_equipment_category_monetary_details + "funding_level_rural as funding_level";
                }
                else if (decimal.Equals(p.match_level,1.00))
                {
                    p.cmdText_get_equipment_category_monetary_details = p.cmdText_get_equipment_category_monetary_details + "allowable_cost as funding_level";
                }
                else
                {
                    p.cmdText_get_equipment_category_monetary_details = p.cmdText_get_equipment_category_monetary_details + "funding_level_nonrural as funding_level";
                }
                p.cmdText_get_equipment_category_monetary_details = p.cmdText_get_equipment_category_monetary_details + " from eligible_provider_equipment_list" + " where fiscal_year_id = " + biz_fiscal_years.IdOfDesignator(Session["fiscal_year_designator"].ToString()) + " and code = ";
                // Mind these indices if the query changes.
                p.dri_equipment_category_allowable_cost = 1;
                p.dri_equipment_category_funding_level = 2;
                be_before_deadline = Session["be_before_service_to_county_submission_deadline"].ToString() == "True";
                // Case matters.
                be_finalized = Session["be_finalized"].ToString() == "True";
                // Case matters.
                be_locked = !be_before_deadline || be_finalized;
                be_new = Session["emsof_request_item_priority"].ToString() == k.EMPTY;
                // Manage whether or not the instruction ("-- Select --") appears at the top of DropDownList_equipment_category.
                if (be_new)
                {
                    DropDownList_equipment_category.Items.Add(new ListItem("-- Select (then wait for form to refresh) --", "0"));
                }
                // Manage the loading of nominal elements into DropDownList_equipment_category.
                if (be_new || !be_locked)
                {
                    // Determine this service's eligibility factors.
                    dr_factors = new MySqlCommand("select (be_als_amb or be_air_amb) as be_als_amb," + " (be_als_amb or be_als_squad) as be_als_squad," + " (be_bls_amb or be_als_amb) as be_bls_amb," + " (be_qrs or be_bls_amb or be_als_amb or be_als_squad) as be_qrs" + " FROM service" + " WHERE id = " + Session["service_user_id"].ToString(), p.db.connection).ExecuteReader();
                    dr_factors.Read();
                    cmdText = "SELECT code,description FROM eligible_provider_equipment_list" + " WHERE fiscal_year_id = " + biz_fiscal_years.IdOfDesignator(Session["fiscal_year_designator"].ToString()) + " and (FALSE ";
                    // Default to k.EMPTY set
                    if (dr_factors["be_als_amb"].ToString() == "1")
                    {
                        cmdText = cmdText + "or be_eligible_als_amb = 1 ";
                    }
                    if (dr_factors["be_als_squad"].ToString() == "1")
                    {
                        cmdText = cmdText + "or be_eligible_als_squad = 1 ";
                    }
                    if (dr_factors["be_bls_amb"].ToString() == "1")
                    {
                        cmdText = cmdText + "or be_eligible_bls_amb = 1 ";
                    }
                    if (dr_factors["be_qrs"].ToString() == "1")
                    {
                        cmdText = cmdText + "or be_eligible_qrs = 1 ";
                    }
                    cmdText = cmdText + ") ORDER BY description";
                    dr_factors.Close();
                    dr_services = new MySqlCommand(cmdText, p.db.connection).ExecuteReader();
                    while (dr_services.Read())
                    {
                        DropDownList_equipment_category.Items.Add(new ListItem(dr_services["description"].ToString(), dr_services["code"].ToString()));
                    }
                    dr_services.Close();
                }
                else
                {
                    DropDownList_equipment_category.Items.Add(new ListItem(Session["emsof_request_item_equipment_category"].ToString(), Session["emsof_request_item_code"].ToString()));
                }
                // Manage the initially selected value in DropDownList_equipment_category and the availability of the submit/update/delete
                // options.
                if (!(be_new || be_locked))
                {
                    DropDownList_equipment_category.SelectedValue = Session["emsof_request_item_code"].ToString();
                    Button_submit_and_repeat.Visible = false;
                    Button_submit_and_stop.Visible = false;
                    Button_update.Visible = true;
                }
                else
                {
                    TableRow_delete.Visible = false;
                }
                // Manage the filling of the other data elements.
                if (!be_new)
                {
                    p.db.Close();
                    ShowDependentData();
                    p.db.Open();
                    dr_user_details = new MySqlCommand("select make_model,place_kept,be_refurbished,unit_cost,quantity,additional_service_ante,emsof_ante" + " from emsof_request_detail" + " where master_id = " + Session["emsof_request_master_id"].ToString() + " and priority = " + Session["emsof_request_item_priority"].ToString(), p.db.connection).ExecuteReader();
                    dr_user_details.Read();
                    TextBox_make_model.Text = dr_user_details["make_model"].ToString();
                    TextBox_place_kept.Text = dr_user_details["place_kept"].ToString();
                    if (dr_user_details["be_refurbished"].ToString() == "0")
                    {
                        RadioButtonList_condition.SelectedIndex = 0;
                    }
                    else
                    {
                        RadioButtonList_condition.SelectedIndex = 1;
                    }
                    TextBox_unit_cost.Text = decimal.Parse(dr_user_details["unit_cost"].ToString()).ToString("N2");
                    TextBox_quantity.Text = dr_user_details["quantity"].ToString();
                    TextBox_additional_service_ante.Text = decimal.Parse(dr_user_details["additional_service_ante"].ToString()).ToString("N2");
                    p.saved_emsof_ante = decimal.Parse(dr_user_details["emsof_ante"].ToString());
                    p.saved_additional_service_ante = decimal.Parse(dr_user_details["additional_service_ante"].ToString());
                    Label_emsof_ante.Text = p.saved_emsof_ante.ToString("N2");
                    dr_user_details.Close();
                    Recalculate();
                }
                // Manage the availability of the remaining item-detail-related controls.
                if (be_locked)
                {
                    DropDownList_equipment_category.Enabled = false;
                    RequiredFieldValidator_equipment_category.Enabled = false;
                    RangeValidator_equipment_category.Enabled = false;
                    TextBox_make_model.Enabled = false;
                    RequiredFieldValidator_make_model.Enabled = false;
                    RegularExpressionValidator_make_model.Enabled = false;
                    TextBox_place_kept.Enabled = false;
                    RequiredFieldValidator_place_kept.Enabled = false;
                    RegularExpressionValidator_place_kept.Enabled = false;
                    RadioButtonList_condition.Enabled = false;
                    RequiredFieldValidator_condition.Enabled = false;
                    TextBox_unit_cost.Enabled = false;
                    RequiredFieldValidator_unit_cost.Enabled = false;
                    RegularExpressionValidator_unit_cost.Enabled = false;
                    TextBox_quantity.Enabled = false;
                    RequiredFieldValidator_quantity.Enabled = false;
                    RegularExpressionValidator_quantity.Enabled = false;
                    TextBox_additional_service_ante.Enabled = false;
                    RegularExpressionValidator_additional_service_ante.Enabled = false;
                    LinkButton_recalculate_1.Visible = false;
                    LinkButton_recalculate_2.Visible = false;
                    LinkButton_recalculate_3.Visible = false;
                    Button_submit_and_repeat.Visible = false;
                    Button_submit_and_stop.Visible = false;
                    Button_update.Visible = false;
                    Button_cancel.Visible = false;
                    TableRow_post_finalization_actions.Visible = true;
                }
                else
                {
                    TableRow_post_finalization_actions.Visible = false;
                }
                Button_withdraw.Enabled = (uint.Parse(Session["status_code"].ToString()) < 11);
                p.db.Close();
            }
        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
        }

        protected void CustomValidator_special_conditions_ServerValidate(object source, System.Web.UI.WebControls.ServerValidateEventArgs args)
        {
            string special_rules_violation;
            args.IsValid = true;
            special_rules_violation = p.biz_equipment.SpecialRulesViolation(Session["service_user_id"].ToString(), Session["emsof_request_master_id"].ToString(), Session["emsof_request_item_priority"].ToString(), k.Safe(DropDownList_equipment_category.SelectedValue, k.safe_hint_type.NUM), k.Safe(TextBox_quantity.Text, k.safe_hint_type.NUM));
            if (special_rules_violation != k.EMPTY)
            {
                args.IsValid = false;
                CustomValidator_special_conditions.ErrorMessage = special_rules_violation;
            }
        }

        private void TWebForm_request_item_detail_PreRender(object sender, System.EventArgs e)
        {
            SessionSet("request_item_detail.p", p);
        }

        protected void Button_withdraw_Click(object sender, System.EventArgs e)
        {
            SessionSet("emsof_request_item_make_model", k.Safe(TextBox_make_model.Text, k.safe_hint_type.MAKE_MODEL));
            SessionSet("emsof_request_item_emsof_ante", k.Safe(Label_emsof_ante.Text, k.safe_hint_type.REAL_NUM));
            SessionSet("emsof_request_item_additional_service_ante", p.saved_additional_service_ante.ToString());
            DropCrumbAndTransferTo("withdraw_request_item.aspx");
        }

        protected void Button_update_Click(object sender, System.EventArgs e)
        {
            Recalculate();
            // Forces setting of additional_service_ante
            if (Page.IsValid)
            {
                p.db.Open();
                // Update the detail record.
                // Update the master record.
                new MySqlCommand(p.db_trail.Saved("START TRANSACTION" + ";" + "update emsof_request_detail" + " set equipment_code = " + k.Safe(DropDownList_equipment_category.SelectedValue, k.safe_hint_type.NUM) + k.COMMA + " make_model = \"" + k.Safe(TextBox_make_model.Text, k.safe_hint_type.MAKE_MODEL) + "\"," + " place_kept = \"" + k.Safe(TextBox_place_kept.Text, k.safe_hint_type.PUNCTUATED) + "\"," + " be_refurbished = " + k.Safe(RadioButtonList_condition.SelectedValue, k.safe_hint_type.NUM) + k.COMMA + " quantity = " + k.Safe(TextBox_quantity.Text, k.safe_hint_type.NUM) + k.COMMA + " unit_cost = " + k.Safe(TextBox_unit_cost.Text, k.safe_hint_type.REAL_NUM) + k.COMMA + " additional_service_ante = " + p.additional_service_ante.ToString() + k.COMMA + " emsof_ante = " + k.Safe(Label_emsof_ante.Text, k.safe_hint_type.REAL_NUM) + " where master_id = " + Session["emsof_request_master_id"].ToString() + " and priority = " + Session["emsof_request_item_priority"].ToString() + ";" + "update emsof_request_master" + " set value = value - " + p.saved_emsof_ante.ToString() + " + " + k.Safe(Label_emsof_ante.Text, k.safe_hint_type.REAL_NUM) + " , shortage = shortage - " + p.saved_additional_service_ante.ToString() + " + " + p.additional_service_ante.ToString() + " where id = " + Session["emsof_request_master_id"].ToString() + ";" + "COMMIT;"), p.db.connection).ExecuteNonQuery();
                p.db.Close();
                BackTrack();
            }
        }

        protected void Button_delete_Click(object sender, System.EventArgs e)
        {
            if (CheckBox_delete.Checked)
            {
                p.db.Open();
                // Delete the detail record.
                // Eliminate the resulting gap in the priority sequence.
                // Update the master record.
                new MySqlCommand(p.db_trail.Saved("START TRANSACTION" + ";" + "delete from emsof_request_detail" + " where master_id = " + Session["emsof_request_master_id"].ToString() + " and priority = " + Session["emsof_request_item_priority"].ToString() + ";" + "update emsof_request_detail set priority = priority - 1" + " where master_id = " + Session["emsof_request_master_id"].ToString() + " and priority > " + Session["emsof_request_item_priority"].ToString() + ";" + "update emsof_request_master" + " set value = value - " + p.saved_emsof_ante.ToString() + " , shortage = shortage - " + p.saved_additional_service_ante.ToString() + " , num_items = num_items - 1" + " where id = " + Session["emsof_request_master_id"].ToString() + ";" + "COMMIT;"), p.db.connection).ExecuteNonQuery();
                p.db.Close();
                BackTrack();
            }
        }

        protected void LinkButton_recalculate_3_Click(object sender, System.EventArgs e)
        {
            Recalculate();
        }

        protected void LinkButton_recalculate_2_Click(object sender, System.EventArgs e)
        {
            Recalculate();
        }

        protected void LinkButton_recalculate_1_Click(object sender, System.EventArgs e)
        {
            Recalculate();
        }

        protected void Button_submit_and_stop_Click(object sender, System.EventArgs e)
        {
            if (Page.IsValid)
            {
                AddItem();
                BackTrack();
            }
        }

        protected void Button_submit_and_repeat_Click(object sender, System.EventArgs e)
        {
            if (Page.IsValid)
            {
                AddItem();
                DropDownList_equipment_category.SelectedIndex =  -1;
                Label_life_expectancy.Text = "";
                TextBox_make_model.Text = "";
                TextBox_place_kept.Text = "";
                RadioButtonList_condition.SelectedIndex =  -1;
                Label_allowable_cost.Text = "";
                TextBox_unit_cost.Text = "";
                TextBox_quantity.Text = "";
                Label_total_cost.Text = "";
                Label_min_service_ante.Text = "";
                TextBox_additional_service_ante.Text = "";
                Label_emsof_ante.Text = "";
            }
        }

        protected void DropDownList_equipment_category_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            ShowDependentData();
        }

        protected void Button_cancel_Click(object sender, System.EventArgs e)
        {
            BackTrack();
        }

        private void Recalculate()
        {
            decimal effective_emsof_ante;
            decimal max_emsof_ante;
            var quantity = new k.decimal_nonnegative();
            decimal total_cost;
            var unit_cost = new k.decimal_nonnegative();
            if ((k.Safe(TextBox_unit_cost.Text, k.safe_hint_type.REAL_NUM) != k.EMPTY) && (k.Safe(TextBox_quantity.Text, k.safe_hint_type.NUM) != k.EMPTY))
            {
                unit_cost.val = decimal.Parse(k.Safe(TextBox_unit_cost.Text, k.safe_hint_type.REAL_NUM));
                quantity.val = decimal.Parse(k.Safe(TextBox_quantity.Text, k.safe_hint_type.NUM));
                if (TextBox_additional_service_ante.Text != k.EMPTY)
                {
                    p.additional_service_ante = decimal.Parse(k.Safe(TextBox_additional_service_ante.Text, k.safe_hint_type.REAL_NUM));
                }
                else
                {
                    p.additional_service_ante = 0;
                }
                total_cost = unit_cost.val * quantity.val;
                Label_total_cost.Text = total_cost.ToString("N2");
                // This is the zebra case where a distressed service wants an item with no specified allowable cost (initially an ambulance
                // or squad/response vehicle).  Basically, they can have whatever they want, up to the limit of the remainder of their
                // appropriation.  Consideration of their appropriation is not within the scope of this form, so we can indicate that the
                // request can be fully funded.
                // This is the case where items in an "equipment category" are always fully funded (up to the limit of a service's
                // appropriation, which is not within the scope of this form).  This initially describes only Data Collection Software and
                // the EMT-P Written Test.  The "Other - with external documentation" category is specifically excluded from this case.
                if ((decimal.Equals(p.match_level,1.00) && (p.allowable_cost == decimal.MaxValue)) || ((unit_cost.val <= p.allowable_cost) && (p.funding_level == p.allowable_cost) && (p.allowable_cost < decimal.MaxValue)))
                {
                    max_emsof_ante = total_cost;
                }
                else
                {
                    if (unit_cost.val > p.allowable_cost)
                    {
                        max_emsof_ante = Math.Max(p.allowable_cost * p.match_level, p.funding_level) * quantity.val;
                    }
                    else
                    {
                        max_emsof_ante = total_cost * p.match_level;
                    }
                }
                // A service may elect not to use the max_emsof_ante.  An example would be when they know that doing so, in the context of all
                // their other request items, would draw more EMSOF funds than they were appropriated.  So account for if they want to ante up
                // more of the cost themselves.
                effective_emsof_ante = max_emsof_ante - p.additional_service_ante;
                Label_emsof_ante.Text = effective_emsof_ante.ToString("N2");
                Label_min_service_ante.Text = (total_cost - max_emsof_ante).ToString("N2");
            }
        }

        private void AddItem()
        {
            string priority_string;
            Recalculate();
            // Forces setting of additional_service_ante
            p.db.Open();
            // Get the number of items entered against this request previously, and initialize this item to have a priority just lower than
            // all previous items.
            priority_string = new MySqlCommand("select (num_items + 1) from emsof_request_master where id = " + Session["emsof_request_master_id"].ToString(), p.db.connection).ExecuteScalar().ToString();
            // Record the new request item.
            // Update the master record.
            new MySqlCommand(p.db_trail.Saved("START TRANSACTION" + ";" + "insert into emsof_request_detail" + " set master_id = " + Session["emsof_request_master_id"].ToString() + k.COMMA + " equipment_code = " + k.Safe(DropDownList_equipment_category.SelectedValue, k.safe_hint_type.NUM) + k.COMMA + " make_model = \"" + k.Safe(TextBox_make_model.Text, k.safe_hint_type.MAKE_MODEL) + "\"," + " place_kept = \"" + k.Safe(TextBox_place_kept.Text, k.safe_hint_type.PUNCTUATED) + "\"," + " be_refurbished = " + k.Safe(RadioButtonList_condition.SelectedValue, k.safe_hint_type.NUM) + k.COMMA + " quantity = " + k.Safe(TextBox_quantity.Text, k.safe_hint_type.NUM) + k.COMMA + " unit_cost = " + k.Safe(TextBox_unit_cost.Text, k.safe_hint_type.REAL_NUM) + k.COMMA + " additional_service_ante = " + p.additional_service_ante.ToString() + k.COMMA + " emsof_ante = " + k.Safe(Label_emsof_ante.Text, k.safe_hint_type.REAL_NUM) + k.COMMA + " priority = " + priority_string + ";" + "update emsof_request_master" + " set status_code = 2," + " value = value + " + k.Safe(Label_emsof_ante.Text, k.safe_hint_type.REAL_NUM) + k.COMMA + " shortage = shortage + " + p.additional_service_ante.ToString() + k.COMMA + " num_items = num_items + 1" + " where id = " + Session["emsof_request_master_id"].ToString() + ";" + "COMMIT;"), p.db.connection).ExecuteNonQuery();
            p.db.Close();
        }

        private void ShowDependentData()
        {
            MySqlDataReader dr_state_details;
            string life_expectancy_string;
            p.db.Open();
            dr_state_details = new MySqlCommand(p.cmdText_get_equipment_category_monetary_details + k.Safe(DropDownList_equipment_category.SelectedValue, k.safe_hint_type.NUM), p.db.connection).ExecuteReader();
            if (dr_state_details.Read())
            {
                life_expectancy_string = dr_state_details["life_expectancy_years"].ToString();
                if (life_expectancy_string != k.EMPTY)
                {
                    Label_life_expectancy.Text = "PA DOH EMSO expects this equipment to last " + life_expectancy_string + " years.";
                    Label_life_expectancy.Font.Bold = true;
                }
                else
                {
                    Label_life_expectancy.Text = "PA DOH EMSO has not specified a life expectancy for this category of equipment.";
                    Label_life_expectancy.Font.Bold = false;
                }
                if (!dr_state_details.IsDBNull((int)(p.dri_equipment_category_allowable_cost)))
                {
                    Label_allowable_cost.Text = decimal.Parse(dr_state_details["allowable_cost"].ToString()).ToString("N2");
                    p.allowable_cost = decimal.Parse(Label_allowable_cost.Text);
                }
                else
                {
                    Label_allowable_cost.Text = "(none specified)";
                    p.allowable_cost = decimal.MaxValue;
                }
                if (!dr_state_details.IsDBNull((int)(p.dri_equipment_category_funding_level)))
                {
                    p.funding_level = decimal.Parse(dr_state_details["funding_level"].ToString());
                }
                else
                {
                    p.funding_level = decimal.MaxValue;
                }
            }
            dr_state_details.Close();
            p.db.Close();
            Recalculate();
        }

        private struct p_type
        {
            public decimal additional_service_ante;
            public decimal allowable_cost;
            public TClass_biz_equipment biz_equipment;
            public uint dri_equipment_category_allowable_cost;
            public uint dri_equipment_category_funding_level;
            public string cmdText_get_equipment_category_monetary_details;
            public TClass_db db;
            public TClass_db_trail db_trail;
            public decimal funding_level;
            public decimal match_level;
            public decimal saved_emsof_ante;
            public decimal saved_additional_service_ante;
        } // end p_type

    } // end TWebForm_request_item_detail

}
