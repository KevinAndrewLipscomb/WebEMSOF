using AjaxControlToolkit;
using Class_biz_accounts;
using Class_biz_emsof_requests;
using Class_biz_user;
using kix;
using System;
using System.Configuration;
using System.Web.UI.WebControls;

namespace emsof_request_status_filter
{

  public class emsof_request_status_filter_Static
    {
    //
    // Keep these values in sync with the values declared in Class_db_emsof_requests.cs.
    //
    public static int TCCI_ID = 0;
    public static int TCCI_SERVICE_ID = 1;
    public static int TCCI_AFFILIATE_NUM = 2;
    public static int TCCI_SERVICE_NAME = 3;
    public static int TCCI_COUNTY_CODE = 4;
    public static int TCCI_SPONSOR_COUNTY = 5;
    public static int TCCI_COUNTY_EMAIL_ADDRESS = 6;
    public static int TCCI_FISCAL_YEAR_DESIGNATOR = 7;
    public static int TCCI_EMSOF_ANTE = 8;
    public static int TCCI_APPROPRIATION = 9;
    public static int TCCI_LEFTOVER_OR_SHORTAGE = 10;
    public static int TCCI_HAS_WISH_LIST = 11;
    public static int TCCI_PASSWORD_RESET_EMAIL_ADDRESS = 12;
    public static int TCCI_STATUS_CODE = 13;
    public static int TCCI_STATUS_DESCRIPTION = 14;
    public static int TCCI_LINKBUTTON_SELECT = 15;
    public static int TCCI_SELECT_FOR_QUICKMESSAGE = 16;
    }

    public partial class TWebForm_emsof_request_status_filter: ki_web_ui.page_class
    {

        private struct p_type
          {
          public bool be_sort_order_ascending;
          public TClass_biz_accounts biz_accounts;
          public TClass_biz_emsof_requests biz_emsof_requests;
          public TClass_biz_user biz_user;
          public string cc_list;
          public string distribution_list;
          public uint num_qualifying_requests;
          public k.int_sign_range scope;
          public string sort_order;
          public string user_email_address;
          }

        private p_type p;

        protected System.Web.UI.WebControls.PlaceHolder PlaceHolder_precontent = null;
        protected System.Web.UI.WebControls.PlaceHolder PlaceHolder_postcontent = null;
        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            this.DataGrid_requests.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.DataGrid_requests_ItemDataBound);
            this.DataGrid_requests.SortCommand += new System.Web.UI.WebControls.DataGridSortCommandEventHandler(this.DataGrid_requests_SortCommand);
            this.DataGrid_requests.ItemCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.DataGrid_requests_ItemCommand);
            this.PreRender += this.TWebForm_emsof_request_status_filter_PreRender;
            //this.Load += this.Page_Load;
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (IsPostBack)
            {
                if ((Session[InstanceId() + ".p"] != null))
                {
                    p = (p_type)(Session[InstanceId() + ".p"]);
                }
                else
                {
                    Server.Transfer("~/timeout.aspx");
                }
            }
            else
            {
                if (Request.ServerVariables["URL"] == Request.CurrentExecutionFilePath)
                {
                    Session.Clear();
                    Server.Transfer("~/login.aspx");
                }
                Title = Server.HtmlEncode(ConfigurationManager.AppSettings["application_name"]) + " - emsof_request_status_filter";
                Label_status.Text = Session["status_of_interest"].ToString();
                LinkButton_retransmit_to_state.Visible = (((status_type)(Session["status_of_interest"])) == Class_biz_emsof_requests.status_type.NEEDS_PA_DOH_EMSO_APPROVAL);
                Label_author_email_address.Text = p.user_email_address;
                BindOverview();
            }
        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
            //
            p.biz_accounts = new TClass_biz_accounts();
            p.biz_emsof_requests = new TClass_biz_emsof_requests();
            p.biz_user = new TClass_biz_user();
            //
            p.be_sort_order_ascending = true;
            p.cc_list = k.EMPTY;
            p.distribution_list = k.EMPTY;
            p.num_qualifying_requests = 0;
            p.scope = new k.int_sign_range();
            p.sort_order = "affiliate_num";
            p.user_email_address = p.biz_accounts.EmailAddressByKindId(p.biz_user.Kind(), p.biz_user.IdNum());
            //
            if (Session["mode:be_for_prior_cycles"] != null)
              {
              p.scope.val = 1;
              Session.Remove("mode:be_for_prior_cycles");
              }
        }

        protected void Button_send_Click(object sender, System.EventArgs e)
          {
          if (p.distribution_list.Length > 0)
            {
            k.SmtpMailSend
              (
              from:ConfigurationManager.AppSettings["sender_email_address"],
              to:k.Safe(Label_distribution_list.Text,k.safe_hint_type.EMAIL_ADDRESS_CSV),
              subject:k.Safe(TextBox_quick_message_subject.Text,k.safe_hint_type.PUNCTUATED),
              message_string:"-- From " + Session[p.biz_user.Kind() + "_name"].ToString() + " (via " + ConfigurationManager.AppSettings["application_name"] + ")" + k.NEW_LINE
              + k.NEW_LINE
              + k.Safe(TextBox_quick_message_body.Text,k.safe_hint_type.MEMO),
              be_html:false,
              cc:p.cc_list,
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
          BuildDistributionListAndRegisterPostBackControls();
          }

    protected void CheckBox_force_all_CheckedChanged(object sender, EventArgs e)
      {
      for (var i = new k.subtype<int>(0,DataGrid_requests.Items.Count); i.val < i.LAST; i.val++)
        {
        (DataGrid_requests.Items[i.val].Cells[emsof_request_status_filter_Static.TCCI_SELECT_FOR_QUICKMESSAGE].FindControl("CheckBox_selected") as CheckBox).Checked = (sender as CheckBox).Checked;
        }
      BuildDistributionListAndRegisterPostBackControls();
      }

    protected void CheckBox_selected_CheckedChanged(object sender, EventArgs e)
      {
      BuildDistributionListAndRegisterPostBackControls();
      }

    private void BuildDistributionListAndRegisterPostBackControls()
      {
      p.distribution_list = k.EMPTY;
      p.cc_list = k.EMPTY;
      TableCellCollection tcc;
      for (var i = new k.subtype<int>(0, DataGrid_requests.Items.Count); i.val < i.LAST; i.val++)
        {
        tcc = DataGrid_requests.Items[i.val].Cells;
        if ((tcc[emsof_request_status_filter_Static.TCCI_SELECT_FOR_QUICKMESSAGE].FindControl("CheckBox_selected") as CheckBox).Checked)
          {
          p.distribution_list += tcc[emsof_request_status_filter_Static.TCCI_PASSWORD_RESET_EMAIL_ADDRESS].Text + k.COMMA_SPACE;
          var county_email_address = tcc[(int)(p.biz_emsof_requests.TcciOfCountyEmailAddress())].Text;
          if ((county_email_address != "&nbsp;") && (!p.cc_list.Contains(county_email_address)))
            {
            p.cc_list += county_email_address + k.COMMA_SPACE;
            }
          }
        ToolkitScriptManager.GetCurrent(Page).RegisterPostBackControl((tcc[emsof_request_status_filter_Static.TCCI_STATUS_DESCRIPTION].Controls[0]) as LinkButton);
        }
      Label_distribution_list.Text = p.distribution_list.TrimEnd(new char[] {Convert.ToChar(k.COMMA),Convert.ToChar(k.SPACE)});
      Label_cc_list.Text = p.cc_list.TrimEnd(new char[] {Convert.ToChar(k.COMMA),Convert.ToChar(k.SPACE)});
      }

        protected void LinkButton_retransmit_to_state_Click(object sender, System.EventArgs e)
        {
            DropCrumbAndTransferTo("state_required_report.aspx");
        }

        private void TWebForm_emsof_request_status_filter_PreRender(object sender, System.EventArgs e)
        {
            SessionSet(InstanceId() + ".p", p);
        }

        private void DataGrid_requests_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
        {
            // Manage column visibility
            e.Item.Cells[emsof_request_status_filter_Static.TCCI_STATUS_DESCRIPTION].Visible = p.biz_emsof_requests.BeOkToDrillDown((status_type)(Session["status_of_interest"]));
            if ((e.Item.ItemType == ListItemType.AlternatingItem) || (e.Item.ItemType == ListItemType.EditItem) || (e.Item.ItemType == ListItemType.Item) || (e.Item.ItemType == ListItemType.SelectedItem))
            {
                // We are dealing with a data row, not a header or footer row.
                p.num_qualifying_requests = p.num_qualifying_requests + 1;
                //--
                // DON'T disable viewstate here since thes server needs it to repopulate bound controls when an update is made as a result of a QuickMessage checkbox change.
                //--
            }
        }

        private void DataGrid_requests_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
        {
            if ((e.Item.ItemType == ListItemType.AlternatingItem) || (e.Item.ItemType == ListItemType.EditItem) || (e.Item.ItemType == ListItemType.Item) || (e.Item.ItemType == ListItemType.SelectedItem))
            {
                // We are dealing with a data row, not a header or footer row.
                ((System.Collections.Stack)(Session["waypoint_stack"])).Push("emsof_request_status_filter.aspx");
                SessionSet("account_descriptor", Session["regional_staffer_name"].ToString());
                SessionSet("e_item", e.Item);
                DropCrumbAndTransferTo("full_request_review_approve.aspx");
            }

        }

        private void DataGrid_requests_SortCommand(object source, System.Web.UI.WebControls.DataGridSortCommandEventArgs e)
        {
            if (e.SortExpression == p.sort_order)
            {
                p.be_sort_order_ascending = !p.be_sort_order_ascending;
            }
            else
            {
                p.sort_order = e.SortExpression;
                p.be_sort_order_ascending = true;
            }
            DataGrid_requests.EditItemIndex =  -1;
            BindOverview();
        }

        private void BindOverview()
        {
            p.biz_emsof_requests.BindOverviewByStatus((status_type)(Session["status_of_interest"]), p.sort_order, p.be_sort_order_ascending, DataGrid_requests, p.scope);
            // Manage control visibilities.
            var be_datagrid_empty = (p.num_qualifying_requests == 0);
            TableRow_none.Visible = be_datagrid_empty;
            TableRow_data.Visible = !be_datagrid_empty;
            LinkButton_retransmit_to_state.Enabled = !be_datagrid_empty;
            Table_quick_message.Visible = !be_datagrid_empty;
            // Clear aggregation vars for next bind, if any.
            p.num_qualifying_requests = 0;
            BuildDistributionListAndRegisterPostBackControls();
        }

    } // end TWebForm_emsof_request_status_filter

}

