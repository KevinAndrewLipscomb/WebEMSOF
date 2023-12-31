@REM
@REM $Id: deploy.bat 3074 2010-02-23 15:56:34Z KevinAnLipscomb $
@REM
@rmdir ready-to-deploy /s /q
@REM      sourcedir---------------------------------------------------destdir-----------------------------------------[files]---quals---------filter--------
@robocopy C:\Inetpub\wwwroot\WebEMSOF                                 ready-to-deploy                                 *.asax    /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF                                 ready-to-deploy                                 *.aspx    /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF                                 ready-to-deploy                                 *.pdf     /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\bin                             ready-to-deploy\bin                             *.dll     /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\bin                             ready-to-deploy\bin                             *.pdb     /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\bin                             ready-to-deploy\bin                             *.TTF     /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\css                             ready-to-deploy\css                                       /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\image                           ready-to-deploy\image                                     /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\js                              ready-to-deploy\js                                        /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\noninteractive                  ready-to-deploy\noninteractive                  *.crontab /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\noninteractive                  ready-to-deploy\noninteractive                  *.aspx    /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\protected                       ready-to-deploy\protected                       *.asax    /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\protected                       ready-to-deploy\protected                       *.aspx    /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\protected                       ready-to-deploy\protected                       *.config  /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\protected\image                 ready-to-deploy\protected\image                           /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\protected\template\notification ready-to-deploy\protected\template\notification           /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\resource                        ready-to-deploy\resource                                  /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\template\notification           ready-to-deploy\template\notification                     /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\usercontrol\app                 ready-to-deploy\usercontrol\app                 *.ascx    /m /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\usercontrol\ki                  ready-to-deploy\usercontrol\ki                  *.ascx    /A /np /ns /z | qgrep "New "
@robocopy C:\Inetpub\wwwroot\WebEMSOF\usercontrol\ki\image            ready-to-deploy\usercontrol\ki\image                      /A /np /ns /z | qgrep "New "
@pause