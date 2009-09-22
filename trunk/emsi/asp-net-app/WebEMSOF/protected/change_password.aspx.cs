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
namespace change_password
{
    public struct p_type
    {
        public TClass_db db;
        public TClass_db_trail db_trail;
    } // end p_type

    public partial class TWebForm_change_password: ki_web_ui.page_class
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
            this.PreRender += this.TWebForm_change_password_PreRender;
            //this.Load += this.Page_Load;
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (IsPostBack)
            {
                if ((Session["change_password.p"] != null))
                {
                    p = (p_type)(Session["change_password.p"]);
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
                Title.InnerText = ConfigurationManager.AppSettings["application_name"] + " - change_password";
                p.db = new TClass_db();
                p.db_trail = new TClass_db_trail();
            }
        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
        }

        protected void CustomValidator_confirmation_password_ServerValidate(object source, System.Web.UI.WebControls.ServerValidateEventArgs args)
        {
            args.IsValid = (TextBox_nominal_password.Text.Trim() == TextBox_confirmation_password.Text.Trim());
        }

        protected void Button_cancel_Click(object sender, System.EventArgs e)
        {
            BackTrack();
        }

        private void TWebForm_change_password_PreRender(object sender, System.EventArgs e)
        {
            SessionSet("change_password.p", p);
        }

        protected void Button_submit_Click(object sender, System.EventArgs e)
        {
            if (Page.IsValid)
            {
                // Commit the data to the database.
                p.db.Open();
                new MySqlCommand(p.db_trail.Saved("UPDATE " + Session["target_user_table"].ToString() + "_user" + " SET encoded_password = \"" + k.Digest(k.Safe(TextBox_nominal_password.Text.Trim(), k.safe_hint_type.ALPHANUM)) + "\"," + " be_stale_password = FALSE" + " WHERE id = \"" + Session[Session["target_user_table"].ToString() + "_user_id"].ToString() + "\""), p.db.connection).ExecuteNonQuery();
                p.db.Close();
                BackTrack();
            }
            else
            {
                ValidationAlert(true);
            }
        }

    } // end TWebForm_change_password

}

namespace change_password.Units
{
    public class change_password
    {
        public const string ID = "$Id: change_password.pas 2585 2008-09-25 15:17:19Z kevinanlipscomb $";
    } // end change_password

}

