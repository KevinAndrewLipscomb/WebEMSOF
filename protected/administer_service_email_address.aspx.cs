using Class_biz_accounts;
using Class_biz_services;
using Class_db;
using Class_db_trail;
using kix;
using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Web.UI;

namespace administer_service_email_address
{
    public partial class TWebForm_administer_service_email_address: ki_web_ui.page_class
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
            this.PreRender += this.TWebForm_administer_service_email_address_PreRender;
            //this.Load += this.Page_Load;
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            string email_address;
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
                Title = ConfigurationManager.AppSettings["application_name"] + " - administer_service_email_address";
                //
                p.biz_accounts = new TClass_biz_accounts();
                p.biz_services = new TClass_biz_services();
                p.db_trail = new TClass_db_trail();
                p.db = new TClass_db();
                //
                p.service_id = p.biz_services.IdOfAffiliateNum(Session["affiliate_num"].ToString());
                Literal_service_name.Text = p.biz_services.NameOf(p.service_id);
                p.db.Open();
                // Preload email address fields
                email_address = new MySqlCommand("SELECT password_reset_email_address " + "FROM service_user " + "WHERE id = '" + p.service_id + "'", p.db.connection).ExecuteScalar().ToString();
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

        private void TWebForm_administer_service_email_address_PreRender(object sender, System.EventArgs e)
        {
            SessionSet(InstanceId() + ".p", p);
        }

        protected void CustomValidator_nominal_email_address_ServerValidate(object source, System.Web.UI.WebControls.ServerValidateEventArgs args)
        {
            args.IsValid = k.BeValidDomainPartOfEmailAddress(args.Value);
        }

        protected void Button_submit_Click(object sender, System.EventArgs e)
        {
            if (Page.IsValid)
            {
                p.biz_accounts.SetPasswordResetEmailAddress("service",p.service_id,k.Safe(TextBox_nominal_email_address.Text.Trim(), k.safe_hint_type.EMAIL_ADDRESS));
                BackTrack();
            }
            else
            {
                ValidationAlert();
            }
        }

        private struct p_type
        {
            public TClass_biz_accounts biz_accounts;
            public TClass_biz_services biz_services;
            public TClass_db db;
            public TClass_db_trail db_trail;
            public string service_id;
        } // end p_type

    } // end TWebForm_administer_service_email_address

}
