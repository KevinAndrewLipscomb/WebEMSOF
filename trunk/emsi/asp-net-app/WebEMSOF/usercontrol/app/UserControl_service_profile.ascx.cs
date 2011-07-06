using Class_biz_accounts;
using Class_biz_appropriations;
using Class_biz_charter_kinds;
using Class_biz_counties;
using Class_biz_emsof_extra_service_county_dependencies;
using Class_biz_fy_calendar;
using Class_biz_milestones;
using Class_biz_services;
using Class_biz_user;
using kix;
using System;
using System.Collections;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
            TextBox_primary_response_area.Text = k.EMPTY;
            CheckBoxList_extra_dependency.ClearSelection();
            TextBox_charter_other_kind.Text = k.EMPTY;
            RadioButtonList_be_valid_profile.ClearSelection();
            TextBox_federal_tax_id.Text = k.EMPTY;
            TextBox_num_staff_typical_als_08_16.Text = k.EMPTY;
            TextBox_num_staff_typical_als_16_00.Text = k.EMPTY;
            TextBox_num_staff_typical_als_00_08.Text = k.EMPTY;
            TextBox_num_staff_typical_bls_08_16.Text = k.EMPTY;
            TextBox_num_staff_typical_bls_16_00.Text = k.EMPTY;
            TextBox_num_staff_typical_bls_00_08.Text = k.EMPTY;
            TextBox_num_units_typical_als_08_16.Text = k.EMPTY;
            TextBox_num_units_typical_als_16_00.Text = k.EMPTY;
            TextBox_num_units_typical_als_00_08.Text = k.EMPTY;
            TextBox_num_units_typical_bls_08_16.Text = k.EMPTY;
            TextBox_num_units_typical_bls_16_00.Text = k.EMPTY;
            TextBox_num_units_typical_bls_00_08.Text = k.EMPTY;
            TextBox_num_n95_masks.Text = k.EMPTY;
            TextBox_num_scba.Text = k.EMPTY;
            TextBox_num_pfd.Text = k.EMPTY;
            TextBox_num_portable_vents.Text = k.EMPTY;
            TextBox_num_infusion_pumps.Text = k.EMPTY;
            TextBox_num_bariatric_stretchers.Text = k.EMPTY;
            TextBox_num_golf_carts.Text = k.EMPTY;
            TextBox_num_gators.Text = k.EMPTY;
            TextBox_num_quads.Text = k.EMPTY;
            TextBox_num_mci_special_event_trailers.Text = k.EMPTY;
            TextBox_num_bariatric_equipped_units.Text = k.EMPTY;
            TextBox_num_wheelchair_vans.Text = k.EMPTY;
            TextBox_num_opensky_radios.Text = k.EMPTY;
            TextBox_num_uhf_portables.Text = k.EMPTY;
            TextBox_num_uhf_mobiles.Text = k.EMPTY;
            TextBox_num_vhf_portables.Text = k.EMPTY;
            TextBox_num_vhf_mobiles.Text = k.EMPTY;
            TextBox_num_trunked_radios.Text = k.EMPTY;
            TextBox_num_gps_receivers.Text = k.EMPTY;
            TextBox_num_mark_1_kits.Text = k.EMPTY;
            TextBox_num_cases_potable_h2o.Text = k.EMPTY;
            TextBox_num_recognized_rescue_units.Text = k.EMPTY;
            TextBox_num_4wd_ambulances.Text = k.EMPTY;
            TextBox_num_recognized_qrs_units.Text = k.EMPTY;
            TextBox_num_unrecognized_qrs_units.Text = k.EMPTY;
            TextBox_num_boats.Text = k.EMPTY;
            TextBox_num_ballistic_vests.Text = k.EMPTY;
            TextBox_num_cases_mre.Text = k.EMPTY;
            TextBox_inventory_memo.Text = k.EMPTY;
            TextBox_key_cell_phone_1_num.Text = k.EMPTY;
            TextBox_key_cell_phone_1_assignee.Text = k.EMPTY;
            TextBox_key_cell_phone_2_num.Text = k.EMPTY;
            TextBox_key_cell_phone_2_assignee.Text = k.EMPTY;
            TextBox_key_cell_phone_3_num.Text = k.EMPTY;
            TextBox_key_cell_phone_3_assignee.Text = k.EMPTY;
            TextBox_key_cell_phone_4_num.Text = k.EMPTY;
            TextBox_key_cell_phone_4_assignee.Text = k.EMPTY;
            TextBox_key_cell_phone_5_num.Text = k.EMPTY;
            TextBox_key_cell_phone_5_assignee.Text = k.EMPTY;
            TextBox_key_cell_phone_6_num.Text = k.EMPTY;
            TextBox_key_cell_phone_6_assignee.Text = k.EMPTY;
            TextBox_radio_channel_1.Text = k.EMPTY;
            TextBox_radio_channel_2.Text = k.EMPTY;
            TextBox_radio_channel_3.Text = k.EMPTY;
            TextBox_radio_channel_4.Text = k.EMPTY;
            TextBox_radio_channel_5.Text = k.EMPTY;
            TextBox_radio_channel_6.Text = k.EMPTY;
            RadioButtonList_be_distressed.ClearSelection();
            ManageCharterControlEnablements();
            ManageEmsofControlEnablements();
            ManageDeraControlEnablements();
            ManageTabPanelCustomValidatorEnablements();
      Literal_match_index.Text = k.EMPTY;
      Literal_num_matches.Text = k.EMPTY;
      Panel_match_numbers.Visible = false;
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
                    //
                  }
                else
                  {
                  TabContainer_control.ActiveTabIndex = 1;
                  TextBox_name.Focus();
                  }
                p.biz_counties.BindDirectToListControl(DropDownList_county, "-- County --");
                p.biz_charter_kinds.BindDirectToListControl(DropDownList_charter_kind, "-- Charter kind --");
                Literal_application_name.Text = ConfigurationManager.AppSettings["application_name"];
                p.biz_counties.BindDirectToListControl(CheckBoxList_extra_dependency,k.EMPTY);
                LinkButton_go_to_match_first.Text = k.ExpandTildePath(LinkButton_go_to_match_first.Text);
                LinkButton_go_to_match_prior.Text = k.ExpandTildePath(LinkButton_go_to_match_prior.Text);
                LinkButton_go_to_match_next.Text = k.ExpandTildePath(LinkButton_go_to_match_next.Text);
                LinkButton_go_to_match_last.Text = k.ExpandTildePath(LinkButton_go_to_match_last.Text);
                RequireConfirmation(Button_delete, "Are you sure you want to delete this record?");
                if (p.affiliate_num != k.EMPTY)
                {
                    PresentRecord(p.affiliate_num);
                }
                if (Session["mode:profile-rendition"].ToString() == "printable-report")
                  {
                  PlaceHolder_tabpanel_interior_introduction.Controls.Remove(Panel_movable_introduction);
                  PlaceHolder_report_introduction.Controls.Add(Panel_movable_introduction);
                  PlaceHolder_tabpanel_interior_basic_id.Controls.Remove(Panel_movable_basic_id);
                  PlaceHolder_report_basic_id.Controls.Add(Panel_movable_basic_id);
                  PlaceHolder_tabpanel_interior_corporate_contact.Controls.Remove(Panel_movable_corporate_contact);
                  PlaceHolder_report_corporate_contact.Controls.Add(Panel_movable_corporate_contact);
                  PlaceHolder_tabpanel_interior_emsof_contact.Controls.Remove(Panel_movable_emsof_contact);
                  PlaceHolder_report_emsof_contact.Controls.Add(Panel_movable_emsof_contact);
                  PlaceHolder_tabpanel_interior_ops_contact.Controls.Remove(Panel_movable_ops_contact);
                  PlaceHolder_report_ops_contact.Controls.Add(Panel_movable_ops_contact);
                  PlaceHolder_tabpanel_interior_md_contact.Controls.Remove(Panel_movable_md_contact);
                  PlaceHolder_report_md_contact.Controls.Add(Panel_movable_md_contact);
                  PlaceHolder_tabpanel_interior_physical_address.Controls.Remove(Panel_movable_physical_address);
                  PlaceHolder_report_physical_address.Controls.Add(Panel_movable_physical_address);
                  PlaceHolder_tabpanel_interior_mailing_address.Controls.Remove(Panel_movable_mailing_address);
                  PlaceHolder_report_mailing_address.Controls.Add(Panel_movable_mailing_address);
                  PlaceHolder_tabpanel_interior_nature_of_service.Controls.Remove(Panel_movable_nature_of_service);
                  PlaceHolder_report_nature_of_service.Controls.Add(Panel_movable_nature_of_service);
                  PlaceHolder_tabpanel_interior_inventory.Controls.Remove(Panel_movable_inventory);
                  PlaceHolder_report_inventory.Controls.Add(Panel_movable_inventory);
                  PlaceHolder_tabpanel_interior_depth.Controls.Remove(Panel_movable_depth);
                  PlaceHolder_report_depth.Controls.Add(Panel_movable_depth);
                  PlaceHolder_tabpanel_interior_communications.Controls.Remove(Panel_movable_communications);
                  PlaceHolder_report_communications.Controls.Add(Panel_movable_communications);
                  PlaceHolder_tabpanel_interior_wrap_up.Controls.Remove(Panel_movable_wrap_up);
                  PlaceHolder_report_wrap_up.Controls.Add(Panel_movable_wrap_up);
                  ListItem_visit_all_tabs.Visible = false;
                  ListItem_submit_to_save.Visible = false;
                  Button_lookup.Visible = false;
                  Label_lookup_arrow.Visible = false;
                  Label_lookup_hint.Visible = false;
                  LinkButton_reset.Visible = false;
                  SetDependentFieldAblements(false);
                  Panel_tabcontainer.Visible = false;
                  Panel_report.Visible = true;
                  }
                p.be_loaded = true;
            }
            InjectPersistentClientSideScript();
            ScriptManager.GetCurrent(Page).RegisterPostBackControl(Button_submit);
            ScriptManager.GetCurrent(Page).RegisterPostBackControl(Button_delete);
        }

        private bool PresentRecord(string affiliate_num)
        {
        Literal_match_index.Text = DropDownList_affiliate_num.SelectedIndex.ToString();
            bool result;
            string id;
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
            string num_staff_typical_als_08_16;
            string num_staff_typical_als_16_00;
            string num_staff_typical_als_00_08;
            string num_staff_typical_bls_08_16;
            string num_staff_typical_bls_16_00;
            string num_staff_typical_bls_00_08;
            string num_units_typical_als_08_16;
            string num_units_typical_als_16_00;
            string num_units_typical_als_00_08;
            string num_units_typical_bls_08_16;
            string num_units_typical_bls_16_00;
            string num_units_typical_bls_00_08;
            string num_n95_masks;
            string num_scba;
            string num_pfd;
            string num_portable_vents;
            string num_infusion_pumps;
            string num_bariatric_stretchers;
            string num_golf_carts;
            string num_gators;
            string num_quads;
            string num_mci_special_event_trailers;
            string num_bariatric_equipped_units;
            string num_wheelchair_vans;
            string num_opensky_radios;
            string num_uhf_portables;
            string num_uhf_mobiles;
            string num_vhf_portables;
            string num_vhf_mobiles;
            string num_trunked_radios;
            string num_gps_receivers;
            string num_mark_1_kits;
            string num_cases_potable_h2o;
            string num_recognized_rescue_units;
            string num_4wd_ambulances;
            string num_recognized_qrs_units;
            string num_unrecognized_qrs_units;
            string num_boats;
            string num_ballistic_vests;
            string num_cases_mre;
            string inventory_memo;
            string key_cell_phone_1_num;
            string key_cell_phone_1_assignee;
            string key_cell_phone_2_num;
            string key_cell_phone_2_assignee;
            string key_cell_phone_3_num;
            string key_cell_phone_3_assignee;
            string key_cell_phone_4_num;
            string key_cell_phone_4_assignee;
            string key_cell_phone_5_num;
            string key_cell_phone_5_assignee;
            string key_cell_phone_6_num;
            string key_cell_phone_6_assignee;
            string radio_channel_1;
            string radio_channel_2;
            string radio_channel_3;
            string radio_channel_4;
            string radio_channel_5;
            string radio_channel_6;
            string primary_response_area;
            result = false;
            if
              (
              p.biz_services.Get
                (
                affiliate_num,
                out id,
                out name,
                out county_code,
                out business_phone_num,
                out business_fax_num,
                out website_address,
                out charter_kind,
                out corpadmin_contact_name,
                out corpadmin_primary_phone_num,
                out corpadmin_secondary_phone_num,
                out corpadmin_email_address,
                out be_emsof_participant,
                out emsof_nonparticipation_reason,
                out emsof_contact_name,
                out emsof_contact_primary_phone_num,
                out emsof_contact_sms_phone_num,
                out coo_name,
                out coo_work_phone_num,
                out coo_home_phone_num,
                out coo_email_address,
                out coo_mobile_phone_or_pager_num,
                out md_name,
                out md_office_phone_num,
                out md_home_phone_num,
                out md_email_address,
                out md_mobile_phone_or_pager_num,
                out physical_street_address_line_1,
                out physical_street_address_line_2,
                out physical_city,
                out physical_state,
                out physical_zip_code,
                out mail_address_line_1,
                out mail_address_line_2,
                out mail_city,
                out mail_state,
                out mail_zip_code,
                out be_qrs,
                out be_bls_amb,
                out be_als_amb,
                out be_als_squad,
                out be_air_amb,
                out be_rescue,
                out be_pa_turnpike_contractor,
                out num_doh_licensed_vehicles,
                out num_ambulances,
                out be_dera,
                out charter_other_kind,
                out be_valid_profile,
                out federal_tax_id,
                out be_qrs_unrecognized,
                out be_rescue_unrecognized,
                out be_distressed,
                out num_staff_typical_als_08_16,
                out num_staff_typical_als_16_00,
                out num_staff_typical_als_00_08,
                out num_staff_typical_bls_08_16,
                out num_staff_typical_bls_16_00,
                out num_staff_typical_bls_00_08,
                out num_units_typical_als_08_16,
                out num_units_typical_als_16_00,
                out num_units_typical_als_00_08,
                out num_units_typical_bls_08_16,
                out num_units_typical_bls_16_00,
                out num_units_typical_bls_00_08,
                out num_n95_masks,
                out num_scba,
                out num_pfd,
                out num_portable_vents,
                out num_infusion_pumps,
                out num_bariatric_stretchers,
                out num_golf_carts,
                out num_gators,
                out num_quads,
                out num_mci_special_event_trailers,
                out num_bariatric_equipped_units,
                out num_wheelchair_vans,
                out num_opensky_radios,
                out num_uhf_portables,
                out num_uhf_mobiles,
                out num_vhf_portables,
                out num_vhf_mobiles,
                out num_trunked_radios,
                out num_gps_receivers,
                out num_mark_1_kits,
                out num_cases_potable_h2o,
                out num_recognized_rescue_units,
                out num_4wd_ambulances,
                out num_recognized_qrs_units,
                out num_unrecognized_qrs_units,
                out num_boats,
                out num_ballistic_vests,
                out num_cases_mre,
                out inventory_memo,
                out key_cell_phone_1_num,
                out key_cell_phone_1_assignee,
                out key_cell_phone_2_num,
                out key_cell_phone_2_assignee,
                out key_cell_phone_3_num,
                out key_cell_phone_3_assignee,
                out key_cell_phone_4_num,
                out key_cell_phone_4_assignee,
                out key_cell_phone_5_num,
                out key_cell_phone_5_assignee,
                out key_cell_phone_6_num,
                out key_cell_phone_6_assignee,
                out radio_channel_1,
                out radio_channel_2,
                out radio_channel_3,
                out radio_channel_4,
                out radio_channel_5,
                out radio_channel_6,
                out primary_response_area
                )
              )
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
                TextBox_primary_response_area.Text = primary_response_area;
                TextBox_charter_other_kind.Text = charter_other_kind;
                RadioButtonList_be_valid_profile.SelectedValue = be_valid_profile.ToString().ToUpper();
                TextBox_federal_tax_id.Text = federal_tax_id;
                RadioButtonList_be_distressed.SelectedValue = be_distressed.ToString().ToUpper();
                TextBox_num_staff_typical_als_08_16.Text = num_staff_typical_als_08_16;
                TextBox_num_staff_typical_als_16_00.Text = num_staff_typical_als_16_00;
                TextBox_num_staff_typical_als_00_08.Text = num_staff_typical_als_00_08;
                TextBox_num_staff_typical_bls_08_16.Text = num_staff_typical_bls_08_16;
                TextBox_num_staff_typical_bls_16_00.Text = num_staff_typical_bls_16_00;
                TextBox_num_staff_typical_bls_00_08.Text = num_staff_typical_bls_00_08;
                TextBox_num_units_typical_als_08_16.Text = num_units_typical_als_08_16;
                TextBox_num_units_typical_als_16_00.Text = num_units_typical_als_16_00;
                TextBox_num_units_typical_als_00_08.Text = num_units_typical_als_00_08;
                TextBox_num_units_typical_bls_08_16.Text = num_units_typical_bls_08_16;
                TextBox_num_units_typical_bls_16_00.Text = num_units_typical_bls_16_00;
                TextBox_num_units_typical_bls_00_08.Text = num_units_typical_bls_00_08;
                TextBox_num_n95_masks.Text = num_n95_masks;
                TextBox_num_scba.Text = num_scba;
                TextBox_num_pfd.Text = num_pfd;
                TextBox_num_portable_vents.Text = num_portable_vents;
                TextBox_num_infusion_pumps.Text = num_infusion_pumps;
                TextBox_num_bariatric_stretchers.Text = num_bariatric_stretchers;
                TextBox_num_golf_carts.Text = num_golf_carts;
                TextBox_num_gators.Text = num_gators;
                TextBox_num_quads.Text = num_quads;
                TextBox_num_mci_special_event_trailers.Text = num_mci_special_event_trailers;
                TextBox_num_bariatric_equipped_units.Text = num_bariatric_equipped_units;
                TextBox_num_wheelchair_vans.Text = num_wheelchair_vans;
                TextBox_num_opensky_radios.Text = num_opensky_radios;
                TextBox_num_uhf_portables.Text = num_uhf_portables;
                TextBox_num_uhf_mobiles.Text = num_uhf_mobiles;
                TextBox_num_vhf_portables.Text = num_vhf_portables;
                TextBox_num_vhf_mobiles.Text = num_vhf_mobiles;
                TextBox_num_trunked_radios.Text = num_trunked_radios;
                TextBox_num_gps_receivers.Text = num_gps_receivers;
                TextBox_num_mark_1_kits.Text = num_mark_1_kits;
                TextBox_num_cases_potable_h2o.Text = num_cases_potable_h2o;
                TextBox_num_recognized_rescue_units.Text = num_recognized_rescue_units;
                TextBox_num_4wd_ambulances.Text = num_4wd_ambulances;
                TextBox_num_recognized_qrs_units.Text = num_recognized_qrs_units;
                TextBox_num_unrecognized_qrs_units.Text = num_unrecognized_qrs_units;
                TextBox_num_boats.Text = num_boats;
                TextBox_num_ballistic_vests.Text = num_ballistic_vests;
                TextBox_num_cases_mre.Text = num_cases_mre;
                TextBox_inventory_memo.Text = inventory_memo;
                TextBox_key_cell_phone_1_num.Text = key_cell_phone_1_num;
                TextBox_key_cell_phone_1_assignee.Text = key_cell_phone_1_assignee;
                TextBox_key_cell_phone_2_num.Text = key_cell_phone_2_num;
                TextBox_key_cell_phone_2_assignee.Text = key_cell_phone_2_assignee;
                TextBox_key_cell_phone_3_num.Text = key_cell_phone_3_num;
                TextBox_key_cell_phone_3_assignee.Text = key_cell_phone_3_assignee;
                TextBox_key_cell_phone_4_num.Text = key_cell_phone_4_num;
                TextBox_key_cell_phone_4_assignee.Text = key_cell_phone_4_assignee;
                TextBox_key_cell_phone_5_num.Text = key_cell_phone_5_num;
                TextBox_key_cell_phone_5_assignee.Text = key_cell_phone_5_assignee;
                TextBox_key_cell_phone_6_num.Text = key_cell_phone_6_num;
                TextBox_key_cell_phone_6_assignee.Text = key_cell_phone_6_assignee;
                TextBox_radio_channel_1.Text = radio_channel_1;
                TextBox_radio_channel_2.Text = radio_channel_2;
                TextBox_radio_channel_3.Text = radio_channel_3;
                TextBox_radio_channel_4.Text = radio_channel_4;
                TextBox_radio_channel_5.Text = radio_channel_5;
                TextBox_radio_channel_6.Text = radio_channel_6;
                //
                p.saved_home_county_code = county_code;
                p.service_id = id;
                var extra_dependency_q = new Queue();
                p.biz_emsof_extra_service_county_dependencies.Get(p.service_id,extra_dependency_q);
                foreach (ListItem check_box in CheckBoxList_extra_dependency.Items)
                  {
                  check_box.Selected = (check_box.Value == p.saved_home_county_code) || extra_dependency_q.Contains(check_box.Value);
                  check_box.Enabled = (check_box.Value != p.saved_home_county_code);
                  }
                //
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
                ManageDeraControlEnablements();
                ManageTabPanelCustomValidatorEnablements();
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
            TabContainer_control.ActiveTabIndex = 1;
            TextBox_affiliate_num.Focus();
        }

        protected override void OnInit(System.EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);
            if (Session[InstanceId() + ".p"] != null)
            {
                p = (p_type)(Session[InstanceId() + ".p"]);
                p.be_loaded = IsPostBack;
            }
            else
            {
                p.biz_accounts = new TClass_biz_accounts();
                p.biz_appropriations = new TClass_biz_appropriations();
                p.biz_charter_kinds = new TClass_biz_charter_kinds();
                p.biz_counties = new TClass_biz_counties();
                p.biz_emsof_extra_service_county_dependencies = new TClass_biz_emsof_extra_service_county_dependencies();
                p.biz_fy_calendar = new TClass_biz_fy_calendar();
                p.biz_services = new TClass_biz_services();
                p.biz_user = new TClass_biz_user();
                p.affiliate_num = k.EMPTY;
                p.be_authorized_to_delete_service = p.biz_services.BeOkToDelete();
                p.be_before_submission_deadline = (DateTime.Now <= p.biz_fy_calendar.MilestoneDate(milestone_type.SERVICE_ANNUAL_SURVEY_SUBMISSION_DEADLINE));
                p.be_loaded = false;
                p.be_service_user = (p.biz_user.Kind() == "service");
                p.be_profile_initially_valid = false;
                p.be_visited_tab_panel_basic_id = false;
                p.be_visited_tab_panel_communications = false;
                p.be_visited_tab_panel_corporate_contact = false;
                p.be_visited_tab_panel_depth = false;
                p.be_visited_tab_panel_emsof_contact = false;
                p.be_visited_tab_panel_inventory = false;
                p.be_visited_tab_panel_mailing_address = false;
                p.be_visited_tab_panel_md_contact = false;
                p.be_visited_tab_panel_nature_of_service = false;
                p.be_visited_tab_panel_ops_contact = false;
                p.be_visited_tab_panel_physical_address = false;
                p.be_visited_tab_panel_wrap_up = false;
                p.saved_home_county_code = k.EMPTY;
                p.service_id = k.EMPTY;
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
            SessionSet(InstanceId() + ".p", p);
        }

        public TWebUserControl_service_profile Fresh()
        {
            TWebUserControl_service_profile result;
            Session.Remove(InstanceId() + ".p");
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

        protected void DropDownList_county_SelectedIndexChanged(object sender, System.EventArgs e)
          {
          var new_home_county_code = k.Safe(DropDownList_county.SelectedValue,k.safe_hint_type.NUM);
          foreach (ListItem check_box in CheckBoxList_extra_dependency.Items)
            {
            if (check_box.Value == new_home_county_code)
              {
              check_box.Selected = true;
              }
            check_box.Enabled = (check_box.Value != new_home_county_code);
            }
          p.saved_home_county_code = new_home_county_code;
          }

        protected void Button_submit_Click(object sender, System.EventArgs e)
        {
            if (Page.IsValid)
            {
                p.biz_services.Set
                  (
                  k.Safe(TextBox_affiliate_num.Text, k.safe_hint_type.NUM),
                  k.Safe(TextBox_name.Text, k.safe_hint_type.ORG_NAME).Trim(),
                  k.Safe(DropDownList_county.SelectedValue, k.safe_hint_type.NUM),
                  k.Safe(TextBox_business_phone_num.Text, k.safe_hint_type.NUM),
                  k.Safe(TextBox_business_fax_num.Text, k.safe_hint_type.NUM),
                  k.Safe(TextBox_website_address.Text, k.safe_hint_type.HTTP_TARGET).Trim(),
                  k.Safe(DropDownList_charter_kind.SelectedValue, k.safe_hint_type.NUM),
                  k.Safe(TextBox_corpadmin_contact_name.Text, k.safe_hint_type.HUMAN_NAME).Trim(),
                  k.Safe(TextBox_corpadmin_primary_phone_num.Text, k.safe_hint_type.NUM),
                  k.Safe(TextBox_corpadmin_secondary_phone_num.Text, k.safe_hint_type.NUM),
                  k.Safe(TextBox_corpadmin_email_address.Text, k.safe_hint_type.EMAIL_ADDRESS).Trim(),
                  (RadioButtonList_be_emsof_participant.SelectedValue == "TRUE"),
                  k.Safe(TextBox_emsof_nonparticipation_reason.Text, k.safe_hint_type.PUNCTUATED).Trim(),
                  k.Safe(TextBox_emsof_contact_name.Text, k.safe_hint_type.HUMAN_NAME).Trim(),
                  k.Safe(TextBox_emsof_contact_primary_phone_num.Text, k.safe_hint_type.NUM),
                  k.EMPTY,
                  k.Safe(TextBox_coo_name.Text, k.safe_hint_type.HUMAN_NAME).Trim(),
                  k.Safe(TextBox_coo_work_phone_num.Text, k.safe_hint_type.NUM),
                  k.Safe(TextBox_coo_home_phone_num.Text, k.safe_hint_type.NUM),
                  k.Safe(TextBox_coo_email_address.Text, k.safe_hint_type.EMAIL_ADDRESS).Trim(),
                  k.Safe(TextBox_coo_mobile_phone_or_pager_num.Text, k.safe_hint_type.NUM),
                  k.Safe(TextBox_md_name.Text, k.safe_hint_type.HUMAN_NAME).Trim(),
                  k.Safe(TextBox_md_office_phone_num.Text, k.safe_hint_type.NUM),
                  k.Safe(TextBox_md_home_phone_num.Text, k.safe_hint_type.NUM),
                  k.Safe(TextBox_md_email_address.Text, k.safe_hint_type.EMAIL_ADDRESS).Trim(),
                  k.Safe(TextBox_md_mobile_phone_or_pager_num.Text, k.safe_hint_type.NUM),
                  k.Safe(TextBox_physical_street_address_line_1.Text, k.safe_hint_type.POSTAL_STREET_ADDRESS).Trim(),
                  k.Safe(TextBox_physical_street_address_line_2.Text, k.safe_hint_type.POSTAL_STREET_ADDRESS).Trim(),
                  k.Safe(TextBox_physical_city.Text, k.safe_hint_type.POSTAL_CITY).Trim(),
                  "PA",
                  k.Safe(TextBox_physical_zip_code.Text, k.safe_hint_type.NUM),
                  k.Safe(TextBox_mail_address_line_1.Text, k.safe_hint_type.POSTAL_STREET_ADDRESS).Trim(),
                  k.Safe(TextBox_mail_address_line_2.Text, k.safe_hint_type.POSTAL_STREET_ADDRESS).Trim(),
                  k.Safe(TextBox_mail_city.Text, k.safe_hint_type.POSTAL_CITY).Trim(),
                  "PA",
                  k.Safe(TextBox_mail_zip_code.Text, k.safe_hint_type.NUM),
                  CheckBox_be_qrs.Checked,
                  CheckBox_be_bls_amb.Checked,
                  CheckBox_be_als_amb.Checked,
                  CheckBox_be_als_squad.Checked,
                  CheckBox_be_air_amb.Checked,
                  CheckBox_be_rescue.Checked,
                  CheckBox_be_pa_turnpike_contractor.Checked,
                  k.Safe(TextBox_num_doh_licensed_vehicles.Text, k.safe_hint_type.NUM),
                  k.Safe(TextBox_num_ambulances.Text, k.safe_hint_type.NUM),
                  (RadioButtonList_be_dera.SelectedValue == "TRUE"),
                  k.Safe(TextBox_charter_other_kind.Text, k.safe_hint_type.PUNCTUATED).Trim(),
                  (p.be_service_user && !p.be_profile_initially_valid),
                  ((p.be_service_user && p.be_before_submission_deadline) || (RadioButtonList_be_valid_profile.SelectedValue == "TRUE")),
                  k.Safe(TextBox_federal_tax_id.Text, k.safe_hint_type.NUM),
                  CheckBox_be_qrs_unrecognized.Checked,
                  CheckBox_be_rescue_unrecognized.Checked,
                  (RadioButtonList_be_distressed.SelectedValue == "TRUE"),
                  k.Safe(TextBox_num_staff_typical_als_08_16.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_staff_typical_als_16_00.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_staff_typical_als_00_08.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_staff_typical_bls_08_16.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_staff_typical_bls_16_00.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_staff_typical_bls_00_08.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_units_typical_als_08_16.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_units_typical_als_16_00.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_units_typical_als_00_08.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_units_typical_bls_08_16.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_units_typical_bls_16_00.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_units_typical_bls_00_08.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_n95_masks.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_scba.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_pfd.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_portable_vents.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_infusion_pumps.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_bariatric_stretchers.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_golf_carts.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_gators.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_quads.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_mci_special_event_trailers.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_bariatric_equipped_units.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_wheelchair_vans.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_opensky_radios.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_uhf_portables.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_uhf_mobiles.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_vhf_portables.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_vhf_mobiles.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_trunked_radios.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_gps_receivers.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_mark_1_kits.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_cases_potable_h2o.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_recognized_rescue_units.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_4wd_ambulances.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_recognized_qrs_units.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_unrecognized_qrs_units.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_boats.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_ballistic_vests.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_num_cases_mre.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_inventory_memo.Text, k.safe_hint_type.PUNCTUATED).Trim(),
                  k.Safe(TextBox_key_cell_phone_1_num.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_key_cell_phone_1_assignee.Text, k.safe_hint_type.PUNCTUATED).Trim(),
                  k.Safe(TextBox_key_cell_phone_2_num.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_key_cell_phone_2_assignee.Text, k.safe_hint_type.PUNCTUATED).Trim(),
                  k.Safe(TextBox_key_cell_phone_3_num.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_key_cell_phone_3_assignee.Text, k.safe_hint_type.PUNCTUATED).Trim(),
                  k.Safe(TextBox_key_cell_phone_4_num.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_key_cell_phone_4_assignee.Text, k.safe_hint_type.PUNCTUATED).Trim(),
                  k.Safe(TextBox_key_cell_phone_5_num.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_key_cell_phone_5_assignee.Text, k.safe_hint_type.PUNCTUATED).Trim(),
                  k.Safe(TextBox_key_cell_phone_6_num.Text, k.safe_hint_type.NUM).Trim(),
                  k.Safe(TextBox_key_cell_phone_6_assignee.Text, k.safe_hint_type.PUNCTUATED).Trim(),
                  k.Safe(TextBox_radio_channel_1.Text, k.safe_hint_type.PUNCTUATED).Trim(),
                  k.Safe(TextBox_radio_channel_2.Text, k.safe_hint_type.PUNCTUATED).Trim(),
                  k.Safe(TextBox_radio_channel_3.Text, k.safe_hint_type.PUNCTUATED).Trim(),
                  k.Safe(TextBox_radio_channel_4.Text, k.safe_hint_type.PUNCTUATED).Trim(),
                  k.Safe(TextBox_radio_channel_5.Text, k.safe_hint_type.PUNCTUATED).Trim(),
                  k.Safe(TextBox_radio_channel_6.Text, k.safe_hint_type.PUNCTUATED).Trim(),
                  k.Safe(TextBox_primary_response_area.Text, k.safe_hint_type.POSTAL_CITY_CSV).Trim()
                  );
                //
                var dependency_q = new Queue();
                foreach (ListItem dependency in CheckBoxList_extra_dependency.Items)
                  {
                  if (dependency.Selected)
                    {
                    dependency_q.Enqueue(k.Safe(dependency.Value,k.safe_hint_type.NUM));
                    }
                  }
                p.biz_emsof_extra_service_county_dependencies.Update(p.service_id,dependency_q,k.Safe(DropDownList_county.SelectedValue,k.safe_hint_type.NUM));
                //
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
            TextBox_primary_response_area.Enabled = ablement;
            TextBox_charter_other_kind.Enabled = ablement;
            RadioButtonList_be_valid_profile.Enabled = ablement;
            TextBox_federal_tax_id.Enabled = ablement;
            RadioButtonList_be_distressed.Enabled = ablement;
            TextBox_num_staff_typical_als_08_16.Enabled = ablement;
            TextBox_num_staff_typical_als_16_00.Enabled = ablement;
            TextBox_num_staff_typical_als_00_08.Enabled = ablement;
            TextBox_num_staff_typical_bls_08_16.Enabled = ablement;
            TextBox_num_staff_typical_bls_16_00.Enabled = ablement;
            TextBox_num_staff_typical_bls_00_08.Enabled = ablement;
            TextBox_num_units_typical_als_08_16.Enabled = ablement;
            TextBox_num_units_typical_als_16_00.Enabled = ablement;
            TextBox_num_units_typical_als_00_08.Enabled = ablement;
            TextBox_num_units_typical_bls_08_16.Enabled = ablement;
            TextBox_num_units_typical_bls_16_00.Enabled = ablement;
            TextBox_num_units_typical_bls_00_08.Enabled = ablement;
            TextBox_num_n95_masks.Enabled = ablement;
            TextBox_num_scba.Enabled = ablement;
            TextBox_num_pfd.Enabled = ablement;
            TextBox_num_portable_vents.Enabled = ablement;
            TextBox_num_infusion_pumps.Enabled = ablement;
            TextBox_num_bariatric_stretchers.Enabled = ablement;
            TextBox_num_golf_carts.Enabled = ablement;
            TextBox_num_gators.Enabled = ablement;
            TextBox_num_quads.Enabled = ablement;
            TextBox_num_mci_special_event_trailers.Enabled = ablement;
            TextBox_num_bariatric_equipped_units.Enabled = ablement;
            TextBox_num_wheelchair_vans.Enabled = ablement;
            TextBox_num_opensky_radios.Enabled = ablement;
            TextBox_num_uhf_portables.Enabled = ablement;
            TextBox_num_uhf_mobiles.Enabled = ablement;
            TextBox_num_vhf_portables.Enabled = ablement;
            TextBox_num_vhf_mobiles.Enabled = ablement;
            TextBox_num_trunked_radios.Enabled = ablement;
            TextBox_num_gps_receivers.Enabled = ablement;
            TextBox_num_mark_1_kits.Enabled = ablement;
            TextBox_num_cases_potable_h2o.Enabled = ablement;
            TextBox_num_recognized_rescue_units.Enabled = ablement;
            TextBox_num_4wd_ambulances.Enabled = ablement;
            TextBox_num_recognized_qrs_units.Enabled = ablement;
            TextBox_num_unrecognized_qrs_units.Enabled = ablement;
            TextBox_num_boats.Enabled = ablement;
            TextBox_num_ballistic_vests.Enabled = ablement;
            TextBox_num_cases_mre.Enabled = ablement;
            TextBox_inventory_memo.Enabled = ablement;
            TextBox_key_cell_phone_1_num.Enabled = ablement;
            TextBox_key_cell_phone_1_assignee.Enabled = ablement;
            TextBox_key_cell_phone_2_num.Enabled = ablement;
            TextBox_key_cell_phone_2_assignee.Enabled = ablement;
            TextBox_key_cell_phone_3_num.Enabled = ablement;
            TextBox_key_cell_phone_3_assignee.Enabled = ablement;
            TextBox_key_cell_phone_4_num.Enabled = ablement;
            TextBox_key_cell_phone_4_assignee.Enabled = ablement;
            TextBox_key_cell_phone_5_num.Enabled = ablement;
            TextBox_key_cell_phone_5_assignee.Enabled = ablement;
            TextBox_key_cell_phone_6_num.Enabled = ablement;
            TextBox_key_cell_phone_6_assignee.Enabled = ablement;
            TextBox_radio_channel_1.Enabled = ablement;
            TextBox_radio_channel_2.Enabled = ablement;
            TextBox_radio_channel_3.Enabled = ablement;
            TextBox_radio_channel_4.Enabled = ablement;
            TextBox_radio_channel_5.Enabled = ablement;
            TextBox_radio_channel_6.Enabled = ablement;
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
          DropDownList_affiliate_num.Visible = true;
          if (num_matches == 1)
            {
            PresentRecord(k.Safe(DropDownList_affiliate_num.SelectedValue, k.safe_hint_type.NUM));
            }
          else
            {
            Literal_match_index.Text = "0";
            Literal_num_matches.Text = num_matches.ToString();
            Panel_match_numbers.Visible = true;
            LinkButton_go_to_match_prior.Visible = true;
            LinkButton_go_to_match_next.Visible = true;
            LinkButton_go_to_match_last.Visible = true;
            LinkButton_go_to_match_first.Visible = true;
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
            if (be_emsof_participant)
            {
                TextBox_emsof_nonparticipation_reason.Text = k.EMPTY;
            }
            else
            {
                TextBox_emsof_contact_name.Text = k.EMPTY;
                TextBox_emsof_contact_primary_phone_num.Text = k.EMPTY;
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

        private void ManageDeraControlEnablements()
          {
          var be_dera = (RadioButtonList_be_dera.SelectedValue == "TRUE");
          Panel_dera_detail.Enabled = be_dera;
          RequiredFieldValidator_primary_response_area.Enabled = be_dera;
          if (!be_dera)
            {
            TextBox_primary_response_area.Text = k.EMPTY;
            }
          }

        private void ManageTabPanelCustomValidatorEnablements()
          {
          //
          var be_all_tabs_visit_required = p.be_service_user && !p.be_profile_initially_valid;
          //
          CustomValidator_basic_id.Enabled = be_all_tabs_visit_required;
          CustomValidator_communications.Enabled = be_all_tabs_visit_required;
          CustomValidator_corporate_contact.Enabled = be_all_tabs_visit_required;
          CustomValidator_depth_of_service.Enabled = be_all_tabs_visit_required;
          CustomValidator_emsof_contact.Enabled = be_all_tabs_visit_required;
          CustomValidator_inventory.Enabled = be_all_tabs_visit_required;
          CustomValidator_mailing_address.Enabled = be_all_tabs_visit_required;
          CustomValidator_md_contact.Enabled = be_all_tabs_visit_required;
          CustomValidator_nature_of_service.Enabled = be_all_tabs_visit_required;
          CustomValidator_ops_contact.Enabled = be_all_tabs_visit_required;
          CustomValidator_physical_address.Enabled = be_all_tabs_visit_required;
          CustomValidator_wrap_up.Enabled = be_all_tabs_visit_required;
          //
          }

        private struct p_type
        {
            public string affiliate_num;
            public bool be_authorized_to_delete_service;
            public bool be_before_submission_deadline;
            public bool be_loaded;
            public bool be_ok_to_config_service_profiles;
            public bool be_profile_initially_valid;
            public bool be_service_user;
            public bool be_visited_tab_panel_basic_id;
            public bool be_visited_tab_panel_communications;
            public bool be_visited_tab_panel_corporate_contact;
            public bool be_visited_tab_panel_depth;
            public bool be_visited_tab_panel_emsof_contact;
            public bool be_visited_tab_panel_inventory;
            public bool be_visited_tab_panel_mailing_address;
            public bool be_visited_tab_panel_md_contact;
            public bool be_visited_tab_panel_nature_of_service;
            public bool be_visited_tab_panel_ops_contact;
            public bool be_visited_tab_panel_physical_address;
            public bool be_visited_tab_panel_wrap_up;
            public TClass_biz_accounts biz_accounts;
            public TClass_biz_appropriations biz_appropriations;
            public TClass_biz_charter_kinds biz_charter_kinds;
            public TClass_biz_counties biz_counties;
            public TClass_biz_emsof_extra_service_county_dependencies biz_emsof_extra_service_county_dependencies;
            public TClass_biz_fy_calendar biz_fy_calendar;
            public TClass_biz_services biz_services;
            public TClass_biz_user biz_user;
            public string saved_home_county_code;
            public string service_id;
        }

        protected void CustomValidator_num_4wd_ambulances_ServerValidate(object source, ServerValidateEventArgs args)
          {
          args.IsValid = (uint.Parse(k.Safe(TextBox_num_4wd_ambulances.Text, k.safe_hint_type.NUM)) <= uint.Parse(k.Safe(TextBox_num_ambulances.Text, k.safe_hint_type.NUM)));
          }

        protected void CustomValidator_num_bariatric_equipped_units_ServerValidate(object source, ServerValidateEventArgs args)
          {
          args.IsValid = (uint.Parse(k.Safe(TextBox_num_bariatric_equipped_units.Text, k.safe_hint_type.NUM)) <= uint.Parse(k.Safe(TextBox_num_ambulances.Text, k.safe_hint_type.NUM)));
          }

        protected void RadioButtonList_be_dera_SelectedIndexChanged(object sender, EventArgs e)
          {
          ManageDeraControlEnablements();
          }

        protected void CustomValidator_basic_id_ServerValidate(object source, ServerValidateEventArgs args)
          {
          args.IsValid = p.be_visited_tab_panel_basic_id;
          }

        protected void CustomValidator_corporate_contact_ServerValidate(object source, ServerValidateEventArgs args)
          {
          args.IsValid = p.be_visited_tab_panel_corporate_contact;
          }

        protected void CustomValidator_emsof_contact_ServerValidate(object source, ServerValidateEventArgs args)
          {
          args.IsValid = p.be_visited_tab_panel_emsof_contact;
          }

        protected void CustomValidator_ops_contact_ServerValidate(object source, ServerValidateEventArgs args)
          {
          args.IsValid = p.be_visited_tab_panel_ops_contact;
          }

        protected void CustomValidator_md_contact_ServerValidate(object source, ServerValidateEventArgs args)
          {
          args.IsValid = p.be_visited_tab_panel_md_contact;
          }

        protected void CustomValidator_physical_address_ServerValidate(object source, ServerValidateEventArgs args)
          {
          args.IsValid = p.be_visited_tab_panel_physical_address;
          }

        protected void CustomValidator_mailing_address_ServerValidate(object source, ServerValidateEventArgs args)
          {
          args.IsValid = p.be_visited_tab_panel_mailing_address;
          }

        protected void CustomValidator_nature_of_service_ServerValidate(object source, ServerValidateEventArgs args)
          {
          args.IsValid = p.be_visited_tab_panel_nature_of_service;
          }

        protected void CustomValidator_inventory_ServerValidate(object source, ServerValidateEventArgs args)
          {
          args.IsValid = p.be_visited_tab_panel_inventory;
          }

        protected void CustomValidator_depth_of_service_ServerValidate(object source, ServerValidateEventArgs args)
          {
          args.IsValid = p.be_visited_tab_panel_depth;
          }

        protected void CustomValidator_communications_ServerValidate(object source, ServerValidateEventArgs args)
          {
          args.IsValid = p.be_visited_tab_panel_communications;
          }

        protected void CustomValidator_wrap_up_ServerValidate(object source, ServerValidateEventArgs args)
          {
          args.IsValid = p.be_visited_tab_panel_wrap_up;
          }

        protected void TabContainer_control_ActiveTabChanged(object sender, EventArgs e)
          {
          if (TabContainer_control.ActiveTabIndex == 1)
            {
            p.be_visited_tab_panel_basic_id = true;
            }
          else if (TabContainer_control.ActiveTabIndex == 2)
            {
            p.be_visited_tab_panel_corporate_contact = true;
            }
          else if (TabContainer_control.ActiveTabIndex == 3)
            {
            p.be_visited_tab_panel_emsof_contact = true;
            }
          else if (TabContainer_control.ActiveTabIndex == 4)
            {
            p.be_visited_tab_panel_ops_contact = true;
            }
          else if (TabContainer_control.ActiveTabIndex == 5)
            {
            p.be_visited_tab_panel_md_contact = true;
            }
          else if (TabContainer_control.ActiveTabIndex == 6)
            {
            p.be_visited_tab_panel_physical_address = true;
            }
          else if (TabContainer_control.ActiveTabIndex == 7)
            {
            p.be_visited_tab_panel_mailing_address = true;
            }
          else if (TabContainer_control.ActiveTabIndex == 8)
            {
            p.be_visited_tab_panel_nature_of_service = true;
            }
          else if (TabContainer_control.ActiveTabIndex == 9)
            {
            p.be_visited_tab_panel_inventory = true;
            }
          else if (TabContainer_control.ActiveTabIndex == 10)
            {
            p.be_visited_tab_panel_depth = true;
            }
          else if (TabContainer_control.ActiveTabIndex == 11)
            {
            p.be_visited_tab_panel_communications = true;
            }
          else if (TabContainer_control.ActiveTabIndex == 12)
            {
            p.be_visited_tab_panel_wrap_up = true;
            }
          }

    } // end TWebUserControl_service_profile

}
