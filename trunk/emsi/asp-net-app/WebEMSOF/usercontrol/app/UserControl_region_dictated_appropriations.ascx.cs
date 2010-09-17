// Derived from KiAspdotnetFramework/UserControl/app/UserControl~template~datagrid~sortable.ascx.cs

using Class_biz_accounts;
using Class_biz_appropriations;
using Class_biz_user;
using kix;
using System;
using System.Collections;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UserControl_region_dictated_appropriations
  {
  public partial class TWebUserControl_region_dictated_appropriations: ki_web_ui.usercontrol_class
    {
    public class UserControl_region_dictated_appropriations_Static
      {
      public const int TCI_SELECT = 0;
      public const int TCI_ID = 1;
      public const int TCI_CODE = 2;
      public const int TCI_EMAIL_ADDRESS = 3;
      public const int TCI_NAME = 4;
      public const int TCI_AMOUNT = 5;
      public const int TCI_DEADLINE = 6;
      public const int TCI_MATCH_LEVEL = 7;
      }

    private struct p_type
      {
      public bool be_interactive;
      public bool be_loaded;
      public bool be_sort_order_ascending;
      public TClass_biz_accounts biz_accounts;
      public TClass_biz_appropriations biz_appropriations;
      public TClass_biz_user biz_user;
      public string distribution_list;
      public uint num_region_dictated_appropriations;
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
        BindGrid();
        p.be_loaded = true;
        }
      InjectPersistentClientSideScript();
      }

    protected override void OnInit(System.EventArgs e)
      {
      // Required for Designer support
      InitializeComponent();
      base.OnInit(e);
      if (Session["UserControl_region_dictated_appropriations.p"] != null)
        {
        p = (p_type)(Session["UserControl_region_dictated_appropriations.p"]);
        p.be_loaded = IsPostBack && ((Session["UserControl_regional_staffer_binder_UserControl_regional_staffer_current_binder_PlaceHolder_content"] as string) == "UserControl_region_dictated_appropriations");
        }
      else
        {
        p.biz_accounts = new TClass_biz_accounts();
        p.biz_appropriations = new TClass_biz_appropriations();
        p.biz_user = new TClass_biz_user();
        p.be_interactive = !(Session["mode:report"] != null);
        p.be_loaded = false;
        p.be_sort_order_ascending = true;
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
      this.PreRender += this.TWebUserControl_region_dictated_appropriations_PreRender;
      //this.Load += this.Page_Load;
      }

    private void TWebUserControl_region_dictated_appropriations_PreRender(object sender, System.EventArgs e)
      {
      SessionSet("UserControl_region_dictated_appropriations.p", p);
      }

    public TWebUserControl_region_dictated_appropriations Fresh()
      {
      Session.Remove("UserControl_region_dictated_appropriations.p");
      return this;
      }

    private void DataGrid_control_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
      {
      if (new ArrayList(new object[] {ListItemType.AlternatingItem, ListItemType.Item, ListItemType.EditItem, ListItemType.SelectedItem}).Contains(e.Item.ItemType))
        {
        SessionSet("region_dictated_appropriation_summary",p.biz_appropriations.RegionDictumSummary(k.Safe(e.Item.Cells[UserControl_region_dictated_appropriations_Static.TCI_ID].Text,k.safe_hint_type.NUM)));
        DropCrumbAndTransferTo("county_dictated_appropriations.aspx");
        }
      }

    private void DataGrid_control_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
      {
      LinkButton link_button;
      if (p.be_interactive)
        {
        if (new ArrayList(new object[] {ListItemType.AlternatingItem, ListItemType.Item, ListItemType.EditItem, ListItemType.SelectedItem}).Contains(e.Item.ItemType))
          {
          link_button = ((e.Item.Cells[UserControl_region_dictated_appropriations_Static.TCI_SELECT].Controls[0]) as LinkButton);
          link_button.Text = k.ExpandTildePath(link_button.Text);
          ScriptManager.GetCurrent(Page).RegisterPostBackControl(link_button);
          //
          // Remove all cell controls from viewstate except for the one at TCI_CODE.
          //
          foreach (TableCell cell in e.Item.Cells)
            {
            cell.EnableViewState = false;
            }
          e.Item.Cells[UserControl_region_dictated_appropriations_Static.TCI_CODE].EnableViewState = true;
          //
          p.distribution_list = p.distribution_list + e.Item.Cells[UserControl_region_dictated_appropriations_Static.TCI_EMAIL_ADDRESS].Text + k.COMMA_SPACE;
          p.num_region_dictated_appropriations++;
          }
        }
      else
        {
        e.Item.Cells[UserControl_region_dictated_appropriations_Static.TCI_SELECT].Visible = false;
        }
      if (new ArrayList(new object[] {ListItemType.AlternatingItem, ListItemType.Item, ListItemType.EditItem, ListItemType.SelectedItem}).Contains(e.Item.ItemType))
        {
        e.Item.Cells[UserControl_region_dictated_appropriations_Static.TCI_AMOUNT].Text = "<tt>" + e.Item.Cells[UserControl_region_dictated_appropriations_Static.TCI_AMOUNT].Text + "</tt>";
        e.Item.Cells[UserControl_region_dictated_appropriations_Static.TCI_DEADLINE].Text = "<tt>" + e.Item.Cells[UserControl_region_dictated_appropriations_Static.TCI_DEADLINE].Text + "</tt>";
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
      DataGrid_control.EditItemIndex = -1;
      BindGrid();
      }

    private void BindGrid()
      {
      p.biz_appropriations.BindRegionDictums(p.sort_order, p.be_sort_order_ascending, DataGrid_control);
      Label_distribution_list.Text = (p.distribution_list + k.SPACE).TrimEnd(new char[] {Convert.ToChar(k.COMMA), Convert.ToChar(k.SPACE)});
      p.distribution_list = k.EMPTY;
      p.num_region_dictated_appropriations = 0;
      }

    protected void Button_send_Click(object sender, EventArgs e)
      {
      k.SmtpMailSend(ConfigurationManager.AppSettings["sender_email_address"], Label_distribution_list.Text, TextBox_quick_message_subject.Text, "-- From the " + Session[p.biz_user.Kind() + "_name"].ToString() + " County EMSOF Coordinator (via " + ConfigurationManager.AppSettings["application_name"] + ")" + k.NEW_LINE + k.NEW_LINE + TextBox_quick_message_body.Text, false, k.EMPTY, p.biz_accounts.EmailAddressByKindId(p.biz_user.Kind(), p.biz_user.IdNum()), p.biz_accounts.EmailAddressByKindId(p.biz_user.Kind(), p.biz_user.IdNum()));
      TextBox_quick_message_subject.Text = k.EMPTY;
      TextBox_quick_message_body.Text = k.EMPTY;
      Alert(k.alert_cause_type.LOGIC, k.alert_state_type.NORMAL, "messagsnt", "Message sent", true);
      }

    } // end TWebUserControl_region_dictated_appropriations

  }