using Class_db_regions;
using kix;

namespace Class_biz_regions
  {

  public class TClass_biz_regions
    {

    private TClass_db_regions db_regions = null;

    public TClass_biz_regions() : base()
      {      
      db_regions = new TClass_db_regions();
      }

    public bool Bind
      (
      string partial_code,
      object target
      )
      {
      return db_regions.Bind(partial_code, target);
      }

    public void BindDirectToListControl
      (
      object target,
      string unselected_literal,
      string selected_value
      )
      {
      db_regions.BindDirectToListControl(target, unselected_literal, selected_value);
      }
    public void BindDirectToListControl(object target, string unselected_literal)
      {
      BindDirectToListControl(target, unselected_literal, k.EMPTY);
      }
    public void BindDirectToListControl(object target)
      {
      BindDirectToListControl(target, "-- region --");
      }

    public void BindEmsrsToListControl
      (
      object target,
      string unselected_literal,
      string selected_value
      )
      {
      db_regions.BindEmsrsToListControl(target, unselected_literal, selected_value);
      }
    public void BindEmsrsToListControl(object target, string unselected_literal)
      {
      BindEmsrsToListControl(target, unselected_literal, k.EMPTY);
      }
    public void BindEmsrsToListControl(object target)
      {
      BindEmsrsToListControl(target, "-- region --");
      }

    public bool Delete(string code)
      {
      return db_regions.Delete(code);
      }

    internal string EmsrsCodeOfCode(string code)
      {
      return db_regions.EmsrsCodeOfCode(code);
      }

    public bool Get
      (
      string code,
      out string description
      )
      {
      return db_regions.Get(code,out description);
      }

    public void Set
      (
      string code,
      string description
      )
      {
      db_regions.Set(code,description);
      }

    } // end TClass_biz_regions

  }