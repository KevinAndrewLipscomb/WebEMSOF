using Class_biz_emsof_requests;
using Class_biz_fiscal_years;
using kix;
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Collections;

namespace UserControl_fy_allocations_reimbursements_returns
  {
  public class UserControl_fy_allocations_reimbursements_returns_Static
    {
    public const int TCI_SELECT = 0;
    public const int TCI_ID = 1;
    public const int TCI_SERVICE = 2;
    public const int TCI_COUNTY = 3;
    public const int TCI_ALLOCATION = 4;
    public const int TCI_REIMBURSEMENT = 5;
    public const int TCI_RETURN = 6;
    }

  public struct p_type
    {
    public bool be_interactive;
    public bool be_loaded;
    public bool be_sort_order_ascending;
    public TClass_biz_emsof_requests biz_emsof_requests;
    public TClass_biz_fiscal_years biz_fiscal_years;
    public string cycle;
    public string sort_order;
    public k.decimal_nonnegative sum_of_allocations;
    public k.decimal_nonnegative sum_of_reimbursements;
    public k.decimal_nonnegative sum_of_returns;
    }

  public partial class TWebUserControl_fy_allocations_reimbursements_returns: ki_web_ui.usercontrol_class
    {
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
        p.biz_fiscal_years.BindListControl(DropDownList_cycle);
        p.cycle = k.Safe(DropDownList_cycle.SelectedValue, k.safe_hint_type.NUM);
        if (!p.be_interactive)
          {
          DropDownList_cycle.Enabled = false;
          DataGrid_control.AllowSorting = false;
          }
        Bind();
        p.be_loaded = true;
        }
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
        p.be_loaded = IsPostBack && ((Session["UserControl_regional_staffer_binder_UserControl_regional_staffer_cat4pe_binder_UserControl_analyses_binder_PlaceHolder_content"] as string) == "UserControl_fy_allocations_reimbursements_returns");
        }
      else
        {
        p.biz_emsof_requests = new TClass_biz_emsof_requests();
        p.biz_fiscal_years = new TClass_biz_fiscal_years();
        p.be_interactive = !(Session["mode:report"] != null);
        p.be_loaded = false;
        p.be_sort_order_ascending = true;
        p.sort_order = "amount_returned desc,service_name,county_name,master_id";
        p.sum_of_allocations = new k.decimal_nonnegative();
        p.sum_of_reimbursements = new k.decimal_nonnegative();
        p.sum_of_returns = new k.decimal_nonnegative();
        }
      }

    // / <summary>
    // / Required method for Designer support -- do not modify
    // / the contents of this method with the code editor.
    // / </summary>
    private void InitializeComponent()
      {
      DataGrid_control.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.DataGrid_control_ItemDataBound);
      DataGrid_control.SortCommand += new System.Web.UI.WebControls.DataGridSortCommandEventHandler(this.DataGrid_control_SortCommand);
      PreRender += this.TWebUserControl_fy_allocations_reimbursements_returns_PreRender;
      }

    private void TWebUserControl_fy_allocations_reimbursements_returns_PreRender(object sender, System.EventArgs e)
      {
      SessionSet(InstanceId() + ".p", p);
      }

    public TWebUserControl_fy_allocations_reimbursements_returns Fresh()
      {
      Session.Remove(InstanceId() + ".p");
      return this;
      }

    private void DataGrid_control_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
      {
      var be_item_signif = new ArrayList {ListItemType.AlternatingItem,ListItemType.Item,ListItemType.EditItem,ListItemType.SelectedItem}.Contains(e.Item.ItemType);
      if (p.be_interactive && be_item_signif)
        {
        var link_button = ((e.Item.Cells[UserControl_fy_allocations_reimbursements_returns_Static.TCI_SELECT].Controls[0]) as LinkButton);
        link_button.Text = k.ExpandTildePath(link_button.Text);
        ScriptManager.GetCurrent(Page).RegisterPostBackControl(link_button);
        }
      if (be_item_signif)
        {
        p.sum_of_allocations.val += decimal.Parse(k.Safe(e.Item.Cells[UserControl_fy_allocations_reimbursements_returns_Static.TCI_ALLOCATION].Text,k.safe_hint_type.REAL_NUM));
        p.sum_of_reimbursements.val += decimal.Parse(k.Safe(e.Item.Cells[UserControl_fy_allocations_reimbursements_returns_Static.TCI_REIMBURSEMENT].Text,k.safe_hint_type.REAL_NUM));
        p.sum_of_returns.val += decimal.Parse(k.Safe(e.Item.Cells[UserControl_fy_allocations_reimbursements_returns_Static.TCI_RETURN].Text,k.safe_hint_type.REAL_NUM));
        }
      if (!p.be_interactive)
        {
        e.Item.Cells[UserControl_fy_allocations_reimbursements_returns_Static.TCI_SELECT].Visible = false;
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

    protected void DropDownList_cycle_SelectedIndexChanged(object sender, System.EventArgs e)
      {
      p.cycle = k.Safe(DropDownList_cycle.SelectedValue, k.safe_hint_type.NUM);
      Bind();
      }

    private void Bind()
      {
      p.biz_fiscal_years.BindAllocationsReimbursementsReturns(p.cycle, p.sort_order, p.be_sort_order_ascending, DataGrid_control);
      Literal_sum_of_allocations.Text = p.sum_of_allocations.val.ToString("C");
      Literal_sum_of_reimbursements.Text = p.sum_of_reimbursements.val.ToString("C");
      Literal_sum_of_returns.Text = p.sum_of_returns.val.ToString("C");
      p.sum_of_allocations.val = 0;
      p.sum_of_reimbursements.val = 0;
      p.sum_of_returns.val = 0;
      }

    }

  }