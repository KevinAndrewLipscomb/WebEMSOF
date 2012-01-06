using Class_db_teaching_entity_levels;
using kix;

namespace Class_biz_teaching_entity_levels
{
    public class TClass_biz_teaching_entity_levels
    {
        private TClass_db_teaching_entity_levels db_teaching_entity_levels = null;
        //Constructor  Create()
        public TClass_biz_teaching_entity_levels() : base()
        {
            // TODO: Add any constructor code here
            db_teaching_entity_levels = new TClass_db_teaching_entity_levels();
        }
        public bool Bind(string partial_code, object target)
        {
            bool result;
            result = db_teaching_entity_levels.Bind(partial_code, target);
            return result;
        }

        public void BindDirectToListControl(object target, string unselected_literal, string selected_value)
        {
            db_teaching_entity_levels.BindDirectToListControl(target, unselected_literal, selected_value);
        }

        public void BindDirectToListControl(object target)
        {
            BindDirectToListControl(target, "-- teaching entity level --");
        }

        public void BindDirectToListControl(object target, string unselected_literal)
        {
            BindDirectToListControl(target, unselected_literal, k.EMPTY);
        }

        public bool Delete(string code)
        {
            bool result;
            result = db_teaching_entity_levels.Delete(code);
            return result;
        }

        public bool Get(string code, out string description)
        {
            bool result;
            result = db_teaching_entity_levels.Get(code, out description);

            return result;
        }

        public void Set(string code, string description)
        {
            db_teaching_entity_levels.Set(code, description);

        }

    } // end TClass_biz_teaching_entity_levels

}
