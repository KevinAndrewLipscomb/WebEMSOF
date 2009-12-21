using UserControl_equipment_procurement_binder;
using UserControl_values_to_region;
using UserControl_values_to_services;

namespace UserControl_analyses_binder
{
    public class UserControl_analyses_binder_Static
    {
        public const int TSSI_equipment_procurement_binder = 0;
        public const int TSSI_VALUES_TO_SERVICES = 1;
        public const int TSSI_VALUES_TO_REGION = 2;
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
            if (Session["UserControl_analyses_binder.p"] != null)
            {
                p = (p_type)(Session["UserControl_analyses_binder.p"]);
                p.be_loaded = IsPostBack && ((Session["UserControl_regional_staffer_binder_control_PlaceHolder_content"] as string) == "UserControl_analyses_binder");
                switch(p.tab_index)
                {
                    case UserControl_analyses_binder_Static.TSSI_equipment_procurement_binder:
                        // Dynamic controls must be re-added on each postback.
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
                p.tab_index = UserControl_analyses_binder_Static.TSSI_equipment_procurement_binder;
                p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_equipment_procurement_binder)(LoadControl("~/usercontrol/app/UserControl_equipment_procurement_binder.ascx"))).Fresh(), "UserControl_equipment_procurement_binder", PlaceHolder_content);
            }

        }

        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            this.TabContainer_control.ActiveTabChanged += this.TabContainer_control_ActiveTabChanged;
            this.PreRender += this.TWebUserControl_analyses_binder_PreRender;
            //this.Load += this.Page_Load;
        }

        private void TWebUserControl_analyses_binder_PreRender(object sender, System.EventArgs e)
        {
            // Indicate to children which content control was active on this pass, so that on subsequent passes a child can detect whether or
            // not it is already loaded in the user's browser.
            SessionSet(PlaceHolder_content.ClientID, p.content_id);
            SessionSet("UserControl_analyses_binder.p", p);

        }

        public TWebUserControl_analyses_binder Fresh()
        {
            TWebUserControl_analyses_binder result;
            Session.Remove("UserControl_analyses_binder.p");
            result = this;
            return result;
        }

        private void TabContainer_control_ActiveTabChanged(object sender, System.EventArgs e)
        {
            p.tab_index = (uint)(TabContainer_control.ActiveTabIndex);
            PlaceHolder_content.Controls.Clear();
            switch(p.tab_index)
            {
                case UserControl_analyses_binder_Static.TSSI_equipment_procurement_binder:
                    p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_equipment_procurement_binder)(LoadControl("~/usercontrol/app/UserControl_equipment_procurement_binder.ascx"))).Fresh(), "UserControl_equipment_procurement_binder", PlaceHolder_content);
                    break;
                case UserControl_analyses_binder_Static.TSSI_VALUES_TO_SERVICES:
                    p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_values_to_services)(LoadControl("~/usercontrol/app/UserControl_values_to_services.ascx"))).Fresh(), "UserControl_values_to_services", PlaceHolder_content);
                    break;
                case UserControl_analyses_binder_Static.TSSI_VALUES_TO_REGION:
                    p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_values_to_region)(LoadControl("~/usercontrol/app/UserControl_values_to_region.ascx"))).Fresh(), "UserControl_values_to_region", PlaceHolder_content);
                    break;
            }
        }

    } // end TWebUserControl_analyses_binder

}

