using System;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
namespace UserControl_postcontent
{
    public partial class TWebUserControl_postcontent: ki_web_ui.usercontrol_class
    {
        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (!IsPostBack)
            {
            TableRow_bounty_program.Visible = (Session["username"] != null);
            }

        }

        protected override void OnInit(System.EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);

        }

        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
        }

    } // end TWebUserControl_postcontent

}
