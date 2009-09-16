using kix;
using System;
using Class_db_charter_kinds;
namespace Class_biz_charter_kinds
{
    public class TClass_biz_charter_kinds
    {
        private TClass_db_charter_kinds db_charter_kinds = null;
        //Constructor  Create()
        public TClass_biz_charter_kinds() : base()
        {
            // TODO: Add any constructor code here
            db_charter_kinds = new TClass_db_charter_kinds();
        }
        public bool Bind(string partial_code, object target)
        {
            bool result;
            result = db_charter_kinds.Bind(partial_code, target);
            return result;
        }

        public void BindDirectToListControl(object target, string unselected_literal, string selected_value)
        {
            db_charter_kinds.BindDirectToListControl(target, unselected_literal, selected_value);
        }

        public void BindDirectToListControl(object target)
        {
            BindDirectToListControl(target, "-- charter_kind --");
        }

        public void BindDirectToListControl(object target, string unselected_literal)
        {
            BindDirectToListControl(target, unselected_literal, k.EMPTY);
        }

        public bool Delete(string code)
        {
            bool result;
            result = db_charter_kinds.Delete(code);
            return result;
        }

        public bool Get(string code, out string description)
        {
            bool result;
            result = db_charter_kinds.Get(code, out description);

            return result;
        }

        public void Set(string code, string description)
        {
            db_charter_kinds.Set(code, description);

        }

    } // end TClass_biz_charter_kinds

}
