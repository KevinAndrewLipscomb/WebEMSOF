using System;
using Class_db_payment_proof_methods;
namespace Class_biz_payment_proof_methods
{
    public class TClass_biz_payment_proof_methods
    {
        private TClass_db_payment_proof_methods db_payment_proof_methods = null;
        //Constructor  Create()
        public TClass_biz_payment_proof_methods() : base()
        {
            // TODO: Add any constructor code here
            db_payment_proof_methods = new TClass_db_payment_proof_methods();
        }
        public void BindListControl(object target)
        {
            db_payment_proof_methods.BindListControl(target);
        }

    } // end TClass_biz_payment_proof_methods

}
