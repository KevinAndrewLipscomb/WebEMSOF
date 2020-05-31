// Derived from KiAspdotnetFramework/UserControl/app/UserControl~template~datagrid~sortable.ascx.cs

using Class_biz_accounts;
using Class_biz_counties;
using Class_biz_user;
using kix;
using System;
using System.Collections;
using System.Configuration;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UserControl_counties
  {
  public partial class TWebUserControl_counties: ki_web_ui.usercontrol_class
    {

    private static class Static
      {
      public const int TCI_CODE = 0;
      public const int TCI_SELECT_FOR_QUICKMESSAGE = 1;
      public const int TCI_NAME = 2;
      public const int TCI_EMAIL_ADDRESS = 3;
      public const int TCI_MATCH_LEVEL = 4;
      public const int TCI_UNALLOCATED = 5;
      public const int TCI_SELECT = 6;
      public const int TCI_IMITATE = 7;
      }

    private struct p_type
      {
      public bool be_interactive;
      public bool be_loaded;
      public bool be_ok_to_change_details;
      public bool be_sort_order_ascending;
      public TClass_biz_accounts biz_accounts;
      public TClass_biz_counties biz_counties;
      public TClass_biz_user biz_user;
      public uint num_counties;
      public string sort_order;
      public string user_email_address;
      }

    private struct v_type
      {
      public StringBuilder distribution_list;
      }

    private p_type p; // Private Parcel of Page-Pertinent Process-Persistent Parameters
    private v_type v; // Volatile instance Variable container

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
        if (p.be_interactive)
          {
          Label_author_email_address.Text = p.user_email_address;
          }
        else
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
      if (Session[InstanceId() + ".p"] != null)
        {
        p = (p_type)(Session[InstanceId() + ".p"]);
        p.be_loaded = IsPostBack && ((Session["UserControl_regional_staffer_binder_UserControl_regional_staffer_cat4pe_binder_UserControl_regional_staffer_current_binder_PlaceHolder_content"] as string) == "UserControl_counties");
        }
      else
        {
        p.biz_accounts = new TClass_biz_accounts();
        p.biz_counties = new TClass_biz_counties();
        p.biz_user = new TClass_biz_user();
        //
        p.be_interactive = !(Session["mode:report"] != null);
        p.be_loaded = false;
        p.be_ok_to_change_details = (HttpContext.Current.User.IsInRole("director") || HttpContext.Current.User.IsInRole("emsof-coordinator"));
        p.be_sort_order_ascending = true;
        p.sort_order = "name%";
        p.user_email_address = p.biz_accounts.EmailAddressByKindId(p.biz_user.Kind(), p.biz_user.IdNum());
        }
      v.distribution_list = new StringBuilder();
      }

    // / <summary>
    // / Required method for Designer support -- do not modify
    // / the contents of this method with the code editor.
    // / </summary>
    private void InitializeComponent()
      {
      DataGrid_control.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(DataGrid_control_ItemDataBound);
      DataGrid_control.SortCommand += new System.Web.UI.WebControls.DataGridSortCommandEventHandler(DataGrid_control_SortCommand);
      DataGrid_control.ItemCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(DataGrid_control_ItemCommand);
      PreRender += TWebUserControl_counties_PreRender;
      }

    private void TWebUserControl_counties_PreRender(object sender, System.EventArgs e)
      {
      SessionSet(InstanceId() + ".p", p);
      }

    public TWebUserControl_counties Fresh()
      {
      Session.Remove(InstanceId() + ".p");
      return this;
      }

    protected void CheckBox_force_all_CheckedChanged(object sender, EventArgs e)
      {
      for (var i = new k.subtype<int>(0,DataGrid_control.Items.Count); i.val < i.LAST; i.val++)
        {
        (DataGrid_control.Items[i.val].Cells[Static.TCI_SELECT_FOR_QUICKMESSAGE].FindControl("CheckBox_selected") as CheckBox).Checked = (sender as CheckBox).Checked;
        }
      BuildDistributionListAndRegisterPostBackControls();
      }

    protected void CheckBox_selected_CheckedChanged(object sender, EventArgs e)
      {
      BuildDistributionListAndRegisterPostBackControls();
      }

    private void BuildDistributionListAndRegisterPostBackControls()
      {
      v.distribution_list.Clear();
      TableCellCollection tcc;
      for (var i = new k.subtype<int>(0, DataGrid_control.Items.Count); i.val < i.LAST; i.val++)
        {
        tcc = DataGrid_control.Items[i.val].Cells;
        if ((tcc[Static.TCI_SELECT].FindControl("CheckBox_selected") as CheckBox).Checked)
          {
          v.distribution_list.Append(k.COMMA_SPACE);
          v.distribution_list.Append(tcc[Static.TCI_EMAIL_ADDRESS].Text);
          }
        ScriptManager.GetCurrent(Page).RegisterPostBackControl((tcc[Static.TCI_SELECT].Controls[0]) as LinkButton);
        ScriptManager.GetCurrent(Page).RegisterPostBackControl((tcc[Static.TCI_IMITATE].Controls[0]) as LinkButton);
        }
      if (v.distribution_list.Length > 0) v.distribution_list.Remove(0,2); // .TrimStart(k.COMMA_SPACE)
      Label_distribution_list.Text = v.distribution_list.ToString();
      }

    private void DataGrid_control_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
      {
      if (new ArrayList {ListItemType.AlternatingItem,ListItemType.Item,ListItemType.EditItem,ListItemType.SelectedItem}.Contains(e.Item.ItemType))
        {
        var county_code = k.Safe(e.Item.Cells[Static.TCI_CODE].Text,k.safe_hint_type.NUM);
        if (e.CommandName == "Edit")
          {
          SessionSet("county_summary",p.biz_counties.Summary(county_code));
          DropCrumbAndTransferTo("county_detail.aspx");
          }
        else if (e.CommandName == "imitate")
          {
          var county_name = k.Safe(e.Item.Cells[Static.TCI_NAME].Text, k.safe_hint_type.ORG_NAME);
          SessionSet(name:"imitator_designator",value:HttpContext.Current.User.Identity.Name);
          SessionSet("target_user_table","county");
          SessionSet("county_user_id",county_code);
          SessionSet("county_name",county_name);
          SessionSet("username",county_name);
          FormsAuthentication.RedirectFromLoginPage("county_" + county_code,false);
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
          link_button = ((e.Item.Cells[Static.TCI_SELECT].Controls[0]) as LinkButton);
          link_button.Text = k.ExpandTildePath(link_button.Text);
          link_button.ToolTip = "Edit";
          link_button = ((e.Item.Cells[Static.TCI_IMITATE].Controls[0]) as LinkButton);
          link_button.Text = k.ExpandTildePath(link_button.Text);
          link_button.ToolTip = "Imitate";
          RequireConfirmation(link_button,"The application will now allow you to imitate a subordinate user.  When you are done imitating the subordinate user, you must log out and log back in as yourself.");
          //--
          // DON'T disable viewstate here since thes server needs it to repopulate bound controls when an update is made as a result of a QuickMessage checkbox change.
          //--
          //
          // Remove all cell controls from viewstate except for the one at TCI_CODE.
          //
          //foreach (TableCell cell in e.Item.Cells)
          //  {
          //  cell.EnableViewState = false;
          //  }
          //e.Item.Cells[UserControl_counties_Static.TCI_CODE].EnableViewState = true;
          //
          p.num_counties++;
          }
        }
      else
        {
        e.Item.Cells[Static.TCI_SELECT].Visible = false;
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
      DataGrid_control.Columns[Static.TCI_SELECT].Visible = p.be_ok_to_change_details;
      p.biz_counties.BindGrid(p.sort_order, p.be_sort_order_ascending, DataGrid_control);
      p.num_counties = 0;
      BuildDistributionListAndRegisterPostBackControls();
      }

    protected void Button_send_Click(object sender, EventArgs e)
      {
      if (Label_distribution_list.Text.Length > 0)
        {
        k.SmtpMailSend
          (
          from:ConfigurationManager.AppSettings["sender_email_address"],
          to:Label_distribution_list.Text,
          subject:TextBox_quick_message_subject.Text,
          message_string:"-- From " + Session[p.biz_user.Kind() + "_name"].ToString() + " (via " + ConfigurationManager.AppSettings["application_name"] + ")" + k.NEW_LINE
            + k.NEW_LINE
            + k.Safe(TextBox_quick_message_body.Text,k.safe_hint_type.MEMO),
          be_html:false,
          cc:k.EMPTY,
          bcc:p.biz_accounts.EmailAddressByKindId(p.biz_user.Kind(), p.biz_user.IdNum()),
          reply_to:p.biz_accounts.EmailAddressByKindId(p.biz_user.Kind(), p.biz_user.IdNum())
          );
        TextBox_quick_message_subject.Text = k.EMPTY;
        TextBox_quick_message_body.Text = k.EMPTY;
        Alert
          (
          cause:k.alert_cause_type.LOGIC,
          state:k.alert_state_type.NORMAL,
          key:"messagsnt",
          value:"Message sent",
          be_using_scriptmanager:true
          );
        }
      else
        {
        Alert
          (
          cause:k.alert_cause_type.USER,
          state:k.alert_state_type.FAILURE,
          key:"noqmrecips",
          value:"Message *NOT* sent.  No recipients are selected.",
          be_using_scriptmanager:true
          );
        }
      BuildDistributionListAndRegisterPostBackControls();
      }

    } // end TWebUserControl_counties

  }