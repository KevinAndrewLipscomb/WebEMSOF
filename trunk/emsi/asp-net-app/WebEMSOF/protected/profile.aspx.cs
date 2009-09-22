using System.Configuration;


using System;
using System.Collections;
using System.ComponentModel;
using System.Web;
using System.Web.SessionState;

using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Data.Common;


namespace profile
{
    public partial class TWebForm_profile: ki_web_ui.page_class
    {
        private p_type p;
        protected new System.Web.UI.HtmlControls.HtmlTitle Title = null;
        protected System.Web.UI.WebControls.Label Label_affiliate_num = null;
        protected System.Web.UI.WebControls.TextBox TextBox_service_name = null;
        protected System.Web.UI.WebControls.RequiredFieldValidator RequiredFieldValidator_service_name = null;
        protected System.Web.UI.WebControls.RegularExpressionValidator RegularExpressionValidator_service_name = null;
        protected System.Web.UI.WebControls.CheckBox CheckBox_qrs = null;
        protected System.Web.UI.WebControls.CheckBox CheckBox_bls_amb = null;
        protected System.Web.UI.WebControls.CheckBox CheckBox_als_amb = null;
        protected System.Web.UI.WebControls.CheckBox CheckBox_als_squad = null;
        protected System.Web.UI.WebControls.CheckBox CheckBox_air_amb = null;
        protected System.Web.UI.WebControls.CheckBox CheckBox_rescue = null;
        protected System.Web.UI.WebControls.TextBox TextBox_address_line_1 = null;
        protected System.Web.UI.WebControls.TextBox TextBox_address_line_2 = null;
        protected System.Web.UI.WebControls.RequiredFieldValidator RequiredFieldValidator_address_line_1 = null;
        protected System.Web.UI.WebControls.RegularExpressionValidator RegularExpressionValidator_address_line_1 = null;
        protected System.Web.UI.WebControls.RegularExpressionValidator RegularExpressionValidator_address_line_2 = null;
        protected System.Web.UI.WebControls.TextBox TextBox_city = null;
        protected System.Web.UI.WebControls.RequiredFieldValidator RequiredFieldValidator_city = null;
        protected System.Web.UI.WebControls.RegularExpressionValidator RegularExpressionValidator_city = null;
        protected System.Web.UI.WebControls.TextBox TextBox_zip_code = null;
        protected System.Web.UI.WebControls.RequiredFieldValidator RequiredFieldValidator_zip_code = null;
        protected System.Web.UI.WebControls.RegularExpressionValidator RegularExpressionValidator_zip_code = null;
        protected System.Web.UI.WebControls.TextBox TextBox_federal_tax_id_num = null;
        protected System.Web.UI.WebControls.RequiredFieldValidator RequiredFieldValidator_federal_tax_id_num = null;
        protected System.Web.UI.WebControls.RegularExpressionValidator RegularExpressionValidator_federal_tax_id_num = null;
        protected System.Web.UI.WebControls.TextBox TextBox_contact_person_name = null;
        protected System.Web.UI.WebControls.RequiredFieldValidator RequiredFieldValidator_contact_person_name = null;
        protected System.Web.UI.WebControls.RegularExpressionValidator RegularExpressionValidator_contact_person_name = null;
        protected System.Web.UI.WebControls.TextBox TextBox_contact_person_phone_num = null;
        protected System.Web.UI.WebControls.RequiredFieldValidator RequiredFieldValidator_contact_person_phone_num = null;
        protected System.Web.UI.WebControls.RegularExpressionValidator RegularExpressionValidator_contact_person_phone_num = null;
        protected System.Web.UI.WebControls.Button Button_submit = null;
        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            this.PreRender += this.TWebForm_profile_PreRender;
            //this.Load += this.Page_Load;
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (IsPostBack)
            {
                if ((Session["profile.p"] != null))
                {
                    p = (p_type)(Session["profile.p"]);
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
                Title.Text = ConfigurationManager.AppSettings["application_name"] + " - profile";
            }
        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
        }

        private void TWebForm_profile_PreRender(object sender, System.EventArgs e)
        {
            SessionSet("profile.p", p);
        }

        private struct p_type
        {
        } // end p_type

    } // end TWebForm_profile

}
