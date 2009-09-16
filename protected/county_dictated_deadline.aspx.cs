using System.Configuration;


using System;
using System.Collections;
using System.ComponentModel;
using System.Web;
using System.Web.SessionState;

using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;


using Class_db;
using Class_biz_appropriations;
using Class_biz_emsof_requests;
namespace county_dictated_deadline
{
    public struct p_type
    {
        public TClass_biz_appropriations biz_appropriations;
        public TClass_biz_emsof_requests biz_emsof_requests;
        public TClass_db db;
    } // end p_type

    public partial class TWebForm_county_dictated_deadline: ki_web_ui.page_class
    {
        private p_type p;
        protected System.Web.UI.WebControls.PlaceHolder PlaceHolder_precontent = null;
        protected System.Web.UI.WebControls.PlaceHolder PlaceHolder_postcontent = null;
        protected System.Web.UI.WebControls.LinkButton LinkButton_county_dictated_appropriations = null;
        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            this.Load += this.Page_Load;
            this.PreRender += this.TWebForm_county_dictated_deadline_PreRender;
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (IsPostBack)
            {
                if ((Session["county_dictated_deadline.p"] != null))
                {
                    p = (p_type)(Session["county_dictated_deadline.p"]);
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
                Title.InnerText = Server.HtmlEncode(ConfigurationManager.AppSettings["application_name"]) + " - county_dictated_deadline";
                p.biz_appropriations = new TClass_biz_appropriations();
                p.biz_emsof_requests = new TClass_biz_emsof_requests();
                p.db = new TClass_db();
                Label_current_deadline.Text = Session["county_dictated_deadline"].ToString();
                Calendar.SelectedDate = DateTime.Parse(Session["county_dictated_deadline"].ToString());
                Calendar.VisibleDate = DateTime.Parse(Session["county_dictated_deadline"].ToString());
            }
        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
        }

        private void TWebForm_county_dictated_deadline_PreRender(object sender, System.EventArgs e)
        {
            SessionSet("county_dictated_deadline.p", p);
        }

        protected void LinkButton_cancel_Click(object sender, System.EventArgs e)
        {
            BackTrack();
        }

        protected void Calendar_SelectionChanged(object sender, System.EventArgs e)
        {
            p.biz_appropriations.SetServiceToCountySubmissionDeadline(Session["region_dictated_appropriation_id"].ToString(), Calendar.SelectedDate);
            if ((DateTime.Parse(Session["county_dictated_deadline"].ToString()) < DateTime.Now) && ((Calendar.SelectedDate + TimeSpan.Parse("23:59:59")) > DateTime.Now) && p.biz_emsof_requests.BeRequestsEligibleForUnrejectionByRegionDictatedAppropriation(Session["region_dictated_appropriation_id"].ToString()))
            {
                DropCrumbAndTransferTo("county_unrejection.aspx");
            }
            else
            {
                BackTrack();
            }
        }

    } // end TWebForm_county_dictated_deadline

}

namespace county_dictated_deadline.Units
{
    public class county_dictated_deadline
    {
        public const string ID = "$Id: county_dictated_deadline.pas 2492 2008-08-13 00:23:10Z kevinanlipscomb $";
    } // end county_dictated_deadline

}

