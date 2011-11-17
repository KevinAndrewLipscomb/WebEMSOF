using Class_biz_scheduled_tasks;
using System;
using System.Web;

namespace import_latest_practitioners_from_emsrs
{
    public partial class TWebForm_import_latest_practitioners_from_emsrs: System.Web.UI.Page
    {
        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            new TClass_biz_scheduled_tasks().ImportLatestPractitionersFromEmsrs();
        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
        }

    }

}
