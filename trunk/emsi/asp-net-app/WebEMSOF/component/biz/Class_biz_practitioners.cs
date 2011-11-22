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
      out string middle_initial,
      out string certification_number,
      out string level_id,
      out string regional_council_code,
      out DateTime birth_date,
      out bool be_stale
      )
      {
      return db_practitioners.Get
        (
        id,
        out last_name,
        out first_name,
        out middle_initial,
        out certification_number,
        out level_id,
        out regional_council_code,
        out birth_date,
        out be_stale
        );
      }

    internal void ImportLatestFromEmsrs()
      {
      db_practitioners.MarkAllStale();
      //
      var context = new Class_ss_emsams.ActivePractitionersContext();
      var be_done = false;
      while (!be_done)
        {
        db_practitioners.ImportLatestFromEmsrs(ss_emsams.ActivePractitioners(context,out be_done));
        }
      //
      db_practitioners.RemoveStale();
      }

    public void Set
      (
      string id,
      string last_name,
      string first_name,
      string middle_initial,
      string certification_number,
      string level_id,
      string regional_council_code,
      DateTime birth_date,
      bool be_stale
      )
      {
      db_practitioners.Set
        (
        id,
        last_name,
        first_name,
        middle_initial,
        certification_number,
        level_id,
        regional_council_code,
        birth_date,
        be_stale
        );
      }

    } // end TClass_biz_practitioners

  }
