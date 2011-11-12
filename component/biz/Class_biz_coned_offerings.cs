// Derived from KiAspdotnetFramework/component/biz/Class~biz~~template~kicrudhelped~item.cs~template

using Class_db_coned_offerings;
using kix;
using System;
using System.Collections;
using WebEMSOF.component.ss;

namespace Class_biz_coned_offerings
  {
  public class TClass_biz_coned_offerings
    {
    private TClass_db_coned_offerings db_coned_offerings = null;
    private Class_ss_emsams ss_emsams = null;

    public TClass_biz_coned_offerings() : base()
      {
      db_coned_offerings = new TClass_db_coned_offerings();
      ss_emsams = new Class_ss_emsams();
      }

    public bool Bind(string partial_spec, object target)
      {
      return db_coned_offerings.Bind(partial_spec, target);
      }

    public void BindDirectToListControl(object target)
      {
      db_coned_offerings.BindDirectToListControl(target);
      }

    public bool Delete(string id)
      {
      return db_coned_offerings.Delete(id);
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
      out string class_final_status,
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
      out string class_final_status_description,
      out string sponsor_name,
      out string courses_course_number,
      out string course_title
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
        out class_final_status,
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
        out class_final_status_description,
        out sponsor_name,
        out courses_course_number,
        out course_title
        );
      }

    internal void ImportLatestMasterRecords()
      {
      db_coned_offerings.ImportLatestMasterRecs(ss_emsams.ClassSearchUnlimited());
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
      string class_final_status,
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
      string class_final_status_description,
      string sponsor_name,
      string courses_course_number,
      string course_title
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
        class_final_status,
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
        class_final_status_description,
        sponsor_name,
        courses_course_number,
        course_title
        );
      }

    } // end TClass_biz_coned_offerings

  }
