using AjaxControlToolkit;
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Collections;

using UserControl_equipment_procurement_overview;
using UserControl_serial_indicator_equipment_quantities;
namespace UserControl_equipment_procurement_binder
{
    // ,UserControl3
    public struct p_type
    {
        public bool be_loaded;
        public string content_id;
        public uint tab_index;
    } // end p_type

    public partial class TWebUserControl_equipment_procurement_binder: ki_web_ui.usercontrol_class
    {
        private p_type p;
        // TSSI_2 = 2;
        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (!p.be_loaded)
            {
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
                p.be_loaded = IsPostBack && ((Session["UserControl_regional_staffer_binder_UserControl_regional_staffer_cat4pe_binder_UserControl_analyses_binder_PlaceHolder_content"] as string) == "UserControl_equipment_procurement_binder");
                switch(p.tab_index)
                {
                    case Units.UserControl_equipment_procurement_binder.TSSI_SNAPSHOT:
                        // Dynamic controls must be re-added on each postback.
                        p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_equipment_procurement_overview)(LoadControl("~/usercontrol/app/UserControl_equipment_procurement_overview.ascx"))), "UserControl_equipment_procurement_overview", PlaceHolder_content);
                        break;
                    case Units.UserControl_equipment_procurement_binder.TSSI_SERIAL:
                        p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_serial_indicator_equipment_quantities)(LoadControl("~/usercontrol/app/UserControl_serial_indicator_equipment_quantities.ascx"))), "UserControl_serial_indicator_equipment_quantities", PlaceHolder_content);
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
                p.tab_index = Units.UserControl_equipment_procurement_binder.TSSI_SNAPSHOT;
                p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_equipment_procurement_overview)(LoadControl("~/usercontrol/app/UserControl_equipment_procurement_overview.ascx"))),"UserControl_equipment_procurement_overview",PlaceHolder_content,InstanceId());
            }

        }

        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            this.TabContainer_control.ActiveTabChanged += this.TabContainer_control_ActiveTabChanged;
            this.PreRender += this.TWebUserControl_equipment_procurement_binder_PreRender;
            //this.Load += this.Page_Load;
        }

        private void TWebUserControl_equipment_procurement_binder_PreRender(object sender, System.EventArgs e)
        {
            // Indicate to children which content control was active on this pass, so that on subsequent passes a child can detect whether or
            // not it is already loaded in the user's browser.
            SessionSet(PlaceHolder_content.ClientID, p.content_id);
            SessionSet(InstanceId() + ".p", p);

        }

        public TWebUserControl_equipment_procurement_binder Fresh()
        {
            TWebUserControl_equipment_procurement_binder result;
            Session.Remove(InstanceId() + ".p");
            result = this;
            return result;
        }

        private void TabContainer_control_ActiveTabChanged(object sender, System.EventArgs e)
        {
            p.tab_index = (uint)(TabContainer_control.ActiveTabIndex);
            PlaceHolder_content.Controls.Clear();
            switch(p.tab_index)
            {
                case Units.UserControl_equipment_procurement_binder.TSSI_SNAPSHOT:
                    p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_equipment_procurement_overview)(LoadControl("~/usercontrol/app/UserControl_equipment_procurement_overview.ascx"))),"UserControl_equipment_procurement_overview",PlaceHolder_content,InstanceId());
                    break;
                case Units.UserControl_equipment_procurement_binder.TSSI_SERIAL:
                    p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_serial_indicator_equipment_quantities)(LoadControl("~/usercontrol/app/UserControl_serial_indicator_equipment_quantities.ascx"))),"UserControl_serial_indicator_equipment_quantities",PlaceHolder_content,InstanceId());
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

    } // end TWebUserControl_equipment_procurement_binder

}

namespace UserControl_equipment_procurement_binder.Units
{
    public class UserControl_equipment_procurement_binder
    {
        public const int TSSI_SNAPSHOT = 0;
        public const int TSSI_SERIAL = 1;
    } // end UserControl_equipment_procurement_binder

}

