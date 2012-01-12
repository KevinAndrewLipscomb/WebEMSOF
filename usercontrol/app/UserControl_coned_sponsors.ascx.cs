using Class_biz_teaching_entities;
using Class_msg_protected;
using kix;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UserControl_coned_sponsors
{
    // Derived from KiAspdotnetFramework/UserControl/app/UserControl~template~datagrid~sortable.pas
    public partial class TWebUserControl_coned_sponsors: ki_web_ui.usercontrol_class
    {
        public class UserControl_coned_sponsors_Static
          {
          public const int TCI_SELECT = 0;
          public const int TCI_ID = 1;
          public const int TCI_SPONSOR_NUMBER = 2;
          public const int TCI_NAME = 3;
          public const int TCI_IMITATE = 4;
          }

        private struct p_type
          {
          public bool be_interactive;
          public bool be_loaded;
          public bool be_sort_order_ascending;
          public TClass_biz_teaching_entities biz_teaching_entities;
          public TClass_msg_protected.coned_sponsor_detail msg_protected_coned_sponsor_detail;
          public uint num_teaching_entities;
          public string sort_order;
          }

        private p_type p;

        private void InjectPersistentClientSideScript()
        {
            // EstablishClientSideFunction(k.client_side_function_enumeral_type.EL);
            // EstablishClientSideFunction(k.client_side_function_enumeral_type.KGS_TO_LBS);
            // EstablishClientSideFunction(k.client_side_function_enumeral_type.LBS_TO_KGS);
            // EstablishClientSideFunction
            // (
            // 'RecalculateDependentValues()',
            // k.EMPTY
            // + 'El("' + TextBox_gain_or_loss_in_lbs.clientid + '").value ='
            // +  ' El("' + TextBox_gross_landed_weight_in_pounds.clientid + '").value - El("' + TextBox_gross_invoiced_weight_in_lbs.clientid + '").value;'
            // + k.NEW_LINE
            // + 'El("' + TextBox_gain_or_loss_in_kgs.clientid + '").value ='
            // +  ' El("' + TextBox_gross_landed_weight_in_kgs.clientid + '").value - El("' + TextBox_gross_invoiced_weight_in_kgs.clientid + '").value;'
            // + k.NEW_LINE
            // + 'El("' + TextBox_gain_or_loss_per_bale_in_lbs.clientid + '").value ='
            // +  ' El("' + TextBox_gain_or_loss_in_lbs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
            // + k.NEW_LINE
            // + 'El("' + TextBox_gain_or_loss_per_bale_in_kgs.clientid + '").value ='
            // +  ' El("' + TextBox_gain_or_loss_in_kgs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
            // + k.NEW_LINE
            // + 'El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value ='
            // +  ' El("' + TextBox_gain_or_loss_in_lbs.clientid + '").value - El("' + TextBox_franchise_in_lbs.clientid + '").value;'
            // + k.NEW_LINE
            // + 'El("' + TextBox_actual_gain_or_loss_in_kgs.clientid + '").value ='
            // +  ' El("' + TextBox_gain_or_loss_in_kgs.clientid + '").value - El("' + TextBox_franchise_in_kgs.clientid + '").value;'
            // + k.NEW_LINE
            // + 'El("' + TextBox_actual_gain_or_loss_per_bale_in_lbs.clientid + '").value ='
            // +  ' El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
            // + k.NEW_LINE
            // + 'El("' + TextBox_actual_gain_or_loss_per_bale_in_kgs.clientid + '").value ='
            // +  ' El("' + TextBox_actual_gain_or_loss_in_kgs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
            // + k.NEW_LINE
            // + 'El("' + TextBox_percent_gain_or_loss.clientid + '").value ='
            // +  ' Math.round(El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value/El("' + TextBox_net_invoiced_in_lbs.clientid + '").value*100*100)/100;'
            // + k.NEW_LINE
            // + 'El("' + TextBox_monetary_gain_or_loss.clientid + '").value ='
            // +  ' El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value*El("' + TextBox_unit_price_in_cents_per_pound.clientid + '").value;'
            // );
            // //
            // TextBox_bales.attributes.Add('onkeyup','RecalculateDependentValues();');
            // TextBox_gross_landed_weight_in_pounds.attributes.Add
            // (
            // 'onkeyup',
            // 'El("' + TextBox_gross_landed_weight_in_kgs.clientid + '").value = LbsToKgs(El("' + TextBox_gross_landed_weight_in_pounds.clientid + '").value);'
            // + ' RecalculateDependentValues();'
            // );
            // TextBox_gross_landed_weight_in_kgs.attributes.Add
            // (
            // 'onkeyup',
            // 'El("' + TextBox_gross_landed_weight_in_pounds.clientid + '").value = KgsToLbs(El("' + TextBox_gross_landed_weight_in_kgs.clientid + '").value);'
            // + ' RecalculateDependentValues();'
            // );
            // TextBox_landed_or_ciq_tare.attributes.Add
            // (
            // 'onkeyup',
            // 'El("' + TextBox_landed_or_ciq_tare_in_kgs.clientid + '").value = LbsToKgs(El("' + TextBox_landed_or_ciq_tare.clientid + '").value);'
            // + ' RecalculateDependentValues();'
            // );
            // TextBox_landed_or_ciq_tare_in_kgs.attributes.Add
            // (
            // 'onkeyup',
            // 'El("' + TextBox_landed_or_ciq_tare.clientid + '").value = KgsToLbs(El("' + TextBox_landed_or_ciq_tare_in_kgs.clientid + '").value);'
            // + ' RecalculateDependentValues();'
            // );
            // TextBox_net_landed_in_pounds.attributes.Add
            // (
            // 'onkeyup',
            // 'El("' + TextBox_net_landed_in_kgs.clientid + '").value = LbsToKgs(El("' + TextBox_net_landed_in_pounds.clientid + '").value);'
            // + ' RecalculateDependentValues();'
            // );
            // TextBox_net_landed_in_kgs.attributes.Add
            // (
            // 'onkeyup',
            // 'El("' + TextBox_net_landed_in_pounds.clientid + '").value = KgsToLbs(El("' + TextBox_net_landed_in_kgs.clientid + '").value);'
            // + ' RecalculateDependentValues();'
            // );

        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (!p.be_loaded)
            {
                if (!p.be_interactive)
                {
                    DataGrid_control.AllowSorting = false;
                }
                p.be_loaded = true;
            }
            Bind();
            InjectPersistentClientSideScript();

        }

        protected override void OnInit(System.EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
            if (Session[InstanceId() + ".p"] != null)
            {
                p = (p_type)(Session[InstanceId() + ".p"]);
                p.be_loaded = IsPostBack && ((Session["UserControl_regional_staffer_binder_UserControl_regional_staffer_emsrs_gateway_binder_UserControl_coned_binder_PlaceHolder_content"] as string) == "UserControl_coned_sponsors");
            }
            else
            {
                p.biz_teaching_entities = new TClass_biz_teaching_entities();
                p.msg_protected_coned_sponsor_detail = new TClass_msg_protected.coned_sponsor_detail();
                p.be_interactive = !(Session["mode:report"] != null);
                p.be_loaded = false;
                p.be_sort_order_ascending = true;
                p.num_teaching_entities = 0;
                p.sort_order = "name%";
            }

        }

        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            this.DataGrid_control.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.DataGrid_control_ItemDataBound);
            this.DataGrid_control.SortCommand += new System.Web.UI.WebControls.DataGridSortCommandEventHandler(this.DataGrid_control_SortCommand);
            this.DataGrid_control.ItemCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.DataGrid_control_ItemCommand);
            this.PreRender += this.TWebUserControl_coned_sponsors_PreRender;
            //this.Load += this.Page_Load;
        }

        private void TWebUserControl_coned_sponsors_PreRender(object sender, System.EventArgs e)
        {
            SessionSet(InstanceId() + ".p", p);
        }

        public TWebUserControl_coned_sponsors Fresh()
        {
            TWebUserControl_coned_sponsors result;
            Session.Remove(InstanceId() + ".p");
            result = this;
            return result;
        }

        private void DataGrid_control_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
        {
            if (new ArrayList {ListItemType.AlternatingItem,ListItemType.Item,ListItemType.EditItem,ListItemType.SelectedItem}.Contains(e.Item.ItemType))
              {
              var sponsor_number = k.Safe(e.Item.Cells[UserControl_coned_sponsors_Static.TCI_SPONSOR_NUMBER].Text, k.safe_hint_type.NUM);
              SessionSet("sponsor_number",sponsor_number);
              if (e.CommandName == "select")
                {
                p.msg_protected_coned_sponsor_detail.id = k.Safe(e.Item.Cells[UserControl_coned_sponsors_Static.TCI_ID].Text, k.safe_hint_type.NUM);
                MessageDropCrumbAndTransferTo(p.msg_protected_coned_sponsor_detail,"protected","coned_sponsor_detail");
                }
              else if (e.CommandName == "imitate")
                {
                var coned_sponsor_name = k.Safe(e.Item.Cells[UserControl_coned_sponsors_Static.TCI_NAME].Text, k.safe_hint_type.ORG_NAME);
                var coned_sponsor_user_id = k.Safe(e.Item.Cells[UserControl_coned_sponsors_Static.TCI_ID].Text, k.safe_hint_type.NUM);
                SessionSet(name:"imitator_designator",value:HttpContext.Current.User.Identity.Name);
                SessionSet("target_user_table","coned_sponsor");
                SessionSet("coned_sponsor_user_id",coned_sponsor_user_id);
                SessionSet("coned_sponsor_name",coned_sponsor_name);
                SessionSet("username",coned_sponsor_name);
                FormsAuthentication.RedirectFromLoginPage("coned_sponsor_" + coned_sponsor_user_id,false);
                }
              }
        }

        private void DataGrid_control_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
        {
            LinkButton link_button;
            if (p.be_interactive)
            {
                if (new ArrayList {ListItemType.AlternatingItem,ListItemType.Item,ListItemType.EditItem,ListItemType.SelectedItem}.Contains(e.Item.ItemType))
                {
                    link_button = ((e.Item.Cells[UserControl_coned_sponsors_Static.TCI_SELECT].Controls[0]) as LinkButton);
                    link_button.Text = k.ExpandTildePath(link_button.Text);
                    link_button.ToolTip = "Profile (tabbed)";
                    ScriptManager.GetCurrent(Page).RegisterPostBackControl(link_button);
                    link_button = ((e.Item.Cells[UserControl_coned_sponsors_Static.TCI_IMITATE].Controls[0]) as LinkButton);
                    link_button.Text = k.ExpandTildePath(link_button.Text);
                    link_button.ToolTip = "Imitate";
                    RequireConfirmation(link_button,"The application will now allow you to imitate a subordinate user.  When you are done imitating the subordinate user, you must log out and log back in as yourself.");
                    ScriptManager.GetCurrent(Page).RegisterPostBackControl(link_button);
                    p.num_teaching_entities++;
                }
            }
            else
            {
                e.Item.Cells[UserControl_coned_sponsors_Static.TCI_SELECT].Visible = false;
                e.Item.Cells[UserControl_coned_sponsors_Static.TCI_IMITATE].Visible = false;
            }
        }

        private void DataGrid_control_SortCommand(object source, System.Web.UI.WebControls.DataGridSortCommandEventArgs e)
        {
            if (e.SortExpression == p.sort_order)
            {
                p.be_sort_order_ascending = !p.be_sort_order_ascending;
            }
            else
            {
                p.sort_order = k.Safe(e.SortExpression, k.safe_hint_type.KI_SORT_EXPRESSION);
                p.be_sort_order_ascending = true;
            }
            DataGrid_control.EditItemIndex =  -1;
            Bind();
        }

        private void Bind()
        {
            p.biz_teaching_entities.BindConedSponsorsBaseDataList(Session["region_code"].ToString(),p.sort_order,p.be_sort_order_ascending,DataGrid_control);
            Label_num_coned_sponsors.Text = p.num_teaching_entities.ToString();
            p.num_teaching_entities = 0;

        }

    } // end TWebUserControl_coned_sponsors

}

