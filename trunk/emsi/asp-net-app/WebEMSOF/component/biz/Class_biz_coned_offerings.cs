// Derived from KiAspdotnetFramework/component/biz/Class~biz~~template~kicrudhelped~item.cs~template

using Class_biz_notifications;
using Class_db_coned_offerings;
using Class_db_coned_offering_statuses;
using Class_db_practitioners;
using kix;
using System;
using System.Collections;
using WebEMSOF.component.ss;

namespace Class_biz_coned_offerings
  {
  public class TClass_biz_coned_offerings
    {
    private TClass_biz_notifications biz_notifications = null;
    private TClass_db_coned_offerings db_coned_offerings = null;
    private TClass_db_practitioners db_practitioners = null;
    private Class_ss_emsams ss_emsams = null;

    public TClass_biz_coned_offerings() : base()
      {
      biz_notifications = new TClass_biz_notifications();
      db_coned_offerings = new TClass_db_coned_offerings();
      db_practitioners = new TClass_db_practitioners();
      ss_emsams = new Class_ss_emsams();
      }

    internal void Archive(object summary)
      {
      if (db_coned_offerings.StatusOf(summary) == coned_offering_status_enumeration.NEEDS_REGIONAL_PROCESSING)
        {
        var class_id = db_coned_offerings.ClassIdOf(summary);
        db_practitioners.MarkDobsConfirmed(class_id);
        db_coned_offerings.SetStatus(class_id,coned_offering_status_enumeration.ARCHIVED);
        }
      }

    internal bool BeApprovedOf(object summary)
      {
      return (db_coned_offerings.ApprovedOf(summary) == "1");
      }

    internal bool BeOkToCloseClassAndSubmitForCredit
      (
      object summary,
      k.int_nonnegative num_attendees,
      k.int_nonnegative num_attendees_with_known_birth_dates
      )
      {
      return BeApprovedOf(summary)
      && (DateTime.Now > DateTime.Parse(db_coned_offerings.StartOf(summary).Replace(" --:--",k.EMPTY)).AddHours(double.Parse(db_coned_offerings.TotalClassHoursOf(summary))))
      && (num_attendees.val > 0)
      && (num_attendees_with_known_birth_dates.val == num_attendees.val);
      }

    internal bool BeOkToEditRoster(object summary)
      {
      return (db_coned_offerings.StatusOf(summary) == coned_offering_status_enumeration.NEEDS_CONED_SPONSOR_FINALIZATION);
      }

    public bool Bind(string partial_spec, object target)
      {
      return db_coned_offerings.Bind(partial_spec, target);
      }

    internal void BindClassCatalog
      (
      string region_code,
      string coned_sponsor_user_id,
      string sort_order,
      bool be_sort_order_ascending,
      object target
      )
      {
      db_coned_offerings.BindClassCatalog(region_code,coned_sponsor_user_id,sort_order,be_sort_order_ascending,target);
      }

    internal void BindReadyRosters
      (
      string region_code,
      string sort_order,
      bool be_sort_order_ascending,
      object target
      )
      {
      db_coned_offerings.BindReadyRosters(region_code,sort_order,be_sort_order_ascending,target);
      }

    public void BindDirectToListControl(object target)
      {
      db_coned_offerings.BindDirectToListControl(target);
      }

    internal string ClassIdOf(object summary)
      {
      return db_coned_offerings.ClassIdOf(summary);
      }

    internal string ClassNumberOf(object summary)
      {
      return db_coned_offerings.ClassNumberOf(summary);
      }

    internal void CloseAndSubmit
      (
      object summary,
      k.int_nonnegative num_attendees
      )
      {
      if (db_coned_offerings.StatusOf(summary) == coned_offering_status_enumeration.NEEDS_CONED_SPONSOR_FINALIZATION)
        {
        db_coned_offerings.SetStatus(db_coned_offerings.ClassIdOf(summary),coned_offering_status_enumeration.NEEDS_REGIONAL_PROCESSING);
        biz_notifications.IssueForClassClosed
          (
          sponsor_id:db_coned_offerings.SponsorIdOf(summary),
          sponsor_number:db_coned_offerings.SponsorNumberOf(summary),
          sponsor_name:db_coned_offerings.SponsorNameOf(summary),
          sponsor_email:db_coned_offerings.SponsorEmailOf(summary),
          sponsor_contact_email:db_coned_offerings.SponsorContactEmailOf(summary),
          sponsor_public_contact_email:db_coned_offerings.SponsorPublicContactEmailOf(summary),
          coned_offering_public_contact_email:db_coned_offerings.PublicContactEmailOf(summary),
          class_number:db_coned_offerings.ClassNumberOf(summary),
          course_title:db_coned_offerings.CourseTitleOf(summary),
          start:db_coned_offerings.StartOf(summary),
          end:db_coned_offerings.EndOf(summary),
          total_class_hours:db_coned_offerings.TotalClassHoursOf(summary),
          location:db_coned_offerings.LocationOf(summary),
          num_attendees:num_attendees,
          status_description:coned_offering_status_enumeration.NEEDS_REGIONAL_PROCESSING.ToString()
          );
        }
      }

    internal string CourseTitleOf(object summary)
      {
      return db_coned_offerings.CourseTitleOf(summary);
      }

    public bool Delete(string id)
      {
      return db_coned_offerings.Delete(id);
      }

    internal string EndOf(object summary)
      {
      return db_coned_offerings.EndOf(summary);
      }

    public bool Get
      (
      string class_id,
      out string course_id,
      out string class_number,
      out string created_by,
      out DateTime date_created,
      out string last_edited_by,
      out DateTime date_last_edited,
      out string sponsor_id,
      out string sponsor_number,
      out string document_status,
      out string class_final_status_id,
      out string course_number,
      out string location,
      out string student_cost,
      out string tuition_includes,
      out bool closed,
      out string estimated_students,
      out DateTime start_date_time,
      out DateTime end_date_time,
      out string start_time,
      out string end_time,
      out string other_dates_and_times,
      out string instructors,
      out string instructor_qualifications,
      out string public_contact_name,
      out string public_contact_phone,
      out string public_contact_email,
      out string public_contact_website,
      out string public_contact_notes,
      out DateTime date_submitted_to_region,
      out DateTime date_received_by_region,
      out DateTime date_sponsor_notified,
      out DateTime date_registration_sent_to_state,
      out DateTime date_cards_sent_to_sponsor,
      out DateTime date_materials_to_be_returned,
      out bool approved,
      out string region_comments,
      out string region_council_num,
      out string class_county_code,
      out string total_class_hours,
      out string location_address_1,
      out string location_address_2,
      out string location_city,
      out string location_state,
      out string location_zip,
      out string location_zip_plus_4,
      out string location_phone,
      out string location_email,
      out string location_of_registration,
      out string primary_text,
      out string additional_texts,
      out DateTime final_registration_date,
      out bool offered_as_college_credit,
      out DateTime practical_exam_date,
      out DateTime written_exam_date,
      out string disapproval_reason_id,
      out DateTime date_final_paperwork_received,
      out bool signed_hardcopy,
      out string created_by_first_name,
      out string created_by_last_name,
      out string class_disapproval_reason_description,
      out string sponsor_name,
      out string courses_course_number,
      out string course_title,
      out string status_id
      )
      {
      return db_coned_offerings.Get
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
        );
      }

    internal void ImportLatestFromEmsrs()
      {
      db_coned_offerings.ImportLatestFromEmsrs(ss_emsams.ClassSearchUnlimited());
      }

    internal string LocationOf(object summary)
      {
      return db_coned_offerings.LocationOf(summary);
      }

    public void Set
      (
      string class_id,
      string course_id,
      string class_number,
      string created_by,
      DateTime date_created,
      string last_edited_by,
      DateTime date_last_edited,
      string sponsor_id,
      string sponsor_number,
      string document_status,
      string class_final_status_id,
      string course_number,
      string location,
      string student_cost,
      string tuition_includes,
      bool closed,
      string estimated_students,
      DateTime start_date_time,
      DateTime end_date_time,
      string start_time,
      string end_time,
      string other_dates_and_times,
      string instructors,
      string instructor_qualifications,
      string public_contact_name,
      string public_contact_phone,
      string public_contact_email,
      string public_contact_website,
      string public_contact_notes,
      DateTime date_submitted_to_region,
      DateTime date_received_by_region,
      DateTime date_sponsor_notified,
      DateTime date_registration_sent_to_state,
      DateTime date_cards_sent_to_sponsor,
      DateTime date_materials_to_be_returned,
      bool approved,
      string region_comments,
      string region_council_num,
      string class_county_code,
      string total_class_hours,
      string location_address_1,
      string location_address_2,
      string location_city,
      string location_state,
      string location_zip,
      string location_zip_plus_4,
      string location_phone,
      string location_email,
      string location_of_registration,
      string primary_text,
      string additional_texts,
      DateTime final_registration_date,
      bool offered_as_college_credit,
      DateTime practical_exam_date,
      DateTime written_exam_date,
      string disapproval_reason_id,
      DateTime date_final_paperwork_received,
      bool signed_hardcopy,
      string created_by_first_name,
      string created_by_last_name,
      string class_disapproval_reason_description,
      string sponsor_name,
      string courses_course_number,
      string course_title,
      string status_id
      )
      {
      db_coned_offerings.Set
        (
        class_id,
        course_id,
        class_number,
        created_by,
        date_created,
        last_edited_by,
        date_last_edited,
        sponsor_id,
        sponsor_number,
        document_status,
        class_final_status_id,
        course_number,
        location,
        student_cost,
        tuition_includes,
        closed,
        estimated_students,
        start_date_time,
        end_date_time,
        start_time,
        end_time,
        other_dates_and_times,
        instructors,
        instructor_qualifications,
        public_contact_name,
        public_contact_phone,
        public_contact_email,
        public_contact_website,
        public_contact_notes,
        date_submitted_to_region,
        date_received_by_region,
        date_sponsor_notified,
        date_registration_sent_to_state,
        date_cards_sent_to_sponsor,
        date_materials_to_be_returned,
        approved,
        region_comments,
        region_council_num,
        class_county_code,
        total_class_hours,
        location_address_1,
        location_address_2,
        location_city,
        location_state,
        location_zip,
        location_zip_plus_4,
        location_phone,
        location_email,
        location_of_registration,
        primary_text,
        additional_texts,
        final_registration_date,
        offered_as_college_credit,
        practical_exam_date,
        written_exam_date,
        disapproval_reason_id,
        date_final_paperwork_received,
        signed_hardcopy,
        created_by_first_name,
        created_by_last_name,
        class_disapproval_reason_description,
        sponsor_name,
        courses_course_number,
        course_title,
        status_id
        );
      }

    internal string StartOf(object summary)
      {
      return db_coned_offerings.StartOf(summary);
      }

    public object Summary(string class_id)
      {
      return db_coned_offerings.Summary(class_id);
      }

    internal k.decimal_nonnegative TotalClassHoursOf(object summary)
      {
      var total_class_hours = new k.decimal_nonnegative();
      var total_class_hours_string = db_coned_offerings.TotalClassHoursOf(summary);
      total_class_hours.val = (total_class_hours_string.Length > 0 ? decimal.Parse(total_class_hours_string) : 0);
      return total_class_hours;
      }

    } // end TClass_biz_coned_offerings

  }
