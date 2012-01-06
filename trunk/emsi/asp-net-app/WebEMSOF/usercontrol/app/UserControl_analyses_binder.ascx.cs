using UserControl_equipment_procurement_binder;
using UserControl_fy_allocations_reimbursements_returns;
using UserControl_values_to_region;
using UserControl_values_to_services;

namespace UserControl_analyses_binder
{
    public class UserControl_analyses_binder_Static
    {
        public const int TSSI_ALLOCATIONS_REIMBURSEMENTS_RETURNS = 0;
        public const int TSSI_EQUIPMENT_PROCUREMENT_BINDER = 1;
        public const int TSSI_VALUES_TO_SERVICES = 2;
        public const int TSSI_VALUES_TO_REGION = 3;
    }

    public struct p_type
    {
        public bool be_loaded;
        public string content_id;
        public uint tab_index;
    }

    public partial class TWebUserControl_analyses_binder: ki_web_ui.usercontrol_class
    {
        private p_type p;

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
                p.be_loaded = IsPostBack && ((Session["UserControl_regional_staffer_binder_UserControl_regional_staffer_cat4pe_binder_PlaceHolder_content"] as string) == "UserControl_analyses_binder");
                // Dynamic controls must be re-added on each postback.
                switch(p.tab_index)
                {
                    case UserControl_analyses_binder_Static.TSSI_ALLOCATIONS_REIMBURSEMENTS_RETURNS:
                        p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_fy_allocations_reimbursements_returns)(LoadControl("~/usercontrol/app/UserControl_fy_allocations_reimbursements_returns.ascx"))), "UserControl_fy_allocations_reimbursements_returns", PlaceHolder_content);
                        break;
                    case UserControl_analyses_binder_Static.TSSI_EQUIPMENT_PROCUREMENT_BINDER:
                        p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_equipment_procurement_binder)(LoadControl("~/usercontrol/app/UserControl_equipment_procurement_binder.ascx"))), "UserControl_equipment_procurement_binder", PlaceHolder_content);
                        break;
                    case UserControl_analyses_binder_Static.TSSI_VALUES_TO_SERVICES:
                        p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_values_to_services)(LoadControl("~/usercontrol/app/UserControl_values_to_services.ascx"))), "UserControl_values_to_services", PlaceHolder_content);
                        break;
                    case UserControl_analyses_binder_Static.TSSI_VALUES_TO_REGION:
                        p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_values_to_region)(LoadControl("~/usercontrol/app/UserControl_values_to_region.ascx"))), "UserControl_values_to_region", PlaceHolder_content);
                        break;
                }
            }
            else
            {
                p.be_loaded = false;
                p.tab_index = UserControl_analyses_binder_Static.TSSI_ALLOCATIONS_REIMBURSEMENTS_RETURNS;
                p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_fy_allocations_reimbursements_returns)(LoadControl("~/usercontrol/app/UserControl_fy_allocations_reimbursements_returns.ascx"))),"UserControl_fy_allocations_reimbursements_returns",PlaceHolder_content,InstanceId());
            }

        }

        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            TabContainer_control.ActiveTabChanged += TabContainer_control_ActiveTabChanged;
            PreRender += TWebUserControl_analyses_binder_PreRender;
        }

        private void TWebUserControl_analyses_binder_PreRender(object sender, System.EventArgs e)
        {
            // Indicate to children which content control was active on this pass, so that on subsequent passes a child can detect whether or
            // not it is already loaded in the user's browser.
            SessionSet(PlaceHolder_content.ClientID, p.content_id);
            SessionSet(InstanceId() + ".p", p);

        }

        public TWebUserControl_analyses_binder Fresh()
        {
            Session.Remove(InstanceId() + ".p");
            return this;
        }

        private void TabContainer_control_ActiveTabChanged(object sender, System.EventArgs e)
        {
            p.tab_index = (uint)(TabContainer_control.ActiveTabIndex);
            PlaceHolder_content.Controls.Clear();
            switch(p.tab_index)
            {
                case UserControl_analyses_binder_Static.TSSI_ALLOCATIONS_REIMBURSEMENTS_RETURNS:
                    p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_fy_allocations_reimbursements_returns)(LoadControl("~/usercontrol/app/UserControl_fy_allocations_reimbursements_returns.ascx"))),"UserControl_fy_allocations_reimbursements_returns",PlaceHolder_content,InstanceId());
                    break;
                case UserControl_analyses_binder_Static.TSSI_EQUIPMENT_PROCUREMENT_BINDER:
                    p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_equipment_procurement_binder)(LoadControl("~/usercontrol/app/UserControl_equipment_procurement_binder.ascx"))),"UserControl_equipment_procurement_binder",PlaceHolder_content,InstanceId());
                    break;
                case UserControl_analyses_binder_Static.TSSI_VALUES_TO_SERVICES:
                    p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_values_to_services)(LoadControl("~/usercontrol/app/UserControl_values_to_services.ascx"))),"UserControl_values_to_services",PlaceHolder_content,InstanceId());
                    break;
                case UserControl_analyses_binder_Static.TSSI_VALUES_TO_REGION:
                    p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_values_to_region)(LoadControl("~/usercontrol/app/UserControl_values_to_region.ascx"))),"UserControl_values_to_region",PlaceHolder_content,InstanceId());
                    break;
            }
        }

    } // end TWebUserControl_analyses_binder

}

