using AjaxControlToolkit;
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Collections;

using UserControl_charter_kind;
namespace UserControl_config_binder
{
    public partial class TWebUserControl_config_binder: ki_web_ui.usercontrol_class
    {
        private p_type p;
        // TSSI_1 = 1;
        // TSSI_2 = 2;
        protected void Page_Load(object sender, System.EventArgs e)
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
                p.be_loaded = IsPostBack && ((Session["UserControl_regional_staffer_binder_PlaceHolder_content"] as string) == "UserControl_config_binder");
                if ((Session["UserControl_config_binder_selected_tab"] != null))
                {
                    p.tab_index = (uint)(Session["UserControl_config_binder_selected_tab"].GetHashCode());
                    Session.Remove("UserControl_config_binder_selected_tab");
                }
                switch(p.tab_index)
                {
                    case Units.UserControl_config_binder.TSSI_CHARTER_KINDS:
                        // Dynamic controls must be re-added on each postback.
                        p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_charter_kind)(LoadControl("~/usercontrol/app/UserControl_charter_kind.ascx"))), "UserControl_charter_kind", PlaceHolder_content);
                        break;
                // TSSI_1:
                // p.content_id := AddIdentifiedControlToPlaceHolder
                // (
                // TWebUserControl2(LoadControl('~/usercontrol/app/UserControl2.ascx')),
                // 'UserControl2',
                // PlaceHolder_content
                // );
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
                p.tab_index = Units.UserControl_config_binder.TSSI_CHARTER_KINDS;
                p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_charter_kind)(LoadControl("~/usercontrol/app/UserControl_charter_kind.ascx"))),"UserControl_charter_kind",PlaceHolder_content,InstanceId());
            }

        }

        private void TabContainer_control_ActiveTabChanged(object sender, System.EventArgs e)
        {
            p.tab_index = (uint)(TabContainer_control.ActiveTabIndex);
            PlaceHolder_content.Controls.Clear();
            switch(p.tab_index)
            {
                case Units.UserControl_config_binder.TSSI_CHARTER_KINDS:
                    p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_charter_kind)(LoadControl("~/usercontrol/app/UserControl_charter_kind.ascx"))),"UserControl_charter_kind",PlaceHolder_content,InstanceId());
                    break;
            // TSSI_1:
            // p.content_id := AddIdentifiedControlToPlaceHolder
            // (
            // TWebUserControl2(LoadControl('~/usercontrol/app/UserControl2.ascx')).Fresh,
            // 'UserControl2',
            // PlaceHolder_content
            // );
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
            this.PreRender += this.TWebUserControl_config_binder_PreRender;
        }

        private void TWebUserControl_config_binder_PreRender(object sender, System.EventArgs e)
        {
            // Indicate to children which content control was active on this pass, so that on subsequent passes a child can detect whether or
            // not it is already loaded in the user's browser.
            SessionSet(PlaceHolder_content.ClientID, p.content_id);
            SessionSet(InstanceId() + ".p", p);

        }

        public TWebUserControl_config_binder Fresh()
        {
            TWebUserControl_config_binder result;
            Session.Remove(InstanceId() + ".p");
            result = this;
            return result;
        }

        private struct p_type
        {
            public bool be_loaded;
            public string content_id;
            public uint tab_index;
        } // end p_type

    } // end TWebUserControl_config_binder

}

namespace UserControl_config_binder.Units
{
    public class UserControl_config_binder
    {
        // ,
        // ,UserControl_1
        // ,UserControl_2
        public const int TSSI_CHARTER_KINDS = 0;
    } // end UserControl_config_binder

}

