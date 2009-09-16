using System.Configuration;


using System;
using System.Collections;
using System.ComponentModel;
using System.Web;
using System.Web.SessionState;

using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;



namespace regional_staffer_overview
{
    public partial class TWebForm_regional_staffer_overview: ki_web_ui.page_class
    {
        protected System.Web.UI.WebControls.PlaceHolder PlaceHolder_precontent = null;
        protected System.Web.UI.WebControls.PlaceHolder PlaceHolder_postcontent = null;
        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            this.Load += this.Page_Load;
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (!IsPostBack)
            {
                if ((Session["regional_staffer_name"] == null) || (Session["regional_staffer_user_id"] == null))
                {
                    Session.Clear();
                    DropCrumbAndTransferTo("~/login.aspx");
                }
                Title.Text = Server.HtmlEncode(ConfigurationManager.AppSettings["application_name"]) + " - regional_staffer_overview";
                BeginBreadCrumbTrail();
            }
        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
        }

    } // end TWebForm_regional_staffer_overview

}
