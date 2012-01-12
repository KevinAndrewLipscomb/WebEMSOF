// Derived from KiAspdotnetFramework/component/db/Class~db~template~kicrudhelped~items.cs~template

using Class_db;
using Class_db_trail;
using kix;
using MySql.Data.MySqlClient;
using System;
using System.Collections;
using System.Web.UI.WebControls;
using UserControl_drop_down_date;
using WebEMSOF.component.ss;

namespace Class_db_teaching_entities
  {
  public class TClass_db_teaching_entities: TClass_db
    {
    private TClass_db_trail db_trail = null;

    public TClass_db_teaching_entities() : base()
      {
      db_trail = new TClass_db_trail();
      }

    public bool Bind(string partial_spec, object target)
      {
      var concat_clause = "concat(IFNULL(emsrs_id,'-'),'|',IFNULL(sponsor_number,'-'),'|',IFNULL(training_ins_accred_num,'-'),'|',IFNULL(name,'-'),'|',IFNULL(short_name,'-'),'|',IFNULL(address_1,'-'),'|',IFNULL(address_2,'-'),'|',IFNULL(city,'-'),'|',IFNULL(state,'-'),'|',IFNULL(zip,'-'),'|',IFNULL(county_code,'-'),'|',IFNULL(region,'-'),'|',IFNULL(email,'-'),'|',IFNULL(website,'-'),'|',IFNULL(daytime_phone,'-'),'|',IFNULL(evening_phone,'-'),'|',IFNULL(fax,'-'),'|',IFNULL(contact_first_name,'-'),'|',IFNULL(contact_last_name,'-'),'|',IFNULL(public_contact_name,'-'))";
      Open();
      ((target) as ListControl).Items.Clear();
      var dr = new MySqlCommand
        (
        "select id"
        + " , CONVERT(" + concat_clause + " USING utf8) as spec"
        + " from teaching_entity"
        + " where " + concat_clause + " like '%" + partial_spec.ToUpper() + "%'"
        + " order by spec",
        connection
        )
        .ExecuteReader();
      while (dr.Read())
        {
        ((target) as ListControl).Items.Add(new ListItem(dr["spec"].ToString(), dr["id"].ToString()));
        }
      dr.Close();
      Close();
      return ((target) as ListControl).Items.Count > 0;
      }

    public void BindConedSponsorsBaseDataList
      (
      string region_code,
      string sort_order,
      bool be_order_ascending,
      object target
      )
      {
      Open();
      ((target) as BaseDataList).DataSource = new MySqlCommand
        (
        "select id"
        + " , sponsor_number"
        + " , IFNULL(teaching_entity.name,IFNULL(teaching_entity.short_name,'')) as name"
        + " from teaching_entity"
        +   " join region_code_name_map on (region_code_name_map.emsrs_code=teaching_entity.region)"
        + " where sponsor_number is not null"
        +   " and IFNULL(email,IFNULL(contact_email,public_contact_email)) is not null"
        +   " and code = '" + region_code + "'"
        + " order by " + sort_order.Replace("%",(be_order_ascending ? " asc" : " desc")),
        connection
        )
        .ExecuteReader();
      ((target) as BaseDataList).DataBind();
      Close();
      }

    public void BindDirectToListControl(object target)
      {
      Open();
      ((target) as ListControl).Items.Clear();
      var dr = new MySqlCommand
        (
        "SELECT id"
        + " , CONVERT(concat(IFNULL(emsrs_id,'-'),'|',IFNULL(sponsor_number,'-'),'|',IFNULL(training_ins_accred_num,'-'),'|',IFNULL(name,'-'),'|',IFNULL(short_name,'-'),'|',IFNULL(address_1,'-'),'|',IFNULL(address_2,'-'),'|',IFNULL(city,'-'),'|',IFNULL(state,'-'),'|',IFNULL(zip,'-'),'|',IFNULL(county_code,'-'),'|',IFNULL(region,'-'),'|',IFNULL(email,'-'),'|',IFNULL(website,'-'),'|',IFNULL(daytime_phone,'-'),'|',IFNULL(evening_phone,'-'),'|',IFNULL(fax,'-'),'|',IFNULL(contact_first_name,'-'),'|',IFNULL(contact_last_name,'-'),'|',IFNULL(public_contact_name,'-')) USING utf8) as spec"
        + " FROM teaching_entity"
        + " order by spec",
        connection
        )
        .ExecuteReader();
      while (dr.Read())
        {
        ((target) as ListControl).Items.Add(new ListItem(dr["spec"].ToString(), dr["id"].ToString()));
        }
      dr.Close();
      Close();
      }

    public bool Delete(string id)
      {
      var result = true;
      Open();
      try
        {
        new MySqlCommand(db_trail.Saved("delete from teaching_entity where id = \"" + id + "\""), connection).ExecuteNonQuery();
        }
      catch(System.Exception e)
        {
        if (e.Message.StartsWith("Cannot delete or update a parent row: a foreign key constraint fails", true, null))
          {
          result = false;
          }
        else
          {
          throw e;
          }
        }
      Close();
      return result;
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
      emsrs_id = k.EMPTY;
      date_created = DateTime.MinValue;
      date_last_edited = DateTime.MinValue;
      sponsor_number = k.EMPTY;
      training_ins_accred_num = k.EMPTY;
      name = k.EMPTY;
      short_name = k.EMPTY;
      address_1 = k.EMPTY;
      address_2 = k.EMPTY;
      city = k.EMPTY;
      state = k.EMPTY;
      zip = k.EMPTY;
      county_code = k.EMPTY;
      region = k.EMPTY;
      email = k.EMPTY;
      website = k.EMPTY;
      daytime_phone = k.EMPTY;
      evening_phone = k.EMPTY;
      fax = k.EMPTY;
      business_type_id = k.EMPTY;
      con_ed_level_id = k.EMPTY;
      certification_level = k.EMPTY;
      contact_first_name = k.EMPTY;
      contact_last_name = k.EMPTY;
      contact_title = k.EMPTY;
      contact_address_1 = k.EMPTY;
      contact_address_2 = k.EMPTY;
      contact_city = k.EMPTY;
      contact_state = k.EMPTY;
      contact_zip = k.EMPTY;
      contact_daytime_phone = k.EMPTY;
      contact_evening_phone = k.EMPTY;
      contact_fax = k.EMPTY;
      contact_email = k.EMPTY;
      public_contact_name = k.EMPTY;
      public_contact_phone = k.EMPTY;
      public_contact_email = k.EMPTY;
      public_contact_website = k.EMPTY;
      public_contact_notes = k.EMPTY;
      application_date = DateTime.MinValue;
      application_received = DateTime.MinValue;
      coned_sponsor_status_id = k.EMPTY;
      training_inst_status_id = k.EMPTY;
      issue_date = DateTime.MinValue;
      prev_expiration_date = DateTime.MinValue;
      expiration_date_sponsor = DateTime.MinValue;
      expiration_date_training_inst = DateTime.MinValue;
      process_date = DateTime.MinValue;
      corrective_action = k.EMPTY;
      compliance_by_date = DateTime.MinValue;
      initial_accred_date = DateTime.MinValue;
      accepted_provisional_date = DateTime.MinValue;
      completed_provisional_date = DateTime.MinValue;
      withdrawal_challenge_due_date = DateTime.MinValue;
      letter_for_expiration = false;
      letter_f_for_ppwk_non_compliance = false;
      other_letter = false;
      history = k.EMPTY;
      var result = false;
      //
      Open();
      var dr = new MySqlCommand("select * from teaching_entity where CAST(id AS CHAR) = \"" + id + "\"", connection).ExecuteReader();
      if (dr.Read())
        {
        emsrs_id = dr["emsrs_id"].ToString();
        DateTime.TryParse(dr["date_created"].ToString(),out date_created);
        DateTime.TryParse(dr["date_last_edited"].ToString(),out date_last_edited);
        sponsor_number = dr["sponsor_number"].ToString();
        training_ins_accred_num = dr["training_ins_accred_num"].ToString();
        name = dr["name"].ToString();
        short_name = dr["short_name"].ToString();
        address_1 = dr["address_1"].ToString();
        address_2 = dr["address_2"].ToString();
        city = dr["city"].ToString();
        state = dr["state"].ToString();
        zip = dr["zip"].ToString();
        county_code = dr["county_code"].ToString();
        region = dr["region"].ToString();
        email = dr["email"].ToString();
        website = dr["website"].ToString();
        daytime_phone = dr["daytime_phone"].ToString();
        evening_phone = dr["evening_phone"].ToString();
        fax = dr["fax"].ToString();
        business_type_id = dr["business_type_id"].ToString();
        con_ed_level_id = dr["con_ed_level_id"].ToString();
        certification_level = dr["certification_level"].ToString();
        contact_first_name = dr["contact_first_name"].ToString();
        contact_last_name = dr["contact_last_name"].ToString();
        contact_title = dr["contact_title"].ToString();
        contact_address_1 = dr["contact_address_1"].ToString();
        contact_address_2 = dr["contact_address_2"].ToString();
        contact_city = dr["contact_city"].ToString();
        contact_state = dr["contact_state"].ToString();
        contact_zip = dr["contact_zip"].ToString();
        contact_daytime_phone = dr["contact_daytime_phone"].ToString();
        contact_evening_phone = dr["contact_evening_phone"].ToString();
        contact_fax = dr["contact_fax"].ToString();
        contact_email = dr["contact_email"].ToString();
        public_contact_name = dr["public_contact_name"].ToString();
        public_contact_phone = dr["public_contact_phone"].ToString();
        public_contact_email = dr["public_contact_email"].ToString();
        public_contact_website = dr["public_contact_website"].ToString();
        public_contact_notes = dr["public_contact_notes"].ToString();
        DateTime.TryParse(dr["application_date"].ToString(),out application_date);
        DateTime.TryParse(dr["application_received"].ToString(),out application_received);
        coned_sponsor_status_id = dr["coned_sponsor_status_id"].ToString();
        training_inst_status_id = dr["training_inst_status_id"].ToString();
        DateTime.TryParse(dr["issue_date"].ToString(),out issue_date);
        DateTime.TryParse(dr["prev_expiration_date"].ToString(),out prev_expiration_date);
        DateTime.TryParse(dr["expiration_date_sponsor"].ToString(),out expiration_date_sponsor);
        DateTime.TryParse(dr["expiration_date_training_inst"].ToString(),out expiration_date_training_inst);
        DateTime.TryParse(dr["process_date"].ToString(),out process_date);
        corrective_action = dr["corrective_action"].ToString();
        DateTime.TryParse(dr["compliance_by_date"].ToString(),out compliance_by_date);
        DateTime.TryParse(dr["initial_accred_date"].ToString(),out initial_accred_date);
        DateTime.TryParse(dr["accepted_provisional_date"].ToString(),out accepted_provisional_date);
        DateTime.TryParse(dr["completed_provisional_date"].ToString(),out completed_provisional_date);
        DateTime.TryParse(dr["withdrawal_challenge_due_date"].ToString(),out withdrawal_challenge_due_date);
        letter_for_expiration = (dr["letter_for_expiration"].ToString() == "1");
        letter_f_for_ppwk_non_compliance = (dr["letter_f_for_ppwk_non_compliance"].ToString() == "1");
        other_letter = (dr["other_letter"].ToString() == "1");
        history = dr["history"].ToString();
        result = true;
        }
      dr.Close();
      Close();
      return result;
      }

    internal void ImportLatestFromEmsrs(ArrayList recs)
      {
      var childless_field_assignments_clause = k.EMPTY;
      Open();
      foreach (var rec in recs)
        {
        childless_field_assignments_clause = k.EMPTY
        + "date_created = STR_TO_DATE(NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).date_created + "',''),'%m/%d/%Y')"
        + " , date_last_edited = STR_TO_DATE(NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).date_last_edited + "',''),'%m/%d/%Y')"
        + " , sponsor_number = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).sponsor_number + "','')"
        + " , training_ins_accred_num = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).training_ins_accred_num + "','')"
        + " , name = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).name + "','')"
        + " , short_name = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).short_name + "','')"
        + " , address_1 = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).address_1 + "','')"
        + " , address_2 = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).address_2 + "','')"
        + " , city = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).city + "','')"
        + " , state = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).state + "','')"
        + " , zip = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).zip + "','')"
        + " , county_code = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).county_code + "','')"
        + " , region = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).region + "','')"
        + " , email = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).email + "','')"
        + " , website = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).website + "','')"
        + " , daytime_phone = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).daytime_phone + "','')"
        + " , evening_phone = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).evening_phone + "','')"
        + " , fax = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).fax + "','')"
        + " , business_type_id = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).business_type_id + "','')"
        + " , con_ed_level_id = NULLIF(IFNULL((select id from teaching_entity_level where description = '" + (rec as Class_ss_emsams.TeachingEntity).con_ed_level + "'),''),'')"
        + " , certification_level = NULLIF(IFNULL((select id from teaching_entity_level where description = '" + (rec as Class_ss_emsams.TeachingEntity).certification_level + "'),''),'')"
        + " , contact_first_name = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).contact_first_name + "','')"
        + " , contact_last_name = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).contact_last_name + "','')"
        + " , contact_title = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).contact_title + "','')"
        + " , contact_address_1 = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).contact_address_1 + "','')"
        + " , contact_address_2 = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).contact_address_2 + "','')"
        + " , contact_city = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).contact_city + "','')"
        + " , contact_state = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).contact_state + "','')"
        + " , contact_zip = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).contact_zip + "','')"
        + " , contact_daytime_phone = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).contact_daytime_phone + "','')"
        + " , contact_evening_phone = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).contact_evening_phone + "','')"
        + " , contact_fax = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).contact_fax + "','')"
        + " , contact_email = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).contact_email + "','')"
        + " , public_contact_name = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).public_contact_name + "','')"
        + " , public_contact_phone = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).public_contact_phone + "','')"
        + " , public_contact_email = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).public_contact_email + "','')"
        + " , public_contact_website = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).public_contact_website + "','')"
        + " , public_contact_notes = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).public_contact_notes + "','')"
        + " , application_date = STR_TO_DATE(NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).application_date + "',''),'%m/%d/%Y')"
        + " , application_received = STR_TO_DATE(NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).application_received + "',''),'%m/%d/%Y')"
        + " , coned_sponsor_status_id = NULLIF(IFNULL((select id from coned_sponsor_status where description = '" + (rec as Class_ss_emsams.TeachingEntity).sponsor_status_description + "'),''),'')"
        + " , training_inst_status_id = NULLIF(IFNULL((select id from training_institute_status where description = '" + (rec as Class_ss_emsams.TeachingEntity).training_inst_status_description + "'),''),'')"
        + " , issue_date = STR_TO_DATE(NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).issue_date + "',''),'%m/%d/%Y')"
        + " , prev_expiration_date = STR_TO_DATE(NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).prev_expiration_date + "',''),'%m/%d/%Y')"
        + " , expiration_date_sponsor = STR_TO_DATE(NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).expiration_date_sponsor + "',''),'%m/%d/%Y')"
        + " , expiration_date_training_inst = STR_TO_DATE(NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).expiration_date_training_inst + "',''),'%m/%d/%Y')"
        + " , process_date = STR_TO_DATE(NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).process_date + "',''),'%m/%d/%Y')"
        + " , corrective_action = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).corrective_action + "','')"
        + " , compliance_by_date = STR_TO_DATE(NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).compliance_by_date + "',''),'%m/%d/%Y')"
        + " , initial_accred_date = STR_TO_DATE(NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).initial_accred_date + "',''),'%m/%d/%Y')"
        + " , accepted_provisional_date = STR_TO_DATE(NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).accepted_provisional_date + "',''),'%m/%d/%Y')"
        + " , completed_provisional_date = STR_TO_DATE(NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).completed_provisional_date + "',''),'%m/%d/%Y')"
        + " , withdrawal_challenge_due_date = STR_TO_DATE(NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).withdrawal_challenge_due_date + "',''),'%m/%d/%Y')"
        + " , letter_for_expiration = " + ((rec as Class_ss_emsams.TeachingEntity).letter_for_expiration.Length > 0 ? (rec as Class_ss_emsams.TeachingEntity).letter_for_expiration : "null")
        + " , letter_f_for_ppwk_non_compliance = " + ((rec as Class_ss_emsams.TeachingEntity).letter_f_for_ppwk_non_compliance.Length > 0 ? (rec as Class_ss_emsams.TeachingEntity).letter_f_for_ppwk_non_compliance : "null")
        + " , other_letter = " + ((rec as Class_ss_emsams.TeachingEntity).other_letter.Length > 0 ? (rec as Class_ss_emsams.TeachingEntity).other_letter : "null")
        + " , history = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).history + "','')"
        + k.EMPTY;
        new MySqlCommand
          (
          "insert teaching_entity"
          + " set emsrs_id = NULLIF('" + (rec as Class_ss_emsams.TeachingEntity).id + "','')"
          + " , " + childless_field_assignments_clause
          + " on duplicate key update "
          + childless_field_assignments_clause,
          connection
          )
          .ExecuteNonQuery();
        }
      Close();
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
      var childless_field_assignments_clause = k.EMPTY
      + "emsrs_id = NULLIF('" + emsrs_id + "','')"
      + " , date_created = '" + date_created.ToString("yyyy-MM-dd") + "'"
      + " , date_last_edited = '" + date_last_edited.ToString("yyyy-MM-dd") + "'"
      + " , sponsor_number = NULLIF('" + sponsor_number + "','')"
      + " , training_ins_accred_num = NULLIF('" + training_ins_accred_num + "','')"
      + " , name = NULLIF('" + name + "','')"
      + " , short_name = NULLIF('" + short_name + "','')"
      + " , address_1 = NULLIF('" + address_1 + "','')"
      + " , address_2 = NULLIF('" + address_2 + "','')"
      + " , city = NULLIF('" + city + "','')"
      + " , state = NULLIF('" + state + "','')"
      + " , zip = NULLIF('" + zip + "','')"
      + " , county_code = NULLIF('" + county_code + "','')"
      + " , region = NULLIF('" + region + "','')"
      + " , email = NULLIF('" + email + "','')"
      + " , website = NULLIF('" + website + "','')"
      + " , daytime_phone = NULLIF('" + daytime_phone + "','')"
      + " , evening_phone = NULLIF('" + evening_phone + "','')"
      + " , fax = NULLIF('" + fax + "','')"
      + " , business_type_id = NULLIF('" + business_type_id + "','')"
      + " , con_ed_level_id = NULLIF('" + con_ed_level_id + "','')"
      + " , certification_level = NULLIF('" + certification_level + "','')"
      + " , contact_first_name = NULLIF('" + contact_first_name + "','')"
      + " , contact_last_name = NULLIF('" + contact_last_name + "','')"
      + " , contact_title = NULLIF('" + contact_title + "','')"
      + " , contact_address_1 = NULLIF('" + contact_address_1 + "','')"
      + " , contact_address_2 = NULLIF('" + contact_address_2 + "','')"
      + " , contact_city = NULLIF('" + contact_city + "','')"
      + " , contact_state = NULLIF('" + contact_state + "','')"
      + " , contact_zip = NULLIF('" + contact_zip + "','')"
      + " , contact_daytime_phone = NULLIF('" + contact_daytime_phone + "','')"
      + " , contact_evening_phone = NULLIF('" + contact_evening_phone + "','')"
      + " , contact_fax = NULLIF('" + contact_fax + "','')"
      + " , contact_email = NULLIF('" + contact_email + "','')"
      + " , public_contact_name = NULLIF('" + public_contact_name + "','')"
      + " , public_contact_phone = NULLIF('" + public_contact_phone + "','')"
      + " , public_contact_email = NULLIF('" + public_contact_email + "','')"
      + " , public_contact_website = NULLIF('" + public_contact_website + "','')"
      + " , public_contact_notes = NULLIF('" + public_contact_notes + "','')"
      + " , application_date = '" + application_date.ToString("yyyy-MM-dd") + "'"
      + " , application_received = '" + application_received.ToString("yyyy-MM-dd") + "'"
      + " , coned_sponsor_status_id = NULLIF('" + coned_sponsor_status_id + "','')"
      + " , training_inst_status_id = NULLIF('" + training_inst_status_id + "','')"
      + " , issue_date = '" + issue_date.ToString("yyyy-MM-dd") + "'"
      + " , prev_expiration_date = '" + prev_expiration_date.ToString("yyyy-MM-dd") + "'"
      + " , expiration_date_sponsor = '" + expiration_date_sponsor.ToString("yyyy-MM-dd") + "'"
      + " , expiration_date_training_inst = '" + expiration_date_training_inst.ToString("yyyy-MM-dd") + "'"
      + " , process_date = '" + process_date.ToString("yyyy-MM-dd") + "'"
      + " , corrective_action = NULLIF('" + corrective_action + "','')"
      + " , compliance_by_date = '" + compliance_by_date.ToString("yyyy-MM-dd") + "'"
      + " , initial_accred_date = '" + initial_accred_date.ToString("yyyy-MM-dd") + "'"
      + " , accepted_provisional_date = '" + accepted_provisional_date.ToString("yyyy-MM-dd") + "'"
      + " , completed_provisional_date = '" + completed_provisional_date.ToString("yyyy-MM-dd") + "'"
      + " , withdrawal_challenge_due_date = '" + withdrawal_challenge_due_date.ToString("yyyy-MM-dd") + "'"
      + " , letter_for_expiration = NULLIF('" + letter_for_expiration.ToString() + "','')"
      + " , letter_f_for_ppwk_non_compliance = NULLIF('" + letter_f_for_ppwk_non_compliance.ToString() + "','')"
      + " , other_letter = NULLIF('" + other_letter.ToString() + "','')"
      + " , history = NULLIF('" + history + "','')"
      + k.EMPTY;
      Open();
      new MySqlCommand
        (
        db_trail.Saved
          (
          "insert teaching_entity"
          + " set id = NULLIF('" + id + "','')"
          + " , " + childless_field_assignments_clause
          + " on duplicate key update "
          + childless_field_assignments_clause
          ),
          connection
        )
        .ExecuteNonQuery();
      Close();
      }

    internal void SyncConedSponsorAccounts()
      {
      Open();
      new MySqlCommand
        (
        "insert coned_sponsor_user (id,password_reset_email_address)"
        + " select id"
        + " , IFNULL(email,IFNULL(contact_email,public_contact_email)) as password_reset_email_address"
        + " from teaching_entity left outer join coned_sponsor_user using (id)"
        + " where coned_sponsor_user.id is null"
        +   " and sponsor_number is not null"
        +   " and IFNULL(email,IFNULL(contact_email,public_contact_email)) is not null",
        connection
        )
        .ExecuteNonQuery();
      Close();
      }

    } // end TClass_db_teaching_entitys

  }
