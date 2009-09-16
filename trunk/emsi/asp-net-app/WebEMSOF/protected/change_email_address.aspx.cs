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
namespace change_email_address
{
    public partial class TWebForm_change_email_address: ki_web_ui.page_class
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
            this.PreRender += this.TWebForm_change_email_address_PreRender;
            this.Load += this.Page_Load;
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            string email_address;
            if (IsPostBack)
            {
                if ((Session["change_email_address.p"] != null))
                {
                    p = (p_type)(Session["change_email_address.p"]);
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
                Title.InnerText = ConfigurationManager.AppSettings["application_name"] + " - change_email_address";
                p.db_trail = new TClass_db_trail();
                p.db = new TClass_db();
                p.db.Open();
                // Preload email address fields
                email_address = new MySqlCommand("SELECT password_reset_email_address " + "FROM " + Session["target_user_table"].ToString() + "_user " + "WHERE id = \"" + Session[Session["target_user_table"].ToString() + "_user_id"].ToString() + "\"", p.db.connection).ExecuteScalar().ToString();
                TextBox_nominal_email_address.Text = email_address;
                TextBox_confirmation_email_address.Text = email_address;
                p.db.Close();
            }
        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
        }

        protected void CustomValidator_confirmation_email_address_ServerValidate(object source, System.Web.UI.WebControls.ServerValidateEventArgs args)
        {
            args.IsValid = (TextBox_nominal_email_address.Text.Trim() == TextBox_confirmation_email_address.Text.Trim());
        }

        protected void Button_cancel_Click(object sender, System.EventArgs e)
        {
            BackTrack();
        }

        private void TWebForm_change_email_address_PreRender(object sender, System.EventArgs e)
        {
            SessionSet("change_email_address.p", p);
        }

        protected void CustomValidator_nominal_email_address_ServerValidate(object source, System.Web.UI.WebControls.ServerValidateEventArgs args)
        {
            args.IsValid = k.BeValidDomainPartOfEmailAddress(args.Value);
        }

        protected void Button_submit_Click(object sender, System.EventArgs e)
        {
            if (Page.IsValid)
            {
                p.db.Open();
                // Commit the data to the database.
                new MySqlCommand(p.db_trail.Saved("UPDATE " + Session["target_user_table"].ToString() + "_user" + " SET password_reset_email_address = \"" + k.Safe(TextBox_nominal_email_address.Text.Trim(), k.safe_hint_type.EMAIL_ADDRESS) + "\"" + " WHERE id = \"" + Session[Session["target_user_table"].ToString() + "_user_id"].ToString() + "\""), p.db.connection).ExecuteNonQuery();
                p.db.Close();
                BackTrack();
            }
            else
            {
                ValidationAlert();
            }
        }

        private struct p_type
        {
            public TClass_db db;
            public TClass_db_trail db_trail;
        } // end p_type

    } // end TWebForm_change_email_address

}
