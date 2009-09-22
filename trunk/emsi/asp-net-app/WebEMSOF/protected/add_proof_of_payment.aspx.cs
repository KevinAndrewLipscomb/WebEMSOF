using System.Configuration;

using kix;

using System;
using System.Collections;
using System.ComponentModel;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;


using Class_biz_emsof_requests;
using Class_biz_payment_proof_methods;
namespace add_proof_of_payment
{
    public struct p_type
    {
        public decimal amount;
        public TClass_biz_emsof_requests biz_emsof_requests;
        public TClass_biz_payment_proof_methods biz_payment_proof_methods;
    } // end p_type

    public partial class TWebForm_add_proof_of_payment: ki_web_ui.page_class
    {
        private p_type p;
        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            //this.Load += this.Page_Load;
            this.PreRender += this.TWebForm_add_proof_of_payment_PreRender;
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (IsPostBack)
            {
                if ((Session["add_proof_of_payment.p"] != null))
                {
                    p = (p_type)(Session["add_proof_of_payment.p"]);
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
                    // The request for this page could not have been the result of a Server.Transfer call, and the session state is therefore unknown.  This is rarely allowed.
                    Session.Clear();
                    Server.Transfer("~/login.aspx");
                }
                else
                {
                    Title.InnerText = Server.HtmlEncode(ConfigurationManager.AppSettings["application_name"]) + " - add_proof_of_payment";
                    p.biz_emsof_requests = new TClass_biz_emsof_requests();
                    p.biz_payment_proof_methods = new TClass_biz_payment_proof_methods();
                    Label_service_name.Text = p.biz_emsof_requests.ServiceNameOf(Session["e_item"]);
                    Calendar_date_of_payment.SelectedDate = DateTime.Today;
                    p.biz_payment_proof_methods.BindListControl(DropDownList_methods);
                }
            }
        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
        }

        protected void CustomValidator_amount_ServerValidate(object source, System.Web.UI.WebControls.ServerValidateEventArgs args)
        {
            string amount_string;
            amount_string = k.Safe(args.Value, k.safe_hint_type.REAL_NUM);
            if (amount_string == k.EMPTY)
            {
                args.IsValid = false;
            }
            else
            {
                p.amount = decimal.Parse(amount_string);
                args.IsValid = (p.amount > 0);
            }
        }

        protected void Button_submit_Click(object sender, System.EventArgs e)
        {
            DateTime timestamp;
            if (p.biz_emsof_requests.BeValidStateApprovalTimestampOf(p.biz_emsof_requests.IdOf(Session["e_item"]), out timestamp) && (Calendar_date_of_payment.SelectedDate >= timestamp.Date) && (Calendar_date_of_payment.SelectedDate < DateTime.Now))
            {
                p.biz_emsof_requests.AddProofOfPayment(p.biz_emsof_requests.IdOf(Session["e_item"]), Calendar_date_of_payment.SelectedDate, k.Safe(DropDownList_methods.SelectedValue, k.safe_hint_type.NUM), p.amount, k.Safe(TextBox_note.Text, k.safe_hint_type.PUNCTUATED));
            }
            BackTrack();
        }

        protected void Button_cancel_Click(object sender, System.EventArgs e)
        {
            BackTrack();
        }

        private void TWebForm_add_proof_of_payment_PreRender(object sender, System.EventArgs e)
        {
            SessionSet("add_proof_of_payment.p", p);
        }

    } // end TWebForm_add_proof_of_payment

}

namespace add_proof_of_payment.Units
{
    public class add_proof_of_payment
    {
        public const string ID = "$Id: add_proof_of_payment.pas 2513 2008-08-28 20:03:46Z kevinanlipscomb $";
    } // end add_proof_of_payment

}

