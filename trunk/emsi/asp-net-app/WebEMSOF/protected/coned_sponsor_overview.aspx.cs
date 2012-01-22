using System;
using System.Configuration;

namespace coned_sponsor_overview
{
    public partial class TWebForm_coned_sponsor_overview: ki_web_ui.page_class
    {

      private void InitializeComponent()
        {
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (!IsPostBack)
            {
                if ((Session["coned_sponsor_name"] == null) || (Session["coned_sponsor_user_id"] == null))
                {
                    Session.Clear();
                    DropCrumbAndTransferTo("~/login.aspx");
                }
                Title = Server.HtmlEncode(ConfigurationManager.AppSettings["application_name"]) + " - coned_sponsor_overview";
                BeginBreadCrumbTrail();
            }
        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
        }

    } // end TWebForm_coned_sponsor_overview

}
