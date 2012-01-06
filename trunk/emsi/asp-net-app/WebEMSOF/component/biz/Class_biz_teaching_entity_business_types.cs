using Class_db_teaching_entity_business_types;
using kix;

namespace Class_biz_teaching_entity_business_types
{
    public class TClass_biz_teaching_entity_business_types
    {
        private TClass_db_teaching_entity_business_types db_teaching_entity_business_types = null;
        //Constructor  Create()
        public TClass_biz_teaching_entity_business_types() : base()
        {
            // TODO: Add any constructor code here
            db_teaching_entity_business_types = new TClass_db_teaching_entity_business_types();
        }
        public bool Bind(string partial_code, object target)
        {
            bool result;
            result = db_teaching_entity_business_types.Bind(partial_code, target);
            return result;
        }

        public void BindDirectToListControl(object target, string unselected_literal, string selected_value)
        {
            db_teaching_entity_business_types.BindDirectToListControl(target, unselected_literal, selected_value);
        }

        public void BindDirectToListControl(object target)
        {
            BindDirectToListControl(target, "-- teaching entity business type --");
        }

        public void BindDirectToListControl(object target, string unselected_literal)
        {
            BindDirectToListControl(target, unselected_literal, k.EMPTY);
        }

        public bool Delete(string code)
        {
            bool result;
            result = db_teaching_entity_business_types.Delete(code);
            return result;
        }

        public bool Get(string code, out string description)
        {
            bool result;
            result = db_teaching_entity_business_types.Get(code, out description);

            return result;
        }

        public void Set(string code, string description)
        {
            db_teaching_entity_business_types.Set(code, description);

        }

    } // end TClass_biz_teaching_entity_business_types

}
