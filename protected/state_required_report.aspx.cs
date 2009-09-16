using System.Configuration;

using kix;

using System;
using System.Collections;
using System.ComponentModel;
using System.Web;
using System.Web.SessionState;

using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;


using System.Web.UI;
using Class_biz_appropriations;
using Class_biz_emsof_requests;
namespace state_required_report
{
    public partial class TWebForm_state_required_report: ki_web_ui.page_class
    {
        private p_type p;
        protected System.Web.UI.WebControls.PlaceHolder PlaceHolder_precontent = null;
        protected System.Web.UI.WebControls.PlaceHolder PlaceHolder_postcontent = null;
        protected System.Web.UI.WebControls.Label Label_amount_available = null;
        protected System.Web.UI.WebControls.LinkButton LinkButton_back = null;
        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            this.DataGrid_state_export_batch.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.DataGrid_state_export_batch_ItemDataBound);
            this.PreRender += this.TWebForm_state_required_report_PreRender;
            this.Load += this.Page_Load;
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            uint i;
            uint num_active_amendments;
            if (IsPostBack)
            {
                if ((Session["state_required_report.p"] != null))
                {
                    p = (p_type)(Session["state_required_report.p"]);
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
                Title.InnerText = Server.HtmlEncode(ConfigurationManager.AppSettings["application_name"]) + " - state_required_report";
                // Initialize implementation-wide vars.
                p.amendment_num_string = "0";
                p.be_replacement_rows_present = false;
                p.biz_appropriations = new TClass_biz_appropriations();
                p.biz_emsof_requests = new TClass_biz_emsof_requests();
                p.grand_total_cost = 0;
                p.num_datagrid_rows = 0;
                p.total_emsof_ante = 0;
                p.total_provider_match = 0;
                Label_total_num_requests.Text = p.biz_emsof_requests.TallyOfStatus(Class_biz_emsof_requests.status_type.NEEDS_SENT_TO_PA_DOH_EMSO);
                num_active_amendments = p.biz_appropriations.NumActiveAmendments(Session["regional_staffer_user_id"].ToString());
                if (num_active_amendments == 0)
                {
                    TableRow_this_is_everything.Visible = true;
                    Label_total_num_requests_2.Text = Label_total_num_requests.Text;
                }
                else
                {
                    TableRow_this_is_just_some.Visible = true;
                    DropDownList_amendment.Items.Add(new ListItem("the original contract", "0"));
                    for (i = 1; i <= num_active_amendments; i ++ )
                    {
                        DropDownList_amendment.Items.Add(new ListItem("contract amendment #" + i.ToString(), i.ToString()));
                    }
                    Label_num_filtered_requests.Text = p.biz_emsof_requests.NumRequestsInStateExportBatch(((status_type)(Session["status_of_interest"])), p.amendment_num_string, Session["regional_staffer_user_id"].ToString()).ToString();
                }
                Label_funding_round.Text = ((uint)p.biz_appropriations.FundingRoundsGenerated(Session["regional_staffer_user_id"].ToString()) + 1).ToString();
                Bind();
                Label_submission_date.Text = DateTime.Today.ToString("d MMM yyyy");
            }
        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
        }

        protected void LinkButton_export_scratch_copy_Click(object sender, System.EventArgs e)
        {
            ExportToExcel(Page, "WebEmsof-UNOFFICIAL-" + DateTime.Now.ToString("yyyyMMddHHmmssf"), StringOfControl(Table_report));
        }

        protected void DropDownList_amendment_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            p.amendment_num_string = k.Safe(DropDownList_amendment.SelectedValue, k.safe_hint_type.NUM);
            Label_num_filtered_requests.Text = p.biz_emsof_requests.NumRequestsInStateExportBatch(((status_type)(Session["status_of_interest"])), p.amendment_num_string, Session["regional_staffer_user_id"].ToString()).ToString();
            Label_funding_round.Text = ((uint)1 + p.biz_appropriations.FundingRoundsGenerated(Session["regional_staffer_user_id"].ToString(), p.amendment_num_string)).ToString();
            Bind();
        }

        protected void LinkButton_transmit_to_state_Click(object sender, System.EventArgs e)
        {
            p.biz_emsof_requests.SubmitToState(Table_report, Request.PhysicalPath, ((status_type)(Session["status_of_interest"])), Session["regional_staffer_user_id"].ToString(), p.amendment_num_string);
            DropCrumbAndTransferTo("state_transmittal_complete.aspx");
        }

        private void DataGrid_state_export_batch_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
        {
            // Manage column visibility
            if ((e.Item.ItemType == ListItemType.AlternatingItem) || (e.Item.ItemType == ListItemType.EditItem) || (e.Item.ItemType == ListItemType.Item) || (e.Item.ItemType == ListItemType.SelectedItem))
            {
                // We are dealing with a data row, not a header or footer row.
                p.num_datagrid_rows = p.num_datagrid_rows + 1;
                p.be_replacement_rows_present = p.be_replacement_rows_present || (e.Item.Cells[(int)(p.biz_emsof_requests.TcciOfSrrReplacementRowIndicator())].Text != "&nbsp;");
                p.grand_total_cost = p.grand_total_cost + Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "total_cost"));
                p.total_emsof_ante = p.total_emsof_ante + Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "emsof_ante"));
                p.total_provider_match = p.total_provider_match + Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "provider_match"));
            }
            else if ((e.Item.ItemType == ListItemType.Footer))
            {
                e.Item.Cells[4].Text = "TOTALS:";
                e.Item.Cells[7].Text = p.grand_total_cost.ToString("C");
                e.Item.Cells[8].Text = p.total_emsof_ante.ToString("C");
                e.Item.Cells[9].Text = p.total_provider_match.ToString("C");
            }
        }

        private void TWebForm_state_required_report_PreRender(object sender, System.EventArgs e)
        {
            SessionSet("state_required_report.p", p);
        }

        private void Bind()
        {
            p.biz_emsof_requests.BindStateExportBatch(DataGrid_state_export_batch, ((status_type)(Session["status_of_interest"])), p.amendment_num_string, Session["regional_staffer_user_id"].ToString());
            // Manage control visibilities.
            p.be_datagrid_empty = (p.num_datagrid_rows == 0);
            TableRow_none.Visible = p.be_datagrid_empty;
            DataGrid_state_export_batch.Visible = !p.be_datagrid_empty;
            LinkButton_transmit_to_state.Enabled = !p.be_datagrid_empty;
            LinkButton_export_scratch_copy.Enabled = !p.be_datagrid_empty;
            Table_replacement_note.Visible = p.be_replacement_rows_present;
            // Clear aggregation vars for next bind, if any.
            p.num_datagrid_rows = 0;

        }

        private struct p_type
        {
            public string amendment_num_string;
            public bool be_datagrid_empty;
            public bool be_replacement_rows_present;
            public TClass_biz_appropriations biz_appropriations;
            public TClass_biz_emsof_requests biz_emsof_requests;
            public decimal grand_total_cost;
            public uint num_datagrid_rows;
            public decimal total_emsof_ante;
            public decimal total_provider_match;
        } // end p_type

    } // end TWebForm_state_required_report

}
