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
using Class_db_trail;
namespace delete_service_appropriation
{
    public partial class TWebForm_delete_service_appropriation: ki_web_ui.page_class
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
            //this.Load += this.Page_Load;
            this.PreRender += this.TWebForm_delete_service_appropriation_PreRender;
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            MySqlDataReader dr;
            string service_name;
            if (IsPostBack)
            {
                if ((Session[InstanceId() + ".p"] != null))
                {
                    p = (p_type)(Session[InstanceId() + ".p"]);
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
                Title.InnerText = Server.HtmlEncode(ConfigurationManager.AppSettings["application_name"]) + " - delete_service_appropriation";
                p.db = new TClass_db();
                p.db_trail = new TClass_db_trail();
                // Set Label_service_name_*.
                service_name = Session["service_name_of_appropriation_selected_for_deletion"].ToString();
                Label_service_name_1.Text = service_name;
                Label_service_name_2.Text = service_name;
                Label_application_name.Text = ConfigurationManager.AppSettings["application_name"];
                // Set appropriation attribute labels.
                p.db.Open();
                dr = new MySqlCommand("select designator,county_dictated_appropriation.amount" + " from county_dictated_appropriation" + " join region_dictated_appropriation" + " on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)" + " join state_dictated_appropriation" + " on (state_dictated_appropriation.id=region_dictated_appropriation.state_dictated_appropriation_id)" + " join fiscal_year on (fiscal_year.id=state_dictated_appropriation.fiscal_year_id)" + " where county_dictated_appropriation.id = " + Session["id_of_appropriation_selected_for_deletion"].ToString(), p.db.connection).ExecuteReader();
                dr.Read();
                Label_fiscal_year.Text = dr["designator"].ToString();
                Label_amount.Text = decimal.Parse(Session["amount_of_appropriation_selected_for_deletion"].ToString()).ToString("C");
                dr.Close();
                p.db.Close();
            }
        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
        }

        private void TWebForm_delete_service_appropriation_PreRender(object sender, System.EventArgs e)
        {
            SessionSet(InstanceId() + ".p", p);
        }

        protected void Button_yes_Click(object sender, System.EventArgs e)
        {
            p.db.Open();
            // Send the notification message.
            // be_html
            // cc
            // bcc
            // reply_to
            k.SmtpMailSend(ConfigurationManager.AppSettings["sender_email_address"], Session["email_address_of_service_of_appropriation_selected_for_deletion"].ToString(), "Deletion of " + ConfigurationManager.AppSettings["application_name"] + " allocation for your service", "The " + Session["county_name"].ToString() + " County EMSOF Coordinator has deleted an EMSOF allocation from your " + "service for " + k.Safe(Label_fiscal_year.Text, k.safe_hint_type.ALPHANUM) + k.PERIOD + k.NEW_LINE + k.NEW_LINE + "NOTE that the equipment request(s) that you had already entered against this allocation were also deleted.  WebEMSOF had " + "made the County Coordinator aware that this would happen." + k.NEW_LINE + k.NEW_LINE + "You can view your allocations by visiting:" + k.NEW_LINE + k.NEW_LINE + "   http://" + ConfigurationManager.AppSettings["host_domain_name"] + "/" + ConfigurationManager.AppSettings["application_name"] + k.NEW_LINE + k.NEW_LINE + "You can contact the " + Session["county_name"].ToString() + " County EMSOF Coordinator at:" + k.NEW_LINE + k.NEW_LINE + "   " + Session["county_user_password_reset_email_address"].ToString() + "  (mailto:" + Session["county_user_password_reset_email_address"].ToString() + ")" + k.NEW_LINE + k.NEW_LINE + "-- " + ConfigurationManager.AppSettings["application_name"], false, k.EMPTY, k.EMPTY, Session["county_user_password_reset_email_address"].ToString());
            new MySqlCommand(p.db_trail.Saved("delete from county_dictated_appropriation where id = " + Session["id_of_appropriation_selected_for_deletion"].ToString()), p.db.connection).ExecuteNonQuery();
            p.db.Close();
            BackTrack();
        }

        protected void Button_no_Click(object sender, System.EventArgs e)
        {
            BackTrack();
        }

        private struct p_type
        {
            public TClass_db db;
            public TClass_db_trail db_trail;
        } // end p_type

    } // end TWebForm_delete_service_appropriation

}
