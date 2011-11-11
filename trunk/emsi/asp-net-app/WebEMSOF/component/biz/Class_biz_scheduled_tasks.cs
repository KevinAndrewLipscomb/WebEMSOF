using Class_biz_coned_offerings;
using WebEMSOF.component.os;

namespace Class_biz_scheduled_tasks
  {
  public class TClass_biz_scheduled_tasks
    {
    private TClass_biz_coned_offerings biz_coned_offerings;
    private Class_fs fs;

    //Constructor  Create()
    public TClass_biz_scheduled_tasks() : base()
      {
      biz_coned_offerings = new TClass_biz_coned_offerings();
      fs = new Class_fs();
      }

    public void DoDailyChores(string current_working_directory_spec)
      {
      fs.DeleteCondemnedFolders(current_working_directory_spec + "/../protected/attachment");
      }

    public void DoQ20mChores()
      {
      biz_coned_offerings.RetreiveLatestMasterRecords();
      }

    } // end TClass_biz_scheduled_tasks

  }