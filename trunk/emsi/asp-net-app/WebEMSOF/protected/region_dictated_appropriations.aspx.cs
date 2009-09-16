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

namespace region_dictated_appropriations
{
    public partial class TWebForm_region_dictated_appropriations: ki_web_ui.page_class
    {
        private p_type p;
        protected System.Web.UI.WebControls.PlaceHolder PlaceHolder_precontent = null;
        protected System.Web.UI.WebControls.PlaceHolder PlaceHolder_postcontent = null;
        protected System.Web.UI.WebControls.Label Label_account_descriptor = null;
        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            this.DataGrid_county_appropriations.ItemCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.DataGrid_county_appropriations_ItemCommand);
            this.DataGrid_county_appropriations.CancelCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.DataGrid_county_appropriations_CancelCommand);
            this.DataGrid_county_appropriations.EditCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.DataGrid_county_appropriations_EditCommand);
            this.DataGrid_county_appropriations.SortCommand += new System.Web.UI.WebControls.DataGridSortCommandEventHandler(this.DataGrid_county_appropriations_SortCommand);
            this.DataGrid_county_appropriations.UpdateCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.DataGrid_county_appropriations_UpdateCommand);
            this.DataGrid_county_appropriations.DeleteCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.DataGrid_county_appropriations_DeleteCommand);
            this.DataGrid_county_appropriations.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.DataGrid_county_appropriations_ItemDataBound);
            this.Load += this.Page_Load;
            this.PreRender += this.TWebForm_region_dictated_appropriations_PreRender;
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            MySqlDataReader dr_appropriation_attribs;
            if (IsPostBack)
            {
                if ((Session["region_dictated_appropriations.p"] != null))
                {
                    p = (p_type)(Session["region_dictated_appropriations.p"]);
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
                p.be_sort_order_ascending = true;
                p.num_appropriations = 0;
                p.county_appropriations_sort_order = "name";
                p.db = new TClass_db();
                p.db_trail = new TClass_db_trail();
                p.sum_of_county_appropriations = 0;
                p.unappropriated_amount = 0;
                // Set up symbolic DataGrid Indices for use in other event handlers.
                p.tcci_id = 0;
                p.tcci_password_reset_email_address = 1;
                p.tcci_county_code = 2;
                p.tcci_name = 3;
                p.tcci_amount = 4;
                p.tcci_linkbutton_edit = 5;
                p.tcci_linkbutton_delete = 6;
                Title.InnerText = ConfigurationManager.AppSettings["application_name"] + " - region_dictated_appropriations";
                Label_account_descriptor.Text = Session["regional_staffer_name"].ToString();
                p.db.Open();
                // Disable Table_appropriations for now.
                Table_appropriations.Visible = false;
                // Set parent appropriation labels.
                dr_appropriation_attribs = new MySqlCommand("select designator,amount " + "from state_dictated_appropriation " + "join fiscal_year on (fiscal_year.id = fiscal_year_id) " + "where state_dictated_appropriation.id = " + Session["state_dictated_appropriation_id"].ToString(), p.db.connection).ExecuteReader();
                dr_appropriation_attribs.Read();
                Label_fiscal_year_designator.Text = dr_appropriation_attribs["designator"].ToString();
                p.state_dictated_appropriation_amount = (decimal)(dr_appropriation_attribs["amount"]);
                Label_parent_appropriation_amount.Text = p.state_dictated_appropriation_amount.ToString("C");
                dr_appropriation_attribs.Close();
                // Code to set LinkButton_region_dictated_deadline.Text should go here.
                Label_application_name.Text = ConfigurationManager.AppSettings["application_name"];
                Table_warning_forced_amount.Visible = false;
                p.db.Close();
                Bind_county_appropriations();
            // also affected by p.be_before_deadline
            }
        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
        }

        private void TWebForm_region_dictated_appropriations_PreRender(object sender, System.EventArgs e)
        {
            SessionSet("region_dictated_appropriations.p", p);
        }

        private void DataGrid_county_appropriations_UpdateCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
        {
            decimal amount;
            string amount_string;
            string appropriation_id_string;
            p.db.Open();
            appropriation_id_string = k.Safe(e.Item.Cells[(int)(p.tcci_id)].Text, k.safe_hint_type.NUM);
            amount_string = k.Safe(((e.Item.Cells[(int)(p.tcci_amount)].Controls[0]) as TextBox).Text.Trim(), k.safe_hint_type.REAL_NUM);
            if (amount_string != k.EMPTY)
            {
                amount = decimal.Parse(amount_string);
                if ((amount - p.saved_amount) > p.unappropriated_amount)
                {
                    amount = p.saved_amount + p.unappropriated_amount;
                    Table_warning_forced_amount.Visible = true;
                }
                else
                {
                    Table_warning_forced_amount.Visible = false;
                }
                new MySqlCommand(p.db_trail.Saved("update region_dictated_appropriation set amount = " + amount.ToString() + " where id = " + appropriation_id_string), p.db.connection).ExecuteNonQuery();
                // be_html
                // cc
                // bcc
                // reply_to
                k.SmtpMailSend(ConfigurationManager.AppSettings["sender_email_address"], k.Safe(e.Item.Cells[(int)(p.tcci_password_reset_email_address)].Text, k.safe_hint_type.EMAIL_ADDRESS), "Modification of " + ConfigurationManager.AppSettings["application_name"] + " allocation for your county", "Regional staffer " + Session["regional_staffer_name"].ToString() + " has modified an EMSOF allocation for " + "your county for " + k.Safe(Label_fiscal_year_designator.Text, k.safe_hint_type.ALPHANUM) + k.PERIOD + k.NEW_LINE + k.NEW_LINE + "You can work on this allocation by visiting:" + k.NEW_LINE + k.NEW_LINE + "   http://" + ConfigurationManager.AppSettings["host_domain_name"] + "/" + ConfigurationManager.AppSettings["application_name"] + k.NEW_LINE + k.NEW_LINE + "You can contact Regional Staffer " + Session["regional_staffer_name"].ToString() + " at:" + k.NEW_LINE + k.NEW_LINE + "   " + Session["regional_staffer_user_password_reset_email_address"].ToString() + "  (mailto:" + Session["regional_staffer_user_password_reset_email_address"].ToString() + ")" + k.NEW_LINE + k.NEW_LINE + "-- " + ConfigurationManager.AppSettings["application_name"], false, k.EMPTY, k.EMPTY, Session["regional_staffer_user_password_reset_email_address"].ToString());
                p.db.Close();
                DataGrid_county_appropriations.EditItemIndex =  -1;
                Bind_county_appropriations();
            }
        }

        private void DataGrid_county_appropriations_SortCommand(object source, System.Web.UI.WebControls.DataGridSortCommandEventArgs e)
        {
        }

        private void DataGrid_county_appropriations_EditCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
        {
            DataGrid_county_appropriations.EditItemIndex = e.Item.ItemIndex;
            Bind_county_appropriations();
        }

        private void DataGrid_county_appropriations_CancelCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
        {
            Table_warning_forced_amount.Visible = false;
            DataGrid_county_appropriations.EditItemIndex =  -1;
            Bind_county_appropriations();
        }

        protected void LinkButton_new_appropriation_Click(object sender, System.EventArgs e)
        {
            SessionSet("parent_appropriation_amount", k.Safe(Label_parent_appropriation_amount.Text, k.safe_hint_type.REAL_NUM));
            SessionSet("fiscal_year_designator", k.Safe(Label_fiscal_year_designator.Text, k.safe_hint_type.ALPHANUM));
            SessionSet("sum_of_county_appropriations", k.Safe(Label_sum_of_county_appropriations.Text, k.safe_hint_type.REAL_NUM));
            SessionSet("unappropriated_amount", p.unappropriated_amount);
            DropCrumbAndTransferTo("create_new_county_appropriation.aspx");
        }

        private void DataGrid_county_appropriations_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                SessionSet("fiscal_year_designator", k.Safe(Label_fiscal_year_designator.Text, k.safe_hint_type.ALPHANUM));
                SessionSet("county_name", k.Safe(e.Item.Cells[(int)(p.tcci_name)].Text, k.safe_hint_type.ORG_NAME));
                SessionSet("county_code", k.Safe(e.Item.Cells[(int)(p.tcci_county_code)].Text, k.safe_hint_type.NUM));
                SessionSet("appropriation_amount", k.Safe(e.Item.Cells[(int)(p.tcci_amount)].Text, k.safe_hint_type.REAL_NUM));
                SessionSet("region_dictated_appropriation_id", k.Safe(e.Item.Cells[(int)(p.tcci_id)].Text, k.safe_hint_type.NUM));
                DropCrumbAndTransferTo("region_dictated_appropriation_detail.aspx");
            }
            else if (e.CommandName == "Edit")
            {
                p.saved_amount = decimal.Parse(k.Safe(e.Item.Cells[(int)(p.tcci_amount)].Text, k.safe_hint_type.REAL_NUM));
            }
        }

        protected void LinkButton_region_dictated_deadline_Click(object sender, System.EventArgs e)
        {
            SessionSet("region_dictated_deadline", LinkButton_region_dictated_deadline.Text);
            DropCrumbAndTransferTo("region_dictated_deadline.aspx");
        }

        private void DataGrid_county_appropriations_DeleteCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
        {
            MySqlCommand bc;
            string id_string;
            p.db.Open();
            id_string = k.Safe(e.Item.Cells[(int)(p.tcci_id)].Text, k.safe_hint_type.NUM);
            // Leaving the star out prevents inclusion of nulls in count
            bc = new MySqlCommand("select count(master_id)" + " from emsof_request_detail" + " join emsof_request_master on (emsof_request_master.id=emsof_request_detail.master_id)" + " join county_dictated_appropriation" + " on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)" + " where region_dictated_appropriation_id = " + id_string, p.db.connection);
            if (bc.ExecuteScalar().ToString() != "0")
            {
                p.db.Close();
                // A service has already entered equipment requests against this appropriation.  Add relevant data to the session and send the
                // county coordinator to a confirmation page.
                SessionSet("id_of_appropriation_selected_for_deletion", id_string);
                Session.Remove("email_address_of_county_of_appropriation_selected_for_deletion");
                Session.Add("email_address_of_county_of_appropriation_selected_for_deletion", k.Safe(e.Item.Cells[(int)(p.tcci_password_reset_email_address)].Text, k.safe_hint_type.EMAIL_ADDRESS));
                SessionSet("county_name_of_appropriation_selected_for_deletion", k.Safe(e.Item.Cells[(int)(p.tcci_name)].Text, k.safe_hint_type.ORG_NAME));
                SessionSet("amount_of_appropriation_selected_for_deletion", k.Safe(e.Item.Cells[(int)(p.tcci_amount)].Text, k.safe_hint_type.REAL_NUM));
                DropCrumbAndTransferTo("delete_county_appropriation.aspx");
            }
            else
            {
                // Nothing is linked to this appropriation, so go ahead and delete it.
                new MySqlCommand(p.db_trail.Saved("delete from region_dictated_appropriation where id = " + id_string), p.db.connection).ExecuteNonQuery();
                // Send a notification message.
                // be_html
                // cc
                // bcc
                // reply_to
                k.SmtpMailSend(ConfigurationManager.AppSettings["sender_email_address"], k.Safe(e.Item.Cells[(int)(p.tcci_password_reset_email_address)].Text, k.safe_hint_type.EMAIL_ADDRESS), "Deletion of " + ConfigurationManager.AppSettings["application_name"] + " allocation for your county", "The " + Session["region_name"].ToString() + " Regional Council EMSOF Coordinator has deleted an EMSOF allocation from " + "your county for " + k.Safe(Label_fiscal_year_designator.Text, k.safe_hint_type.ALPHANUM) + k.PERIOD + k.NEW_LINE + k.NEW_LINE + "For an overview of your EMSOF allocations, visit:" + k.NEW_LINE + k.NEW_LINE + "   http://" + ConfigurationManager.AppSettings["host_domain_name"] + "/" + ConfigurationManager.AppSettings["application_name"] + k.NEW_LINE + k.NEW_LINE + "You can contact the " + Session["region_name"].ToString() + " Regional Council EMSOF Coordinator at:" + k.NEW_LINE + k.NEW_LINE + "   " + Session["regional_staffer_user_password_reset_email_address"].ToString() + "  (mailto:" + Session["regional_staffer_user_password_reset_email_address"].ToString() + ")" + k.NEW_LINE + k.NEW_LINE + "-- " + ConfigurationManager.AppSettings["application_name"], false, k.EMPTY, k.EMPTY, Session["regional_staffer_user_password_reset_email_address"].ToString());
                p.db.Close();
            }
            Table_warning_forced_amount.Visible = false;
            DataGrid_county_appropriations.EditItemIndex =  -1;
            Bind_county_appropriations();
        }

        private void DataGrid_county_appropriations_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
        {
            // Manage column visibility
            e.Item.Cells[(int)(p.tcci_linkbutton_edit)].Visible = p.be_before_deadline;
            e.Item.Cells[(int)(p.tcci_linkbutton_delete)].Visible = p.be_before_deadline;
            if ((e.Item.ItemType == ListItemType.AlternatingItem) || (e.Item.ItemType == ListItemType.EditItem) || (e.Item.ItemType == ListItemType.Item) || (e.Item.ItemType == ListItemType.SelectedItem))
            {
                // We are dealing with a data row, not a header or footer row.
                p.num_appropriations = p.num_appropriations + 1;
                p.sum_of_county_appropriations = p.sum_of_county_appropriations + decimal.Parse(DataBinder.Eval(e.Item.DataItem, "amount").ToString());
            }
        }

        private void Bind_county_appropriations()
        {
            bool be_datagrid_empty;
            string cmdText;
            p.db.Open();
            // When changing this query, remember to make corresponding changes to DataGrid Index settings in Page_Load.
            // column 0
            // column 1
            // column 2
            // column 3
            // column 4
            cmdText = "select region_dictated_appropriation.id," + " password_reset_email_address," + " county_code," + " name," + " region_dictated_appropriation.amount" + " from region_dictated_appropriation" + " join county_code_name_map on (county_code_name_map.code=county_code)" + " join county_user on (county_user.id=county_code)" + " where state_dictated_appropriation_id = " + Session["state_dictated_appropriation_id"].ToString() + " order by " + p.county_appropriations_sort_order;
            if (p.be_sort_order_ascending)
            {
                cmdText = cmdText + " asc";
            }
            else
            {
                cmdText = cmdText + " desc";
            }
            DataGrid_county_appropriations.DataSource = new MySqlCommand(cmdText, p.db.connection).ExecuteReader();
            DataGrid_county_appropriations.DataBind();
            ((MySqlDataReader)(DataGrid_county_appropriations.DataSource)).Close();
            be_datagrid_empty = (p.num_appropriations == 0);
            // Manage control visibilities.
            Label_no_appropriations.Visible = be_datagrid_empty;
            DataGrid_county_appropriations.Visible = !be_datagrid_empty;
            // Manage non-DataGrid control properties.
            Label_sum_of_county_appropriations.Text = p.sum_of_county_appropriations.ToString("C");
            p.unappropriated_amount = p.state_dictated_appropriation_amount - p.sum_of_county_appropriations;
            Label_unappropriated_amount.Text = p.unappropriated_amount.ToString("C");
            if (p.unappropriated_amount < 0)
            {
                Label_unappropriated_amount.Font.Bold = true;
                Label_unappropriated_amount.ForeColor = Color.Red;
            }
            // Clear aggregation vars for next bind, if any.
            p.num_appropriations = 0;
            p.sum_of_county_appropriations = 0;
            p.db.Close();
        }

        protected void SortCommand_county_appropriations(object source, System.Web.UI.WebControls.DataGridSortCommandEventArgs e)
        {
            if (e.SortExpression == p.county_appropriations_sort_order)
            {
                p.be_sort_order_ascending = !p.be_sort_order_ascending;
            }
            else
            {
                p.county_appropriations_sort_order = e.SortExpression;
                p.be_sort_order_ascending = true;
            }
            Table_warning_forced_amount.Visible = false;
            DataGrid_county_appropriations.EditItemIndex =  -1;
            Bind_county_appropriations();
        }

        private struct p_type
        {
            public bool be_before_deadline;
            public bool be_sort_order_ascending;
            public string county_appropriations_sort_order;
            public TClass_db db;
            public TClass_db_trail db_trail;
            public uint tcci_id;
            public uint tcci_password_reset_email_address;
            public uint tcci_county_code;
            public uint tcci_name;
            public uint tcci_amount;
            public uint tcci_linkbutton_edit;
            public uint tcci_linkbutton_delete;
            public uint num_appropriations;
            public decimal saved_amount;
            public decimal state_dictated_appropriation_amount;
            public decimal sum_of_county_appropriations;
            public decimal unappropriated_amount;
        } // end p_type

    } // end TWebForm_region_dictated_appropriations

}
