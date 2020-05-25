using Class_db;
using kix;
using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Web.UI.WebControls;

namespace county_overview
{
  public partial class TWebForm_county_overview: ki_web_ui.page_class
    {

    private struct p_type
      {
      public TClass_db db;
      }

    private p_type p; // Private Parcel of Page-Pertinent Process-Persistent Parameters

        protected System.Web.UI.WebControls.PlaceHolder PlaceHolder_precontent = null;
        protected System.Web.UI.WebControls.PlaceHolder PlaceHolder_postcontent = null;
        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            PreRender += TWebForm_county_overview_PreRender;
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            MySqlDataReader dr;
            string county_user_email_address;
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
                Title = ConfigurationManager.AppSettings["application_name"] + " - county_overview";
                p.db = new TClass_db();
                p.db.Open();
                dr = new MySqlCommand("SELECT be_stale_password, password_reset_email_address FROM county_user" + " where id = " + Session["county_user_id"].ToString(), p.db.connection).ExecuteReader();
                dr.Read();
                if (dr["be_stale_password"].ToString() == "0")
                {
                    // Get anything else needed from this reader, then close it.  We have another reader to open, and only one can be open at a
                    // time.
                    county_user_email_address = dr["password_reset_email_address"].ToString();
                    dr.Close();
                    // Add the county's email address to the session, as it will be needed by county_dictated_appropriations however we
                    // get there.
                    SessionSet("county_user_password_reset_email_address", county_user_email_address);
                }
                else
                {
                    dr.Close();
                    p.db.Close();
                    DropCrumbAndTransferTo("change_password.aspx");
                }
            }
        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
            //
            // When NullReferenceException happens during a Page_Load and the Session is empty, it's because this kind of logic is being checked too late, in the Page_Load, rather than in the OnInit.
            //
            if ((Session["county_user_id"] == null) || (Session["county_name"] == null))
              {
              Session.Clear();
              Server.Transfer("~/login.aspx");
              }
            BeginBreadCrumbTrail();

        }

        private void TWebForm_county_overview_PreRender(object sender, System.EventArgs e)
        {
            SessionSet(InstanceId() + ".p", p);
        }

    } // end TWebForm_county_overview

}
