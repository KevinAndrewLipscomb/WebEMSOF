using System;
using System.Configuration;

namespace charter_kinds
  {
  public partial class TWebForm_charter_kinds: ki_web_ui.page_class
    {

    private struct p_type
      {
        }

    private p_type p; // Private Parcel of Page-Pertinent Process-Persistent Parameters

        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            PreRender += TWebForm_charter_kinds_PreRender;
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            Title = Server.HtmlEncode(ConfigurationManager.AppSettings["application_name"]) + " - charter_kinds";
            if (!IsPostBack)
            {
            }
        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
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
                if ((Session["regional_staffer_name"] == null) || (Session["regional_staffer_user_id"] == null))
                {
                    Session.Clear();
                    Server.Transfer("~/login.aspx");
                }
            }

        }

        private void TWebForm_charter_kinds_PreRender(object sender, System.EventArgs e)
        {
            SessionSet(InstanceId() + ".p", p);
        }

    } // end TWebForm_charter_kinds

}
