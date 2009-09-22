using kix;
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Collections;

using Class_biz_appropriations;
using Class_biz_charter_kinds;
using Class_biz_counties;
using Class_biz_services;
using Class_biz_user;
namespace UserControl_service_profile
{
    public partial class TWebUserControl_service_profile: ki_web_ui.usercontrol_class
    {
        private p_type p;
        protected System.Web.UI.WebControls.CustomValidator CustomValidator_emsof_contact_name = null;
        private void Clear()
        {
            TextBox_affiliate_num.Text = k.EMPTY;
            DropDownList_affiliate_num.Visible = false;
            TextBox_name.Text = k.EMPTY;
            DropDownList_county.ClearSelection();
            TextBox_business_phone_num.Text = k.EMPTY;
            TextBox_business_fax_num.Text = k.EMPTY;
            TextBox_website_address.Text = k.EMPTY;
            DropDownList_charter_kind.ClearSelection();
            TextBox_corpadmin_contact_name.Text = k.EMPTY;
            TextBox_corpadmin_primary_phone_num.Text = k.EMPTY;
            TextBox_corpadmin_secondary_phone_num.Text = k.EMPTY;
            TextBox_corpadmin_email_address.Text = k.EMPTY;
            RadioButtonList_be_emsof_participant.ClearSelection();
            TextBox_emsof_nonparticipation_reason.Text = k.EMPTY;
            TextBox_emsof_contact_name.Text = k.EMPTY;
            TextBox_emsof_contact_primary_phone_num.Text = k.EMPTY;
            TextBox_emsof_contact_sms_phone_num.Text = k.EMPTY;
            TextBox_coo_name.Text = k.EMPTY;
            TextBox_coo_work_phone_num.Text = k.EMPTY;
            TextBox_coo_home_phone_num.Text = k.EMPTY;
            TextBox_coo_email_address.Text = k.EMPTY;
            TextBox_coo_mobile_phone_or_pager_num.Text = k.EMPTY;
            TextBox_md_name.Text = k.EMPTY;
            TextBox_md_office_phone_num.Text = k.EMPTY;
            TextBox_md_home_phone_num.Text = k.EMPTY;
            TextBox_md_email_address.Text = k.EMPTY;
            TextBox_md_mobile_phone_or_pager_num.Text = k.EMPTY;
            TextBox_physical_street_address_line_1.Text = k.EMPTY;
            TextBox_physical_street_address_line_2.Text = k.EMPTY;
            TextBox_physical_city.Text = k.EMPTY;
            TextBox_physical_zip_code.Text = k.EMPTY;
            TextBox_mail_address_line_1.Text = k.EMPTY;
            TextBox_mail_address_line_2.Text = k.EMPTY;
            TextBox_mail_city.Text = k.EMPTY;
            TextBox_mail_zip_code.Text = k.EMPTY;
            CheckBox_be_qrs_unrecognized.Checked = false;
            CheckBox_be_qrs.Checked = false;
            CheckBox_be_bls_amb.Checked = false;
            CheckBox_be_als_amb.Checked = false;
            CheckBox_be_als_squad.Checked = false;
            CheckBox_be_air_amb.Checked = false;
            CheckBox_be_rescue_unrecognized.Checked = false;
            CheckBox_be_rescue.Checked = false;
            CheckBox_be_pa_turnpike_contractor.Checked = false;
            TextBox_num_doh_licensed_vehicles.Text = k.EMPTY;
            TextBox_num_ambulances.Text = k.EMPTY;
            RadioButtonList_be_dera.ClearSelection();
            TextBox_charter_other_kind.Text = k.EMPTY;
            RadioButtonList_be_valid_profile.ClearSelection();
            TextBox_federal_tax_id.Text = k.EMPTY;
            RadioButtonList_be_distressed.ClearSelection();
            ManageCharterControlEnablements();
            ManageEmsofControlEnablements();
            LinkButton_go_to_match_prior.Visible = false;
            LinkButton_go_to_match_next.Visible = false;
            LinkButton_go_to_match_last.Visible = false;
            LinkButton_go_to_match_first.Visible = false;
            SetDependentFieldAblements(false);
            Button_submit.Enabled = false;
            Button_delete.Enabled = false;

        }

        private void InjectPersistentClientSideScript()
        {
            // EstablishClientSideFunction(k.client_side_function_enumeral_type.EL);
            // EstablishClientSideFunction(k.client_side_function_enumeral_type.KGS_TO_LBS);
            // EstablishClientSideFunction(k.client_side_function_enumeral_type.LBS_TO_KGS);
            // EstablishClientSideFunction
            // (
            // 'RecalculateDependentValues()',
            // k.EMPTY
            // + 'El("' + TextBox_gain_or_loss_in_lbs.clientid + '").value ='
            // +  ' El("' + TextBox_gross_landed_weight_in_pounds.clientid + '").value - El("' + TextBox_gross_invoiced_weight_in_lbs.clientid + '").value;'
            // + k.NEW_LINE
            // + 'El("' + TextBox_gain_or_loss_in_kgs.clientid + '").value ='
            // +  ' El("' + TextBox_gross_landed_weight_in_kgs.clientid + '").value - El("' + TextBox_gross_invoiced_weight_in_kgs.clientid + '").value;'
            // + k.NEW_LINE
            // + 'El("' + TextBox_gain_or_loss_per_bale_in_lbs.clientid + '").value ='
            // +  ' El("' + TextBox_gain_or_loss_in_lbs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
            // + k.NEW_LINE
            // + 'El("' + TextBox_gain_or_loss_per_bale_in_kgs.clientid + '").value ='
            // +  ' El("' + TextBox_gain_or_loss_in_kgs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
            // + k.NEW_LINE
            // + 'El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value ='
            // +  ' El("' + TextBox_gain_or_loss_in_lbs.clientid + '").value - El("' + TextBox_franchise_in_lbs.clientid + '").value;'
            // + k.NEW_LINE
            // + 'El("' + TextBox_actual_gain_or_loss_in_kgs.clientid + '").value ='
            // +  ' El("' + TextBox_gain_or_loss_in_kgs.clientid + '").value - El("' + TextBox_franchise_in_kgs.clientid + '").value;'
            // + k.NEW_LINE
            // + 'El("' + TextBox_actual_gain_or_loss_per_bale_in_lbs.clientid + '").value ='
            // +  ' El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
            // + k.NEW_LINE
            // + 'El("' + TextBox_actual_gain_or_loss_per_bale_in_kgs.clientid + '").value ='
            // +  ' El("' + TextBox_actual_gain_or_loss_in_kgs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
            // + k.NEW_LINE
            // + 'El("' + TextBox_percent_gain_or_loss.clientid + '").value ='
            // +  ' Math.round(El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value/El("' + TextBox_net_invoiced_in_lbs.clientid + '").value*100*100)/100;'
            // + k.NEW_LINE
            // + 'El("' + TextBox_monetary_gain_or_loss.clientid + '").value ='
            // +  ' El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value*El("' + TextBox_unit_price_in_cents_per_pound.clientid + '").value;'
            // );
            // //
            // TextBox_bales.attributes.Add('onkeyup','RecalculateDependentValues();');
            // TextBox_gross_landed_weight_in_pounds.attributes.Add
            // (
            // 'onkeyup',
            // 'El("' + TextBox_gross_landed_weight_in_kgs.clientid + '").value = LbsToKgs(El("' + TextBox_gross_landed_weight_in_pounds.clientid + '").value);'
            // + ' RecalculateDependentValues();'
            // );
            // TextBox_gross_landed_weight_in_kgs.attributes.Add
            // (
            // 'onkeyup',
            // 'El("' + TextBox_gross_landed_weight_in_pounds.clientid + '").value = KgsToLbs(El("' + TextBox_gross_landed_weight_in_kgs.clientid + '").value);'
            // + ' RecalculateDependentValues();'
            // );
            // TextBox_landed_or_ciq_tare.attributes.Add
            // (
            // 'onkeyup',
            // 'El("' + TextBox_landed_or_ciq_tare_in_kgs.clientid + '").value = LbsToKgs(El("' + TextBox_landed_or_ciq_tare.clientid + '").value);'
            // + ' RecalculateDependentValues();'
            // );
            // TextBox_landed_or_ciq_tare_in_kgs.attributes.Add
            // (
            // 'onkeyup',
            // 'El("' + TextBox_landed_or_ciq_tare.clientid + '").value = KgsToLbs(El("' + TextBox_landed_or_ciq_tare_in_kgs.clientid + '").value);'
            // + ' RecalculateDependentValues();'
            // );
            // TextBox_net_landed_in_pounds.attributes.Add
            // (
            // 'onkeyup',
            // 'El("' + TextBox_net_landed_in_kgs.clientid + '").value = LbsToKgs(El("' + TextBox_net_landed_in_pounds.clientid + '").value);'
            // + ' RecalculateDependentValues();'
            // );
            // TextBox_net_landed_in_kgs.attributes.Add
            // (
            // 'onkeyup',
            // 'El("' + TextBox_net_landed_in_pounds.clientid + '").value = KgsToLbs(El("' + TextBox_net_landed_in_kgs.clientid + '").value);'
            // + ' RecalculateDependentValues();'
            // );

        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (!p.be_loaded)
            {
                if (p.be_service_user)
                {
                    Button_lookup.Visible = false;
                    Label_lookup_arrow.Visible = false;
                    Label_lookup_hint.Visible = false;
                    LinkButton_reset.Visible = false;
                    Button_delete.Visible = false;
                }
                p.biz_counties.BindDirectToListControl(DropDownList_county, "-- County --");
                p.biz_charter_kinds.BindDirectToListControl(DropDownList_charter_kind, "-- Charter kind --");
                LinkButton_go_to_match_first.Text = k.ExpandTildePath(LinkButton_go_to_match_first.Text);
                LinkButton_go_to_match_prior.Text = k.ExpandTildePath(LinkButton_go_to_match_prior.Text);
                LinkButton_go_to_match_next.Text = k.ExpandTildePath(LinkButton_go_to_match_next.Text);
                LinkButton_go_to_match_last.Text = k.ExpandTildePath(LinkButton_go_to_match_last.Text);
                RequireConfirmation(Button_delete, "Are you sure you want to delete this record?");
                if (p.affiliate_num != k.EMPTY)
                {
                    PresentRecord(p.affiliate_num);
                }
                Focus(TextBox_name, true);
                p.be_loaded = true;
            }
            InjectPersistentClientSideScript();

        }

        private bool PresentRecord(string affiliate_num)
        {
            bool result;
            string name;
            string county_code;
            string business_phone_num;
            string business_fax_num;
            string website_address;
            string charter_kind;
            string corpadmin_contact_name;
            string corpadmin_primary_phone_num;
            string corpadmin_secondary_phone_num;
            string corpadmin_email_address;
            bool be_emsof_participant;
            string emsof_nonparticipation_reason;
            string emsof_contact_name;
            string emsof_contact_primary_phone_num;
            string emsof_contact_sms_phone_num;
            string coo_name;
            string coo_work_phone_num;
            string coo_home_phone_num;
            string coo_email_address;
            string coo_mobile_phone_or_pager_num;
            string md_name;
            string md_office_phone_num;
            string md_home_phone_num;
            string md_email_address;
            string md_mobile_phone_or_pager_num;
            string physical_street_address_line_1;
            string physical_street_address_line_2;
            string physical_city;
            string physical_state;
            string physical_zip_code;
            string mail_address_line_1;
            string mail_address_line_2;
            string mail_city;
            string mail_state;
            string mail_zip_code;
            bool be_qrs_unrecognized;
            bool be_qrs;
            bool be_bls_amb;
            bool be_als_amb;
            bool be_als_squad;
            bool be_air_amb;
            bool be_rescue_unrecognized;
            bool be_rescue;
            bool be_pa_turnpike_contractor;
            string num_doh_licensed_vehicles;
            string num_ambulances;
            bool be_dera;
            string charter_other_kind;
            bool be_valid_profile;
            string federal_tax_id;
            bool be_distressed;
            result = false;
            if (p.biz_services.Get(affiliate_num, out name, out county_code, out business_phone_num, out business_fax_num, out website_address, out charter_kind, out corpadmin_contact_name, out corpadmin_primary_phone_num, out corpadmin_secondary_phone_num, out corpadmin_email_address, out be_emsof_participant, out emsof_nonparticipation_reason, out emsof_contact_name, out emsof_contact_primary_phone_num, out emsof_contact_sms_phone_num, out coo_name, out coo_work_phone_num, out coo_home_phone_num, out coo_email_address, out coo_mobile_phone_or_pager_num, out md_name, out md_office_phone_num, out md_home_phone_num, out md_email_address, out md_mobile_phone_or_pager_num, out physical_street_address_line_1, out physical_street_address_line_2, out physical_city, out physical_state, out physical_zip_code, out mail_address_line_1, out mail_address_line_2, out mail_city, out mail_state, out mail_zip_code, out be_qrs, out be_bls_amb, out be_als_amb, out be_als_squad, out be_air_amb, out be_rescue, out be_pa_turnpike_contractor, out num_doh_licensed_vehicles, out num_ambulances, out be_dera, out charter_other_kind, out be_valid_profile, out federal_tax_id, out be_qrs_unrecognized, out be_rescue_unrecognized, out be_distressed))
            {
                TextBox_affiliate_num.Text = affiliate_num;
                TextBox_name.Text = name;
                DropDownList_county.SelectedValue = county_code;
                TextBox_business_phone_num.Text = business_phone_num;
                TextBox_business_fax_num.Text = business_fax_num;
                TextBox_website_address.Text = website_address;
                DropDownList_charter_kind.SelectedValue = charter_kind;
                TextBox_corpadmin_contact_name.Text = corpadmin_contact_name;
                TextBox_corpadmin_primary_phone_num.Text = corpadmin_primary_phone_num;
                TextBox_corpadmin_secondary_phone_num.Text = corpadmin_secondary_phone_num;
                TextBox_corpadmin_email_address.Text = corpadmin_email_address;
                RadioButtonList_be_emsof_participant.SelectedValue = be_emsof_participant.ToString().ToUpper();
                TextBox_emsof_nonparticipation_reason.Text = emsof_nonparticipation_reason;
                TextBox_emsof_contact_name.Text = emsof_contact_name;
                TextBox_emsof_contact_primary_phone_num.Text = emsof_contact_primary_phone_num;
                TextBox_emsof_contact_sms_phone_num.Text = emsof_contact_sms_phone_num;
                TextBox_coo_name.Text = coo_name;
                TextBox_coo_work_phone_num.Text = coo_work_phone_num;
                TextBox_coo_home_phone_num.Text = coo_home_phone_num;
                TextBox_coo_email_address.Text = coo_email_address;
                TextBox_coo_mobile_phone_or_pager_num.Text = coo_mobile_phone_or_pager_num;
                TextBox_md_name.Text = md_name;
                TextBox_md_office_phone_num.Text = md_office_phone_num;
                TextBox_md_home_phone_num.Text = md_home_phone_num;
                TextBox_md_email_address.Text = md_email_address;
                TextBox_md_mobile_phone_or_pager_num.Text = md_mobile_phone_or_pager_num;
                TextBox_physical_street_address_line_1.Text = physical_street_address_line_1;
                TextBox_physical_street_address_line_2.Text = physical_street_address_line_2;
                TextBox_physical_city.Text = physical_city;
                TextBox_physical_zip_code.Text = physical_zip_code;
                TextBox_mail_address_line_1.Text = mail_address_line_1;
                TextBox_mail_address_line_2.Text = mail_address_line_2;
                TextBox_mail_city.Text = mail_city;
                TextBox_mail_zip_code.Text = mail_zip_code;
                CheckBox_be_qrs_unrecognized.Checked = be_qrs_unrecognized;
                CheckBox_be_qrs.Checked = be_qrs;
                CheckBox_be_bls_amb.Checked = be_bls_amb;
                CheckBox_be_als_amb.Checked = be_als_amb;
                CheckBox_be_als_squad.Checked = be_als_squad;
                CheckBox_be_air_amb.Checked = be_air_amb;
                CheckBox_be_rescue_unrecognized.Checked = be_rescue_unrecognized;
                CheckBox_be_rescue.Checked = be_rescue;
                CheckBox_be_pa_turnpike_contractor.Checked = be_pa_turnpike_contractor;
                TextBox_num_doh_licensed_vehicles.Text = num_doh_licensed_vehicles;
                TextBox_num_ambulances.Text = num_ambulances;
                RadioButtonList_be_dera.SelectedValue = be_dera.ToString().ToUpper();
                TextBox_charter_other_kind.Text = charter_other_kind;
                RadioButtonList_be_valid_profile.SelectedValue = be_valid_profile.ToString().ToUpper();
                TextBox_federal_tax_id.Text = federal_tax_id;
                RadioButtonList_be_distressed.SelectedValue = be_distressed.ToString().ToUpper();
                p.be_profile_initially_valid = be_valid_profile;
                TextBox_affiliate_num.Enabled = false;
                Button_lookup.Enabled = false;
                Label_lookup_arrow.Enabled = false;
                Label_lookup_hint.Enabled = false;
                LinkButton_reset.Enabled = true;
                // Proforma enablements of all dependent fields
                SetDependentFieldAblements(p.be_ok_to_config_service_profiles);
                // Ablement customizations unique to this control
                RadioButtonList_be_valid_profile.Enabled = p.be_authorized_to_delete_service;
                RadioButtonList_be_distressed.Enabled = p.be_authorized_to_delete_service;
                ManageCharterControlEnablements();
                ManageEmsofControlEnablements();
                Button_submit.Enabled = p.be_ok_to_config_service_profiles;
                Button_delete.Enabled = p.be_authorized_to_delete_service;
                result = true;
            }
            return result;
        }

        private void SetLookupMode()
        {
            Clear();
            TextBox_affiliate_num.Enabled = true;
            Button_lookup.Enabled = true;
            Label_lookup_arrow.Enabled = true;
            Label_lookup_hint.Enabled = true;
            LinkButton_reset.Enabled = false;
            Focus(TextBox_affiliate_num, true);
        }

        protected override void OnInit(System.EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
            if (Session["UserControl_service_profile.p"] != null)
            {
                p = (p_type)(Session["UserControl_service_profile.p"]);
                p.be_loaded = IsPostBack;
            }
            else
            {
                p.biz_appropriations = new TClass_biz_appropriations();
                p.biz_charter_kinds = new TClass_biz_charter_kinds();
                p.biz_counties = new TClass_biz_counties();
                p.biz_services = new TClass_biz_services();
                p.biz_user = new TClass_biz_user();
                p.affiliate_num = k.EMPTY;
                p.be_authorized_to_delete_service = p.biz_services.BeOkToDelete();
                p.be_loaded = false;
                p.be_service_user = (p.biz_user.Kind() == "service");
                p.be_profile_initially_valid = false;
                if (p.be_service_user)
                {
                    p.affiliate_num = p.biz_services.AffiliateNumOfId(p.biz_user.IdNum());
                }
                p.be_ok_to_config_service_profiles = p.be_service_user || HttpContext.Current.User.IsInRole("director") || HttpContext.Current.User.IsInRole("emsof-coordinator");
            }
            if ((Session["affiliate_num"] != null))
            {
                p.affiliate_num = Session["affiliate_num"].ToString();
            }

        }

        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
            this.PreRender += this.TWebUserControl_service_profile_PreRender;
            //this.Load += this.Page_Load;
        }

        private void TWebUserControl_service_profile_PreRender(object sender, System.EventArgs e)
        {
            SessionSet("UserControl_service_profile.p", p);
        }

        public TWebUserControl_service_profile Fresh()
        {
            TWebUserControl_service_profile result;
            Session.Remove("UserControl_service_profile.p");
            result = this;
            return result;
        }

        protected void CustomValidator_num_ambulances_ServerValidate(object source, System.Web.UI.WebControls.ServerValidateEventArgs args)
        {
            args.IsValid = (uint.Parse(k.Safe(TextBox_num_ambulances.Text, k.safe_hint_type.NUM)) <= uint.Parse(k.Safe(TextBox_num_doh_licensed_vehicles.Text, k.safe_hint_type.NUM)));

        }

        protected void RadioButtonList_be_emsof_participant_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            ManageEmsofControlEnablements();
        }

        protected void CustomValidator_md_email_address_ServerValidate(object source, System.Web.UI.WebControls.ServerValidateEventArgs args)
        {
            args.IsValid = k.BeValidDomainPartOfEmailAddress(k.Safe(TextBox_md_email_address.Text, k.safe_hint_type.EMAIL_ADDRESS));
        }

        protected void CustomValidator_be_als_medical_director_name_ServerValidate(object source, System.Web.UI.WebControls.ServerValidateEventArgs args)
        {
            args.IsValid = !((CheckBox_be_als_amb.Checked || CheckBox_be_als_squad.Checked || CheckBox_be_air_amb.Checked) && (TextBox_md_name.Text == k.EMPTY));

        }

        protected void CustomValidator_coo_email_address_ServerValidate(object source, System.Web.UI.WebControls.ServerValidateEventArgs args)
        {
            args.IsValid = k.BeValidDomainPartOfEmailAddress(k.Safe(TextBox_coo_email_address.Text, k.safe_hint_type.EMAIL_ADDRESS));
        }

        protected void CustomValidator_website_address_ServerValidate(object source, System.Web.UI.WebControls.ServerValidateEventArgs args)
        {
            args.IsValid = k.BeValidDomainPartOfWebAddress(k.Safe(TextBox_website_address.Text, k.safe_hint_type.HTTP_TARGET));
        }

        protected void CustomValidator_corpadmin_email_address_ServerValidate(object source, System.Web.UI.WebControls.ServerValidateEventArgs args)
        {
            args.IsValid = k.BeValidDomainPartOfEmailAddress(k.Safe(TextBox_corpadmin_email_address.Text, k.safe_hint_type.EMAIL_ADDRESS));
        }

        protected void DropDownList_charter_kind_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            ManageCharterControlEnablements();
        }

        protected void Button_submit_Click(object sender, System.EventArgs e)
        {
            if (Page.IsValid)
            {
                p.biz_services.Set(k.Safe(TextBox_affiliate_num.Text, k.safe_hint_type.NUM), k.Safe(TextBox_name.Text, k.safe_hint_type.ORG_NAME).Trim(), k.Safe(DropDownList_county.SelectedValue, k.safe_hint_type.NUM), k.Safe(TextBox_business_phone_num.Text, k.safe_hint_type.NUM), k.Safe(TextBox_business_fax_num.Text, k.safe_hint_type.NUM), k.Safe(TextBox_website_address.Text, k.safe_hint_type.HTTP_TARGET).Trim(), k.Safe(DropDownList_charter_kind.SelectedValue, k.safe_hint_type.NUM), k.Safe(TextBox_corpadmin_contact_name.Text, k.safe_hint_type.HUMAN_NAME).Trim(), k.Safe(TextBox_corpadmin_primary_phone_num.Text, k.safe_hint_type.NUM), k.Safe(TextBox_corpadmin_secondary_phone_num.Text, k.safe_hint_type.NUM), k.Safe(TextBox_corpadmin_email_address.Text, k.safe_hint_type.EMAIL_ADDRESS).Trim(), (RadioButtonList_be_emsof_participant.SelectedValue == "TRUE"), k.Safe(TextBox_emsof_nonparticipation_reason.Text, k.safe_hint_type.PUNCTUATED).Trim(), k.Safe(TextBox_emsof_contact_name.Text, k.safe_hint_type.HUMAN_NAME).Trim(), k.Safe(TextBox_emsof_contact_primary_phone_num.Text, k.safe_hint_type.NUM), k.Safe(TextBox_emsof_contact_sms_phone_num.Text, k.safe_hint_type.NUM), k.Safe(TextBox_coo_name.Text, k.safe_hint_type.HUMAN_NAME).Trim(), k.Safe(TextBox_coo_work_phone_num.Text, k.safe_hint_type.NUM), k.Safe(TextBox_coo_home_phone_num.Text, k.safe_hint_type.NUM), k.Safe(TextBox_coo_email_address.Text, k.safe_hint_type.EMAIL_ADDRESS).Trim(), k.Safe(TextBox_coo_mobile_phone_or_pager_num.Text, k.safe_hint_type.NUM), k.Safe(TextBox_md_name.Text, k.safe_hint_type.HUMAN_NAME).Trim(), k.Safe(TextBox_md_office_phone_num.Text, k.safe_hint_type.NUM), k.Safe(TextBox_md_home_phone_num.Text, k.safe_hint_type.NUM), k.Safe(TextBox_md_email_address.Text, k.safe_hint_type.EMAIL_ADDRESS).Trim(), k.Safe(TextBox_md_mobile_phone_or_pager_num.Text, k.safe_hint_type.NUM), k.Safe(TextBox_physical_street_address_line_1.Text, k.safe_hint_type.POSTAL_STREET_ADDRESS).Trim(), k.Safe(TextBox_physical_street_address_line_2.Text, k.safe_hint_type.POSTAL_STREET_ADDRESS).Trim(), k.Safe(TextBox_physical_city.Text, k.safe_hint_type.POSTAL_CITY).Trim(), "PA", k.Safe(TextBox_physical_zip_code.Text, k.safe_hint_type.NUM), k.Safe(TextBox_mail_address_line_1.Text, k.safe_hint_type.POSTAL_STREET_ADDRESS).Trim(), k.Safe(TextBox_mail_address_line_2.Text, k.safe_hint_type.POSTAL_STREET_ADDRESS).Trim(), k.Safe(TextBox_mail_city.Text, k.safe_hint_type.POSTAL_CITY).Trim(), "PA", k.Safe(TextBox_mail_zip_code.Text, k.safe_hint_type.NUM), CheckBox_be_qrs.Checked, CheckBox_be_bls_amb.Checked, CheckBox_be_als_amb.Checked, CheckBox_be_als_squad.Checked, CheckBox_be_air_amb.Checked, CheckBox_be_rescue.Checked, CheckBox_be_pa_turnpike_contractor.Checked, k.Safe(TextBox_num_doh_licensed_vehicles.Text, k.safe_hint_type.NUM), k.Safe(TextBox_num_ambulances.Text, k.safe_hint_type.NUM), (RadioButtonList_be_dera.SelectedValue == "TRUE"), k.Safe(TextBox_charter_other_kind.Text, k.safe_hint_type.PUNCTUATED).Trim(), (p.be_service_user && !p.be_profile_initially_valid), (p.be_service_user || (RadioButtonList_be_valid_profile.SelectedValue == "TRUE")), k.Safe(TextBox_federal_tax_id.Text, k.safe_hint_type.NUM), CheckBox_be_qrs_unrecognized.Checked, CheckBox_be_rescue_unrecognized.Checked, (RadioButtonList_be_distressed.SelectedValue == "TRUE"));
                if (p.be_service_user)
                {
                    BackTrack();
                }
                else
                {
                    Alert(k.alert_cause_type.USER, k.alert_state_type.SUCCESS, "recsaved", "Record saved.", true);
                    SetLookupMode();
                }
            }
            else
            {
                ValidationAlert(true);
            }
        }

        protected void DropDownList_affiliate_num_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            PresentRecord(k.Safe(DropDownList_affiliate_num.SelectedValue, k.safe_hint_type.NUM));
        }

        protected void LinkButton_go_to_match_first_Click(object sender, System.EventArgs e)
        {
            DropDownList_affiliate_num.SelectedIndex = 1;
            PresentRecord(k.Safe(DropDownList_affiliate_num.SelectedValue, k.safe_hint_type.NUM));
        }

        protected void LinkButton_go_to_match_prior_Click(object sender, System.EventArgs e)
        {
            DropDownList_affiliate_num.SelectedIndex = Math.Max(1, (DropDownList_affiliate_num.SelectedIndex - 1));
            PresentRecord(k.Safe(DropDownList_affiliate_num.SelectedValue, k.safe_hint_type.NUM));
        }

        protected void LinkButton_go_to_match_next_Click(object sender, System.EventArgs e)
        {
            DropDownList_affiliate_num.SelectedIndex = Math.Min((DropDownList_affiliate_num.SelectedIndex + 1), (DropDownList_affiliate_num.Items.Count - 1));
            PresentRecord(k.Safe(DropDownList_affiliate_num.SelectedValue, k.safe_hint_type.NUM));
        }

        protected void LinkButton_go_to_match_last_Click(object sender, System.EventArgs e)
        {
            DropDownList_affiliate_num.SelectedIndex = DropDownList_affiliate_num.Items.Count - 1;
            PresentRecord(k.Safe(DropDownList_affiliate_num.SelectedValue, k.safe_hint_type.NUM));
        }

        protected void Button_delete_Click(object sender, System.EventArgs e)
        {
            if (p.biz_services.Delete(k.Safe(TextBox_affiliate_num.Text, k.safe_hint_type.ALPHANUM)))
            {
                SetLookupMode();
            }
            else
            {
                Alert(k.alert_cause_type.APPDATA, k.alert_state_type.FAILURE, "dependency", " Cannot delete this record because another record depends on it.", true);
            }
        }

        protected void LinkButton_reset_Click(object sender, System.EventArgs e)
        {
            SetLookupMode();
        }

        private void SetDependentFieldAblements(bool ablement)
        {
            TextBox_name.Enabled = ablement;
            DropDownList_county.Enabled = ablement;
            TextBox_business_phone_num.Enabled = ablement;
            TextBox_business_fax_num.Enabled = ablement;
            TextBox_website_address.Enabled = ablement;
            DropDownList_charter_kind.Enabled = ablement;
            TextBox_corpadmin_contact_name.Enabled = ablement;
            TextBox_corpadmin_primary_phone_num.Enabled = ablement;
            TextBox_corpadmin_secondary_phone_num.Enabled = ablement;
            TextBox_corpadmin_email_address.Enabled = ablement;
            RadioButtonList_be_emsof_participant.Enabled = ablement;
            TextBox_emsof_nonparticipation_reason.Enabled = ablement;
            TextBox_emsof_contact_name.Enabled = ablement;
            TextBox_emsof_contact_primary_phone_num.Enabled = ablement;
            TextBox_emsof_contact_sms_phone_num.Enabled = ablement;
            TextBox_coo_name.Enabled = ablement;
            TextBox_coo_work_phone_num.Enabled = ablement;
            TextBox_coo_home_phone_num.Enabled = ablement;
            TextBox_coo_email_address.Enabled = ablement;
            TextBox_coo_mobile_phone_or_pager_num.Enabled = ablement;
            TextBox_md_name.Enabled = ablement;
            TextBox_md_office_phone_num.Enabled = ablement;
            TextBox_md_home_phone_num.Enabled = ablement;
            TextBox_md_email_address.Enabled = ablement;
            TextBox_md_mobile_phone_or_pager_num.Enabled = ablement;
            TextBox_physical_street_address_line_1.Enabled = ablement;
            TextBox_physical_street_address_line_2.Enabled = ablement;
            TextBox_physical_city.Enabled = ablement;
            TextBox_physical_zip_code.Enabled = ablement;
            TextBox_mail_address_line_1.Enabled = ablement;
            TextBox_mail_address_line_2.Enabled = ablement;
            TextBox_mail_city.Enabled = ablement;
            TextBox_mail_zip_code.Enabled = ablement;
            CheckBox_be_qrs_unrecognized.Enabled = ablement;
            CheckBox_be_qrs.Enabled = ablement;
            CheckBox_be_bls_amb.Enabled = ablement;
            CheckBox_be_als_amb.Enabled = ablement;
            CheckBox_be_als_squad.Enabled = ablement;
            CheckBox_be_air_amb.Enabled = ablement;
            CheckBox_be_rescue_unrecognized.Enabled = ablement;
            CheckBox_be_rescue.Enabled = ablement;
            CheckBox_be_pa_turnpike_contractor.Enabled = ablement;
            TextBox_num_doh_licensed_vehicles.Enabled = ablement;
            TextBox_num_ambulances.Enabled = ablement;
            RadioButtonList_be_dera.Enabled = ablement;
            TextBox_charter_other_kind.Enabled = ablement;
            RadioButtonList_be_valid_profile.Enabled = ablement;
            TextBox_federal_tax_id.Enabled = ablement;
            RadioButtonList_be_distressed.Enabled = ablement;
        }

        protected void Button_lookup_Click(object sender, System.EventArgs e)
        {
            uint num_matches;
            string saved_affiliate_num;
            saved_affiliate_num = TextBox_affiliate_num.Text;
            Clear();
            if (!PresentRecord(saved_affiliate_num))
            {
                TextBox_affiliate_num.Text = saved_affiliate_num;
                p.biz_services.Bind(saved_affiliate_num, DropDownList_affiliate_num);
                num_matches = (uint)(DropDownList_affiliate_num.Items.Count);
                if (num_matches > 0)
                {
                    LinkButton_go_to_match_prior.Visible = true;
                    LinkButton_go_to_match_next.Visible = true;
                    LinkButton_go_to_match_last.Visible = true;
                    LinkButton_go_to_match_first.Visible = true;
                    DropDownList_affiliate_num.Visible = true;
                    if (num_matches == 1)
                    {
                        PresentRecord(k.Safe(DropDownList_affiliate_num.SelectedValue, k.safe_hint_type.NUM));
                    }
                    else
                    {
                        DropDownList_affiliate_num.Items.Insert(0, new ListItem("-- Select --", k.EMPTY));
                    }
                }
            }
        }

        private void ManageEmsofControlEnablements()
        {
            bool be_emsof_participant;
            be_emsof_participant = (RadioButtonList_be_emsof_participant.SelectedValue != "FALSE");
            RadioButtonList_be_emsof_participant.Enabled = !(p.biz_appropriations.BeAnyCurrentToService(p.affiliate_num) && be_emsof_participant);
            Label_emsof_nonparticipation_reason.Enabled = !be_emsof_participant;
            TextBox_emsof_nonparticipation_reason.Enabled = !be_emsof_participant;
            TableRow_emsof_contact_name.Visible = be_emsof_participant;
            TableRow_emsof_contact_primary_phone_num.Visible = be_emsof_participant;
            TableRow_emsof_contact_sms_phone_num.Visible = be_emsof_participant;
            if (be_emsof_participant)
            {
                TextBox_emsof_nonparticipation_reason.Text = k.EMPTY;
            }
            else
            {
                TextBox_emsof_contact_name.Text = k.EMPTY;
                TextBox_emsof_contact_primary_phone_num.Text = k.EMPTY;
                TextBox_emsof_contact_sms_phone_num.Text = k.EMPTY;
            }
        }

        private void ManageCharterControlEnablements()
        {
            bool be_charter_other_kind;
            be_charter_other_kind = (DropDownList_charter_kind.SelectedItem.Text == "Other");
            Label_charter_other_kind.Enabled = be_charter_other_kind;
            TextBox_charter_other_kind.Enabled = be_charter_other_kind;
            RequiredFieldValidator_charter_other_kind.Enabled = be_charter_other_kind;
            if (!be_charter_other_kind)
            {
                TextBox_charter_other_kind.Text = k.EMPTY;
            }
        }

        private struct p_type
        {
            public string affiliate_num;
            public bool be_authorized_to_delete_service;
            public bool be_loaded;
            public bool be_ok_to_config_service_profiles;
            public bool be_profile_initially_valid;
            public bool be_service_user;
            public TClass_biz_appropriations biz_appropriations;
            public TClass_biz_charter_kinds biz_charter_kinds;
            public TClass_biz_counties biz_counties;
            public TClass_biz_services biz_services;
            public TClass_biz_user biz_user;
        } // end p_type

    } // end TWebUserControl_service_profile

}
