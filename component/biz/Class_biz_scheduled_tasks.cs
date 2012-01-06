using Class_biz_coned_offerings;
using Class_biz_teaching_entities;
using Class_biz_practitioners;
using WebEMSOF.component.os;

namespace Class_biz_scheduled_tasks
  {
  public class TClass_biz_scheduled_tasks
    {
    private TClass_biz_coned_offerings biz_coned_offerings;
    private TClass_biz_practitioners biz_practitioners;
    private TClass_biz_teaching_entities biz_teaching_entities;
    private Class_fs fs;

    //Constructor  Create()
    public TClass_biz_scheduled_tasks() : base()
      {
      biz_coned_offerings = new TClass_biz_coned_offerings();
      biz_teaching_entities = new TClass_biz_teaching_entities();
      biz_practitioners = new TClass_biz_practitioners();
      fs = new Class_fs();
      }

    public void DoDailyChores(string current_working_directory_spec)
      {
      fs.DeleteCondemnedFolders(current_working_directory_spec + "/../protected/attachment");
      }

    public void ImportLatestConedOfferingsFromEmsrs()
      {
      biz_coned_offerings.ImportLatestFromEmsrs();
      }

    public void ImportLatestTeachingEntitiesFromEmsrs()
      {
      biz_teaching_entities.ImportLatestFromEmsrs();
      biz_teaching_entities.SyncConedSponsorAccounts();
      }

    public void ImportLatestPractitionersFromEmsrs()
      {
      biz_practitioners.ImportLatestFromEmsrs();
      }

    } // end TClass_biz_scheduled_tasks

  }