using Class_biz_accounts;
using Class_biz_emsof_requests;
using Class_biz_user;
using kix;
using System;
using System.Configuration;
using System.Drawing;
using System.Text;
using System.Web.UI.WebControls;

namespace all_emsof_requests
  {
  public partial class TWebForm_all_emsof_requests: ki_web_ui.page_class
    {

    private struct p_type
      {
      public TClass_biz_accounts biz_accounts;
      public TClass_biz_emsof_requests biz_emsof_requests;
      public bool be_datagrid_empty;
      public bool be_sort_order_ascending;
      public TClass_biz_user biz_user;
      public uint num_datagrid_rows;
      public string sort_order;
      }

    private struct v_type
      {
      public StringBuilder distribution_list;
      }

    private p_type p; // Private Parcel of Page-Pertinent Process-Persistent Parameters
    private v_type v; // Volatile instance Variable container

        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            DataGrid_requests.ItemDataBound += new DataGridItemEventHandler(DataGrid_requests_ItemDataBound);
            DataGrid_requests.SortCommand += new DataGridSortCommandEventHandler(DataGrid_requests_SortCommand);
            DataGrid_requests.ItemCommand += new DataGridCommandEventHandler(DataGrid_requests_ItemCommand);
            PreRender += TWebForm_all_emsof_requests_PreRender;
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            Title = Server.HtmlEncode(ConfigurationManager.AppSettings["application_name"]) + " - all_emsof_requests";
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
                // Initialize private class instance vars.
                p.biz_accounts = new TClass_biz_accounts();
                p.biz_emsof_requests = new TClass_biz_emsof_requests();
                p.biz_user = new TClass_biz_user();
                p.be_sort_order_ascending = true;
                p.num_datagrid_rows = 0;
                p.sort_order = "service_name";
                Label_author_email_address.Text = p.biz_accounts.EmailAddressByKindId(p.biz_user.Kind(), p.biz_user.IdNum());
                Bind();
            }
        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
            //
            v.distribution_list = new StringBuilder();
        }

        protected void Button_send_Click(object sender, System.EventArgs e)
        {
            k.SmtpMailSend
              (
              from:ConfigurationManager.AppSettings["sender_email_address"],
              to:Label_distribution_list.Text,
              subject:TextBox_quick_message_subject.Text,
              message_string:"-- From " + Session[p.biz_user.Kind() + "_name"].ToString() + " (via " + ConfigurationManager.AppSettings["application_name"] + ")" + k.NEW_LINE
              + k.NEW_LINE
              + TextBox_quick_message_body.Text,
              be_html:false,
              cc:k.EMPTY,
              bcc:p.biz_accounts.EmailAddressByKindId(p.biz_user.Kind(), p.biz_user.IdNum()),
              reply_to:p.biz_accounts.EmailAddressByKindId(p.biz_user.Kind(), p.biz_user.IdNum())
              );
            TextBox_quick_message_subject.Text = k.EMPTY;
            TextBox_quick_message_body.Text = k.EMPTY;
            Alert(k.alert_cause_type.LOGIC, k.alert_state_type.NORMAL, "messagsnt", "Message sent", true);
        }

        private void DataGrid_requests_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                switch(p.biz_emsof_requests.StatusOf(e.Item))
                {
                    case Class_biz_emsof_requests.status_type.NEEDS_SENT_TO_PA_DOH_EMSO:
                        SessionSet("status_of_interest", Class_biz_emsof_requests.status_type.NEEDS_SENT_TO_PA_DOH_EMSO);
                        ((System.Collections.Stack)(Session["waypoint_stack"])).Push("all_emsof_requests.aspx");
                        DropCrumbAndTransferTo("state_required_report.aspx");
                        break;
                    default:
                        SessionSet("account_descriptor", Session["regional_staffer_name"].ToString());
                        SessionSet("e_item", e.Item);
                        ((System.Collections.Stack)(Session["waypoint_stack"])).Push("all_emsof_requests.aspx");
                        DropCrumbAndTransferTo("full_request_review_approve.aspx");
                        break;
                }
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
            Bind();
        }

        private void DataGrid_requests_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
        {
            if ((e.Item.ItemType == ListItemType.AlternatingItem) || (e.Item.ItemType == ListItemType.EditItem) || (e.Item.ItemType == ListItemType.Item) || (e.Item.ItemType == ListItemType.SelectedItem))
            {
                // We are dealing with a data row, not a header or footer row.
                p.num_datagrid_rows++;
                if (p.biz_emsof_requests.BeOkToDrillDown(((status_type)(Convert.ToInt16(e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfStatusCode())].Text)))))
                {
                    ((e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfStatusDescription())].Controls[0]) as LinkButton).Enabled = true;
                    ((e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfStatusDescription())].Controls[0]) as LinkButton).ForeColor = Color.Blue;
                    if (p.biz_emsof_requests.BeOkToApproveEmsofRequest(((status_type)(Convert.ToInt16(e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfStatusCode())].Text)))))
                    {
                        ((e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfStatusDescription())].Controls[0]) as LinkButton).Font.Bold = true;
                        ((e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfStatusDescription())].Controls[0]) as LinkButton).Text = ">" + ((e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfStatusDescription())].Controls[0]) as LinkButton).Text.ToUpper() + "<";
                    }
                }
                else
                {
                    ((e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfStatusDescription())].Controls[0]) as LinkButton).Enabled = false;
                }
                if (e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfPasswordResetEmailAddress())].Text != "&nbsp;")
                {
                    v.distribution_list.Append(k.COMMA_SPACE);
                    v.distribution_list.Append(e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfPasswordResetEmailAddress())].Text);
                }
            }
        }

        private void TWebForm_all_emsof_requests_PreRender(object sender, System.EventArgs e)
        {
            SessionSet(InstanceId() + ".p", p);
        }

        private void Bind()
        {
            p.biz_emsof_requests.BindOverviewAll(p.sort_order, p.be_sort_order_ascending, DataGrid_requests);
            // Manage control visibilities.
            p.be_datagrid_empty = (p.num_datagrid_rows == 0);
            TableRow_none.Visible = p.be_datagrid_empty;
            TableRow_data.Visible = !p.be_datagrid_empty;
            Table_quick_message.Visible = !p.be_datagrid_empty;
            Label_distribution_list.Text = v.distribution_list.Remove(0,2).ToString(); // .TrimStart(k.COMMA_SPACE)
            // Clear aggregation vars for next bind, if any.
            Label_num_datagrid_rows.Text = p.num_datagrid_rows.ToString();
            p.num_datagrid_rows = 0;

        }

    } // end TWebForm_all_emsof_requests

}
