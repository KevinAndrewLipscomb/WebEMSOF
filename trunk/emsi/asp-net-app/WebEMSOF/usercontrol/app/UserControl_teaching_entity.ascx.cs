// Derived from KiAspdotnetFramework/UserControl/app/UserControl~template~kicrudhelped~item.ascx.cs~template

using Class_biz_teaching_entities;
using kix;
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Collections;
using UserControl_drop_down_date;

namespace UserControl_teaching_entity
  {
  public partial class TWebUserControl_teaching_entity: ki_web_ui.usercontrol_class
    {
    private p_type p;

    private void Clear()
      {
      TextBox_id.Text = k.EMPTY;
      DropDownList_id.Visible = false;
      TextBox_emsrs_id.Text = k.EMPTY;
      UserControl_drop_down_date_date_created.Clear();
      UserControl_drop_down_date_date_last_edited.Clear();
      TextBox_sponsor_number.Text = k.EMPTY;
      TextBox_training_ins_accred_num.Text = k.EMPTY;
      TextBox_name.Text = k.EMPTY;
      TextBox_short_name.Text = k.EMPTY;
      TextBox_address_1.Text = k.EMPTY;
      TextBox_address_2.Text = k.EMPTY;
      TextBox_city.Text = k.EMPTY;
      TextBox_state.Text = k.EMPTY;
      TextBox_zip.Text = k.EMPTY;
      TextBox_county_code.Text = k.EMPTY;
      TextBox_region.Text = k.EMPTY;
      TextBox_email.Text = k.EMPTY;
      TextBox_website.Text = k.EMPTY;
      TextBox_daytime_phone.Text = k.EMPTY;
      TextBox_evening_phone.Text = k.EMPTY;
      TextBox_fax.Text = k.EMPTY;
      TextBox_business_type_id.Text = k.EMPTY;
      TextBox_con_ed_level_id.Text = k.EMPTY;
      TextBox_certification_level.Text = k.EMPTY;
      TextBox_contact_first_name.Text = k.EMPTY;
      TextBox_contact_last_name.Text = k.EMPTY;
      TextBox_contact_title.Text = k.EMPTY;
      TextBox_contact_address_1.Text = k.EMPTY;
      TextBox_contact_address_2.Text = k.EMPTY;
      TextBox_contact_city.Text = k.EMPTY;
      TextBox_contact_state.Text = k.EMPTY;
      TextBox_contact_zip.Text = k.EMPTY;
      TextBox_contact_daytime_phone.Text = k.EMPTY;
      TextBox_contact_evening_phone.Text = k.EMPTY;
      TextBox_contact_fax.Text = k.EMPTY;
      TextBox_contact_email.Text = k.EMPTY;
      TextBox_public_contact_name.Text = k.EMPTY;
      TextBox_public_contact_phone.Text = k.EMPTY;
      TextBox_public_contact_email.Text = k.EMPTY;
      TextBox_public_contact_website.Text = k.EMPTY;
      TextBox_public_contact_notes.Text = k.EMPTY;
      UserControl_drop_down_date_application_date.Clear();
      UserControl_drop_down_date_application_received.Clear();
      TextBox_coned_sponsor_status_id.Text = k.EMPTY;
      TextBox_training_inst_status_id.Text = k.EMPTY;
      UserControl_drop_down_date_issue_date.Clear();
      UserControl_drop_down_date_prev_expiration_date.Clear();
      UserControl_drop_down_date_expiration_date_sponsor.Clear();
      UserControl_drop_down_date_expiration_date_training_inst.Clear();
      UserControl_drop_down_date_process_date.Clear();
      TextBox_corrective_action.Text = k.EMPTY;
      UserControl_drop_down_date_compliance_by_date.Clear();
      UserControl_drop_down_date_initial_accred_date.Clear();
      UserControl_drop_down_date_accepted_provisional_date.Clear();
      UserControl_drop_down_date_completed_provisional_date.Clear();
      UserControl_drop_down_date_withdrawal_challenge_due_date.Clear();
      CheckBox_letter_for_expiration.Checked = false;
      CheckBox_letter_f_for_ppwk_non_compliance.Checked = false;
      CheckBox_other_letter.Checked = false;
      TextBox_history.Text = k.EMPTY;
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
      //   (
      //   'RecalculateDependentValues()',
      //   k.EMPTY
      //   + 'El("' + TextBox_gain_or_loss_in_lbs.clientid + '").value ='
      //   +  ' El("' + TextBox_gross_landed_weight_in_pounds.clientid + '").value - El("' + TextBox_gross_invoiced_weight_in_lbs.clientid + '").value;'
      //   + k.NEW_LINE
      //   + 'El("' + TextBox_gain_or_loss_in_kgs.clientid + '").value ='
      //   +  ' El("' + TextBox_gross_landed_weight_in_kgs.clientid + '").value - El("' + TextBox_gross_invoiced_weight_in_kgs.clientid + '").value;'
      //   + k.NEW_LINE
      //   + 'El("' + TextBox_gain_or_loss_per_bale_in_lbs.clientid + '").value ='
      //   +  ' El("' + TextBox_gain_or_loss_in_lbs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
      //   + k.NEW_LINE
      //   + 'El("' + TextBox_gain_or_loss_per_bale_in_kgs.clientid + '").value ='
      //   +  ' El("' + TextBox_gain_or_loss_in_kgs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
      //   + k.NEW_LINE
      //   + 'El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value ='
      //   +  ' El("' + TextBox_gain_or_loss_in_lbs.clientid + '").value - El("' + TextBox_franchise_in_lbs.clientid + '").value;'
      //   + k.NEW_LINE
      //   + 'El("' + TextBox_actual_gain_or_loss_in_kgs.clientid + '").value ='
      //   +  ' El("' + TextBox_gain_or_loss_in_kgs.clientid + '").value - El("' + TextBox_franchise_in_kgs.clientid + '").value;'
      //   + k.NEW_LINE
      //   + 'El("' + TextBox_actual_gain_or_loss_per_bale_in_lbs.clientid + '").value ='
      //   +  ' El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
      //   + k.NEW_LINE
      //   + 'El("' + TextBox_actual_gain_or_loss_per_bale_in_kgs.clientid + '").value ='
      //   +  ' El("' + TextBox_actual_gain_or_loss_in_kgs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
      //   + k.NEW_LINE
      //   + 'El("' + TextBox_percent_gain_or_loss.clientid + '").value ='
      //   +  ' Math.round(El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value/El("' + TextBox_net_invoiced_in_lbs.clientid + '").value*100*100)/100;'
      //   + k.NEW_LINE
      //   + 'El("' + TextBox_monetary_gain_or_loss.clientid + '").value ='
      //   +  ' El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value*El("' + TextBox_unit_price_in_cents_per_pound.clientid + '").value;'
      //   );
      // //
      // TextBox_bales.attributes.Add('onkeyup','RecalculateDependentValues();');
      // TextBox_gross_landed_weight_in_pounds.attributes.Add
      //   (
      //   'onkeyup',
      //   'El("' + TextBox_gross_landed_weight_in_kgs.clientid + '").value = LbsToKgs(El("' + TextBox_gross_landed_weight_in_pounds.clientid + '").value);'
      //   + ' RecalculateDependentValues();'
      //   );
      // TextBox_gross_landed_weight_in_kgs.attributes.Add
      //   (
      //   'onkeyup',
      //   'El("' + TextBox_gross_landed_weight_in_pounds.clientid + '").value = KgsToLbs(El("' + TextBox_gross_landed_weight_in_kgs.clientid + '").value);'
      //   + ' RecalculateDependentValues();'
      //   );
      // TextBox_landed_or_ciq_tare.attributes.Add
      //   (
      //   'onkeyup',
      //   'El("' + TextBox_landed_or_ciq_tare_in_kgs.clientid + '").value = LbsToKgs(El("' + TextBox_landed_or_ciq_tare.clientid + '").value);'
      //   + ' RecalculateDependentValues();'
      //   );
      // TextBox_landed_or_ciq_tare_in_kgs.attributes.Add
      //   (
      //   'onkeyup',
      //   'El("' + TextBox_landed_or_ciq_tare.clientid + '").value = KgsToLbs(El("' + TextBox_landed_or_ciq_tare_in_kgs.clientid + '").value);'
      //   + ' RecalculateDependentValues();'
      //   );
      // TextBox_net_landed_in_pounds.attributes.Add
      //   (
      //   'onkeyup',
      //   'El("' + TextBox_net_landed_in_kgs.clientid + '").value = LbsToKgs(El("' + TextBox_net_landed_in_pounds.clientid + '").value);'
      //   + ' RecalculateDependentValues();'
      //   );
      // TextBox_net_landed_in_kgs.attributes.Add
      //   (
      //   'onkeyup',
      //   'El("' + TextBox_net_landed_in_pounds.clientid + '").value = KgsToLbs(El("' + TextBox_net_landed_in_kgs.clientid + '").value);'
      //   + ' RecalculateDependentValues();'
      //   );
      }

    protected void Page_Load(object sender, System.EventArgs e)
      {
      if (!p.be_loaded)
        {
        LinkButton_new_record.Visible = p.be_ok_to_config_teaching_entities;
        LinkButton_go_to_match_first.Text = k.ExpandTildePath(LinkButton_go_to_match_first.Text);
        LinkButton_go_to_match_prior.Text = k.ExpandTildePath(LinkButton_go_to_match_prior.Text);
        LinkButton_go_to_match_next.Text = k.ExpandTildePath(LinkButton_go_to_match_next.Text);
        LinkButton_go_to_match_last.Text = k.ExpandTildePath(LinkButton_go_to_match_last.Text);
        RequireConfirmation(Button_delete, "Are you sure you want to delete this record?");
        if ((Session["mode:goto"] != null) && Session["mode:goto"].ToString().Contains("/teaching_entity/"))
          {
          PresentRecord(Session["mode:goto"].ToString().Substring(Session["mode:goto"].ToString().LastIndexOf("/") + 1));
          Session.Remove("mode:goto");
          }
        p.be_loaded = true;
        }
      InjectPersistentClientSideScript();
      }

    private bool PresentRecord(string id)
      {
      Literal_match_index.Text = DropDownList_id.SelectedIndex.ToString();
      bool result;
      string emsrs_id;
      DateTime date_created;
      DateTime date_last_edited;
      string sponsor_number;
      string training_ins_accred_num;
      string name;
      string short_name;
      string address_1;
      string address_2;
      string city;
      string state;
      string zip;
      string county_code;
      string region;
      string email;
      string website;
      string daytime_phone;
      string evening_phone;
      string fax;
      string business_type_id;
      string con_ed_level_id;
      string certification_level;
      string contact_first_name;
      string contact_last_name;
      string contact_title;
      string contact_address_1;
      string contact_address_2;
      string contact_city;
      string contact_state;
      string contact_zip;
      string contact_daytime_phone;
      string contact_evening_phone;
      string contact_fax;
      string contact_email;
      string public_contact_name;
      string public_contact_phone;
      string public_contact_email;
      string public_contact_website;
      string public_contact_notes;
      DateTime application_date;
      DateTime application_received;
      string coned_sponsor_status_id;
      string training_inst_status_id;
      DateTime issue_date;
      DateTime prev_expiration_date;
      DateTime expiration_date_sponsor;
      DateTime expiration_date_training_inst;
      DateTime process_date;
      string corrective_action;
      DateTime compliance_by_date;
      DateTime initial_accred_date;
      DateTime accepted_provisional_date;
      DateTime completed_provisional_date;
      DateTime withdrawal_challenge_due_date;
      bool letter_for_expiration;
      bool letter_f_for_ppwk_non_compliance;
      bool other_letter;
      string history;
      result = false;
      if
        (
        p.biz_teaching_entities.Get
          (
          id,
          out emsrs_id,
          out date_created,
          out date_last_edited,
          out sponsor_number,
          out training_ins_accred_num,
          out name,
          out short_name,
          out address_1,
          out address_2,
          out city,
          out state,
          out zip,
          out county_code,
          out region,
          out email,
          out website,
          out daytime_phone,
          out evening_phone,
          out fax,
          out business_type_id,
          out con_ed_level_id,
          out certification_level,
          out contact_first_name,
          out contact_last_name,
          out contact_title,
          out contact_address_1,
          out contact_address_2,
          out contact_city,
          out contact_state,
          out contact_zip,
          out contact_daytime_phone,
          out contact_evening_phone,
          out contact_fax,
          out contact_email,
          out public_contact_name,
          out public_contact_phone,
          out public_contact_email,
          out public_contact_website,
          out public_contact_notes,
          out application_date,
          out application_received,
          out coned_sponsor_status_id,
          out training_inst_status_id,
          out issue_date,
          out prev_expiration_date,
          out expiration_date_sponsor,
          out expiration_date_training_inst,
          out process_date,
          out corrective_action,
          out compliance_by_date,
          out initial_accred_date,
          out accepted_provisional_date,
          out completed_provisional_date,
          out withdrawal_challenge_due_date,
          out letter_for_expiration,
          out letter_f_for_ppwk_non_compliance,
          out other_letter,
          out history
          )
        )
        {
        TextBox_id.Text = id;
        TextBox_id.Enabled = false;
        TextBox_emsrs_id.Text = emsrs_id;
        UserControl_drop_down_date_date_created.selectedvalue = date_created;
        UserControl_drop_down_date_date_last_edited.selectedvalue = date_last_edited;
        TextBox_sponsor_number.Text = sponsor_number;
        TextBox_training_ins_accred_num.Text = training_ins_accred_num;
        TextBox_name.Text = name;
        TextBox_short_name.Text = short_name;
        TextBox_address_1.Text = address_1;
        TextBox_address_2.Text = address_2;
        TextBox_city.Text = city;
        TextBox_state.Text = state;
        TextBox_zip.Text = zip;
        TextBox_county_code.Text = county_code;
        TextBox_region.Text = region;
        TextBox_email.Text = email;
        TextBox_website.Text = website;
        TextBox_daytime_phone.Text = daytime_phone;
        TextBox_evening_phone.Text = evening_phone;
        TextBox_fax.Text = fax;
        TextBox_business_type_id.Text = business_type_id;
        TextBox_con_ed_level_id.Text = con_ed_level_id;
        TextBox_certification_level.Text = certification_level;
        TextBox_contact_first_name.Text = contact_first_name;
        TextBox_contact_last_name.Text = contact_last_name;
        TextBox_contact_title.Text = contact_title;
        TextBox_contact_address_1.Text = contact_address_1;
        TextBox_contact_address_2.Text = contact_address_2;
        TextBox_contact_city.Text = contact_city;
        TextBox_contact_state.Text = contact_state;
        TextBox_contact_zip.Text = contact_zip;
        TextBox_contact_daytime_phone.Text = contact_daytime_phone;
        TextBox_contact_evening_phone.Text = contact_evening_phone;
        TextBox_contact_fax.Text = contact_fax;
        TextBox_contact_email.Text = contact_email;
        TextBox_public_contact_name.Text = public_contact_name;
        TextBox_public_contact_phone.Text = public_contact_phone;
        TextBox_public_contact_email.Text = public_contact_email;
        TextBox_public_contact_website.Text = public_contact_website;
        TextBox_public_contact_notes.Text = public_contact_notes;
        UserControl_drop_down_date_application_date.selectedvalue = application_date;
        UserControl_drop_down_date_application_received.selectedvalue = application_received;
        TextBox_coned_sponsor_status_id.Text = coned_sponsor_status_id;
        TextBox_training_inst_status_id.Text = training_inst_status_id;
        UserControl_drop_down_date_issue_date.selectedvalue = issue_date;
        UserControl_drop_down_date_prev_expiration_date.selectedvalue = prev_expiration_date;
        UserControl_drop_down_date_expiration_date_sponsor.selectedvalue = expiration_date_sponsor;
        UserControl_drop_down_date_expiration_date_training_inst.selectedvalue = expiration_date_training_inst;
        UserControl_drop_down_date_process_date.selectedvalue = process_date;
        TextBox_corrective_action.Text = corrective_action;
        UserControl_drop_down_date_compliance_by_date.selectedvalue = compliance_by_date;
        UserControl_drop_down_date_initial_accred_date.selectedvalue = initial_accred_date;
        UserControl_drop_down_date_accepted_provisional_date.selectedvalue = accepted_provisional_date;
        UserControl_drop_down_date_completed_provisional_date.selectedvalue = completed_provisional_date;
        UserControl_drop_down_date_withdrawal_challenge_due_date.selectedvalue = withdrawal_challenge_due_date;
        CheckBox_letter_for_expiration.Checked = letter_for_expiration;
        CheckBox_letter_f_for_ppwk_non_compliance.Checked = letter_f_for_ppwk_non_compliance;
        CheckBox_other_letter.Checked = other_letter;
        TextBox_history.Text = history;
        Button_lookup.Enabled = false;
        Label_lookup_arrow.Enabled = false;
        Label_lookup_hint.Enabled = false;
        LinkButton_reset.Enabled = true;
        SetDependentFieldAblements(p.be_ok_to_config_teaching_entities);
        Button_submit.Enabled = p.be_ok_to_config_teaching_entities;
        Button_delete.Enabled = p.be_ok_to_config_teaching_entities;
        result = true;
        }
      return result;
      }

    private void SetDataEntryMode()
      {
      Clear();
      TextBox_id.Text = "*";
      TextBox_id.Enabled = false;
      Button_lookup.Enabled = false;
      Label_lookup_arrow.Enabled = false;
      Label_lookup_hint.Enabled = false;
      LinkButton_reset.Enabled = true;
      LinkButton_new_record.Enabled = false;
      SetDependentFieldAblements(p.be_ok_to_config_teaching_entities);
      Button_submit.Enabled = p.be_ok_to_config_teaching_entities;
      Button_delete.Enabled = false;
      TextBox_id.Focus();
      }

    private void SetLookupMode()
      {
      Clear();
      TextBox_id.Enabled = true;
      Button_lookup.Enabled = true;
      Label_lookup_arrow.Enabled = true;
      Label_lookup_hint.Enabled = true;
      LinkButton_reset.Enabled = false;
      LinkButton_new_record.Enabled = true;
      TextBox_id.Focus();
      }

    protected override void OnInit(System.EventArgs e)
      {
      // Required for Designer support
      InitializeComponent();
      base.OnInit(e);
      if (Session[InstanceId() + ".p"] != null)
        {
        p = (p_type)(Session[InstanceId() + ".p"]);
        p.be_loaded = IsPostBack && ((Session["UserControl_regional_staffer_binder_UserControl_config_binder_PlaceHolder_content"] as string) == "UserControl_teaching_entity");
        }
      else
        {
        p.be_loaded = false;
        p.biz_teaching_entities = new TClass_biz_teaching_entities();
        p.be_ok_to_config_teaching_entities = k.Has((string[])(Session["privilege_array"]), "config-teaching_entities");
        }
      }

    // / <summary>
    // / Required method for Designer support -- do not modify
    // / the contents of this method with the code editor.
    // / </summary>
    private void InitializeComponent()
      {
      //this.Load += this.Page_Load;
      this.PreRender += this.TWebUserControl_teaching_entity_PreRender;
      }

    private void TWebUserControl_teaching_entity_PreRender(object sender, System.EventArgs e)
      {
      SessionSet(InstanceId() + ".p", p);
      }

    public TWebUserControl_teaching_entity Fresh()
      {
      Session.Remove(InstanceId() + ".p");
      UserControl_drop_down_date_date_created.Fresh();
      UserControl_drop_down_date_date_last_edited.Fresh();
      UserControl_drop_down_date_application_date.Fresh();
      UserControl_drop_down_date_application_received.Fresh();
      UserControl_drop_down_date_issue_date.Fresh();
      UserControl_drop_down_date_prev_expiration_date.Fresh();
      UserControl_drop_down_date_expiration_date_sponsor.Fresh();
      UserControl_drop_down_date_expiration_date_training_inst.Fresh();
      UserControl_drop_down_date_process_date.Fresh();
      UserControl_drop_down_date_compliance_by_date.Fresh();
      UserControl_drop_down_date_initial_accred_date.Fresh();
      UserControl_drop_down_date_accepted_provisional_date.Fresh();
      UserControl_drop_down_date_completed_provisional_date.Fresh();
      UserControl_drop_down_date_withdrawal_challenge_due_date.Fresh();
      return this;
      }

    protected void Button_submit_Click(object sender, System.EventArgs e)
      {
      if (Page.IsValid)
        {
        p.biz_teaching_entities.Set
          (
          k.Safe(TextBox_id.Text,k.safe_hint_type.NUM),
          k.Safe(TextBox_emsrs_id.Text,k.safe_hint_type.NUM).Trim(),
          UserControl_drop_down_date_date_created.selectedvalue,
          UserControl_drop_down_date_date_last_edited.selectedvalue,
          k.Safe(TextBox_sponsor_number.Text,k.safe_hint_type.HYPHENATED_NUM).Trim(),
          k.Safe(TextBox_training_ins_accred_num.Text,k.safe_hint_type.HYPHENATED_NUM).Trim(),
          k.Safe(TextBox_name.Text,k.safe_hint_type.ORG_NAME).Trim(),
          k.Safe(TextBox_short_name.Text,k.safe_hint_type.ORG_NAME).Trim(),
          k.Safe(TextBox_address_1.Text,k.safe_hint_type.POSTAL_STREET_ADDRESS).Trim(),
          k.Safe(TextBox_address_2.Text,k.safe_hint_type.POSTAL_STREET_ADDRESS).Trim(),
          k.Safe(TextBox_city.Text,k.safe_hint_type.POSTAL_CITY).Trim(),
          k.Safe(TextBox_state.Text,k.safe_hint_type.ALPHA).Trim(),
          k.Safe(TextBox_zip.Text,k.safe_hint_type.HYPHENATED_NUM).Trim(),
          k.Safe(TextBox_county_code.Text,k.safe_hint_type.NUM).Trim(),
          k.Safe(TextBox_region.Text,k.safe_hint_type.NUM).Trim(),
          k.Safe(TextBox_email.Text,k.safe_hint_type.EMAIL_ADDRESS).Trim(),
          k.Safe(TextBox_website.Text,k.safe_hint_type.HTTP_TARGET).Trim(),
          k.Safe(TextBox_daytime_phone.Text,k.safe_hint_type.PHONE_NUM).Trim(),
          k.Safe(TextBox_evening_phone.Text,k.safe_hint_type.PHONE_NUM).Trim(),
          k.Safe(TextBox_fax.Text,k.safe_hint_type.PHONE_NUM).Trim(),
          k.Safe(TextBox_business_type_id.Text,k.safe_hint_type.NUM).Trim(),
          k.Safe(TextBox_con_ed_level_id.Text,k.safe_hint_type.NUM).Trim(),
          k.Safe(TextBox_certification_level.Text,k.safe_hint_type.NUM).Trim(),
          k.Safe(TextBox_contact_first_name.Text,k.safe_hint_type.HUMAN_NAME).Trim(),
          k.Safe(TextBox_contact_last_name.Text,k.safe_hint_type.HUMAN_NAME).Trim(),
          k.Safe(TextBox_contact_title.Text,k.safe_hint_type.MAKE_MODEL).Trim(),
          k.Safe(TextBox_contact_address_1.Text,k.safe_hint_type.POSTAL_STREET_ADDRESS).Trim(),
          k.Safe(TextBox_contact_address_2.Text,k.safe_hint_type.POSTAL_STREET_ADDRESS).Trim(),
          k.Safe(TextBox_contact_city.Text,k.safe_hint_type.POSTAL_CITY).Trim(),
          k.Safe(TextBox_contact_state.Text,k.safe_hint_type.ALPHA).Trim(),
          k.Safe(TextBox_contact_zip.Text,k.safe_hint_type.HYPHENATED_NUM).Trim(),
          k.Safe(TextBox_contact_daytime_phone.Text,k.safe_hint_type.PHONE_NUM).Trim(),
          k.Safe(TextBox_contact_evening_phone.Text,k.safe_hint_type.PHONE_NUM).Trim(),
          k.Safe(TextBox_contact_fax.Text,k.safe_hint_type.PHONE_NUM).Trim(),
          k.Safe(TextBox_contact_email.Text,k.safe_hint_type.EMAIL_ADDRESS).Trim(),
          k.Safe(TextBox_public_contact_name.Text,k.safe_hint_type.HUMAN_NAME).Trim(),
          k.Safe(TextBox_public_contact_phone.Text,k.safe_hint_type.PHONE_NUM).Trim(),
          k.Safe(TextBox_public_contact_email.Text,k.safe_hint_type.EMAIL_ADDRESS).Trim(),
          k.Safe(TextBox_public_contact_website.Text,k.safe_hint_type.HTTP_TARGET).Trim(),
          k.Safe(TextBox_public_contact_notes.Text,k.safe_hint_type.PUNCTUATED).Trim(),
          UserControl_drop_down_date_application_date.selectedvalue,
          UserControl_drop_down_date_application_received.selectedvalue,
          k.Safe(TextBox_coned_sponsor_status_id.Text,k.safe_hint_type.NUM).Trim(),
          k.Safe(TextBox_training_inst_status_id.Text,k.safe_hint_type.NUM).Trim(),
          UserControl_drop_down_date_issue_date.selectedvalue,
          UserControl_drop_down_date_prev_expiration_date.selectedvalue,
          UserControl_drop_down_date_expiration_date_sponsor.selectedvalue,
          UserControl_drop_down_date_expiration_date_training_inst.selectedvalue,
          UserControl_drop_down_date_process_date.selectedvalue,
          k.Safe(TextBox_corrective_action.Text,k.safe_hint_type.PUNCTUATED).Trim(),
          UserControl_drop_down_date_compliance_by_date.selectedvalue,
          UserControl_drop_down_date_initial_accred_date.selectedvalue,
          UserControl_drop_down_date_accepted_provisional_date.selectedvalue,
          UserControl_drop_down_date_completed_provisional_date.selectedvalue,
          UserControl_drop_down_date_withdrawal_challenge_due_date.selectedvalue,
          CheckBox_letter_for_expiration.Checked,
          CheckBox_letter_f_for_ppwk_non_compliance.Checked,
          CheckBox_other_letter.Checked,
          k.Safe(TextBox_history.Text,k.safe_hint_type.MEMO).Trim()
          );
        Alert(k.alert_cause_type.USER, k.alert_state_type.SUCCESS, "recsaved", "Record saved.", true);
        SetLookupMode();
        }
      else
        {
        ValidationAlert(true);
        }
      }

    protected void DropDownList_id_SelectedIndexChanged(object sender, System.EventArgs e)
      {
      PresentRecord(k.Safe(DropDownList_id.SelectedValue, k.safe_hint_type.NUM));
      }

    protected void LinkButton_go_to_match_first_Click(object sender, System.EventArgs e)
      {
      DropDownList_id.SelectedIndex = 1;
      PresentRecord(k.Safe(DropDownList_id.SelectedValue, k.safe_hint_type.NUM));
      }

    protected void LinkButton_go_to_match_prior_Click(object sender, System.EventArgs e)
      {
      DropDownList_id.SelectedIndex = Math.Max(1, (DropDownList_id.SelectedIndex - 1));
      PresentRecord(k.Safe(DropDownList_id.SelectedValue, k.safe_hint_type.NUM));
      }

    protected void LinkButton_go_to_match_next_Click(object sender, System.EventArgs e)
      {
      DropDownList_id.SelectedIndex = Math.Min((DropDownList_id.SelectedIndex + 1), (DropDownList_id.Items.Count - 1));
      PresentRecord(k.Safe(DropDownList_id.SelectedValue, k.safe_hint_type.NUM));
      }

    protected void LinkButton_go_to_match_last_Click(object sender, System.EventArgs e)
      {
      DropDownList_id.SelectedIndex = DropDownList_id.Items.Count - 1;
      PresentRecord(k.Safe(DropDownList_id.SelectedValue, k.safe_hint_type.NUM));
      }

    protected void Button_delete_Click(object sender, System.EventArgs e)
      {
      if (p.biz_teaching_entities.Delete(k.Safe(TextBox_id.Text, k.safe_hint_type.NUM)))
        {
        SetLookupMode();
        }
      else
        {
        Alert(k.alert_cause_type.APPDATA,k.alert_state_type.FAILURE, "dependency", " Cannot delete this record because another record depends on it.", true);
        }
      }

    protected void LinkButton_new_record_Click(object sender, System.EventArgs e)
      {
      SetDataEntryMode();
      }

    protected void LinkButton_reset_Click(object sender, System.EventArgs e)
      {
      SetLookupMode();
      }

    private void SetDependentFieldAblements(bool ablement)
      {
      TextBox_emsrs_id.Enabled = ablement;
      UserControl_drop_down_date_date_created.enabled = ablement;
      UserControl_drop_down_date_date_last_edited.enabled = ablement;
      TextBox_sponsor_number.Enabled = ablement;
      TextBox_training_ins_accred_num.Enabled = ablement;
      TextBox_name.Enabled = ablement;
      TextBox_short_name.Enabled = ablement;
      TextBox_address_1.Enabled = ablement;
      TextBox_address_2.Enabled = ablement;
      TextBox_city.Enabled = ablement;
      TextBox_state.Enabled = ablement;
      TextBox_zip.Enabled = ablement;
      TextBox_county_code.Enabled = ablement;
      TextBox_region.Enabled = ablement;
      TextBox_email.Enabled = ablement;
      TextBox_website.Enabled = ablement;
      TextBox_daytime_phone.Enabled = ablement;
      TextBox_evening_phone.Enabled = ablement;
      TextBox_fax.Enabled = ablement;
      TextBox_business_type_id.Enabled = ablement;
      TextBox_con_ed_level_id.Enabled = ablement;
      TextBox_certification_level.Enabled = ablement;
      TextBox_contact_first_name.Enabled = ablement;
      TextBox_contact_last_name.Enabled = ablement;
      TextBox_contact_title.Enabled = ablement;
      TextBox_contact_address_1.Enabled = ablement;
      TextBox_contact_address_2.Enabled = ablement;
      TextBox_contact_city.Enabled = ablement;
      TextBox_contact_state.Enabled = ablement;
      TextBox_contact_zip.Enabled = ablement;
      TextBox_contact_daytime_phone.Enabled = ablement;
      TextBox_contact_evening_phone.Enabled = ablement;
      TextBox_contact_fax.Enabled = ablement;
      TextBox_contact_email.Enabled = ablement;
      TextBox_public_contact_name.Enabled = ablement;
      TextBox_public_contact_phone.Enabled = ablement;
      TextBox_public_contact_email.Enabled = ablement;
      TextBox_public_contact_website.Enabled = ablement;
      TextBox_public_contact_notes.Enabled = ablement;
      UserControl_drop_down_date_application_date.enabled = ablement;
      UserControl_drop_down_date_application_received.enabled = ablement;
      TextBox_coned_sponsor_status_id.Enabled = ablement;
      TextBox_training_inst_status_id.Enabled = ablement;
      UserControl_drop_down_date_issue_date.enabled = ablement;
      UserControl_drop_down_date_prev_expiration_date.enabled = ablement;
      UserControl_drop_down_date_expiration_date_sponsor.enabled = ablement;
      UserControl_drop_down_date_expiration_date_training_inst.enabled = ablement;
      UserControl_drop_down_date_process_date.enabled = ablement;
      TextBox_corrective_action.Enabled = ablement;
      UserControl_drop_down_date_compliance_by_date.enabled = ablement;
      UserControl_drop_down_date_initial_accred_date.enabled = ablement;
      UserControl_drop_down_date_accepted_provisional_date.enabled = ablement;
      UserControl_drop_down_date_completed_provisional_date.enabled = ablement;
      UserControl_drop_down_date_withdrawal_challenge_due_date.enabled = ablement;
      CheckBox_letter_for_expiration.Enabled = ablement;
      CheckBox_letter_f_for_ppwk_non_compliance.Enabled = ablement;
      CheckBox_other_letter.Enabled = ablement;
      TextBox_history.Enabled = ablement;
      }

    protected void Button_lookup_Click(object sender, System.EventArgs e)
      {
      uint num_matches;
      string saved_id;
      saved_id = k.Safe(TextBox_id.Text,k.safe_hint_type.PUNCTUATED);
      Clear();
      if (!PresentRecord(saved_id))
        {
        TextBox_id.Text = saved_id;
        p.biz_teaching_entities.Bind(saved_id, DropDownList_id);
        num_matches = (uint)(DropDownList_id.Items.Count);
        if (num_matches > 0)
          {
          DropDownList_id.Visible = true;
          if (num_matches == 1)
            {
            PresentRecord(k.Safe(DropDownList_id.SelectedValue, k.safe_hint_type.NUM));
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
            DropDownList_id.Items.Insert(0, new ListItem("-- Select --", k.EMPTY));
            }
          }
        }
      }

    private struct p_type
      {
      public bool be_loaded;
      public TClass_biz_teaching_entities biz_teaching_entities;
      public bool be_ok_to_config_teaching_entities;
      } // end p_type

    } // end TWebUserControl_teaching_entity

  }
