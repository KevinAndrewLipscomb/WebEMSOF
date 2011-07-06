using System.Configuration;


using System;
using System.Collections;
using System.ComponentModel;
using System.Web;
using System.Web.SessionState;

using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;


namespace state_transmittal_complete
{
    public struct p_type
    {
    } // end p_type

    public partial class TWebForm_state_transmittal_complete: ki_web_ui.page_class
    {
        private p_type p;
        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            //this.Load += this.Page_Load;
            this.PreRender += this.TWebForm_state_transmittal_complete_PreRender;
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
                Title.InnerText = Server.HtmlEncode(ConfigurationManager.AppSettings["application_name"]) + " - state_transmittal_complete";
                Label_application_name.Text = ConfigurationManager.AppSettings["application_name"];
            }
        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
        }

        protected void Button_return_to_overview_Click(object sender, System.EventArgs e)
        {
            BackTrack(2);
        }

        private void TWebForm_state_transmittal_complete_PreRender(object sender, System.EventArgs e)
        {
            SessionSet(InstanceId() + ".p", p);
        }

    } // end TWebForm_state_transmittal_complete

}

namespace state_transmittal_complete.Units
{
    public class state_transmittal_complete
    {
        public const string ID = "$Id: state_transmittal_complete.pas 2513 2008-08-28 20:03:46Z kevinanlipscomb $";
    } // end state_transmittal_complete

}

