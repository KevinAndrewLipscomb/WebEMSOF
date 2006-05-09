@REM
@REM $Id$
@REM
@xcopy C:\Inetpub\wwwroot\WebEMSOF\*.asax x:\ssl\WebEMSOF /d /i /k /y /z
@xcopy C:\Inetpub\wwwroot\WebEMSOF\*.aspx x:\ssl\WebEMSOF /d /i /k /y /z
@xcopy C:\Inetpub\wwwroot\WebEMSOF\bin\*.dll x:\ssl\WebEMSOF\bin /d /i /k /y /z
@xcopy "C:\Program Files\Common Files\Borland Shared\BDS\Shared Assemblies\4.0\Borland.Data.Provider.dll" x:\ssl\WebEMSOF\bin /d /i /k /y /z
@xcopy "C:\Program Files\Common Files\Borland Shared\BDS\Shared Assemblies\4.0\Borland.Data.Common.dll" x:\ssl\WebEMSOF\bin /d /i /k /y /z
@xcopy "C:\Program Files\CoreLab\Bdp\MySql\BDS4\CoreLab.Bdp.MySql.dll" x:\ssl\WebEMSOF\bin /d /i /k /y /z
