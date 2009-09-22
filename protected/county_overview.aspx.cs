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
namespace county_overview
{
    public struct p_type
    {
        public TClass_db db;
    } // end p_type

    public partial class TWebForm_county_overview: ki_web_ui.page_class
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
            this.PreRender += this.TWebForm_county_overview_PreRender;
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            MySqlDataReader dr;
            string county_user_email_address;
            string max_fiscal_year_id_string;
            if (IsPostBack)
            {
                if ((Session["county_overview.p"] != null))
                {
                    p = (p_type)(Session["county_overview.p"]);
                }
                else
                {
                    Server.Transfer("~/timeout.aspx");
                }
            }
            else
            {
                if ((Session["county_user_id"] == null) || (Session["county_name"] == null))
                {
                    Session.Clear();
                    Server.Transfer("~/login.aspx");
                }
                Title.InnerText = ConfigurationManager.AppSettings["application_name"] + " - county_overview";
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
                    // Where we go next depends on how many appropriations have been made to this county.
                    // Determine current fiscal year
                    max_fiscal_year_id_string = new MySqlCommand("SELECT max(id) as max_id FROM fiscal_year", p.db.connection).ExecuteScalar().ToString();
                    dr = new MySqlCommand("SELECT region_dictated_appropriation.id," + " concat(\"$\",format(region_dictated_appropriation.amount,2),\" from the \",name,\" \",designator,\" contract (amendment \",amendment_num,\")\")" + " as appropriation_description" + " FROM region_dictated_appropriation" + " JOIN state_dictated_appropriation on (state_dictated_appropriation.id=state_dictated_appropriation_id)" + " JOIN region_code_name_map on (region_code_name_map.code=region_code)" + " JOIN fiscal_year on (fiscal_year.id = fiscal_year_id)" + " WHERE county_code = " + Session["county_user_id"].ToString() + " and fiscal_year_id = " + max_fiscal_year_id_string, p.db.connection).ExecuteReader();
                    while (dr.Read())
                    {
                        RadioButtonList_appropriation.Items.Add(new ListItem(dr["appropriation_description"].ToString(), dr["id"].ToString()));
                    }
                    dr.Close();
                    p.db.Close();
                    if (RadioButtonList_appropriation.Items.Count == 0)
                    {
                        DropCrumbAndTransferTo("no_appropriation.aspx");
                    }
                    else
                    {
                        // Add the county's email address to the session, as it will be needed by county_dictated_appropriations however we
                        // get there.
                        SessionSet("county_user_password_reset_email_address", county_user_email_address);
                        if (RadioButtonList_appropriation.Items.Count == 1)
                        {
                            SessionSet("region_dictated_appropriation_id", RadioButtonList_appropriation.Items[0].Value);
                            DropCrumbAndTransferTo("county_dictated_appropriations.aspx");
                        }
                    }
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
            BeginBreadCrumbTrail();

        }

        private void TWebForm_county_overview_PreRender(object sender, System.EventArgs e)
        {
            SessionSet("county_overview.p", p);
        }

        protected void Button_continue_Click(object sender, System.EventArgs e)
        {
            SessionSet("region_dictated_appropriation_id", k.Safe(RadioButtonList_appropriation.SelectedValue, k.safe_hint_type.NUM));
            DropCrumbAndTransferTo("county_dictated_appropriations.aspx");
        }

    } // end TWebForm_county_overview

}

namespace county_overview.Units
{
    public class county_overview
    {
        public const string ID = "$Id: county_overview.pas 2492 2008-08-13 00:23:10Z kevinanlipscomb $";
    } // end county_overview

}

