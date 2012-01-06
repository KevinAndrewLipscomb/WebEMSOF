using Class_db_coned_offering_statuses;
using kix;

namespace Class_biz_coned_offering_statuses
  {

  public class TClass_biz_coned_offering_statuses
    {

    private TClass_db_coned_offering_statuses db_coned_offering_statuses = null;

    public TClass_biz_coned_offering_statuses() : base()
      {
      db_coned_offering_statuses = new TClass_db_coned_offering_statuses();
      }

    public bool Bind(string partial_code, object target)
      {
      return db_coned_offering_statuses.Bind(partial_code, target);
      }

    public void BindDirectToListControl(object target, string unselected_literal, string selected_value)
      {
      db_coned_offering_statuses.BindDirectToListControl(target, unselected_literal, selected_value);
      }

    public void BindDirectToListControl(object target)
      {
      BindDirectToListControl(target, "-- coned_offering_status --");
      }

    public void BindDirectToListControl(object target, string unselected_literal)
      {
      BindDirectToListControl(target, unselected_literal, k.EMPTY);
      }

    public bool Delete(string code)
      {
      return db_coned_offering_statuses.Delete(code);
      }

    public bool Get(string code, out string description)
      {
      return db_coned_offering_statuses.Get(code, out description);
      }

    public void Set(string code, string description)
      {
      db_coned_offering_statuses.Set(code, description);
      }

    } // end TClass_biz_coned_offering_statuses

  }