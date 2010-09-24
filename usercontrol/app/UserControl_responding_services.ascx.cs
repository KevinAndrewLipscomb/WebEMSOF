using kix;
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Collections;

using Class_biz_services;
namespace UserControl_responding_services
{
    // Derived from KiAspdotnetFramework/UserControl/app/UserControl~template~datagrid~sortable.pas
    public partial class TWebUserControl_responding_services: ki_web_ui.usercontrol_class
    {
        public class UserControl_responding_services_Static
          {
          public const int TCI_UPDATE_EMAIL_ADDRESS = 0;
          public const int TCI_PROFILE_TABBED = 1;
          public const int TCI_PROFILE_PRINTABLE = 2;
          public const int TCI_AFFILIATE_NUM = 3;
          public const int TCI_SERVICE_NAME = 4;
          public const int TCI_COUNTY_NAME = 5;
          public const int TCI_BE_EMSOF_PARTICIPANT = 6;
          }

        private struct p_type
          {
          public bool be_interactive;
          public bool be_loaded;
          public bool be_ok_to_update_service_email_address;
          public bool be_sort_order_ascending;
          public TClass_biz_services biz_services;
          public uint num_nonparticipants;
          public uint num_participants;
          public uint num_respondents;
          public uint num_services;
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
            if (Session["UserControl_responding_services.p"] != null)
            {
                p = (p_type)(Session["UserControl_responding_services.p"]);
                p.be_loaded = IsPostBack && ((Session["UserControl_regional_staffer_binder_control_UserControl_regional_staffer_current_binder_PlaceHolder_content"] as string) == "UserControl_responding_services");
            }
            else
            {
                p.biz_services = new TClass_biz_services();
                p.be_interactive = !(Session["mode:report"] != null);
                p.be_loaded = false;
                p.be_ok_to_update_service_email_address = (HttpContext.Current.User.IsInRole("director") || HttpContext.Current.User.IsInRole("emsof-coordinator"));
                p.be_sort_order_ascending = true;
                p.num_nonparticipants = 0;
                p.num_participants = 0;
                p.num_respondents = 0;
                p.num_services = 0;
                p.sort_order = "service_name%";
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
            this.PreRender += this.TWebUserControl_responding_services_PreRender;
            //this.Load += this.Page_Load;
        }

        private void TWebUserControl_responding_services_PreRender(object sender, System.EventArgs e)
        {
            SessionSet("UserControl_responding_services.p", p);
        }

        public TWebUserControl_responding_services Fresh()
        {
            TWebUserControl_responding_services result;
            Session.Remove("UserControl_responding_services.p");
            result = this;
            return result;
        }

        private void DataGrid_control_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
        {
            if (new ArrayList(new object[] {ListItemType.AlternatingItem, ListItemType.Item, ListItemType.EditItem, ListItemType.SelectedItem}).Contains(e.Item.ItemType))
              {
              SessionSet("affiliate_num", k.Safe(e.Item.Cells[UserControl_responding_services_Static.TCI_AFFILIATE_NUM].Text, k.safe_hint_type.NUM));
              if (e.CommandName == "update-email-address")
                {
                DropCrumbAndTransferTo("administer_service_email_address.aspx");
                }
              else if (e.CommandName == "profile-tabbed")
                {
                SessionSet("mode:profile-rendition","create-refresh-edit");
                DropCrumbAndTransferTo("responding_services_detail.aspx");
                }
              else if (e.CommandName == "profile-printable")
                {
                SessionSet("mode:profile-rendition","printable-report");
                DropCrumbAndTransferTo("responding_services_detail.aspx");
                }
              }
        }

        private void DataGrid_control_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
        {
            LinkButton link_button;
            if (p.be_interactive)
            {
                if (new ArrayList(new object[] {ListItemType.AlternatingItem, ListItemType.Item, ListItemType.EditItem, ListItemType.SelectedItem}).Contains(e.Item.ItemType))
                {
                    link_button = ((e.Item.Cells[UserControl_responding_services_Static.TCI_UPDATE_EMAIL_ADDRESS].Controls[0]) as LinkButton);
                    link_button.Text = k.ExpandTildePath(link_button.Text);
                    link_button.ToolTip = "Update email address";
                    ScriptManager.GetCurrent(Page).RegisterPostBackControl(link_button);
                    link_button = ((e.Item.Cells[UserControl_responding_services_Static.TCI_PROFILE_TABBED].Controls[0]) as LinkButton);
                    link_button.Text = k.ExpandTildePath(link_button.Text);
                    link_button.ToolTip = "Profile (tabbed)";
                    ScriptManager.GetCurrent(Page).RegisterPostBackControl(link_button);
                    link_button = ((e.Item.Cells[UserControl_responding_services_Static.TCI_PROFILE_PRINTABLE].Controls[0]) as LinkButton);
                    link_button.Text = k.ExpandTildePath(link_button.Text);
                    link_button.ToolTip = "Profile (printable)";
                    ScriptManager.GetCurrent(Page).RegisterPostBackControl(link_button);
                    p.num_services++;
                    var participation = e.Item.Cells[UserControl_responding_services_Static.TCI_BE_EMSOF_PARTICIPANT].Text;
                    if (participation != "no response")
                      {
                      p.num_respondents++;
                      if (participation == "YES")
                        {
                        p.num_participants = p.num_participants + 1;
                        }
                      else
                        {
                        p.num_nonparticipants = p.num_nonparticipants + 1;
                        }
                      }
                }
            }
            else
            {
                e.Item.Cells[UserControl_responding_services_Static.TCI_PROFILE_TABBED].Visible = false;
                e.Item.Cells[UserControl_responding_services_Static.TCI_PROFILE_PRINTABLE].Visible = false;
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
            DataGrid_control.Columns[UserControl_responding_services_Static.TCI_UPDATE_EMAIL_ADDRESS].Visible = p.be_ok_to_update_service_email_address;
            p.biz_services.BindAnnualRespondents(p.sort_order, p.be_sort_order_ascending, DataGrid_control);
            Label_num_nonparticipants.Text = p.num_nonparticipants.ToString();
            Label_num_participants.Text = p.num_participants.ToString();
            Label_num_respondents.Text = p.num_respondents.ToString();
            Label_num_services.Text = p.num_services.ToString();
            p.num_nonparticipants = 0;
            p.num_participants = 0;
            p.num_respondents = 0;
            p.num_services = 0;

        }

    } // end TWebUserControl_responding_services

}

