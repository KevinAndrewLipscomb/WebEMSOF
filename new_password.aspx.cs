using System.Configuration;

using kix;

using System;
using System.Collections;
using System.ComponentModel;
using System.Web;
using System.Web.SessionState;

using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;


using Class_biz_accounts;
namespace new_password
{
    public partial class TWebForm_new_password: ki_web_ui.page_class
    {
        protected System.Web.UI.WebControls.PlaceHolder PlaceHolder_precontent = null;
        protected System.Web.UI.WebControls.PlaceHolder PlaceHolder_postcontent = null;
        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            //this.Load += this.Page_Load;
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            TClass_biz_accounts biz_accounts;
            string email_address;
            string temporary_password;
            if (!IsPostBack)
            {
                if (Request.ServerVariables["URL"] == Request.CurrentExecutionFilePath)
                {
                    Session.Clear();
                    Server.Transfer("~/login.aspx");
                }
                Title = ConfigurationManager.AppSettings["application_name"] + " - new_password";
                biz_accounts = new TClass_biz_accounts();
                Label_user_name.Text = Session[Session["target_user_table"].ToString() + "_name"].ToString();
                if (Session["target_user_table"].ToString() == "county")
                {
                    Label_user_name.Text = Label_user_name.Text + " County";
                }
                // Build a suitably-random password string.
                temporary_password = System.Guid.NewGuid().ToString().Substring(0, 8);
                // Make the password string the service's new temporary password, and set the stale flag to force an immediate password change.
                biz_accounts.SetTemporaryPassword(Session["target_user_table"].ToString(), Session[Session["target_user_table"].ToString() + "_user_id"].ToString(), k.Digest(temporary_password));
                // Send the new password to the service's email address of record.
                email_address = biz_accounts.EmailAddressByKindId(Session["target_user_table"].ToString(), Session[Session["target_user_table"].ToString() + "_user_id"].ToString());
                k.SmtpMailSend(ConfigurationManager.AppSettings["sender_email_address"], email_address, ConfigurationManager.AppSettings["application_name"] + " temp password", "Someone at the host known as " + k.Safe(Request.UserHostName, k.safe_hint_type.HOSTNAME) + " (possibly you) requested a new password for the \"" + Session[Session["target_user_table"].ToString() + "_name"].ToString() + "\" " + Session["target_user_table"].ToString() + " account on the " + ConfigurationManager.AppSettings["application_name"] + " system.  Please log into " + ConfigurationManager.AppSettings["application_name"] + " using the following credentials.  " + "You will receive further instructions at that time." + k.NEW_LINE + k.NEW_LINE + "   " + Session["target_user_table"].ToString() + ":" + k.NEW_LINE + "      " + Session[Session["target_user_table"].ToString() + "_name"].ToString() + k.NEW_LINE + "   password:" + k.NEW_LINE + "      " + temporary_password + k.NEW_LINE + k.NEW_LINE + "You can complete this process by visiting:" + k.NEW_LINE + k.NEW_LINE + "   http://" + ConfigurationManager.AppSettings["host_domain_name"] + "/" + Server.UrlEncode(ConfigurationManager.AppSettings["application_name"]) + k.NEW_LINE + k.NEW_LINE + "-- " + ConfigurationManager.AppSettings["application_name"]);
                // Set Label_email_address.
                Label_email_address.Text = email_address;
            }
        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
        }

    } // end TWebForm_new_password

}

namespace new_password.Units
{
    public class new_password
    {
        public const string ID = "$Id: new_password.pas 2353 2008-06-08 17:28:19Z kevinanlipscomb $";
    } // end new_password

}

