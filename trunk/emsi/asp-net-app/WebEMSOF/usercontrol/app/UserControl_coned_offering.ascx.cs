// Derived from KiAspdotnetFramework/UserControl/app/UserControl~template~kicrudhelped~item.ascx.cs~template

using Class_biz_coned_offering_class_final_statuses;
using Class_biz_coned_offering_document_statuses;
using Class_biz_coned_offering_statuses;
using Class_biz_coned_offerings;
using Class_biz_counties;
using Class_biz_regions;
using kix;
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Collections;
using UserControl_drop_down_date;

namespace UserControl_coned_offering
  {
  public partial class TWebUserControl_coned_offering: ki_web_ui.usercontrol_class
    {
    private struct p_type
      {
      public bool be_loaded;
      public TClass_biz_coned_offering_class_final_statuses biz_coned_offering_class_final_statuses;
      public TClass_biz_coned_offering_document_statuses biz_coned_offering_document_statuses;
      public TClass_biz_coned_offering_statuses biz_coned_offering_statuses;
      public TClass_biz_coned_offerings biz_coned_offerings;
      public TClass_biz_counties biz_counties;
      public TClass_biz_regions biz_regions;
      public bool be_ok_to_config_coned_offerings;
      }

    private p_type p;

    private void Clear()
      {
      TextBox_class_id.Text = k.EMPTY;
      DropDownList_class_id.Visible = false;
      TextBox_course_id.Text = k.EMPTY;
      TextBox_class_number.Text = k.EMPTY;
      TextBox_created_by.Text = k.EMPTY;
      UserControl_drop_down_date_date_created.Clear();
      TextBox_last_edited_by.Text = k.EMPTY;
      UserControl_drop_down_date_date_last_edited.Clear();
      TextBox_sponsor_id.Text = k.EMPTY;
      TextBox_sponsor_number.Text = k.EMPTY;
      DropDownList_document_status.ClearSelection();
      DropDownList_class_final_status.ClearSelection();
      TextBox_course_number.Text = k.EMPTY;
      TextBox_location.Text = k.EMPTY;
      TextBox_student_cost.Text = k.EMPTY;
      TextBox_tuition_includes.Text = k.EMPTY;
      CheckBox_closed.Checked = false;
      TextBox_estimated_students.Text = k.EMPTY;
      UserControl_drop_down_date_start_date_time.Clear();
      UserControl_drop_down_date_end_date_time.Clear();
      TextBox_start_time.Text = k.EMPTY;
      TextBox_end_time.Text = k.EMPTY;
      TextBox_other_dates_and_times.Text = k.EMPTY;
      TextBox_instructors.Text = k.EMPTY;
      TextBox_instructor_qualifications.Text = k.EMPTY;
      TextBox_public_contact_name.Text = k.EMPTY;
      TextBox_public_contact_phone.Text = k.EMPTY;
      TextBox_public_contact_email.Text = k.EMPTY;
      TextBox_public_contact_website.Text = k.EMPTY;
      TextBox_public_contact_notes.Text = k.EMPTY;
      UserControl_drop_down_date_date_submitted_to_region.Clear();
      UserControl_drop_down_date_date_received_by_region.Clear();
      UserControl_drop_down_date_date_sponsor_notified.Clear();
      UserControl_drop_down_date_date_registration_sent_to_state.Clear();
      UserControl_drop_down_date_date_cards_sent_to_sponsor.Clear();
      UserControl_drop_down_date_date_materials_to_be_returned.Clear();
      CheckBox_approved.Checked = false;
      TextBox_region_comments.Text = k.EMPTY;
      DropDownList_region_council.ClearSelection();
      DropDownList_class_county.ClearSelection();
      TextBox_total_class_hours.Text = k.EMPTY;
      TextBox_location_address_1.Text = k.EMPTY;
      TextBox_location_address_2.Text = k.EMPTY;
      TextBox_location_city.Text = k.EMPTY;
      TextBox_location_state.Text = k.EMPTY;
      TextBox_location_zip.Text = k.EMPTY;
      TextBox_location_zip_plus_4.Text = k.EMPTY;
      TextBox_location_phone.Text = k.EMPTY;
      TextBox_location_email.Text = k.EMPTY;
      TextBox_location_of_registration.Text = k.EMPTY;
      TextBox_primary_text.Text = k.EMPTY;
      TextBox_additional_texts.Text = k.EMPTY;
      UserControl_drop_down_date_final_registration_date.Clear();
      CheckBox_offered_as_college_credit.Checked = false;
      UserControl_drop_down_date_practical_exam_date.Clear();
      UserControl_drop_down_date_written_exam_date.Clear();
      TextBox_disapproval_reason_id.Text = k.EMPTY;
      UserControl_drop_down_date_date_final_paperwork_received.Clear();
      CheckBox_signed_hardcopy.Checked = false;
      TextBox_created_by_first_name.Text = k.EMPTY;
      TextBox_created_by_last_name.Text = k.EMPTY;
      TextBox_class_disapproval_reason_description.Text = k.EMPTY;
      TextBox_sponsor_name.Text = k.EMPTY;
      TextBox_courses_course_number.Text = k.EMPTY;
      TextBox_course_title.Text = k.EMPTY;
      DropDownList_status.ClearSelection();
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
        TableRow_class_id.Visible = HttpContext.Current.User.IsInRole("director") || HttpContext.Current.User.IsInRole("education-coordinator")|| HttpContext.Current.User.IsInRole("education-specialist");
        p.biz_coned_offering_document_statuses.BindDirectToListControl(DropDownList_document_status);
        p.biz_coned_offering_class_final_statuses.BindDirectToListControl(DropDownList_class_final_status,"- - -");
        p.biz_regions.BindEmsrsToListControl(DropDownList_region_council);
        p.biz_counties.BindEmsrsToListControl(DropDownList_class_county);
        p.biz_coned_offering_statuses.BindDirectToListControl(DropDownList_status);
        LinkButton_new_record.Visible = p.be_ok_to_config_coned_offerings;
        LinkButton_go_to_match_first.Text = k.ExpandTildePath(LinkButton_go_to_match_first.Text);
        LinkButton_go_to_match_prior.Text = k.ExpandTildePath(LinkButton_go_to_match_prior.Text);
        LinkButton_go_to_match_next.Text = k.ExpandTildePath(LinkButton_go_to_match_next.Text);
        LinkButton_go_to_match_last.Text = k.ExpandTildePath(LinkButton_go_to_match_last.Text);
        RequireConfirmation(Button_delete, "Are you sure you want to delete this record?");
        if ((Session["mode:goto"] != null) && Session["mode:goto"].ToString().Contains("/coned_offering/"))
          {
          PresentRecord(Session["mode:goto"].ToString().Substring(Session["mode:goto"].ToString().LastIndexOf("/") + 1));
          Session.Remove("mode:goto");
          }
        p.be_loaded = true;
        }
      InjectPersistentClientSideScript();
      }

    private bool PresentRecord(string class_id)
      {
      Literal_match_index.Text = DropDownList_class_id.SelectedIndex.ToString();
      bool result;
      string course_id;
      string class_number;
      string created_by;
      DateTime date_created;
      string last_edited_by;
      DateTime date_last_edited;
      string sponsor_id;
      string sponsor_number;
      string document_status;
      string class_final_status_id;
      string course_number;
      string location;
      string student_cost;
      string tuition_includes;
      bool closed;
      string estimated_students;
      DateTime start_date_time;
      DateTime end_date_time;
      string start_time;
      string end_time;
      string other_dates_and_times;
      string instructors;
      string instructor_qualifications;
      string public_contact_name;
      string public_contact_phone;
      string public_contact_email;
      string public_contact_website;
      string public_contact_notes;
      DateTime date_submitted_to_region;
      DateTime date_received_by_region;
      DateTime date_sponsor_notified;
      DateTime date_registration_sent_to_state;
      DateTime date_cards_sent_to_sponsor;
      DateTime date_materials_to_be_returned;
      bool approved;
      string region_comments;
      string region_council_num;
      string class_county_code;
      string total_class_hours;
      string location_address_1;
      string location_address_2;
      string location_city;
      string location_state;
      string location_zip;
      string location_zip_plus_4;
      string location_phone;
      string location_email;
      string location_of_registration;
      string primary_text;
      string additional_texts;
      DateTime final_registration_date;
      bool offered_as_college_credit;
      DateTime practical_exam_date;
      DateTime written_exam_date;
      string disapproval_reason_id;
      DateTime date_final_paperwork_received;
      bool signed_hardcopy;
      string created_by_first_name;
      string created_by_last_name;
      string class_disapproval_reason_description;
      string sponsor_name;
      string courses_course_number;
      string course_title;
      string status_id;
      result = false;
      if
        (
        p.biz_coned_offerings.Get
          (
          class_id,
          out course_id,
          out class_number,
          out created_by,
          out date_created,
          out last_edited_by,
          out date_last_edited,
          out sponsor_id,
          out sponsor_number,
          out document_status,
          out class_final_status_id,
          out course_number,
          out location,
          out student_cost,
          out tuition_includes,
          out closed,
          out estimated_students,
          out start_date_time,
          out end_date_time,
          out start_time,
          out end_time,
          out other_dates_and_times,
          out instructors,
          out instructor_qualifications,
          out public_contact_name,
          out public_contact_phone,
          out public_contact_email,
          out public_contact_website,
          out public_contact_notes,
          out date_submitted_to_region,
          out date_received_by_region,
          out date_sponsor_notified,
          out date_registration_sent_to_state,
          out date_cards_sent_to_sponsor,
          out date_materials_to_be_returned,
          out approved,
          out region_comments,
          out region_council_num,
          out class_county_code,
          out total_class_hours,
          out location_address_1,
          out location_address_2,
          out location_city,
          out location_state,
          out location_zip,
          out location_zip_plus_4,
          out location_phone,
          out location_email,
          out location_of_registration,
          out primary_text,
          out additional_texts,
          out final_registration_date,
          out offered_as_college_credit,
          out practical_exam_date,
          out written_exam_date,
          out disapproval_reason_id,
          out date_final_paperwork_received,
          out signed_hardcopy,
          out created_by_first_name,
          out created_by_last_name,
          out class_disapproval_reason_description,
          out sponsor_name,
          out courses_course_number,
          out course_title,
          out status_id
          )
        )
        {
        TextBox_class_id.Text = class_id;
        TextBox_class_id.Enabled = false;
        TextBox_course_id.Text = course_id;
        TextBox_class_number.Text = class_number;
        TextBox_created_by.Text = created_by;
        UserControl_drop_down_date_date_created.selectedvalue = date_created;
        TextBox_last_edited_by.Text = last_edited_by;
        UserControl_drop_down_date_date_last_edited.selectedvalue = date_last_edited;
        TextBox_sponsor_id.Text = sponsor_id;
        TextBox_sponsor_number.Text = sponsor_number;
        DropDownList_document_status.SelectedValue = document_status;
        DropDownList_class_final_status.SelectedValue = class_final_status_id;
        TextBox_course_number.Text = course_number;
        TextBox_location.Text = location;
        TextBox_student_cost.Text = student_cost;
        TextBox_tuition_includes.Text = tuition_includes;
        CheckBox_closed.Checked = closed;
        TextBox_estimated_students.Text = estimated_students;
        UserControl_drop_down_date_start_date_time.selectedvalue = start_date_time;
        UserControl_drop_down_date_end_date_time.selectedvalue = end_date_time;
        TextBox_start_time.Text = start_time;
        TextBox_end_time.Text = end_time;
        TextBox_other_dates_and_times.Text = other_dates_and_times;
        TextBox_instructors.Text = instructors;
        TextBox_instructor_qualifications.Text = instructor_qualifications;
        TextBox_public_contact_name.Text = public_contact_name;
        TextBox_public_contact_phone.Text = public_contact_phone;
        TextBox_public_contact_email.Text = public_contact_email;
        TextBox_public_contact_website.Text = public_contact_website;
        TextBox_public_contact_notes.Text = public_contact_notes;
        UserControl_drop_down_date_date_submitted_to_region.selectedvalue = date_submitted_to_region;
        UserControl_drop_down_date_date_received_by_region.selectedvalue = date_received_by_region;
        UserControl_drop_down_date_date_sponsor_notified.selectedvalue = date_sponsor_notified;
        UserControl_drop_down_date_date_registration_sent_to_state.selectedvalue = date_registration_sent_to_state;
        UserControl_drop_down_date_date_cards_sent_to_sponsor.selectedvalue = date_cards_sent_to_sponsor;
        UserControl_drop_down_date_date_materials_to_be_returned.selectedvalue = date_materials_to_be_returned;
        CheckBox_approved.Checked = approved;
        TextBox_region_comments.Text = region_comments;
        DropDownList_region_council.SelectedValue = region_council_num;
        DropDownList_class_county.SelectedValue = class_county_code;
        TextBox_total_class_hours.Text = total_class_hours;
        TextBox_location_address_1.Text = location_address_1;
        TextBox_location_address_2.Text = location_address_2;
        TextBox_location_city.Text = location_city;
        TextBox_location_state.Text = location_state;
        TextBox_location_zip.Text = location_zip;
        TextBox_location_zip_plus_4.Text = location_zip_plus_4;
        TextBox_location_phone.Text = location_phone;
        TextBox_location_email.Text = location_email;
        TextBox_location_of_registration.Text = location_of_registration;
        TextBox_primary_text.Text = primary_text;
        TextBox_additional_texts.Text = additional_texts;
        UserControl_drop_down_date_final_registration_date.selectedvalue = final_registration_date;
        CheckBox_offered_as_college_credit.Checked = offered_as_college_credit;
        UserControl_drop_down_date_practical_exam_date.selectedvalue = practical_exam_date;
        UserControl_drop_down_date_written_exam_date.selectedvalue = written_exam_date;
        TextBox_disapproval_reason_id.Text = disapproval_reason_id;
        UserControl_drop_down_date_date_final_paperwork_received.selectedvalue = date_final_paperwork_received;
        CheckBox_signed_hardcopy.Checked = signed_hardcopy;
        TextBox_created_by_first_name.Text = created_by_first_name;
        TextBox_created_by_last_name.Text = created_by_last_name;
        TextBox_class_disapproval_reason_description.Text = class_disapproval_reason_description;
        TextBox_sponsor_name.Text = sponsor_name;
        TextBox_courses_course_number.Text = courses_course_number;
        TextBox_course_title.Text = course_title;
        DropDownList_status.SelectedValue = status_id;
        Button_lookup.Enabled = false;
        Label_lookup_arrow.Enabled = false;
        Label_lookup_hint.Enabled = false;
        LinkButton_reset.Enabled = true;
        SetDependentFieldAblements(p.be_ok_to_config_coned_offerings);
        Button_submit.Enabled = p.be_ok_to_config_coned_offerings;
        Button_delete.Enabled = p.be_ok_to_config_coned_offerings;
        result = true;
        }
      return result;
      }

    private void SetDataEntryMode()
      {
      Clear();
      TextBox_class_id.Enabled = false;
      Button_lookup.Enabled = false;
      Label_lookup_arrow.Enabled = false;
      Label_lookup_hint.Enabled = false;
      LinkButton_reset.Enabled = true;
      LinkButton_new_record.Enabled = false;
      SetDependentFieldAblements(p.be_ok_to_config_coned_offerings);
      Button_submit.Enabled = p.be_ok_to_config_coned_offerings;
      Button_delete.Enabled = false;
      Focus(TextBox_class_id, true);
      }

    private void SetLookupMode()
      {
      Clear();
      TextBox_class_id.Enabled = true;
      Button_lookup.Enabled = true;
      Label_lookup_arrow.Enabled = true;
      Label_lookup_hint.Enabled = true;
      LinkButton_reset.Enabled = false;
      LinkButton_new_record.Enabled = true;
      Focus(TextBox_class_id, true);
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
        p.biz_coned_offering_class_final_statuses = new TClass_biz_coned_offering_class_final_statuses();
        p.biz_coned_offering_document_statuses = new TClass_biz_coned_offering_document_statuses();
        p.biz_coned_offering_statuses = new TClass_biz_coned_offering_statuses();
        p.biz_coned_offerings = new TClass_biz_coned_offerings();
        p.biz_counties = new TClass_biz_counties();
        p.biz_regions = new TClass_biz_regions();
        //
        p.be_loaded = false;
        p.be_ok_to_config_coned_offerings = k.Has((string[])(Session["privilege_array"]), "config-coned_offerings");
        }
      }

    // / <summary>
    // / Required method for Designer support -- do not modify
    // / the contents of this method with the code editor.
    // / </summary>
    private void InitializeComponent()
      {
      //this.Load += this.Page_Load;
      this.PreRender += this.TWebUserControl_coned_offering_PreRender;
      }

    private void TWebUserControl_coned_offering_PreRender(object sender, System.EventArgs e)
      {
      SessionSet(InstanceId() + ".p", p);
      }

    public TWebUserControl_coned_offering Fresh()
      {
      Session.Remove(InstanceId() + ".p");
      UserControl_drop_down_date_date_created.Fresh();
      UserControl_drop_down_date_date_last_edited.Fresh();
      UserControl_drop_down_date_start_date_time.Fresh();
      UserControl_drop_down_date_end_date_time.Fresh();
      UserControl_drop_down_date_date_submitted_to_region.Fresh();
      UserControl_drop_down_date_date_received_by_region.Fresh();
      UserControl_drop_down_date_date_sponsor_notified.Fresh();
      UserControl_drop_down_date_date_registration_sent_to_state.Fresh();
      UserControl_drop_down_date_date_cards_sent_to_sponsor.Fresh();
      UserControl_drop_down_date_date_materials_to_be_returned.Fresh();
      UserControl_drop_down_date_final_registration_date.Fresh();
      UserControl_drop_down_date_practical_exam_date.Fresh();
      UserControl_drop_down_date_written_exam_date.Fresh();
      UserControl_drop_down_date_date_final_paperwork_received.Fresh();
      return this;
      }

    protected void Button_submit_Click(object sender, System.EventArgs e)
      {
      if (Page.IsValid)
        {
        p.biz_coned_offerings.Set
          (
          k.Safe(TextBox_class_id.Text,k.safe_hint_type.NUM).Trim(),
          k.Safe(TextBox_course_id.Text,k.safe_hint_type.NUM).Trim(),
          k.Safe(TextBox_class_number.Text,k.safe_hint_type.NUM).Trim(),
          k.Safe(TextBox_created_by.Text,k.safe_hint_type.NUM).Trim(),
          UserControl_drop_down_date_date_created.selectedvalue,
          k.Safe(TextBox_last_edited_by.Text,k.safe_hint_type.NUM).Trim(),
          UserControl_drop_down_date_date_last_edited.selectedvalue,
          k.Safe(TextBox_sponsor_id.Text,k.safe_hint_type.NUM).Trim(),
          k.Safe(TextBox_sponsor_number.Text,k.safe_hint_type.HYPHENATED_NUM).Trim(),
          k.Safe(DropDownList_document_status.SelectedValue,k.safe_hint_type.ALPHA).Trim(),
          k.Safe(DropDownList_class_final_status.SelectedValue,k.safe_hint_type.NUM).Trim(),
          k.Safe(TextBox_course_number.Text,k.safe_hint_type.NUM).Trim(),
          k.Safe(TextBox_location.Text,k.safe_hint_type.POSTAL_STREET_ADDRESS).Trim(),
          k.Safe(TextBox_student_cost.Text,k.safe_hint_type.CURRENCY_USA).Trim(),
          k.Safe(TextBox_tuition_includes.Text,k.safe_hint_type.PUNCTUATED).Trim(),
          CheckBox_closed.Checked,
          k.Safe(TextBox_estimated_students.Text,k.safe_hint_type.NUM).Trim(),
          UserControl_drop_down_date_start_date_time.selectedvalue,
          UserControl_drop_down_date_end_date_time.selectedvalue,
          k.Safe(TextBox_start_time.Text,k.safe_hint_type.PUNCTUATED).Trim(),
          k.Safe(TextBox_end_time.Text,k.safe_hint_type.PUNCTUATED).Trim(),
          k.Safe(TextBox_other_dates_and_times.Text,k.safe_hint_type.PUNCTUATED).Trim(),
          k.Safe(TextBox_instructors.Text,k.safe_hint_type.PUNCTUATED).Trim(),
          k.Safe(TextBox_instructor_qualifications.Text,k.safe_hint_type.PUNCTUATED).Trim(),
          k.Safe(TextBox_public_contact_name.Text,k.safe_hint_type.HUMAN_NAME).Trim(),
          k.Safe(TextBox_public_contact_phone.Text,k.safe_hint_type.PHONE_NUM).Trim(),
          k.Safe(TextBox_public_contact_email.Text,k.safe_hint_type.EMAIL_ADDRESS).Trim(),
          k.Safe(TextBox_public_contact_website.Text,k.safe_hint_type.HTTP_TARGET).Trim(),
          k.Safe(TextBox_public_contact_notes.Text,k.safe_hint_type.PUNCTUATED).Trim(),
          UserControl_drop_down_date_date_submitted_to_region.selectedvalue,
          UserControl_drop_down_date_date_received_by_region.selectedvalue,
          UserControl_drop_down_date_date_sponsor_notified.selectedvalue,
          UserControl_drop_down_date_date_registration_sent_to_state.selectedvalue,
          UserControl_drop_down_date_date_cards_sent_to_sponsor.selectedvalue,
          UserControl_drop_down_date_date_materials_to_be_returned.selectedvalue,
          CheckBox_approved.Checked,
          k.Safe(TextBox_region_comments.Text,k.safe_hint_type.PUNCTUATED).Trim(),
          k.Safe(DropDownList_region_council.SelectedValue,k.safe_hint_type.NUM).Trim(),
          k.Safe(DropDownList_class_county.SelectedValue,k.safe_hint_type.NUM).Trim(),
          k.Safe(TextBox_total_class_hours.Text,k.safe_hint_type.REAL_NUM).Trim(),
          k.Safe(TextBox_location_address_1.Text,k.safe_hint_type.POSTAL_STREET_ADDRESS).Trim(),
          k.Safe(TextBox_location_address_2.Text,k.safe_hint_type.POSTAL_STREET_ADDRESS).Trim(),
          k.Safe(TextBox_location_city.Text,k.safe_hint_type.POSTAL_CITY).Trim(),
          k.Safe(TextBox_location_state.Text,k.safe_hint_type.ALPHA).Trim(),
          k.Safe(TextBox_location_zip.Text,k.safe_hint_type.NUM).Trim(),
          k.Safe(TextBox_location_zip_plus_4.Text,k.safe_hint_type.NUM).Trim(),
          k.Safe(TextBox_location_phone.Text,k.safe_hint_type.PHONE_NUM).Trim(),
          k.Safe(TextBox_location_email.Text,k.safe_hint_type.EMAIL_ADDRESS).Trim(),
          k.Safe(TextBox_location_of_registration.Text,k.safe_hint_type.PUNCTUATED).Trim(),
          k.Safe(TextBox_primary_text.Text,k.safe_hint_type.PUNCTUATED).Trim(),
          k.Safe(TextBox_additional_texts.Text,k.safe_hint_type.NUM).Trim(),
          UserControl_drop_down_date_final_registration_date.selectedvalue,
          CheckBox_offered_as_college_credit.Checked,
          UserControl_drop_down_date_practical_exam_date.selectedvalue,
          UserControl_drop_down_date_written_exam_date.selectedvalue,
          k.Safe(TextBox_disapproval_reason_id.Text,k.safe_hint_type.NUM).Trim(),
          UserControl_drop_down_date_date_final_paperwork_received.selectedvalue,
          CheckBox_signed_hardcopy.Checked,
          k.Safe(TextBox_created_by_first_name.Text,k.safe_hint_type.HUMAN_NAME).Trim(),
          k.Safe(TextBox_created_by_last_name.Text,k.safe_hint_type.HUMAN_NAME).Trim(),
          k.Safe(TextBox_class_disapproval_reason_description.Text,k.safe_hint_type.PUNCTUATED).Trim(),
          k.Safe(TextBox_sponsor_name.Text,k.safe_hint_type.ORG_NAME).Trim(),
          k.Safe(TextBox_courses_course_number.Text,k.safe_hint_type.NUM).Trim(),
          k.Safe(TextBox_course_title.Text,k.safe_hint_type.PUNCTUATED).Trim(),
          k.Safe(DropDownList_status.SelectedValue,k.safe_hint_type.NUM)
          );
        Alert(k.alert_cause_type.USER, k.alert_state_type.SUCCESS, "recsaved", "Record saved.", true);
        SetLookupMode();
        }
      else
        {
        ValidationAlert(true);
        }
      }

    protected void DropDownList_class_id_SelectedIndexChanged(object sender, System.EventArgs e)
      {
      PresentRecord(k.Safe(DropDownList_class_id.SelectedValue, k.safe_hint_type.NUM));
      }

    protected void LinkButton_go_to_match_first_Click(object sender, System.EventArgs e)
      {
      DropDownList_class_id.SelectedIndex = 1;
      PresentRecord(k.Safe(DropDownList_class_id.SelectedValue, k.safe_hint_type.NUM));
      }

    protected void LinkButton_go_to_match_prior_Click(object sender, System.EventArgs e)
      {
      DropDownList_class_id.SelectedIndex = Math.Max(1, (DropDownList_class_id.SelectedIndex - 1));
      PresentRecord(k.Safe(DropDownList_class_id.SelectedValue, k.safe_hint_type.NUM));
      }

    protected void LinkButton_go_to_match_next_Click(object sender, System.EventArgs e)
      {
      DropDownList_class_id.SelectedIndex = Math.Min((DropDownList_class_id.SelectedIndex + 1), (DropDownList_class_id.Items.Count - 1));
      PresentRecord(k.Safe(DropDownList_class_id.SelectedValue, k.safe_hint_type.NUM));
      }

    protected void LinkButton_go_to_match_last_Click(object sender, System.EventArgs e)
      {
      DropDownList_class_id.SelectedIndex = DropDownList_class_id.Items.Count - 1;
      PresentRecord(k.Safe(DropDownList_class_id.SelectedValue, k.safe_hint_type.NUM));
      }

    protected void Button_delete_Click(object sender, System.EventArgs e)
      {
      if (p.biz_coned_offerings.Delete(k.Safe(TextBox_class_id.Text, k.safe_hint_type.ALPHANUM)))
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
      TextBox_course_id.Enabled = ablement;
      TextBox_class_number.Enabled = ablement;
      TextBox_created_by.Enabled = ablement;
      UserControl_drop_down_date_date_created.enabled = ablement;
      TextBox_last_edited_by.Enabled = ablement;
      UserControl_drop_down_date_date_last_edited.enabled = ablement;
      TextBox_sponsor_id.Enabled = ablement;
      TextBox_sponsor_number.Enabled = ablement;
      DropDownList_document_status.Enabled = ablement;
      DropDownList_class_final_status.Enabled = ablement;
      TextBox_course_number.Enabled = ablement;
      TextBox_location.Enabled = ablement;
      TextBox_student_cost.Enabled = ablement;
      TextBox_tuition_includes.Enabled = ablement;
      CheckBox_closed.Enabled = ablement;
      TextBox_estimated_students.Enabled = ablement;
      UserControl_drop_down_date_start_date_time.enabled = ablement;
      UserControl_drop_down_date_end_date_time.enabled = ablement;
      TextBox_start_time.Enabled = ablement;
      TextBox_end_time.Enabled = ablement;
      TextBox_other_dates_and_times.Enabled = ablement;
      TextBox_instructors.Enabled = ablement;
      TextBox_instructor_qualifications.Enabled = ablement;
      TextBox_public_contact_name.Enabled = ablement;
      TextBox_public_contact_phone.Enabled = ablement;
      TextBox_public_contact_email.Enabled = ablement;
      TextBox_public_contact_website.Enabled = ablement;
      TextBox_public_contact_notes.Enabled = ablement;
      UserControl_drop_down_date_date_submitted_to_region.enabled = ablement;
      UserControl_drop_down_date_date_received_by_region.enabled = ablement;
      UserControl_drop_down_date_date_sponsor_notified.enabled = ablement;
      UserControl_drop_down_date_date_registration_sent_to_state.enabled = ablement;
      UserControl_drop_down_date_date_cards_sent_to_sponsor.enabled = ablement;
      UserControl_drop_down_date_date_materials_to_be_returned.enabled = ablement;
      CheckBox_approved.Enabled = ablement;
      TextBox_region_comments.Enabled = ablement;
      DropDownList_region_council.Enabled = ablement;
      DropDownList_class_county.Enabled = ablement;
      TextBox_total_class_hours.Enabled = ablement;
      TextBox_location_address_1.Enabled = ablement;
      TextBox_location_address_2.Enabled = ablement;
      TextBox_location_city.Enabled = ablement;
      TextBox_location_state.Enabled = ablement;
      TextBox_location_zip.Enabled = ablement;
      TextBox_location_zip_plus_4.Enabled = ablement;
      TextBox_location_phone.Enabled = ablement;
      TextBox_location_email.Enabled = ablement;
      TextBox_location_of_registration.Enabled = ablement;
      TextBox_primary_text.Enabled = ablement;
      TextBox_additional_texts.Enabled = ablement;
      UserControl_drop_down_date_final_registration_date.enabled = ablement;
      CheckBox_offered_as_college_credit.Enabled = ablement;
      UserControl_drop_down_date_practical_exam_date.enabled = ablement;
      UserControl_drop_down_date_written_exam_date.enabled = ablement;
      TextBox_disapproval_reason_id.Enabled = ablement;
      UserControl_drop_down_date_date_final_paperwork_received.enabled = ablement;
      CheckBox_signed_hardcopy.Enabled = ablement;
      TextBox_created_by_first_name.Enabled = ablement;
      TextBox_created_by_last_name.Enabled = ablement;
      TextBox_class_disapproval_reason_description.Enabled = ablement;
      TextBox_sponsor_name.Enabled = ablement;
      TextBox_courses_course_number.Enabled = ablement;
      TextBox_course_title.Enabled = ablement;
      DropDownList_status.Enabled = ablement;
      }

    protected void Button_lookup_Click(object sender, System.EventArgs e)
      {
      uint num_matches;
      string saved_class_id;
      saved_class_id = k.Safe(TextBox_class_id.Text,k.safe_hint_type.PUNCTUATED);
      Clear();
      if (!PresentRecord(saved_class_id))
        {
        TextBox_class_id.Text = saved_class_id;
        p.biz_coned_offerings.Bind(saved_class_id, DropDownList_class_id);
        num_matches = (uint)(DropDownList_class_id.Items.Count);
        if (num_matches > 0)
          {
          DropDownList_class_id.Visible = true;
          if (num_matches == 1)
            {
            PresentRecord(k.Safe(DropDownList_class_id.SelectedValue, k.safe_hint_type.NUM));
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
            DropDownList_class_id.Items.Insert(0, new ListItem("-- Select --", k.EMPTY));
            }
          }
        }
      }

    internal void SetFilter(object summary)
      {
      SessionSet("mode:goto","/coned_offering/" + p.biz_coned_offerings.ClassIdOf(summary));
      }

    } // end TWebUserControl_coned_offering

  }
