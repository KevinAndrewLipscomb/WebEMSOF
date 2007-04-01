@REM
@REM $Id$
@REM
@rmdir ready-to-deploy /s /q
@REM      sourcedir----------------------------------------------------------------destdir-----------------------------------------[files]-------------------quals---------filter--------
@robocopy C:\Inetpub\wwwroot\WebEMSOF                                              ready-to-deploy                                 *.asax                    /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF                                              ready-to-deploy                                 *.aspx                    /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF                                              ready-to-deploy                                 *.config                  /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF                                              ready-to-deploy                                 *.pdf                     /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\bin                                          ready-to-deploy\bin                                                       /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\noninteractive                               ready-to-deploy\noninteractive                  *.crontab                 /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\noninteractive                               ready-to-deploy\noninteractive                  *.aspx                    /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\protected                                    ready-to-deploy\protected                       *.asax                    /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\protected                                    ready-to-deploy\protected                       *.aspx                    /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\protected                                    ready-to-deploy\protected                       *.config                  /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\protected\image                              ready-to-deploy\protected\image                                           /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\protected\template\notification              ready-to-deploy\protected\template\notification                           /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\resource                                     ready-to-deploy\resource                                                  /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\usercontrol\app                              ready-to-deploy\usercontrol\app                 *.ascx                    /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\usercontrol\ki                               ready-to-deploy\usercontrol\ki                  *.ascx                    /A /np /ns /z | qgrep "New "
@robocopy "C:\Program Files\Common Files\Borland Shared\BDS\Shared Assemblies\4.0" ready-to-deploy\bin                             Borland.Data.Provider.dll /m /np /ns /z | qgrep "New "
@robocopy "C:\Program Files\Common Files\Borland Shared\BDS\Shared Assemblies\4.0" ready-to-deploy\bin                             Borland.Data.Common.dll   /m /np /ns /z | qgrep "New "
@robocopy "C:\Program Files\Common Files\Borland Shared\BDS\Shared Assemblies\4.0" ready-to-deploy\bin                             Borland.Delphi.dll        /m /np /ns /z | qgrep "New "
@robocopy "C:\Program Files\CoreLab\Bdp\MySql\BDS4"                                ready-to-deploy\bin                             CoreLab.Bdp.MySql.dll     /m /np /ns /z | qgrep "New "
@pause