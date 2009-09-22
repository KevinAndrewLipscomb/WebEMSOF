using AjaxControlToolkit;


using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Collections;

using UserControl_annual_cycle_setup;
using UserControl_new_service;
namespace UserControl_regional_staffer_new_binder
{
    public partial class TWebUserControl_regional_staffer_new_binder: ki_web_ui.usercontrol_class
    {
        private p_type p;
        // TSSI_2 = 2;
        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (!p.be_loaded)
            {
                TabContainer_control.ActiveTabIndex = (int)(p.tab_index);
                TabPanel_annual_cycle.Enabled = HttpContext.Current.User.IsInRole("director") || HttpContext.Current.User.IsInRole("emsof-coordinator");
                TabPanel_service.Enabled = HttpContext.Current.User.IsInRole("director") || HttpContext.Current.User.IsInRole("emsof-coordinator");
                p.be_loaded = true;
            }

        }

        protected override void OnInit(System.EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
            if (Session["UserControl_regional_staffer_new_binder.p"] != null)
            {
                p = (p_type)(Session["UserControl_regional_staffer_new_binder.p"]);
                p.be_loaded = IsPostBack && ((Session["UserControl_regional_staffer_binder_control_PlaceHolder_content"] as string) == "UserControl_regional_staffer_new_binder");
                if ((Session["UserControl_regional_staffer_new_binder_selected_tab"] != null))
                {
                    p.tab_index = (uint)(Session["UserControl_regional_staffer_new_binder_selected_tab"].GetHashCode());
                    Session.Remove("UserControl_regional_staffer_new_binder_selected_tab");
                }
                switch(p.tab_index)
                {
                    case Units.UserControl_regional_staffer_new_binder.TSSI_ANNUAL_CYCLE:
                        // Dynamic controls must be re-added on each postback.
                        p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_annual_cycle_setup)(LoadControl("~/usercontrol/app/UserControl_annual_cycle_setup.ascx"))), "UserControl_annual_cycle_setup", PlaceHolder_content);
                        break;
                    case Units.UserControl_regional_staffer_new_binder.TSSI_SERVICE:
                        p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_new_service)(LoadControl("~/usercontrol/app/UserControl_new_service.ascx"))), "UserControl_new_service", PlaceHolder_content);
                        break;
                // TSSI_2:
                // p.content_id := AddIdentifiedControlToPlaceHolder
                // (
                // TWebUserControl3(LoadControl('~/usercontrol/app/UserControl3.ascx')),
                // 'UserControl3',
                // PlaceHolder_content
                // );
                }
            }
            else
            {
                p.be_loaded = false;
                p.tab_index = Units.UserControl_regional_staffer_new_binder.TSSI_ANNUAL_CYCLE;
                p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_annual_cycle_setup)(LoadControl("~/usercontrol/app/UserControl_annual_cycle_setup.ascx"))).Fresh(), "UserControl_annual_cycle_setup", PlaceHolder_content);
            }

        }

        private void TabContainer_control_ActiveTabChanged(object sender, System.EventArgs e)
        {
            p.tab_index = (uint)(TabContainer_control.ActiveTabIndex);
            PlaceHolder_content.Controls.Clear();
            switch(p.tab_index)
            {
                case Units.UserControl_regional_staffer_new_binder.TSSI_ANNUAL_CYCLE:
                    p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_annual_cycle_setup)(LoadControl("~/usercontrol/app/UserControl_annual_cycle_setup.ascx"))).Fresh(), "UserControl_annual_cycle_setup", PlaceHolder_content);
                    break;
                case Units.UserControl_regional_staffer_new_binder.TSSI_SERVICE:
                    p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_new_service)(LoadControl("~/usercontrol/app/UserControl_new_service.ascx"))).Fresh(), "UserControl_new_service", PlaceHolder_content);
                    break;
            // TSSI_2:
            // p.content_id := AddIdentifiedControlToPlaceHolder
            // (
            // TWebUserControl3(LoadControl('~/usercontrol/app/UserControl3.ascx')).Fresh,
            // 'UserControl3',
            // PlaceHolder_content
            // );
            }
        }

        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            this.TabContainer_control.ActiveTabChanged += this.TabContainer_control_ActiveTabChanged;
            //this.Load += this.Page_Load;
            this.PreRender += this.TWebUserControl_regional_staffer_new_binder_PreRender;
        }

        private void TWebUserControl_regional_staffer_new_binder_PreRender(object sender, System.EventArgs e)
        {
            // Indicate to children which content control was active on this pass, so that on subsequent passes a child can detect whether or
            // not it is already loaded in the user's browser.
            SessionSet(PlaceHolder_content.ClientID, p.content_id);
            SessionSet("UserControl_regional_staffer_new_binder.p", p);

        }

        public TWebUserControl_regional_staffer_new_binder Fresh()
        {
            TWebUserControl_regional_staffer_new_binder result;
            Session.Remove("UserControl_regional_staffer_new_binder.p");
            result = this;
            return result;
        }

        private struct p_type
        {
            public bool be_loaded;
            public string content_id;
            public uint tab_index;
        } // end p_type

    } // end TWebUserControl_regional_staffer_new_binder

}

namespace UserControl_regional_staffer_new_binder.Units
{
    public class UserControl_regional_staffer_new_binder
    {
        // ,
        // ,UserControl_2
        public const int TSSI_ANNUAL_CYCLE = 0;
        public const int TSSI_SERVICE = 1;
    } // end UserControl_regional_staffer_new_binder

}

