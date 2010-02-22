using System;
using System.IO;

namespace WebEMSOF.component.os
  {
  public static class Class_os_Static
    {
    public const string WWWROOT = "c:\\inetpub\\wwwroot\\";
    }

  public class Class_fs
    {
    //public void CopyTemplatesToTarget
    //  (
    //  string app_name,
    //  string table_name
    //  )
    //  {
    //  System.IO.File.Copy(Class_os_Static.WWWROOT + "KiAspdotnetFramework\\component\\biz\\Class_biz_template_kicrudhelped_items.cs-template", Class_os_Static.WWWROOT + app_name + "\\component\\biz\\Class_biz_" + table_name + "s.cs", true);
    //  System.IO.File.Copy(Class_os_Static.WWWROOT + "KiAspdotnetFramework\\component\\db\\Class_db_template_kicrudhelped_items.cs-template", Class_os_Static.WWWROOT + app_name + "\\component\\db\\Class_db_" + table_name + "s.cs", true);
    //  System.IO.File.Copy(Class_os_Static.WWWROOT + "KiAspdotnetFramework\\dbscript\\create-table-template-kicrudhelped-item.sql-template", Class_os_Static.WWWROOT + app_name + "\\dbscript\\create-table-" + table_name + ".sql", true);
    //  System.IO.File.Copy(Class_os_Static.WWWROOT + "KiAspdotnetFramework\\usercontrol\\app\\UserControl_template_kicrudhelped_item.ascx-template", Class_os_Static.WWWROOT + app_name + "\\usercontrol\\app\\UserControl_" + table_name + ".ascx", true);
    //  System.IO.File.Copy(Class_os_Static.WWWROOT + "KiAspdotnetFramework\\usercontrol\\app\\UserControl_template_kicrudhelped_item.ascx.cs-template", Class_os_Static.WWWROOT + app_name + "\\usercontrol\\app\\UserControl_" + table_name + ".ascx.cs", true);
    //  System.IO.File.Copy(Class_os_Static.WWWROOT + "KiAspdotnetFramework\\usercontrol\\app\\UserControl_template_kicrudhelped_item.ascx.designer.cs-template", Class_os_Static.WWWROOT + app_name + "\\usercontrol\\app\\UserControl_" + table_name + ".ascx.designer.cs", true);
    //  }

    internal void PurgeDanglingAttachments(string path)
      {
      var flag_file_spec_array = Directory.GetFiles(path,".webemsof_noninteractive_delete_pending",SearchOption.AllDirectories);
      foreach (var flag_file_spec in flag_file_spec_array)
        {
        Directory.Delete(Path.GetDirectoryName(flag_file_spec),true);
        }
      }
    }
  }
