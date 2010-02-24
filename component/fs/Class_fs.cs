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
    internal void PurgeDanglingAttachments(string path)
      {
      var flag_file_spec_array = Directory.GetFiles(path,"noninteractive_delete_pending.kaf",SearchOption.AllDirectories);
      foreach (var flag_file_spec in flag_file_spec_array)
        {
        try
          {
          Directory.Delete(Path.GetDirectoryName(flag_file_spec),true);
          }
        catch (IOException)
          {
          }
        }
      }
    }
  }
