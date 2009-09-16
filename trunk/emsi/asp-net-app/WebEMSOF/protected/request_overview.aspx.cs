using Class_biz_emsof_requests;
using Class_db;
using Class_db_trail;
using kix;
using MySql.Data.MySqlClient;
using System;
using System.Collections;
using System.ComponentModel;
using System.Configuration;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace request_overview
{
    public partial class TWebForm_request_overview: ki_web_ui.page_class
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
            this.DataGrid_items.ItemCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.DataGrid_items_ItemCommand);
            this.DataGrid_items.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.DataGrid_items_ItemDataBound);
            this.Load += this.Page_Load;
            this.PreRender += this.TWebForm_request_overview_PreRender;
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            MySqlDataReader dr;
            bool be_deadline_exempt;
            decimal county_dictated_appropriation_amount;
            DateTime make_item_requests_deadline;
            if (IsPostBack)
            {
                if ((Session["request_overview.p"] != null))
                {
                    p = (p_type)(Session["request_overview.p"]);
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
                // Initialize implementation-global variables.
                p.be_before_deadline = true;
                p.be_completely_approved = false;
                p.biz_emsof_requests = new TClass_biz_emsof_requests();
                county_dictated_appropriation_amount = decimal.Parse(Session["county_dictated_appropriation_amount"].ToString());
                p.db = new TClass_db();
                p.db_trail = new TClass_db_trail();
                p.tcci_master_id = 0;
                p.tcci_priority = 1;
                p.tcci_code = 2;
                p.tcci_item_description = 3;
                p.tcci_emsof_ante = 4;
                p.tcci_status = 5;
                p.tcci_linkbutton_select = 6;
                p.tcci_linkbutton_increase_priority = 7;
                p.tcci_linkbutton_decrease_priority = 8;
                p.num_items = 0;
                p.sum_of_emsof_antes = 0;
                be_deadline_exempt = p.biz_emsof_requests.BeDeadlineExempt(Session["emsof_request_master_id"].ToString());
                Title.InnerText = ConfigurationManager.AppSettings["application_name"] + " - request_overview";
                p.db.Open();
                Label_master_status.Text = Session["emsof_request_master_status"].ToString();
                // All further rendering is deadline-dependent.
                make_item_requests_deadline = (DateTime)(new MySqlCommand("select service_to_county_submission_deadline" + " from county_dictated_appropriation join region_dictated_appropriation" + " on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)" + " where county_dictated_appropriation.id = " + Session["county_dictated_appropriation_id"].ToString(), p.db.connection).ExecuteScalar());
                p.be_before_deadline = (DateTime.Now <= make_item_requests_deadline) || be_deadline_exempt;
                p.be_finalized = "1" == new MySqlCommand("select (status_code > 2) from emsof_request_master where id = " + Session["emsof_request_master_id"].ToString(), p.db.connection).ExecuteScalar().ToString();
                if ((!p.be_before_deadline) || p.be_finalized)
                {
                    Table_parent_appropriation_outer.Visible = false;
                    Table_deadlines.Visible = false;
                    LinkButton_add_item_to_request.Visible = false;
                    LinkButton_finalize.Visible = false;
                }
                else
                {
                    Label_fiscal_year_designator.Text = Session["fiscal_year_designator"].ToString();
                    Label_sponsor_county.Text = Session["sponsor_county"].ToString();
                    Label_parent_appropriation_amount.Text = county_dictated_appropriation_amount.ToString("C");
                    Label_make_requests_deadline.Text = make_item_requests_deadline.ToString("HH:mm:ss dddd, MMMM dd, yyyy");
                    SessionSet("emsof_request_item_priority", k.EMPTY);
                }
                SessionSet("be_before_service_to_county_submission_deadline", p.be_before_deadline.ToString());
                SessionSet("be_finalized", p.be_finalized.ToString());
                // Determine the number of items in this request so that during the Bind call we can recognize the last item and manage the
                // visibility of its "Decrease priority" LinkButton.  It is cheap at this point to also set Label_sum_of_emsof_antes.
                dr = new MySqlCommand("select num_items,value from emsof_request_master where id = " + Session["emsof_request_master_id"].ToString(), p.db.connection).ExecuteReader();
                dr.Read();
                p.num_items = (uint)(dr["num_items"].GetHashCode());
                if (p.be_before_deadline && (!p.be_finalized))
                {
                    p.sum_of_emsof_antes = decimal.Parse(dr["value"].ToString());
                    p.unused_amount = county_dictated_appropriation_amount - p.sum_of_emsof_antes;
                    Label_sum_of_emsof_antes.Text = p.sum_of_emsof_antes.ToString("C");
                    Label_unused_amount.Text = p.unused_amount.ToString("C");
                    if (p.unused_amount < 0)
                    {
                        Label_unused_amount.Font.Bold = true;
                        Label_unused_amount.ForeColor = Color.Red;
                    }
                }
                dr.Close();
                if (p.num_items == 0)
                {
                    Label_no_appropriations.Visible = true;
                }
                else
                {
                    DataGrid_items.Visible = true;
                }
                if (p.be_finalized)
                {
                    p.be_completely_approved = "1" == new MySqlCommand("select (status_code between 8 and 10) from emsof_request_master where id = " + Session["emsof_request_master_id"].ToString(), p.db.connection).ExecuteScalar().ToString();
                }
                p.db.Close();
                Bind_items();
                // also affected by be_before_deadline
                CheckBox_has_wish_list.Checked = p.biz_emsof_requests.HasWishList(Session["emsof_request_master_id"].ToString());
                CheckBox_has_wish_list.Enabled = (uint.Parse(Session["status_code"].ToString()) < 11);
                Table_withdrawal.Visible = p.biz_emsof_requests.BeWithdrawable(uint.Parse(Session["status_code"].ToString()));
            }
        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
        }

        protected void Button_withdraw_Click(object sender, System.EventArgs e)
        {
            p.biz_emsof_requests.Withdraw(Session["emsof_request_master_id"].ToString());
            BackTrack();
        }

        protected void LinkButton_add_item_to_request_Click(object sender, System.EventArgs e)
        {
            DropCrumbAndTransferTo("request_item_detail.aspx");
        }

        protected void CheckBox_has_wish_list_CheckedChanged(object sender, System.EventArgs e)
        {
            p.biz_emsof_requests.SetHasWishList(Session["emsof_request_master_id"].ToString(), CheckBox_has_wish_list.Checked);
        }

        private void TWebForm_request_overview_PreRender(object sender, System.EventArgs e)
        {
            SessionSet("request_overview.p", p);
        }

        protected void LinkButton_finalize_Click(object sender, System.EventArgs e)
        {
            SessionSet("sum_of_emsof_antes", p.sum_of_emsof_antes);
            SessionSet("unused_amount", p.unused_amount);
            DropCrumbAndTransferTo("finalize.aspx");
        }

        private void DataGrid_items_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
        {
            if (e.CommandName == "IncreasePriority")
            {
                p.db.Open();
                new MySqlCommand(p.db_trail.Saved("START TRANSACTION;" + "update emsof_request_detail set priority = 0" + " where master_id = " + Session["emsof_request_master_id"].ToString() + " and priority = " + k.Safe(e.Item.Cells[(int)(p.tcci_priority)].Text, k.safe_hint_type.NUM) + ";" + "update emsof_request_detail set priority = " + k.Safe(e.Item.Cells[(int)(p.tcci_priority)].Text, k.safe_hint_type.NUM) + " where master_id = " + Session["emsof_request_master_id"].ToString() + " and priority = " + k.Safe(e.Item.Cells[(int)(p.tcci_priority)].Text, k.safe_hint_type.NUM) + " - 1" + ";" + "update emsof_request_detail set priority = " + k.Safe(e.Item.Cells[(int)(p.tcci_priority)].Text, k.safe_hint_type.NUM) + " - 1" + " where master_id = " + Session["emsof_request_master_id"].ToString() + " and priority = 0;" + "COMMIT;"), p.db.connection).ExecuteNonQuery();
                p.db.Close();
            }
            else if (e.CommandName == "DecreasePriority")
            {
                p.db.Open();
                new MySqlCommand(p.db_trail.Saved("START TRANSACTION;" + "update emsof_request_detail set priority = 0" + " where master_id = " + Session["emsof_request_master_id"].ToString() + " and priority = " + k.Safe(e.Item.Cells[(int)(p.tcci_priority)].Text, k.safe_hint_type.NUM) + ";" + "update emsof_request_detail set priority = " + k.Safe(e.Item.Cells[(int)(p.tcci_priority)].Text, k.safe_hint_type.NUM) + " where master_id = " + Session["emsof_request_master_id"].ToString() + " and priority = " + k.Safe(e.Item.Cells[(int)(p.tcci_priority)].Text, k.safe_hint_type.NUM) + " + 1" + ";" + "update emsof_request_detail set priority = " + k.Safe(e.Item.Cells[(int)(p.tcci_priority)].Text, k.safe_hint_type.NUM) + " + 1" + " where master_id = " + Session["emsof_request_master_id"].ToString() + " and priority = 0;" + "COMMIT;"), p.db.connection).ExecuteNonQuery();
                p.db.Close();
            }
            else
            {
                // e.commandname = 'Select'
                SessionSet("emsof_request_item_priority", k.Safe(e.Item.Cells[(int)(p.tcci_priority)].Text, k.safe_hint_type.NUM));
                SessionSet("emsof_request_item_code", k.Safe(e.Item.Cells[(int)(p.tcci_code)].Text, k.safe_hint_type.NUM));
                SessionSet("emsof_request_item_equipment_category", k.Safe(e.Item.Cells[(int)(p.tcci_item_description)].Text, k.safe_hint_type.PUNCTUATED));
                DropCrumbAndTransferTo("request_item_detail.aspx");
            }
            Bind_items();
        }

        private void DataGrid_items_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
        {
            // Manage column visibility.
            e.Item.Cells[(int)(p.tcci_status)].Visible = p.be_completely_approved;
            // Manage cells in visible columns.
            if ((e.Item.ItemType == ListItemType.AlternatingItem) || (e.Item.ItemType == ListItemType.EditItem) || (e.Item.ItemType == ListItemType.Item) || (e.Item.ItemType == ListItemType.SelectedItem))
            {
                // We are dealing with a data row, not a header or footer row.
                if (e.Item.Cells[(int)(p.tcci_status)].Text == "WITHDRAWN")
                {
                    e.Item.Cells[(int)(p.tcci_priority)].Enabled = false;
                    e.Item.Cells[(int)(p.tcci_item_description)].Enabled = false;
                    e.Item.Cells[(int)(p.tcci_emsof_ante)].Enabled = false;
                    ((e.Item.Cells[(int)(p.tcci_linkbutton_select)].Controls[0]) as LinkButton).Text = "WITHDRAWN";
                    ((e.Item.Cells[(int)(p.tcci_linkbutton_select)].Controls[0]) as LinkButton).Enabled = false;
                }
                e.Item.Cells[(int)(p.tcci_linkbutton_increase_priority)].Controls[0].Visible = (e.Item.ItemIndex > 0) && p.be_before_deadline && !p.be_finalized;
                e.Item.Cells[(int)(p.tcci_linkbutton_decrease_priority)].Controls[0].Visible = (e.Item.ItemIndex < ((int)p.num_items) - 1) && p.be_before_deadline && !p.be_finalized;
            }
        }

        private void Bind_items()
        {
            string cmdText;
            p.db.Open();
            // When changing this query, remember to make corresponding changes to DataGrid Index settings in Page_Load.
            // column 0
            // column 1
            // column 2
            // column 3
            // column 4
            // column 5
            cmdText = "select master_id," + " priority," + " eligible_provider_equipment_list.code," + " eligible_provider_equipment_list.description as item_description," + " emsof_ante," + " item_status_code_description_map.description as status" + " from emsof_request_detail" + " join eligible_provider_equipment_list on (eligible_provider_equipment_list.code=emsof_request_detail.equipment_code)" + " join item_status_code_description_map on (item_status_code_description_map.code=emsof_request_detail.status_code)" + " where master_id = " + Session["emsof_request_master_id"].ToString() + " order by priority";
            DataGrid_items.DataSource = new MySqlCommand(cmdText, p.db.connection).ExecuteReader();
            DataGrid_items.DataBind();
            ((MySqlDataReader)(DataGrid_items.DataSource)).Close();
            // Clear aggregation vars for next bind, if any.
            p.db.Close();
        }

        private struct p_type
        {
            public bool be_before_deadline;
            public bool be_completely_approved;
            public bool be_finalized;
            public TClass_biz_emsof_requests biz_emsof_requests;
            public TClass_db db;
            public TClass_db_trail db_trail;
            public uint tcci_master_id;
            public uint tcci_priority;
            public uint tcci_code;
            public uint tcci_item_description;
            public uint tcci_status;
            public uint tcci_linkbutton_select;
            public uint tcci_linkbutton_increase_priority;
            public uint tcci_linkbutton_decrease_priority;
            public uint tcci_emsof_ante;
            public uint num_items;
            public decimal sum_of_emsof_antes;
            public decimal unused_amount;
        } // end p_type

    } // end TWebForm_request_overview

}
