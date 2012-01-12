// Derived from KiAspdotnetFramework/component/biz/Class~biz~~template~kicrudhelped~item.cs~template

using Class_db_teaching_entities;
using kix;
using System;
using System.Collections;
using WebEMSOF.component.ss;

namespace Class_biz_teaching_entities
  {
  public class TClass_biz_teaching_entities
    {
    private TClass_db_teaching_entities db_teaching_entities = null;
    private Class_ss_emsams ss_emsams = null;

    public TClass_biz_teaching_entities() : base()
      {
      db_teaching_entities = new TClass_db_teaching_entities();
      ss_emsams = new Class_ss_emsams();
      }

    public bool Bind(string partial_spec, object target)
      {
      return db_teaching_entities.Bind(partial_spec, target);
      }

    public void BindConedSponsorsBaseDataList
      (
      string region_code,
      string sort_order,
      bool be_order_ascending,
      object target
      )
      {
      db_teaching_entities.BindConedSponsorsBaseDataList(region_code,sort_order,be_order_ascending,target);
      }

    public void BindDirectToListControl(object target)
      {
      db_teaching_entities.BindDirectToListControl(target);
      }

    public bool Delete(string id)
      {
      return db_teaching_entities.Delete(id);
      }

    public bool Get
      (
      string id,
      out string emsrs_id,
      out DateTime date_created,
      out DateTime date_last_edited,
      out string sponsor_number,
      out string training_ins_accred_num,
      out string name,
      out string short_name,
      out string address_1,
      out string address_2,
      out string city,
      out string state,
      out string zip,
      out string county_code,
      out string region,
      out string email,
      out string website,
      out string daytime_phone,
      out string evening_phone,
      out string fax,
      out string business_type_id,
      out string con_ed_level_id,
      out string certification_level,
      out string contact_first_name,
      out string contact_last_name,
      out string contact_title,
      out string contact_address_1,
      out string contact_address_2,
      out string contact_city,
      out string contact_state,
      out string contact_zip,
      out string contact_daytime_phone,
      out string contact_evening_phone,
      out string contact_fax,
      out string contact_email,
      out string public_contact_name,
      out string public_contact_phone,
      out string public_contact_email,
      out string public_contact_website,
      out string public_contact_notes,
      out DateTime application_date,
      out DateTime application_received,
      out string coned_sponsor_status_id,
      out string training_inst_status_id,
      out DateTime issue_date,
      out DateTime prev_expiration_date,
      out DateTime expiration_date_sponsor,
      out DateTime expiration_date_training_inst,
      out DateTime process_date,
      out string corrective_action,
      out DateTime compliance_by_date,
      out DateTime initial_accred_date,
      out DateTime accepted_provisional_date,
      out DateTime completed_provisional_date,
      out DateTime withdrawal_challenge_due_date,
      out bool letter_for_expiration,
      out bool letter_f_for_ppwk_non_compliance,
      out bool other_letter,
      out string history
      )
      {
      return db_teaching_entities.Get
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
        );
      }

    internal void ImportLatestFromEmsrs()
      {
      db_teaching_entities.ImportLatestFromEmsrs(ss_emsams.TeachingEntitySearchUnlimited());
      }

    public void Set
      (
      string id,
      string emsrs_id,
      DateTime date_created,
      DateTime date_last_edited,
      string sponsor_number,
      string training_ins_accred_num,
      string name,
      string short_name,
      string address_1,
      string address_2,
      string city,
      string state,
      string zip,
      string county_code,
      string region,
      string email,
      string website,
      string daytime_phone,
      string evening_phone,
      string fax,
      string business_type_id,
      string con_ed_level_id,
      string certification_level,
      string contact_first_name,
      string contact_last_name,
      string contact_title,
      string contact_address_1,
      string contact_address_2,
      string contact_city,
      string contact_state,
      string contact_zip,
      string contact_daytime_phone,
      string contact_evening_phone,
      string contact_fax,
      string contact_email,
      string public_contact_name,
      string public_contact_phone,
      string public_contact_email,
      string public_contact_website,
      string public_contact_notes,
      DateTime application_date,
      DateTime application_received,
      string coned_sponsor_status_id,
      string training_inst_status_id,
      DateTime issue_date,
      DateTime prev_expiration_date,
      DateTime expiration_date_sponsor,
      DateTime expiration_date_training_inst,
      DateTime process_date,
      string corrective_action,
      DateTime compliance_by_date,
      DateTime initial_accred_date,
      DateTime accepted_provisional_date,
      DateTime completed_provisional_date,
      DateTime withdrawal_challenge_due_date,
      bool letter_for_expiration,
      bool letter_f_for_ppwk_non_compliance,
      bool other_letter,
      string history
      )
      {
      db_teaching_entities.Set
        (
        id,
        emsrs_id,
        date_created,
        date_last_edited,
        sponsor_number,
        training_ins_accred_num,
        name,
        short_name,
        address_1,
        address_2,
        city,
        state,
        zip,
        county_code,
        region,
        email,
        website,
        daytime_phone,
        evening_phone,
        fax,
        business_type_id,
        con_ed_level_id,
        certification_level,
        contact_first_name,
        contact_last_name,
        contact_title,
        contact_address_1,
        contact_address_2,
        contact_city,
        contact_state,
        contact_zip,
        contact_daytime_phone,
        contact_evening_phone,
        contact_fax,
        contact_email,
        public_contact_name,
        public_contact_phone,
        public_contact_email,
        public_contact_website,
        public_contact_notes,
        application_date,
        application_received,
        coned_sponsor_status_id,
        training_inst_status_id,
        issue_date,
        prev_expiration_date,
        expiration_date_sponsor,
        expiration_date_training_inst,
        process_date,
        corrective_action,
        compliance_by_date,
        initial_accred_date,
        accepted_provisional_date,
        completed_provisional_date,
        withdrawal_challenge_due_date,
        letter_for_expiration,
        letter_f_for_ppwk_non_compliance,
        other_letter,
        history
        );
      }

    internal void SyncConedSponsorAccounts()
      {
      db_teaching_entities.SyncConedSponsorAccounts();
      }

    } // end TClass_biz_teaching_entitys

  }
