using Class_biz_accounts;
using Class_biz_fiscal_years;
using kix;
using System;
using System.Configuration;
using System.IO;
using System.Text;
using System.Web.UI;
using UserControl_fy_allocations_reimbursements_returns;

namespace report_fy_allocations_reimbursements_nonspends
{
    public struct p_type
    {
        public TClass_biz_accounts biz_accounts;
        public TClass_biz_fiscal_years biz_fiscal_years;
    } // end p_type

    public partial class TWebForm_report_fy_allocations_reimbursements_nonspends: ki_web_ui.page_class
    {
        private p_type p;
        protected System.Web.UI.WebControls.Label Label_application_name_2 = null;
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
            string url;
            Title = ConfigurationManager.AppSettings["application_name"] + " - report_fy_allocations_reimbursements_nonspends";
            Label_application_name_1.Text = ConfigurationManager.AppSettings["application_name"];
            url = "http://" + ConfigurationManager.AppSettings["host_domain_name"] + "/" + ConfigurationManager.AppSettings["application_name"];
            HyperLink_web_site.Text = url;
            HyperLink_web_site.NavigateUrl = url;

        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
            p.biz_accounts = new TClass_biz_accounts();
            p.biz_fiscal_years = new TClass_biz_fiscal_years();
            // Set session objects referenced by UserControl_roster.
            Session.Add("mode:report", k.EMPTY);
            Session.Add("mode:report/allocations-reimbursements-nonspends", k.EMPTY);
            PlaceHolder_control.Controls.Add(((TWebUserControl_fy_allocations_reimbursements_returns)(LoadControl("~/usercontrol/app/UserControl_fy_allocations_reimbursements_returns.ascx"))));

        }

        protected override void Render(HtmlTextWriter writer)
        {
            string body;
            StringBuilder sb;
            // Write the HTML stream into a StringBuilder.
            sb = new StringBuilder();
            base.Render(new HtmlTextWriter(new StringWriter(sb)));
            // //
            // writer.Write(sb.ToString());
            // //
            body = sb.ToString();
            // Send output stream as an email message.
            // from
            // to
            // subject
            // body
            // be_html
            k.SmtpMailSend(ConfigurationManager.AppSettings["sender_email_address"], p.biz_accounts.EmailTargetByRole("director") + k.COMMA_SPACE + p.biz_accounts.EmailTargetByRole("emsof-planner"), "Report: Allocations-Reimbursements-Nonspends, " + p.biz_fiscal_years.DesignatorOfCurrent(), body, true);
            Session.Abandon();

        }

    } // end TWebForm_report_fy_allocations_reimbursements_nonspends

}
