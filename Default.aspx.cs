using System.Configuration;


using System;
using System.Collections;
using System.ComponentModel;
using System.Web;
using System.Web.SessionState;

using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;


namespace Default
{
    public partial class TWebForm_Default: ki_web_ui.page_class
    {
        protected System.Web.UI.WebControls.PlaceHolder PlaceHolder_precontent = null;
        protected System.Web.UI.WebControls.PlaceHolder PlaceHolder_postcontent = null;
        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            this.Load += this.Page_Load;
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (!IsPostBack)
            {
                Title.InnerText = Server.HtmlEncode(ConfigurationManager.AppSettings["application_name"]) + " - Default";
                Label_application_name.Text = ConfigurationManager.AppSettings["application_name"];
                if (Session["target_user_table"] != null)
                {
                    Response.Redirect("protected/" + Session["target_user_table"].ToString() + "_overview.aspx");
                }
            }
        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
        }

    } // end TWebForm_Default

}

namespace Default.Units
{
    public class __Default
    {
        public const string ID = "$Id: Default.pas 2343 2008-05-28 21:19:37Z kevinanlipscomb $";
    } // end __Default

}

