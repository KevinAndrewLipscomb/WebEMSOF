@REM
@REM $Id$
@REM
@rmdir ready-to-deploy /s /q
@xcopy C:\Inetpub\wwwroot\WebEMSOF\*.asax ready-to-deploy /m /i /k /y /z
@xcopy C:\Inetpub\wwwroot\WebEMSOF\*.aspx ready-to-deploy /m /i /k /y /z
@xcopy C:\Inetpub\wwwroot\WebEMSOF\*.pdf ready-to-deploy /m /i /k /y /z
@xcopy C:\Inetpub\wwwroot\WebEMSOF\bin\*.dll ready-to-deploy\bin /m /i /k /y /z
@xcopy C:\Inetpub\wwwroot\WebEMSOF\protected\*.asax ready-to-deploy /m /i /k /y /z
@xcopy C:\Inetpub\wwwroot\WebEMSOF\protected\*.aspx ready-to-deploy /m /i /k /y /z
@xcopy "C:\Program Files\Common Files\Borland Shared\BDS\Shared Assemblies\4.0\Borland.Data.Provider.dll" ready-to-deploy\bin /m /i /k /y /z
@xcopy "C:\Program Files\Common Files\Borland Shared\BDS\Shared Assemblies\4.0\Borland.Data.Common.dll" ready-to-deploy\bin /m /i /k /y /z
@xcopy "C:\Program Files\CoreLab\Bdp\MySql\BDS4\CoreLab.Bdp.MySql.dll" ready-to-deploy\bin /m /i /k /y /z
