using Class_db;
using kix;
using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Web.UI.WebControls;

namespace regional_staffer_fiscal_year_selection
  {
  public partial class TWebForm_regional_staffer_fiscal_year_selection: ki_web_ui.page_class
    {

    private struct p_type
      {
      public TClass_db db;
      }

    private p_type p; // Private Parcel of Page-Pertinent Process-Persistent Parameters

        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            PreRender += TWebForm_regional_staffer_fiscal_year_selection_PreRender;
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            Title = Server.HtmlEncode(ConfigurationManager.AppSettings["application_name"]) + " - account_overview";
            MySqlDataReader dr;
            string regional_staffer_user_email_address;
            string max_fiscal_year_id_string;
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
                p.db = new TClass_db();
                p.db.Open();
                using var mysql_command_1 = new MySqlCommand("SELECT be_stale_password, password_reset_email_address FROM regional_staffer_user" + " where id = " + Session["regional_staffer_user_id"].ToString(), p.db.connection);
                dr = mysql_command_1.ExecuteReader();
                dr.Read();
                if (dr["be_stale_password"].ToString() == "0")
                {
                    // Get anything else needed from this reader, then close it.  We have another reader to open, and only one can be open at a
                    // time.
                    regional_staffer_user_email_address = dr["password_reset_email_address"].ToString();
                    dr.Close();
                    // Where we go next depends on how many appropriations have been made to this county.
                    // Determine current fiscal year
                    using var mysql_command_2 = new MySqlCommand("SELECT max(id) as max_id FROM fiscal_year", p.db.connection);
                    max_fiscal_year_id_string = mysql_command_2.ExecuteScalar().ToString();
                    using var mysql_command_3 = new MySqlCommand("SELECT state_dictated_appropriation.id," + " concat(designator,\"  ($\",format(state_dictated_appropriation.amount,2),\" from PA DOH EMSO)\")" + " as appropriation_description" + " FROM state_dictated_appropriation" + " JOIN fiscal_year on (fiscal_year.id = fiscal_year_id)" + " JOIN regional_staffer on (regional_staffer.region_code=state_dictated_appropriation.region_code)" + " WHERE regional_staffer.id = " + Session["regional_staffer_user_id"].ToString() + " and fiscal_year_id >= (" + max_fiscal_year_id_string + " - 1)", p.db.connection);
                    dr = mysql_command_3.ExecuteReader();
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
                        // Add the regional staffer's email address to the session, as it will be needed by region_dictated_appropriations however
                        // we get there.
                        SessionSet("regional_staffer_user_password_reset_email_address", regional_staffer_user_email_address);
                        if (RadioButtonList_appropriation.Items.Count == 1)
                        {
                            SessionSet("state_dictated_appropriation_id", dr["id"].ToString());
                            DropCrumbAndTransferTo("regional_compliance_check_overview.aspx");
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
        }

        private void TWebForm_regional_staffer_fiscal_year_selection_PreRender(object sender, System.EventArgs e)
        {
            SessionSet(InstanceId() + ".p", p);
        }

        protected void Button_continue_Click(object sender, System.EventArgs e)
        {
            SessionSet("state_dictated_appropriation_id", k.Safe(RadioButtonList_appropriation.SelectedValue, k.safe_hint_type.NUM));
            DropCrumbAndTransferTo("regional_compliance_check_overview.aspx");
        }

    } // end TWebForm_regional_staffer_fiscal_year_selection

}

namespace regional_staffer_fiscal_year_selection.Units
  {
  public class regional_staffer_fiscal_year_selection
    {
        public const string ID = "$Id: regional_staffer_fiscal_year_selection.pas 2492 2008-08-13 00:23:10Z kevinanlipscomb $";
    } // end regional_staffer_fiscal_year_selection

}

