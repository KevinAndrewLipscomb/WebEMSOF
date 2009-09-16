using Class_biz_appropriations;
using Class_biz_services;
using Class_db;
using Class_db_trail;
using MySql.Data.MySqlClient;
using kix;
using System;
using System.Collections;
using System.ComponentModel;
using System.Configuration;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace create_new_service_appropriation
{
    public class TWebForm_create_new_service_appropriation: ki_web_ui.page_class
    {
        private p_type p;
        protected new System.Web.UI.HtmlControls.HtmlTitle Title = null;
        protected System.Web.UI.WebControls.PlaceHolder PlaceHolder_precontent = null;
        protected System.Web.UI.WebControls.PlaceHolder PlaceHolder_postcontent = null;
        protected System.Web.UI.WebControls.DropDownList DropDownList_services = null;
        protected System.Web.UI.WebControls.RangeValidator RangeValidator_service = null;
        protected System.Web.UI.WebControls.TextBox TextBox_new_amount = null;
        protected System.Web.UI.WebControls.RequiredFieldValidator RequiredFieldValidator_new_amount = null;
        protected System.Web.UI.WebControls.RegularExpressionValidator RegularExpressionValidator_new_amount = null;
        protected System.Web.UI.WebControls.Button Button_add_appropriation_and_repeat = null;
        protected System.Web.UI.WebControls.RequiredFieldValidator RequiredFieldValidator_service = null;
        protected System.Web.UI.WebControls.Button Button_add_appropriation_and_stop = null;
        protected System.Web.UI.WebControls.Button Button_cancel = null;
        protected System.Web.UI.WebControls.CheckBox CheckBox_show_out_of_county_services = null;
        protected System.Web.UI.WebControls.RadioButtonList RadioButtonList_match_level = null;
        protected System.Web.UI.WebControls.Label Label_parent_appropriation_amount = null;
        protected System.Web.UI.WebControls.Label Label_region_name = null;
        protected System.Web.UI.WebControls.Label Label_fiscal_year_designator = null;
        protected System.Web.UI.WebControls.Label Label_sum_of_service_appropriations = null;
        protected System.Web.UI.WebControls.Label Label_unappropriated_amount = null;
        protected System.Web.UI.HtmlControls.HtmlTableRow TableRow_sum_of_service_appropriations = null;
        protected System.Web.UI.HtmlControls.HtmlTableRow TableRow_unappropriated_amount = null;
        protected System.Web.UI.WebControls.CustomValidator CustomValidator_amount = null;
        protected System.Web.UI.UpdatePanel UpdatePanel_control = null;
        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            this.DropDownList_services.SelectedIndexChanged += new System.EventHandler(this.DropDownList_services_SelectedIndexChanged);
            this.CheckBox_show_out_of_county_services.CheckedChanged += new System.EventHandler(this.CheckBox_unfilter_CheckedChanged);
            this.CustomValidator_amount.ServerValidate += new System.Web.UI.WebControls.ServerValidateEventHandler(this.CustomValidator_amount_ServerValidate);
            this.Button_add_appropriation_and_repeat.Click += new System.EventHandler(this.Button_add_appropriation_and_repeat_Click);
            this.Button_add_appropriation_and_stop.Click += new System.EventHandler(this.Button_add_appropriation_and_stop_Click);
            this.Button_cancel.Click += new System.EventHandler(this.Button_cancel_Click);
            this.PreRender += this.TWebForm_create_new_service_appropriation_PreRender;
            this.Load += this.Page_Load;
        }

        private void Page_Load(object sender, System.EventArgs e)
        {
            if (IsPostBack)
            {
                if ((Session["create_new_service_appropriation.p"] != null))
                {
                    p = (p_type)(Session["create_new_service_appropriation.p"]);
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
                Title.Text = Server.HtmlEncode(ConfigurationManager.AppSettings["application_name"]) + " - create_new_service_appropriation";
                // Initialize implementation-scoped variables.
                p.amount = 0;
                p.db = new TClass_db();
                p.db_trail = new TClass_db_trail();
                Label_parent_appropriation_amount.Text = decimal.Parse(Session["parent_appropriation_amount"].ToString()).ToString("C");
                Label_region_name.Text = Session["region_name"].ToString();
                Label_fiscal_year_designator.Text = Session["fiscal_year_designator"].ToString();
                Label_sum_of_service_appropriations.Text = decimal.Parse(Session["sum_of_service_appropriations"].ToString()).ToString("C");
                p.unappropriated_amount = (decimal)(Session["unappropriated_amount"]);
                Label_unappropriated_amount.Text = p.unappropriated_amount.ToString("C");
                if (p.unappropriated_amount < 0)
                {
                    Label_unappropriated_amount.Font.Bold = true;
                    Label_unappropriated_amount.ForeColor = Color.Red;
                }
                p.biz_appropriations = new TClass_biz_appropriations();
                p.biz_services = new TClass_biz_services();
                p.biz_services.BindListControl(Session["county_user_id"].ToString(), DropDownList_services, CheckBox_show_out_of_county_services.Checked);
                p.match_level_id_of_region_dictum = p.biz_appropriations.MatchLevelIdOfRegionDictum(Session["region_dictated_appropriation_id"].ToString()).ToString();
                RadioButtonList_match_level.SelectedValue = p.match_level_id_of_region_dictum;
            }
            ScriptManager.GetCurrent(Page).RegisterPostBackControl(Button_add_appropriation_and_repeat);
            ScriptManager.GetCurrent(Page).RegisterPostBackControl(Button_add_appropriation_and_stop);
            ScriptManager.GetCurrent(Page).RegisterPostBackControl(Button_cancel);

        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
        }

        private void DropDownList_services_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            if (p.biz_services.BeDistressed(k.Safe(DropDownList_services.SelectedValue, k.safe_hint_type.NUM)))
            {
                RadioButtonList_match_level.SelectedValue = "3";
            }
            else
            {
                RadioButtonList_match_level.SelectedValue = p.match_level_id_of_region_dictum;
            }
        }

        private void TWebForm_create_new_service_appropriation_PreRender(object sender, System.EventArgs e)
        {
            SessionSet("create_new_service_appropriation.p", p);
        }

        private void CustomValidator_amount_ServerValidate(object source, System.Web.UI.WebControls.ServerValidateEventArgs args)
        {
            string amount_string;
            amount_string = k.Safe(args.Value, k.safe_hint_type.REAL_NUM);
            if (amount_string == k.EMPTY)
            {
                args.IsValid = false;
            }
            else
            {
                p.amount = decimal.Parse(amount_string);
                args.IsValid = (p.amount > 0) && (p.amount <= p.unappropriated_amount);
            }
        }

        private void CheckBox_unfilter_CheckedChanged(object sender, System.EventArgs e)
        {
            p.biz_services.BindListControl(Session["county_user_id"].ToString(), DropDownList_services, CheckBox_show_out_of_county_services.Checked);
        }

        private void Button_add_appropriation_and_stop_Click(object sender, System.EventArgs e)
        {
            if (Page.IsValid)
            {
                AddAppropriation();
                BackTrack();
            }
            else
            {
                ValidationAlert();
            }
        }

        private void Button_cancel_Click(object sender, System.EventArgs e)
        {
            BackTrack();
        }

        private void Button_add_appropriation_and_repeat_Click(object sender, System.EventArgs e)
        {
            if (Page.IsValid)
            {
                AddAppropriation();
                TextBox_new_amount.Text = k.EMPTY;
                DropDownList_services.SelectedIndex =  -1;
                // Update labels in the Parent appropriation section.
                Label_sum_of_service_appropriations.Text = (decimal.Parse(k.Safe(Label_sum_of_service_appropriations.Text, k.safe_hint_type.REAL_NUM)) + p.amount).ToString("C");
                p.unappropriated_amount = p.unappropriated_amount - p.amount;
                Label_unappropriated_amount.Text = p.unappropriated_amount.ToString("C");
                if (p.unappropriated_amount < 0)
                {
                    Label_unappropriated_amount.Font.Bold = true;
                    Label_unappropriated_amount.ForeColor = Color.Red;
                }
            }
        }

        private void AddAppropriation()
        {
            MySqlCommand mysql_get_fy_designator;
            MySqlCommand mysql_get_service_email_address;
            string cc_email_address;
            string max_county_dictated_appropriation_id_string;
            string messageText;
            string service_id_string;
            service_id_string = k.Safe(DropDownList_services.SelectedValue, k.safe_hint_type.NUM);
            p.db.Open();
            // Record the new appropriation.
            new MySqlCommand(p.db_trail.Saved("insert into county_dictated_appropriation" + " set region_dictated_appropriation_id = " + Session["region_dictated_appropriation_id"].ToString() + k.COMMA + " service_id = " + service_id_string + k.COMMA + " amount = " + p.amount.ToString() + k.COMMA + " match_level_id = " + k.Safe(RadioButtonList_match_level.SelectedValue, k.safe_hint_type.NUM)), p.db.connection).ExecuteNonQuery();
            // Initialize a new emsof_request_master record, since at this time there must be a one-to-one relationship between a county-
            // dictated appropriation and an EMSOF request.
            // Get max(county_dictated_appropriation.id), which must be the id of the county_dictated_appropriation record that we just
            // inserted.
            max_county_dictated_appropriation_id_string = new MySqlCommand("select max(id) from county_dictated_appropriation", p.db.connection).ExecuteScalar().ToString();
            // Insert and link back to the above max id.
            new MySqlCommand(p.db_trail.Saved("insert into emsof_request_master set county_dictated_appropriation_id = " + max_county_dictated_appropriation_id_string), p.db.connection).ExecuteNonQuery();
            // Send notice of the appropriation to the service's email address of record.
            // Set up the command to get service's email address of record.
            mysql_get_service_email_address = new MySqlCommand("select password_reset_email_address from service_user " + "where id = " + service_id_string, p.db.connection);
            // Set up the command to get the appropriate fiscal year designator.
            mysql_get_fy_designator = new MySqlCommand("select designator" + " from fiscal_year" + " join state_dictated_appropriation on (state_dictated_appropriation.fiscal_year_id=fiscal_year.id)" + " join region_dictated_appropriation" + " on (region_dictated_appropriation.state_dictated_appropriation_id=state_dictated_appropriation.id)" + " where region_dictated_appropriation.id = " + Session["region_dictated_appropriation_id"].ToString(), p.db.connection);
            // Set up the command to get the County Coorindator's email address.
            cc_email_address = new MySqlCommand("select password_reset_email_address from county_user where id = " + Session["county_user_id"].ToString(), p.db.connection).ExecuteScalar().ToString();
            // Set up the messageText.
            messageText = "The " + Session["county_name"].ToString() + " County EMSOF Coordinator has made a new EMSOF allocation " + "of " + p.amount.ToString("C") + " to your service for " + mysql_get_fy_designator.ExecuteScalar().ToString() + k.PERIOD + k.NEW_LINE + k.NEW_LINE + "You can work on this allocation by visiting:" + k.NEW_LINE + k.NEW_LINE + "   http://" + ConfigurationManager.AppSettings["host_domain_name"] + "/" + ConfigurationManager.AppSettings["application_name"] + k.NEW_LINE + k.NEW_LINE + "You can contact the " + Session["county_name"].ToString() + " County EMSOF Coordinator at:" + k.NEW_LINE + k.NEW_LINE + "   " + cc_email_address + "  (mailto:" + cc_email_address + ")" + k.NEW_LINE + k.NEW_LINE + "-- " + ConfigurationManager.AppSettings["application_name"];
            // Send the email message.
            // be_html
            // cc
            // bcc
            // reply_to
            k.SmtpMailSend(ConfigurationManager.AppSettings["sender_email_address"], mysql_get_service_email_address.ExecuteScalar().ToString(), "New " + ConfigurationManager.AppSettings["application_name"] + " allocation for your service", messageText, false, k.EMPTY, k.EMPTY, cc_email_address);
            p.db.Close();
        }

        private struct p_type
        {
            public decimal amount;
            public TClass_biz_appropriations biz_appropriations;
            public TClass_biz_services biz_services;
            public TClass_db db;
            public TClass_db_trail db_trail;
            public string match_level_id_of_region_dictum;
            public decimal unappropriated_amount;
        } // end p_type

    } // end TWebForm_create_new_service_appropriation

}
