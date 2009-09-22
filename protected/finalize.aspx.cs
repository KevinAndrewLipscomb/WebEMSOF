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



using Class_db;
using Class_biz_accounts;
using Class_biz_appropriations;
using Class_biz_emsof_requests;
using Class_biz_fiscal_years;
namespace finalize
{
    public partial class TWebForm_finalize: ki_web_ui.page_class
    {
        private p_type p;
        protected System.Web.UI.WebControls.PlaceHolder PlaceHolder_precontent = null;
        protected System.Web.UI.WebControls.PlaceHolder PlaceHolder_postcontent = null;
        protected System.Web.UI.WebControls.LinkButton LinkButton_request_overview_00 = null;
        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            this.PreRender += this.TWebForm_finalize_PreRender;
            //this.Load += this.Page_Load;
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            MySqlDataReader dr;
            TClass_biz_fiscal_years biz_fiscal_years;
            decimal grand_total_cost;
            object grand_total_cost_obj;
            decimal max_reimbursement;
            if (IsPostBack)
            {
                if ((Session["finalize.p"] != null))
                {
                    p = (p_type)(Session["finalize.p"]);
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
                Title.InnerText = Server.HtmlEncode(ConfigurationManager.AppSettings["application_name"]) + " - finalize";
                biz_fiscal_years = new TClass_biz_fiscal_years();
                p.db = new TClass_db();
                if ((decimal)(Session["unused_amount"]) >= 0)
                {
                    Table_sorry.Visible = false;
                    if ((decimal)(Session["unused_amount"]) == 0)
                    {
                        ListItem_remainder_goes_to_region.Visible = false;
                    }
                    else
                    {
                        Label_unused_amount.Text = ((decimal)(Session["unused_amount"])).ToString("C");
                    }
                    p.db.Open();
                    // Set Label_grand_total_cost.
                    grand_total_cost_obj = new MySqlCommand("select sum(unit_cost*quantity) from emsof_request_detail" + " where master_id = " + Session["emsof_request_master_id"].ToString(), p.db.connection).ExecuteScalar();
                    if (grand_total_cost_obj == DBNull.Value)
                    {
                        grand_total_cost = 0;
                    }
                    else
                    {
                        grand_total_cost = (decimal)(grand_total_cost_obj);
                    }
                    Label_grand_total_cost.Text = grand_total_cost.ToString("C");
                    // Set Label_max_reimbursement.
                    max_reimbursement = (decimal)(Session["sum_of_emsof_antes"]);
                    Label_max_reimbursement_1.Text = max_reimbursement.ToString("C");
                    Label_max_reimbursement_2.Text = Label_max_reimbursement_1.Text;
                    // Set Label_unreimbursed_amount.
                    Label_unreimbursed_amount.Text = (grand_total_cost - max_reimbursement).ToString("C");
                    // Set Label_deadline_*
                    dr = new MySqlCommand("select value as emsof_service_purchase_completion_deadline" + " from fy_calendar" + " join milestone_code_name_map on (milestone_code_name_map.code=fy_calendar.milestone_code)" + " where name = \"emsof-service-purchase-completion-deadline\"" + "   and fiscal_year_id = " + biz_fiscal_years.IdOfCurrent(), p.db.connection).ExecuteReader();
                    dr.Read();
                    Label_deadline_purchase_completion.Text = DateTime.Parse(dr["emsof_service_purchase_completion_deadline"].ToString()).ToString("HH:mm:ss dddd, MMMM dd, yyyy");
                    dr.Close();
                    dr = new MySqlCommand("select value as emsof_service_invoice_submission_deadline" + " from fy_calendar" + " join milestone_code_name_map on (milestone_code_name_map.code=fy_calendar.milestone_code)" + " where name = \"emsof-service-invoice-submission-deadline\"" + "   and fiscal_year_id = " + biz_fiscal_years.IdOfCurrent(), p.db.connection).ExecuteReader();
                    dr.Read();
                    Label_deadline_invoice_submission.Text = DateTime.Parse(dr["emsof_service_invoice_submission_deadline"].ToString()).ToString("HH:mm:ss dddd, MMMM dd, yyyy");
                    dr.Close();
                    dr = new MySqlCommand("select value as emsof_service_canceled_check_submission_deadline" + " from fy_calendar" + " join milestone_code_name_map on (milestone_code_name_map.code=fy_calendar.milestone_code)" + " where name = \"emsof-service-canceled-check-submission-deadline\"" + "   and fiscal_year_id = " + biz_fiscal_years.IdOfCurrent(), p.db.connection).ExecuteReader();
                    dr.Read();
                    Label_deadline_canceled_check_submission.Text = DateTime.Parse(dr["emsof_service_canceled_check_submission_deadline"].ToString()).ToString("HH:mm:ss dddd, MMMM dd, yyyy");
                    dr.Close();
                    p.db.Close();
                }
                else
                {
                    Table_summary.Visible = false;
                }
            }
        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
        }

        private void TWebForm_finalize_PreRender(object sender, System.EventArgs e)
        {
            SessionSet("finalize.p", p);
        }

        protected void LinkButton_request_overview_bottom_Click(object sender, System.EventArgs e)
        {
            BackTrack();
        }

        protected void LinkButton_request_overview_10_Click(object sender, System.EventArgs e)
        {
            BackTrack();
        }

        protected void LinkButton_request_overview_9_Click(object sender, System.EventArgs e)
        {
            BackTrack();
        }

        protected void LinkButton_request_overview_8_Click(object sender, System.EventArgs e)
        {
            BackTrack();
        }

        protected void LinkButton_request_overview_7_Click(object sender, System.EventArgs e)
        {
            BackTrack();
        }

        protected void LinkButton_request_overview_6_Click(object sender, System.EventArgs e)
        {
            BackTrack();
        }

        protected void LinkButton_request_overview_5_Click(object sender, System.EventArgs e)
        {
            BackTrack();
        }

        protected void LinkButton_request_overview_4_Click(object sender, System.EventArgs e)
        {
            BackTrack();
        }

        protected void LinkButton_request_overview_3_Click(object sender, System.EventArgs e)
        {
            BackTrack();
        }

        protected void LinkButton_request_overview_2_Click(object sender, System.EventArgs e)
        {
            BackTrack();
        }

        protected void LinkButton_request_overview_1_Click(object sender, System.EventArgs e)
        {
            BackTrack();
        }

        protected void LinkButton_request_overview_0_Click(object sender, System.EventArgs e)
        {
            BackTrack();
        }

        protected void Button_finalize_Click(object sender, System.EventArgs e)
        {
            TClass_biz_accounts biz_accounts;
            string cc_email_address;
            string emsof_request_master_status;
            string service_email_address;
            if (CheckBox_understand_read_only_1.Checked && (((decimal)(Session["unused_amount"]) == 0) || CheckBox_understand_remainder_goes_to_region.Checked) && CheckBox_understand_grand_total_up_front.Checked && CheckBox_understand_max_reimbursement.Checked && CheckBox_understand_anticipated_vs_actual.Checked && CheckBox_understand_unreimbursed_amount.Checked && CheckBox_understand_deadlines.Checked && CheckBox_agree_to_terms_and_conditions.Checked && CheckBox_understand_read_only_2.Checked && CheckBox_understand_wait_for_approval_to_order.Checked)
            {
                // Update database.
                new TClass_biz_emsof_requests().Finalize(Session["emsof_request_master_id"].ToString());
                // Update the appropriate session object.
                emsof_request_master_status = ((status_type)(3)).ToString();
                SessionSet("emsof_request_master_status", emsof_request_master_status);
                // Send notifications to county and regional coordinators.
                biz_accounts = new TClass_biz_accounts();
                service_email_address = biz_accounts.EmailAddressByKindId("service", Session["service_user_id"].ToString());
                cc_email_address = biz_accounts.EmailAddressByKindId("county", new TClass_biz_appropriations().CountyCodeOfCountyDictum(Session["county_dictated_appropriation_id"].ToString()));
                // be_html
                // cc
                // bcc
                // reply_to
                k.SmtpMailSend(ConfigurationManager.AppSettings["sender_email_address"], cc_email_address, Session["service_name"].ToString() + " has finalized its " + ConfigurationManager.AppSettings["application_name"] + " request", Session["service_name"].ToString() + " has finalized its " + ConfigurationManager.AppSettings["application_name"] + " request for " + Session["fiscal_year_designator"].ToString() + k.PERIOD + k.NEW_LINE + k.NEW_LINE + "Please approve or return/reject this request by visiting:" + k.NEW_LINE + k.NEW_LINE + "   http://" + ConfigurationManager.AppSettings["host_domain_name"] + "/" + ConfigurationManager.AppSettings["application_name"] + k.NEW_LINE + k.NEW_LINE + "You can contact the " + Session["service_name"].ToString() + " EMSOF Coordinator at:" + k.NEW_LINE + k.NEW_LINE + "   " + service_email_address + "  (mailto:" + service_email_address + ")" + k.NEW_LINE + k.NEW_LINE + "-- " + ConfigurationManager.AppSettings["application_name"], false, k.EMPTY, k.EMPTY, service_email_address);
                // be_html
                // cc
                // bcc
                // reply_to
                k.SmtpMailSend(ConfigurationManager.AppSettings["sender_email_address"], biz_accounts.EmailTargetByRole("emsof-coordinator"), Session["service_name"].ToString() + " has finalized a " + ConfigurationManager.AppSettings["application_name"] + " request", Session["service_name"].ToString() + " has finalized a " + ConfigurationManager.AppSettings["application_name"] + " request for " + Session["fiscal_year_designator"].ToString() + k.PERIOD + k.NEW_LINE + k.NEW_LINE + "WebEMSOF has forwarded the finalized request to <" + cc_email_address + "> for county approval.  No action is required " + "from you at this time." + k.NEW_LINE + k.NEW_LINE + "You can use WebEMSOF by visiting:" + k.NEW_LINE + k.NEW_LINE + "   http://" + ConfigurationManager.AppSettings["host_domain_name"] + "/" + ConfigurationManager.AppSettings["application_name"] + k.NEW_LINE + k.NEW_LINE + "You can contact the " + Session["service_name"].ToString() + " EMSOF Coordinator at:" + k.NEW_LINE + k.NEW_LINE + "   " + service_email_address + "  (mailto:" + service_email_address + ")" + k.NEW_LINE + k.NEW_LINE + "-- " + ConfigurationManager.AppSettings["application_name"], false, k.EMPTY, k.EMPTY, service_email_address);
                BackTrack();
            }
        }

        private struct p_type
        {
            public TClass_db db;
        } // end p_type

    } // end TWebForm_finalize

}
