// Derived from template~protected~nonlanding.aspx.cs~template

using Class_biz_counties;
using Class_biz_match_level;
using kix;
using System;
using System.Collections;
using System.ComponentModel;
using System.Configuration;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace county_detail
  {
  public struct p_type
    {
    public TClass_biz_counties biz_counties;
    public TClass_biz_match_level biz_match_level;
    }

  public partial class TWebForm_county_detail: ki_web_ui.page_class
    {
    private p_type p;

    // / <summary>
    // / Required method for Designer support -- do not modify
    // / the contents of this method with the code editor.
    // / </summary>
    private void InitializeComponent()
      {
      //this.Load += this.Page_Load;
      this.PreRender += this.TWebForm_county_detail_PreRender;
      }

    protected void Page_Load(object sender, System.EventArgs e)
      {
      if (!IsPostBack)
        {
        Title = Server.HtmlEncode(ConfigurationManager.AppSettings["application_name"]) + " - county_detail";
        Literal_county_name.Text = p.biz_counties.NameOfSummary(Session["county_summary"]);
        TextBox_email_address.Text = p.biz_counties.EmailAddressOfSummary(Session["county_summary"]);
        p.biz_match_level.BindDirectToListControl(DropDownList_default_match_level,k.EMPTY,p.biz_counties.DefaultMatchLevelIdOfSummary(Session["county_summary"]));
        }
      }

    protected override void OnInit(EventArgs e)
      {
      // Required for Designer support
      InitializeComponent();
      base.OnInit(e);
      var nature_of_visit = NatureOfVisit(InstanceId() + ".p");
      if (nature_of_visit == nature_of_visit_type.VISIT_INITIAL)
        {
        //
        // Initialize p.~ objects here.
        //
        p.biz_counties = new TClass_biz_counties();
        p.biz_match_level = new TClass_biz_match_level();
        }
      else if (nature_of_visit == nature_of_visit_type.VISIT_POSTBACK_STANDARD)
        {
        p = (p_type)(Session[InstanceId() + ".p"]);
        }
      }

    private void TWebForm_county_detail_PreRender(object sender, System.EventArgs e)
      {
      SessionSet(InstanceId() + ".p", p);
      }

    protected void CustomValidator_email_address_ServerValidate(object source, ServerValidateEventArgs args)
      {
      args.IsValid = k.BeValidDomainPartOfEmailAddress(k.Safe(TextBox_email_address.Text,k.safe_hint_type.EMAIL_ADDRESS));
      }

    protected void Button_cancel_Click(object sender, EventArgs e)
      {
      BackTrack();
      }

    protected void Button_submit_Click(object sender, EventArgs e)
      {
      if (IsValid)
        {
        p.biz_counties.Set(p.biz_counties.CodeOfSummary(Session["county_summary"]),k.Safe(TextBox_email_address.Text,k.safe_hint_type.EMAIL_ADDRESS),k.Safe(DropDownList_default_match_level.SelectedValue,k.safe_hint_type.NUM));
        BackTrack();
        }
      }

    } // end TWebForm_county_detail

  }
