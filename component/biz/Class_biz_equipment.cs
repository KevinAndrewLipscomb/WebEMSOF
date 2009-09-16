using kix;
using System;

using System.Collections;
using Class_biz_match_level;
using Class_db_emsof_requests;
using Class_db_equipment;
using Class_db_services;
namespace Class_biz_equipment
{
    public class TClass_biz_equipment
    {
        private TClass_db_emsof_requests db_emsof_requests = null;
        private TClass_db_equipment db_equipment = null;
        private TClass_db_services db_services = null;
        //Constructor  Create()
        public TClass_biz_equipment() : base()
        {
            // TODO: Add any constructor code here
            db_emsof_requests = new TClass_db_emsof_requests();
            db_equipment = new TClass_db_equipment();
            db_services = new TClass_db_services();
        }
        public bool BeMatchExempt(string code, nominal_type match_level_enum)
        {
            bool result;
            decimal allowable_cost;
            allowable_cost = db_equipment.AllowableCostOf(code);
            switch(match_level_enum)
            {
                case Class_biz_match_level.nominal_type.STANDARD:
                    result = (allowable_cost == db_equipment.FundingLevelNonRuralOf(code));
                    break;
                case Class_biz_match_level.nominal_type.RURAL:
                    result = (allowable_cost == db_equipment.FundingLevelRuralOf(code));
                    break;
                case Class_biz_match_level.nominal_type.DISTRESSED:
                    result = (allowable_cost == db_equipment.FundingLevelNonRuralOf(code)) || (allowable_cost == db_equipment.FundingLevelRuralOf(code));
                    break;
                default:
                    result = false;
                    break;
            }
            return result;
        }

        public string SpecialRulesViolation(string service_id, string master_id, string priority, string code, string quantity_string)
        {
            string result;
            uint i;
            string name;
            Queue q;
            string special_rules_violation;
            special_rules_violation = k.EMPTY;
            q = db_equipment.SpecialRuleNames(code);
            for (i = 1; i <= q.Count; i ++ )
            {
                name = q.Dequeue().ToString();
                // UpTo1PerVehicle
                if ((name == "UpTo1PerVehicle") && (uint.Parse(quantity_string) + db_emsof_requests.NumCompetingEquipmentItems(code, service_id, master_id, priority) > db_services.NumDohLicensedVehiclesOf(service_id)))
                {
                    special_rules_violation = special_rules_violation + "The quantity of the requested items, plus those you\'ve procured from recent EMSOF cycles, exceeds 1 per DOH licensed vehicle." + k.SPACE + k.SPACE;
                // UpTo2PerVehicle
                }
                else if ((name == "UpTo2PerVehicle") && (uint.Parse(quantity_string) + db_emsof_requests.NumCompetingEquipmentItems(code, service_id, master_id, priority) > db_services.NumDohLicensedVehiclesOf(service_id) * 2))
                {
                    special_rules_violation = special_rules_violation + "The quantity of the requested items, plus those you\'ve procured from recent EMSOF cycles, exceeds 2 per DOH licensed vehicle." + k.SPACE + k.SPACE;
                // UpTo5
                }
                else if ((name == "UpTo5") && (uint.Parse(quantity_string) > 5))
                {
                    special_rules_violation = special_rules_violation + "The quantity of the requested items exceeds 5." + k.SPACE + k.SPACE;
                // HasMedicalDirector
                }
                else if ((name == "HasMedicalDirector") && (db_services.MdNameOf(service_id) == k.EMPTY))
                {
                    special_rules_violation = special_rules_violation + "To request this item, your service\'s profile (annual survey) must first specify a Medical Director." + k.SPACE + k.SPACE;
                // UpTo1PerAmbulance
                }
                else if ((name == "UpTo1PerAmbulance") && (uint.Parse(quantity_string) + db_emsof_requests.NumCompetingEquipmentItems(code, service_id, master_id, priority) > db_services.NumAmbulancesOf(service_id)))
                {
                    special_rules_violation = special_rules_violation + "The quantity of the requested items, plus those you\'ve procured from recent EMSOF cycles, exceeds 1 per ambulance." + k.SPACE + k.SPACE;
                }
            }
            result = special_rules_violation;

            return result;
        }

        public void BindDescriptionsOnlyToListControl(object target)
        {
            db_equipment.BindDescriptionsOnlyToListControl(target);
        }

        public void BindListControl(string fy_id, object target)
        {
            db_equipment.BindListControl(fy_id, target);
        }

        public Queue SerialIndicatorData(string indicator, string description)
        {
            Queue result;
            result = db_equipment.SerialIndicatorData(indicator, description);
            return result;
        }

    } // end TClass_biz_equipment

}
