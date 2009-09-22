using System.Configuration;


using System;
using System.Collections;
using System.ComponentModel;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;


namespace responding_services_detail
{
    // Derived from KiAspdotnetFramework/protected/template~protected~nonlanding.pas~template
    public partial class TWebForm_responding_services_detail: ki_web_ui.page_class
    {
        private p_type p;
        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            this.PreRender += this.TWebForm_responding_services_detail_PreRender;
            //this.Load += this.Page_Load;
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (!IsPostBack)
            {
                Title.Text = ConfigurationManager.AppSettings["application_name"] + " - responding_services_detail";
            }
        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
            switch(NatureOfVisit("responding_services_detail.p"))
            {
                case nature_of_visit_type.VISIT_INITIAL:
                    break;
                case nature_of_visit_type.VISIT_POSTBACK_STANDARD:
                    p = (p_type)(Session["responding_services_detail.p"]);
                    break;
            }

        }

        private void TWebForm_responding_services_detail_PreRender(object sender, System.EventArgs e)
        {
            SessionSet("responding_services_detail.p", p);
        }

        private struct p_type
        {
        } // end p_type

    } // end TWebForm_responding_services_detail

}
