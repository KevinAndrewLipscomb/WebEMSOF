using System.Web;
using UserControl_analyses_binder;
using UserControl_regional_staffer_current_binder;
using UserControl_regional_staffer_new_binder;
using UserControl_regional_staffer_old_binder;

namespace UserControl_regional_staffer_cat4pe_binder
{
    public partial class TWebUserControl_regional_staffer_cat4pe_binder: ki_web_ui.usercontrol_class
    {
        private p_type p;
        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (!p.be_loaded)
            {
                TabContainer_control.ActiveTabIndex = (int)(p.tab_index);
                TabPanel_new.Enabled = HttpContext.Current.User.IsInRole("director") || HttpContext.Current.User.IsInRole("emsof-coordinator");
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
                p.be_loaded = IsPostBack && ((Session["UserControl_regional_staffer_binder_PlaceHolder_content"] as string) == "UserControl_regional_staffer_cat4pe_binder");
                if ((Session["UserControl_regional_staffer_cat4pe_binder_selected_tab"] != null))
                {
                    p.tab_index = (uint)(Session["UserControl_regional_staffer_cat4pe_binder_selected_tab"].GetHashCode());
                    Session.Remove("UserControl_regional_staffer_cat4pe_binder_selected_tab");
                }
                switch(p.tab_index)
                {
                    case Units.UserControl_regional_staffer_cat4pe_binder.TSSI_CURRENT:
                        // Dynamic controls must be re-added on each postback.
                        p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_regional_staffer_current_binder)(LoadControl("~/usercontrol/app/UserControl_regional_staffer_current_binder.ascx"))), "UserControl_regional_staffer_current_binder", PlaceHolder_content);
                        break;
                    case Units.UserControl_regional_staffer_cat4pe_binder.TSSI_OLD:
                        p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_regional_staffer_old_binder)(LoadControl("~/usercontrol/app/UserControl_regional_staffer_old_binder.ascx"))), "UserControl_regional_staffer_old_binder", PlaceHolder_content);
                        break;
                    case Units.UserControl_regional_staffer_cat4pe_binder.TSSI_NEW:
                        p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_regional_staffer_new_binder)(LoadControl("~/usercontrol/app/UserControl_regional_staffer_new_binder.ascx"))), "UserControl_regional_staffer_new_binder", PlaceHolder_content);
                        break;
                    case Units.UserControl_regional_staffer_cat4pe_binder.TSSI_ANALYSES:
                        p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_analyses_binder)(LoadControl("~/usercontrol/app/UserControl_analyses_binder.ascx"))), "UserControl_analyses_binder", PlaceHolder_content);
                        break;
                }
            }
            else
            {
                p.be_loaded = false;
                p.tab_index = Units.UserControl_regional_staffer_cat4pe_binder.TSSI_CURRENT;
                p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_regional_staffer_current_binder)(LoadControl("~/usercontrol/app/UserControl_regional_staffer_current_binder.ascx"))),"UserControl_regional_staffer_current_binder",PlaceHolder_content,InstanceId());
            }

        }

        private void TabContainer_control_ActiveTabChanged(object sender, System.EventArgs e)
        {
            p.tab_index = (uint)(TabContainer_control.ActiveTabIndex);
            PlaceHolder_content.Controls.Clear();
            switch(p.tab_index)
            {
                case Units.UserControl_regional_staffer_cat4pe_binder.TSSI_CURRENT:
                    p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_regional_staffer_current_binder)(LoadControl("~/usercontrol/app/UserControl_regional_staffer_current_binder.ascx"))),"UserControl_regional_staffer_current_binder",PlaceHolder_content,InstanceId());
                    break;
                case Units.UserControl_regional_staffer_cat4pe_binder.TSSI_OLD:
                    p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_regional_staffer_old_binder)(LoadControl("~/usercontrol/app/UserControl_regional_staffer_old_binder.ascx"))),"UserControl_regional_staffer_old_binder",PlaceHolder_content,InstanceId());
                    break;
                case Units.UserControl_regional_staffer_cat4pe_binder.TSSI_NEW:
                    p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_regional_staffer_new_binder)(LoadControl("~/usercontrol/app/UserControl_regional_staffer_new_binder.ascx"))),"UserControl_regional_staffer_new_binder",PlaceHolder_content,InstanceId());
                    break;
                case Units.UserControl_regional_staffer_cat4pe_binder.TSSI_ANALYSES:
                    p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_analyses_binder)(LoadControl("~/usercontrol/app/UserControl_analyses_binder.ascx"))),"UserControl_analyses_binder",PlaceHolder_content,InstanceId());
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
            this.PreRender += this.TWebUserControl_regional_staffer_cat4pe_binder_PreRender;
        }

        private void TWebUserControl_regional_staffer_cat4pe_binder_PreRender(object sender, System.EventArgs e)
        {
            // Indicate to children which content control was active on this pass, so that on subsequent passes a child can detect whether or
            // not it is already loaded in the user's browser.
            SessionSet(PlaceHolder_content.ClientID, p.content_id);
            SessionSet(InstanceId() + ".p", p);

        }

        public TWebUserControl_regional_staffer_cat4pe_binder Fresh()
        {
            TWebUserControl_regional_staffer_cat4pe_binder result;
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

    } // end TWebUserControl_regional_staffer_cat4pe_binder

}

namespace UserControl_regional_staffer_cat4pe_binder.Units
{
    public class UserControl_regional_staffer_cat4pe_binder
    {
        public const int TSSI_NEW = 0;
        public const int TSSI_CURRENT = 1;
        public const int TSSI_OLD = 2;
        public const int TSSI_ANALYSES = 3;
    } // end UserControl_regional_staffer_cat4pe_binder

}

