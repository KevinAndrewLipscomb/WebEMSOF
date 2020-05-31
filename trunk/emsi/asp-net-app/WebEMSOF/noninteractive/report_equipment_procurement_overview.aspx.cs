using Class_biz_accounts;
using Class_biz_fiscal_years;
using kix;
using System;
using System.Configuration;
using System.IO;
using System.Text;
using System.Web.UI;
using UserControl_equipment_procurement_overview;

namespace report_equipment_procurement_overview
  {
  public partial class TWebForm_report_equipment_procurement_overview: ki_web_ui.page_class
    {

    private struct p_type
      {
      public TClass_biz_accounts biz_accounts;
      public TClass_biz_fiscal_years biz_fiscal_years;
      }

    private p_type p; // Private Parcel of Page-Pertinent Process-Persistent Parameters

        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            string url;
            Title.InnerText = ConfigurationManager.AppSettings["application_name"] + " - report_equipment_procurement_overview";
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
            Session.Add("mode:report/equipment-procurement-overview", k.EMPTY);
            PlaceHolder_control.Controls.Add(((TWebUserControl_equipment_procurement_overview)(LoadControl("~/usercontrol/app/UserControl_equipment_procurement_overview.ascx"))));

        }

        protected override void Render(HtmlTextWriter writer)
        {
            // Write the HTML stream into a StringBuilder.
            var sb = new StringBuilder();
            using var html_text_writer = new HtmlTextWriter(new StringWriter(sb));
            base.Render(html_text_writer);
            // //
            // writer.Write(sb.ToString());
            // //
            var body = sb.ToString();
            //
            // Send output stream as an email message.
            //
            var region_code = k.Safe(Request["region_code"],k.safe_hint_type.NUM);
            k.SmtpMailSend
              (
              from:ConfigurationManager.AppSettings["sender_email_address"],
              to:p.biz_accounts.EmailTargetByRegionAndRole(region_code,"director") + k.COMMA_SPACE + p.biz_accounts.EmailTargetByRegionAndRole(region_code,"emsof-planner"),
              subject:"Report: Equipment Procurement Overview, " + p.biz_fiscal_years.DesignatorOfCurrent(),
              message_string:body,
              be_html:true
              );
            Session.Abandon();

        }

    } // end TWebForm_report_equipment_procurement_overview

}
