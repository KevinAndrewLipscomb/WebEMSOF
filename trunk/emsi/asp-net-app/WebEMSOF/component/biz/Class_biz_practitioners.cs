// Derived from KiAspdotnetFramework/component/biz/Class~biz~~template~kicrudhelped~item.cs~template

using Class_db_practitioners;
using kix;
using System;
using System.Collections;
using WebEMSOF.component.ss;

namespace Class_biz_practitioners
  {
  public class TClass_biz_practitioners
    {
    private TClass_db_practitioners db_practitioners = null;
    private Class_ss_emsams ss_emsams = null;

    public TClass_biz_practitioners() : base()
      {
      db_practitioners = new TClass_db_practitioners();
      ss_emsams = new Class_ss_emsams();
      }

    public bool Bind(string partial_spec, object target)
      {
      return db_practitioners.Bind(partial_spec, target);
      }

    public void BindDirectToListControl(object target)
      {
      db_practitioners.BindDirectToListControl(target);
      }

    public bool Delete(string id)
      {
      return db_practitioners.Delete(id);
      }

    public bool Get
      (
      string id,
      out string last_name,
      out string first_name,
      out string middle_name,
      out string email_address,
      out string new_emso_user_id,
      out string county_code,
      out string street_address,
      out string city,
      out string zip,
      out DateTime birth_date
      )
      {
      return db_practitioners.Get
        (
        id,
        out last_name,
        out first_name,
        out middle_name,
        out email_address,
        out new_emso_user_id,
        out county_code,
        out street_address,
        out city,
        out zip,
        out birth_date
        );
      }

    internal void ImportLatestFromEmsrs()
      {
      db_practitioners.ImportLatestFromEmsrs(ss_emsams.UserSearchLimitedToRegion("04"));
      }

    public void Set
      (
      string id,
      string last_name,
      string first_name,
      string middle_name,
      string email_address,
      string new_emso_user_id,
      string county_code,
      string street_address,
      string city,
      string zip,
      DateTime birth_date
      )
      {
      db_practitioners.Set
        (
        id,
        last_name,
        first_name,
        middle_name,
        email_address,
        new_emso_user_id,
        county_code,
        street_address,
        city,
        zip,
        birth_date
        );
      }

    } // end TClass_biz_practitioners

  }
