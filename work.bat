REM
REM $Id$
REM
cd "C:\Inetpub\wwwroot\WebEMSOF"
start /max explorer /e,/select,C:\Inetpub\wwwroot\WebEMSOF\.svn
start /max explorer ftp://kalipso:@frompaper2web.com/ssl/WebEMSOF_x
start /max explorer ftp://frompaper2web:@frompaper2web.win.aplus.net/WWWROOT/WebEMSOF/
start /max WebEMSOF.sln
start "" /max "C:\Program Files\MySQL\MySQL Workbench 5.2 OSS\MySQLWorkbench.exe"
