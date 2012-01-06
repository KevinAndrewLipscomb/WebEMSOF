// Derived from KiAspdotnetFramework/UserControl/app/UserControl~coned_sponsor~binder.cs~coned_sponsor

using kix;
using System;
using System.Collections;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using UserControl_about;
using UserControl_class_catalog;
using UserControl_coned_sponsor;

namespace UserControl_coned_sponsor_binder
  {
  public class UserControl_coned_sponsor_binder_Static
    {
    public const int TSSI_MY_PROFILE = 0;
    public const int TSSI_CLASSES = 1;
    public const int TSSI_ABOUT = 2;
    }

  public struct p_type
    {
    public bool be_loaded;
    public string content_id;
    public uint tab_index;
    }

  public partial class TWebUserControl_coned_sponsor_binder: ki_web_ui.usercontrol_class
    {
    private p_type p;

    private void Page_Load(object sender, System.EventArgs e)
      {
      if (!p.be_loaded)
        {
        TabContainer_control.ActiveTabIndex = (int)(p.tab_index);
        p.be_loaded = true;
        }
      }

    protected override void OnInit(System.EventArgs e)
      {
      // Required for Designer support
      InitializeComponent();
      base.OnInit(e);
      if (Session[InstanceId() + ".p"] != null)
        {
        p = (p_type)(Session[InstanceId() + ".p"]);
        p.be_loaded = IsPostBack;
        //
        // Dynamic controls must be re-added on each postback.
        //
        FillPlaceHolder(false);
        }
      else
        {
        p.be_loaded = false;
        p.tab_index = UserControl_coned_sponsor_binder_Static.TSSI_CLASSES;
        FillPlaceHolder(true);
        }
      }

    // / <summary>
    // / Required method for Designer support -- do not modify
    // / the contents of this method with the code editor.
    // / </summary>
    private void InitializeComponent()
      {
      TabContainer_control.ActiveTabChanged += TabContainer_control_ActiveTabChanged;
      PreRender += TWebUserControl_coned_sponsor_binder_PreRender;
      }

    private void TWebUserControl_coned_sponsor_binder_PreRender(object sender, System.EventArgs e)
      {
      //
      // Indicate to children which content control was active on this pass, so that on subsequent passes a child can detect whether or
      // not it is already loaded in the user's browser.
      //
      SessionSet(PlaceHolder_content.ClientID, p.content_id);
      SessionSet(InstanceId() + ".p", p);
      }

    public TWebUserControl_coned_sponsor_binder Fresh()
      {
      Session.Remove(InstanceId() + ".p");
      return this;
      }

    private void TabContainer_control_ActiveTabChanged(object sender, System.EventArgs e)
      {
      p.tab_index = (uint)(TabContainer_control.ActiveTabIndex);
      PlaceHolder_content.Controls.Clear();
      FillPlaceHolder(true);
      }

    private void FillPlaceHolder
      (
      bool be_fresh_control_required,
      string target
      )
      {
      if (p.tab_index == UserControl_coned_sponsor_binder_Static.TSSI_MY_PROFILE)
        {
        var c = ((TWebUserControl_coned_sponsor)(LoadControl("~/usercontrol/app/UserControl_coned_sponsor.ascx")));
        p.content_id = AddIdentifiedControlToPlaceHolder(c,"UserControl_coned_sponsor",PlaceHolder_content,(be_fresh_control_required ? InstanceId() : k.EMPTY));
        c.SetTarget("/coned_sponsor/" + Session["coned_sponsor_user_id"].ToString());
        }
      else if (p.tab_index == UserControl_coned_sponsor_binder_Static.TSSI_CLASSES)
        {
        var c = ((TWebUserControl_class_catalog)(LoadControl("~/usercontrol/app/UserControl_class_catalog.ascx")));
        p.content_id = AddIdentifiedControlToPlaceHolder(c,"UserControl_class_catalog",PlaceHolder_content,(be_fresh_control_required ? InstanceId() : k.EMPTY));
        }
      else if (p.tab_index == UserControl_coned_sponsor_binder_Static.TSSI_ABOUT)
        {
        var c = ((TWebUserControl_about)(LoadControl("~/usercontrol/app/UserControl_about.ascx")));
        p.content_id = AddIdentifiedControlToPlaceHolder(c,"UserControl_about",PlaceHolder_content,(be_fresh_control_required ? InstanceId() : k.EMPTY));
        }
      }
    private void FillPlaceHolder(bool be_fresh_control_required)
      {
      FillPlaceHolder(be_fresh_control_required,k.EMPTY);
      }

    public void SetTarget(string target)
      {
      if (target != k.EMPTY)
        {
        if (target.ToLower().Contains("/profile/"))
          {
          p.tab_index = UserControl_coned_sponsor_binder_Static.TSSI_MY_PROFILE;
          }
        else if (target.ToLower().Contains("/class/"))
          {
          p.tab_index = UserControl_coned_sponsor_binder_Static.TSSI_CLASSES;
          }
        else if (target.ToLower().Contains("/about/"))
          {
          p.tab_index = UserControl_coned_sponsor_binder_Static.TSSI_ABOUT;
          }
        //
        PlaceHolder_content.Controls.Clear();
        FillPlaceHolder(false,target);
        //
        }
      }

    } // end TWebUserControl_coned_sponsor_binder

  }

