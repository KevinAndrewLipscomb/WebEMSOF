using UserControl_counties;
using UserControl_financial_snapshot;
using UserControl_outcomes;
using UserControl_region_dictated_appropriations;
using UserControl_responding_services;
using UserControl_workflow;

namespace UserControl_regional_staffer_current_binder
{
    public static class UserControl_regional_staffer_current_binder_Static
    {
        public const int TSSI_SNAPSHOT = 0;
        public const int TSSI_SERVICES = 1;
        public const int TSSI_COUNTIES = 2;
        public const int TSSI_ALLOCATIONS = 3;
        public const int TSSI_WORKFLOW = 4;
        public const int TSSI_OUTCOMES = 5;
    }

    public struct p_type
    {
        public bool be_loaded;
        public string content_id;
        public uint tab_index;
    } // end p_type

    public partial class TWebUserControl_regional_staffer_current_binder: ki_web_ui.usercontrol_class
    {
        private p_type p;
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
                p.be_loaded = IsPostBack && ((Session["UserControl_regional_staffer_binder_UserControl_regional_staffer_cat4pe_binder_PlaceHolder_content"] as string) == "UserControl_regional_staffer_current_binder");
                if ((Session["UserControl_regional_staffer_current_binder_selected_tab"] != null))
                {
                    p.tab_index = (uint)(Session["UserControl_regional_staffer_current_binder_selected_tab"].GetHashCode());
                    Session.Remove("UserControl_regional_staffer_current_binder_selected_tab");
                }
                switch(p.tab_index)
                {
                    case UserControl_regional_staffer_current_binder_Static.TSSI_SNAPSHOT:
                        // Dynamic controls must be re-added on each postback.
                        p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_financial_snapshot)(LoadControl("~/usercontrol/app/UserControl_financial_snapshot.ascx"))), "UserControl_financial_snapshot", PlaceHolder_content);
                        break;
                    case UserControl_regional_staffer_current_binder_Static.TSSI_WORKFLOW:
                        p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_workflow)(LoadControl("~/usercontrol/app/UserControl_workflow.ascx"))), "UserControl_workflow", PlaceHolder_content);
                        break;
                    case UserControl_regional_staffer_current_binder_Static.TSSI_OUTCOMES:
                        p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_outcomes)(LoadControl("~/usercontrol/app/UserControl_outcomes.ascx"))), "UserControl_outcomes", PlaceHolder_content);
                        break;
                    case UserControl_regional_staffer_current_binder_Static.TSSI_SERVICES:
                        p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_responding_services)(LoadControl("~/usercontrol/app/UserControl_responding_services.ascx"))), "UserControl_responding_services", PlaceHolder_content);
                        break;
                    case UserControl_regional_staffer_current_binder_Static.TSSI_COUNTIES:
                        p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_counties)(LoadControl("~/usercontrol/app/UserControl_counties.ascx"))), "UserControl_counties", PlaceHolder_content);
                        break;
                    case UserControl_regional_staffer_current_binder_Static.TSSI_ALLOCATIONS:
                        p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_region_dictated_appropriations)(LoadControl("~/usercontrol/app/UserControl_region_dictated_appropriations.ascx"))), "UserControl_region_dictated_appropriations", PlaceHolder_content);
                        break;
                }
            }
            else
            {
                p.be_loaded = false;
                p.tab_index = UserControl_regional_staffer_current_binder_Static.TSSI_SNAPSHOT;
                p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_financial_snapshot)(LoadControl("~/usercontrol/app/UserControl_financial_snapshot.ascx"))),"UserControl_financial_snapshot",PlaceHolder_content,InstanceId());
            }

        }

        private void TabContainer_control_ActiveTabChanged(object sender, System.EventArgs e)
        {
            p.tab_index = (uint)(TabContainer_control.ActiveTabIndex);
            PlaceHolder_content.Controls.Clear();
            switch(p.tab_index)
            {
                case UserControl_regional_staffer_current_binder_Static.TSSI_SNAPSHOT:
                    p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_financial_snapshot)(LoadControl("~/usercontrol/app/UserControl_financial_snapshot.ascx"))),"UserControl_financial_snapshot",PlaceHolder_content,InstanceId());
                    break;
                case UserControl_regional_staffer_current_binder_Static.TSSI_WORKFLOW:
                    p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_workflow)(LoadControl("~/usercontrol/app/UserControl_workflow.ascx"))),"UserControl_workflow",PlaceHolder_content,InstanceId());
                    break;
                case UserControl_regional_staffer_current_binder_Static.TSSI_OUTCOMES:
                    p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_outcomes)(LoadControl("~/usercontrol/app/UserControl_outcomes.ascx"))),"UserControl_outcomes",PlaceHolder_content,InstanceId());
                    break;
                case UserControl_regional_staffer_current_binder_Static.TSSI_SERVICES:
                    p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_responding_services)(LoadControl("~/usercontrol/app/UserControl_responding_services.ascx"))),"UserControl_responding_services",PlaceHolder_content,InstanceId());
                    break;
                case UserControl_regional_staffer_current_binder_Static.TSSI_COUNTIES:
                    p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_counties)(LoadControl("~/usercontrol/app/UserControl_counties.ascx"))),"UserControl_counties",PlaceHolder_content,InstanceId());
                    break;
                case UserControl_regional_staffer_current_binder_Static.TSSI_ALLOCATIONS:
                    p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_region_dictated_appropriations)(LoadControl("~/usercontrol/app/UserControl_region_dictated_appropriations.ascx"))),"UserControl_region_dictated_appropriations",PlaceHolder_content,InstanceId());
                    break;
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
            this.PreRender += this.TWebUserControl_regional_staffer_current_binder_PreRender;
        }

        private void TWebUserControl_regional_staffer_current_binder_PreRender(object sender, System.EventArgs e)
        {
            // Indicate to children which content control was active on this pass, so that on subsequent passes a child can detect whether or
            // not it is already loaded in the user's browser.
            SessionSet(PlaceHolder_content.ClientID, p.content_id);
            SessionSet(InstanceId() + ".p", p);

        }

        public TWebUserControl_regional_staffer_current_binder Fresh()
        {
            TWebUserControl_regional_staffer_current_binder result;
            Session.Remove(InstanceId() + ".p");
            result = this;
            return result;
        }

    } // end TWebUserControl_regional_staffer_current_binder

}
