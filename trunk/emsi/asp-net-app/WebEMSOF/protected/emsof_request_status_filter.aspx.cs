using System.Configuration;

using kix;

using System;
using System.Collections;
using System.ComponentModel;
using System.Web;
using System.Web.SessionState;

using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;



using Class_biz_accounts;
using Class_biz_emsof_requests;
using Class_biz_user;
namespace emsof_request_status_filter
{
    public partial class TWebForm_emsof_request_status_filter: ki_web_ui.page_class
    {
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
                if ((Session["emsof_request_status_filter.p"] != null))
                {
                    p = (p_type)(Session["emsof_request_status_filter.p"]);
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
                Title.InnerText = Server.HtmlEncode(ConfigurationManager.AppSettings["application_name"]) + " - emsof_request_status_filter";
                Label_status.Text = Session["status_of_interest"].ToString();
                LinkButton_retransmit_to_state.Visible = (((status_type)(Session["status_of_interest"])) == Class_biz_emsof_requests.status_type.NEEDS_PA_DOH_EMSO_APPROVAL);
                // Initialize instance private data members.
                p.biz_accounts = new TClass_biz_accounts();
                p.biz_emsof_requests = new TClass_biz_emsof_requests();
                p.biz_user = new TClass_biz_user();
                p.be_sort_order_ascending = true;
                p.num_qualifying_requests = 0;
                p.sort_order = "affiliate_num";
                BindOverview();
            }
        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
        }

        protected void Button_send_Click(object sender, System.EventArgs e)
        {
            // from
            // to
            // subject
            // body
            // be_html
            // cc
            // bcc
            // reply_to
            k.SmtpMailSend(ConfigurationManager.AppSettings["sender_email_address"], Label_distribution_list.Text, TextBox_quick_message_subject.Text, "-- From " + Session[p.biz_user.Kind() + "_name"].ToString() + " (via " + ConfigurationManager.AppSettings["application_name"] + ")" + k.NEW_LINE + k.NEW_LINE + TextBox_quick_message_body.Text, false, k.EMPTY, k.EMPTY, p.biz_accounts.EmailAddressByKindId(p.biz_user.Kind(), p.biz_user.IdNum()));
            TextBox_quick_message_subject.Text = k.EMPTY;
            TextBox_quick_message_body.Text = k.EMPTY;
            Alert(k.alert_cause_type.LOGIC, k.alert_state_type.NORMAL, "messagsnt", "Message sent", true);
        }

        protected void LinkButton_retransmit_to_state_Click(object sender, System.EventArgs e)
        {
            DropCrumbAndTransferTo("state_required_report.aspx");
        }

        private void TWebForm_emsof_request_status_filter_PreRender(object sender, System.EventArgs e)
        {
            SessionSet("emsof_request_status_filter.p", p);
        }

        private void DataGrid_requests_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
        {
            // Manage column visibility
            e.Item.Cells[Units.emsof_request_status_filter.TCCI_LINKBUTTON_SELECT].Visible = p.biz_emsof_requests.BeOkToDrillDown((status_type)(Session["status_of_interest"]));
            if ((e.Item.ItemType == ListItemType.AlternatingItem) || (e.Item.ItemType == ListItemType.EditItem) || (e.Item.ItemType == ListItemType.Item) || (e.Item.ItemType == ListItemType.SelectedItem))
            {
                // We are dealing with a data row, not a header or footer row.
                if (e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfPasswordResetEmailAddress())].Text != "&nbsp;")
                {
                    p.distribution_list = p.distribution_list + e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfPasswordResetEmailAddress())].Text + k.COMMA_SPACE;
                }
                p.num_qualifying_requests = p.num_qualifying_requests + 1;
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
            bool be_datagrid_empty;
            p.biz_emsof_requests.BindOverviewByStatus((status_type)(Session["status_of_interest"]), p.sort_order, p.be_sort_order_ascending, DataGrid_requests);
            // Manage control visibilities.
            be_datagrid_empty = (p.num_qualifying_requests == 0);
            TableRow_none.Visible = be_datagrid_empty;
            TableRow_data.Visible = !be_datagrid_empty;
            LinkButton_retransmit_to_state.Enabled = !be_datagrid_empty;
            Table_quick_message.Visible = !be_datagrid_empty;
            Label_distribution_list.Text = (p.distribution_list + k.SPACE).TrimEnd(new char[] {Convert.ToChar(k.COMMA), Convert.ToChar(k.SPACE)});
            // Clear aggregation vars for next bind, if any.
            p.num_qualifying_requests = 0;

        }

        private struct p_type
        {
            public bool be_sort_order_ascending;
            public TClass_biz_accounts biz_accounts;
            public TClass_biz_emsof_requests biz_emsof_requests;
            public TClass_biz_user biz_user;
            public string distribution_list;
            public uint num_qualifying_requests;
            public string sort_order;
        } // end p_type

    } // end TWebForm_emsof_request_status_filter

}

namespace emsof_request_status_filter.Units
{
    public class emsof_request_status_filter
    {
        public const int TCCI_LINKBUTTON_SELECT = 14;
    } // end emsof_request_status_filter

}

