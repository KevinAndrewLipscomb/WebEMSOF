// Derived from KiAspdotnetFramework/UserControl/app/UserControl~template~datagrid~sortable.pas

using Class_biz_accounts;
using Class_biz_services;
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

namespace UserControl_responding_services
  {
  public partial class TWebUserControl_responding_services: ki_web_ui.usercontrol_class
    {

        private static class Static
          {
          public const int TCI_UPDATE_EMAIL_ADDRESS = 0;
          public const int TCI_PROFILE_TABBED = 1;
          public const int TCI_PROFILE_PRINTABLE = 2;
          public const int TCI_IMITATE = 3;
          public const int TCI_AFFILIATE_NUM = 4;
          public const int TCI_SELECT = 5;
          public const int TCI_SERVICE_NAME = 6;
          public const int TCI_COUNTY_NAME = 7;
          public const int TCI_BE_EMSOF_PARTICIPANT = 8;
          public const int TCI_PASSWORD_RESET_EMAIL_ADDRESS = 9;
          public const int TCI_CORPADMIN_EMAIL_ADDRESS = 10;
          public const int TCI_COO_EMAIL_ADDRESS = 11;
          }

        private struct p_type
          {
          public bool be_interactive;
          public bool be_loaded;
          public bool be_ok_to_imitate_service;
          public bool be_ok_to_update_service_email_address;
          public bool be_sort_order_ascending;
          public TClass_biz_accounts biz_accounts;
          public TClass_biz_services biz_services;
          public TClass_biz_user biz_user;
          public string county_code;
          public uint num_nonparticipants;
          public uint num_participants;
          public uint num_respondents;
          public uint num_services;
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

    protected void Page_Load(object sender, EventArgs e)
      {
      if (!p.be_loaded)
        {
        if (p.be_interactive)
          {
          DataGrid_control.Columns[Static.TCI_UPDATE_EMAIL_ADDRESS].Visible = p.be_ok_to_update_service_email_address;
          DataGrid_control.Columns[Static.TCI_IMITATE].Visible = p.be_ok_to_imitate_service;
          Literal_author_email_address.Text = p.user_email_address;
          }
        else
          {
          DataGrid_control.AllowSorting = false;
          }
        Bind();
        p.be_loaded = true;
        }
      InjectPersistentClientSideScript();
      }

    protected override void OnInit(EventArgs e)
      {
      // Required for Designer support
      InitializeComponent();
      base.OnInit(e);
      if (Session[InstanceId() + ".p"] != null)
        {
        p = (p_type)(Session[InstanceId() + ".p"]);
        p.be_loaded = IsPostBack && ((Session["UserControl_regional_staffer_binder_UserControl_regional_staffer_cat4pe_binder_UserControl_regional_staffer_current_binder_PlaceHolder_content"] as string) == "UserControl_responding_services");
        }
      else
        {
        p.biz_accounts = new TClass_biz_accounts();
        p.biz_services = new TClass_biz_services();
        p.biz_user = new TClass_biz_user();
        //
        p.be_interactive = !(Session["mode:report"] != null);
        p.be_loaded = false;
        p.be_ok_to_imitate_service = (HttpContext.Current.User.IsInRole("director") || HttpContext.Current.User.IsInRole("emsof-coordinator"));
        p.be_ok_to_update_service_email_address = (HttpContext.Current.User.IsInRole("director") || HttpContext.Current.User.IsInRole("emsof-coordinator"));
        p.be_sort_order_ascending = true;
        p.county_code = (Session["county_user_id"] == null ? k.EMPTY : Session["county_user_id"].ToString());
        p.num_nonparticipants = 0;
        p.num_participants = 0;
        p.num_respondents = 0;
        p.num_services = 0;
        p.sort_order = "service_name%";
        p.user_email_address = p.biz_accounts.EmailAddressByKindId(p.biz_user.Kind(),p.biz_user.IdNum());
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
            PreRender += TWebUserControl_responding_services_PreRender;
        }

        private void TWebUserControl_responding_services_PreRender(object sender, EventArgs e)
        {
            SessionSet(InstanceId() + ".p", p);
        }

        public TWebUserControl_responding_services Fresh()
        {
            TWebUserControl_responding_services result;
            Session.Remove(InstanceId() + ".p");
            result = this;
            return result;
        }

    protected void Button_send_Click(object sender, EventArgs e)
      {
      BuildDistributionListAndRegisterPostBackControls();
      if (Label_distribution_list.Text.Length > 0)
        {
        k.SmtpMailSend
          (
          from:ConfigurationManager.AppSettings["sender_email_address"],
          to:Label_distribution_list.Text,
          subject:k.Safe(TextBox_quick_message_subject.Text,k.safe_hint_type.PUNCTUATED),
          message_string:"-- From " + Session[p.biz_user.Kind() + "_name"].ToString() + " (via " + ConfigurationManager.AppSettings["application_name"] + ")" + k.NEW_LINE
            + k.NEW_LINE
            + k.Safe(TextBox_quick_message_body.Text,k.safe_hint_type.MEMO),
          be_html:false,
          cc:k.EMPTY,
          bcc:p.user_email_address,
          reply_to:p.user_email_address
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
      }

    protected void CheckBox_force_all_CheckedChanged(object sender, EventArgs e)
      {
      for (var i = new k.subtype<int>(0,DataGrid_control.Items.Count); i.val < i.LAST; i.val++)
        {
        (DataGrid_control.Items[i.val].Cells[Static.TCI_SELECT].FindControl("CheckBox_selected") as CheckBox).Checked = (sender as CheckBox).Checked;
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
          v.distribution_list.Append(CheckBox_use_password_reset_email_address.Checked ?  k.COMMA_SPACE + tcc[Static.TCI_PASSWORD_RESET_EMAIL_ADDRESS].Text : k.EMPTY);
          v.distribution_list.Append(CheckBox_use_corpadmin_email_address.Checked ? k.COMMA_SPACE + tcc[Static.TCI_CORPADMIN_EMAIL_ADDRESS].Text : k.EMPTY);
          v.distribution_list.Append(CheckBox_use_coo_email_address.Checked ? k.COMMA_SPACE + tcc[Static.TCI_COO_EMAIL_ADDRESS].Text : k.EMPTY);
          }
        ScriptManager.GetCurrent(Page).RegisterPostBackControl((tcc[Static.TCI_UPDATE_EMAIL_ADDRESS].Controls[0]) as LinkButton);
        ScriptManager.GetCurrent(Page).RegisterPostBackControl((tcc[Static.TCI_PROFILE_TABBED].Controls[0]) as LinkButton);
        ScriptManager.GetCurrent(Page).RegisterPostBackControl((tcc[Static.TCI_PROFILE_PRINTABLE].Controls[0]) as LinkButton);
        ScriptManager.GetCurrent(Page).RegisterPostBackControl((tcc[Static.TCI_IMITATE].Controls[0]) as LinkButton);
        }
      if (v.distribution_list.Length > 0) v.distribution_list.Remove(0,2); // .TrimStart(k.COMMA_SPACE)
      Label_distribution_list.Text = v.distribution_list.ToString();
      }

        private void DataGrid_control_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
        {
            if (new ArrayList {ListItemType.AlternatingItem,ListItemType.Item,ListItemType.EditItem,ListItemType.SelectedItem}.Contains(e.Item.ItemType))
              {
              var affiliate_num = k.Safe(e.Item.Cells[Static.TCI_AFFILIATE_NUM].Text, k.safe_hint_type.NUM);
              SessionSet("affiliate_num",affiliate_num);
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
              else if (e.CommandName == "imitate")
                {
                var service_name = k.Safe(e.Item.Cells[Static.TCI_SERVICE_NAME].Text, k.safe_hint_type.ORG_NAME);
                var service_user_id = p.biz_services.IdOfAffiliateNum(affiliate_num);
                SessionSet(name:"imitator_designator",value:HttpContext.Current.User.Identity.Name);
                SessionSet("target_user_table","service");
                SessionSet("service_user_id",service_user_id);
                SessionSet("service_name",service_name);
                SessionSet("username",service_name);
                FormsAuthentication.RedirectFromLoginPage("service_" + service_user_id,false);
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
                    link_button = ((e.Item.Cells[Static.TCI_UPDATE_EMAIL_ADDRESS].Controls[0]) as LinkButton);
                    link_button.Text = k.ExpandTildePath(link_button.Text);
                    link_button.ToolTip = "Update email address";
                    link_button = ((e.Item.Cells[Static.TCI_PROFILE_TABBED].Controls[0]) as LinkButton);
                    link_button.Text = k.ExpandTildePath(link_button.Text);
                    link_button.ToolTip = "Profile (tabbed)";
                    link_button = ((e.Item.Cells[Static.TCI_PROFILE_PRINTABLE].Controls[0]) as LinkButton);
                    link_button.Text = k.ExpandTildePath(link_button.Text);
                    link_button.ToolTip = "Profile (printable)";
                    link_button = ((e.Item.Cells[Static.TCI_IMITATE].Controls[0]) as LinkButton);
                    link_button.Text = k.ExpandTildePath(link_button.Text);
                    link_button.ToolTip = "Imitate";
                    RequireConfirmation(link_button,"The application will now allow you to imitate a subordinate user.  When you are done imitating the subordinate user, you must log out and log back in as yourself.");
                    p.num_services++;
                    var participation = e.Item.Cells[Static.TCI_BE_EMSOF_PARTICIPANT].Text;
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
                    //--
                    // DON'T disable viewstate here since thes server needs it to repopulate bound controls when an update is made as a result of a QuickMessage checkbox change.
                    //--
                }
            }
            else
            {
                e.Item.Cells[Static.TCI_PROFILE_TABBED].Visible = false;
                e.Item.Cells[Static.TCI_PROFILE_PRINTABLE].Visible = false;
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
            DataGrid_control.Columns[Static.TCI_UPDATE_EMAIL_ADDRESS].Visible = p.be_ok_to_update_service_email_address;
            p.biz_services.BindAnnualRespondents
              (
              sort_order:p.sort_order,
              be_order_ascending:p.be_sort_order_ascending,
              target:DataGrid_control,
              region_code:Session["region_code"].ToString(),
              county_code:p.county_code
              );
            Label_num_nonparticipants.Text = p.num_nonparticipants.ToString();
            Label_num_participants.Text = p.num_participants.ToString();
            Label_num_respondents.Text = p.num_respondents.ToString();
            Label_num_services.Text = p.num_services.ToString();
            p.num_nonparticipants = 0;
            p.num_participants = 0;
            p.num_respondents = 0;
            p.num_services = 0;
            BuildDistributionListAndRegisterPostBackControls();
        }

    } // end TWebUserControl_responding_services

}

