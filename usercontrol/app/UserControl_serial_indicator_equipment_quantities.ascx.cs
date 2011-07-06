using kix;
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Collections;


using Class_biz_equipment;
namespace UserControl_serial_indicator_equipment_quantities
{
    public struct p_type
    {
        public bool be_loaded;
        public TClass_biz_equipment biz_equipment;
        public string image_control_src_base;
    } // end p_type

    public partial class TWebUserControl_serial_indicator_equipment_quantities: ki_web_ui.usercontrol_class
    {
        private p_type p;
        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (!p.be_loaded)
            {
                p.biz_equipment.BindDescriptionsOnlyToListControl(DropDownList_equipment);
                p.image_control_src_base = k.ExpandTildePath(Image_control.Src);
                Image_control.Src = p.image_control_src_base + Server.UrlEncode(DropDownList_equipment.Text);
                p.be_loaded = true;
            }

        }

        protected override void OnInit(System.EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
            if (IsPostBack && (Session[InstanceId() + ".p"] != null))
            {
                p = (p_type)(Session[InstanceId() + ".p"]);
            }
            else
            {
                p.be_loaded = false;
                p.biz_equipment = new TClass_biz_equipment();
            }

        }

        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            this.PreRender += this.TWebUserControl_serial_indicator_equipment_quantities_PreRender;
            //this.Load += this.Page_Load;
        }

        private void TWebUserControl_serial_indicator_equipment_quantities_PreRender(object sender, System.EventArgs e)
        {
            SessionSet(InstanceId() + ".p", p);
        }

        public TWebUserControl_serial_indicator_equipment_quantities Fresh()
        {
            TWebUserControl_serial_indicator_equipment_quantities result;
            Session.Remove(InstanceId() + ".p");
            result = this;
            return result;
        }

        protected void DropDownList_equipment_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            Image_control.Src = p.image_control_src_base + Server.UrlEncode(DropDownList_equipment.Text);
        }

    } // end TWebUserControl_serial_indicator_equipment_quantities

}
