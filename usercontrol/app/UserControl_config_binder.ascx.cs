using UserControl_charter_kind;
using UserControl_coned_offering;
using UserControl_coned_offering_class_final_status_description;
using UserControl_coned_offering_class_final_status;
using UserControl_coned_offering_document_status;

namespace UserControl_config_binder
{
    public partial class TWebUserControl_config_binder: ki_web_ui.usercontrol_class
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
                p.be_loaded = IsPostBack && ((Session["UserControl_regional_staffer_binder_PlaceHolder_content"] as string) == "UserControl_config_binder");
                if ((Session["UserControl_config_binder_selected_tab"] != null))
                {
                    p.tab_index = (uint)(Session["UserControl_config_binder_selected_tab"].GetHashCode());
                    Session.Remove("UserControl_config_binder_selected_tab");
                }
                switch(p.tab_index)
                {
                    case Units.UserControl_config_binder.TSSI_CHARTER_KINDS:
                        p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_charter_kind)(LoadControl("~/usercontrol/app/UserControl_charter_kind.ascx"))), "UserControl_charter_kind", PlaceHolder_content);
                        break;
                    case Units.UserControl_config_binder.TSSI_CONED_OFFERING_DOCUMENT_STATUSES:
                        p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_coned_offering_document_status)(LoadControl("~/usercontrol/app/UserControl_coned_offering_document_status.ascx"))), "UserControl_coned_offering_document_status", PlaceHolder_content);
                        break;
                    case Units.UserControl_config_binder.TSSI_CONED_OFFERING_FINAL_STATUSES:
                        p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_coned_offering_class_final_status)(LoadControl("~/usercontrol/app/UserControl_coned_offering_class_final_status.ascx"))), "UserControl_coned_offering_class_final_status", PlaceHolder_content);
                        break;
                    case Units.UserControl_config_binder.TSSI_CONED_OFFERING_FINAL_STATUS_DESCRIPTIONS:
                        p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_coned_offering_class_final_status_description)(LoadControl("~/usercontrol/app/UserControl_coned_offering_class_final_status_description.ascx"))), "UserControl_coned_offering_class_final_status_description", PlaceHolder_content);
                        break;
                    case Units.UserControl_config_binder.TSSI_CONED_OFFERINGS:
                        p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_coned_offering)(LoadControl("~/usercontrol/app/UserControl_coned_offering.ascx"))), "UserControl_coned_offering", PlaceHolder_content);
                        break;
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
                case Units.UserControl_config_binder.TSSI_CONED_OFFERING_DOCUMENT_STATUSES:
                    p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_coned_offering_document_status)(LoadControl("~/usercontrol/app/UserControl_coned_offering_document_status.ascx"))),"UserControl_coned_offering_document_status",PlaceHolder_content,InstanceId());
                    break;
                case Units.UserControl_config_binder.TSSI_CONED_OFFERING_FINAL_STATUSES:
                    p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_coned_offering_class_final_status)(LoadControl("~/usercontrol/app/UserControl_coned_offering_class_final_status.ascx"))),"UserControl_coned_offering_class_final_status",PlaceHolder_content,InstanceId());
                    break;
                case Units.UserControl_config_binder.TSSI_CONED_OFFERING_FINAL_STATUS_DESCRIPTIONS:
                    p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_coned_offering_class_final_status_description)(LoadControl("~/usercontrol/app/UserControl_coned_offering_class_final_status_description.ascx"))),"UserControl_coned_offering_class_final_status_description",PlaceHolder_content,InstanceId());
                    break;
                case Units.UserControl_config_binder.TSSI_CONED_OFFERINGS:
                    p.content_id = AddIdentifiedControlToPlaceHolder(((TWebUserControl_coned_offering)(LoadControl("~/usercontrol/app/UserControl_coned_offering.ascx"))),"UserControl_coned_offering",PlaceHolder_content,InstanceId());
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
        public const int TSSI_CONED_OFFERING_DOCUMENT_STATUSES = 1;
        public const int TSSI_CONED_OFFERING_FINAL_STATUSES = 2;
        public const int TSSI_CONED_OFFERING_FINAL_STATUS_DESCRIPTIONS = 3;
        public const int TSSI_CONED_OFFERINGS = 4;
    } // end UserControl_config_binder

}

