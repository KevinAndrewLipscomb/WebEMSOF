REM
REM $Id$
REM
cd "C:\Inetpub\wwwroot\WebEMSOF"
start /max explorer /e,/select,C:\Inetpub\wwwroot\WebEMSOF\.svn
start /max explorer ftp://kalipso:@frompaper2web.com/ssl/WebEMSOF_x
start /max WebEMSOF.sln
start "" /max "C:\Program Files\MySQL\MySQL Workbench 5.2 CE\MySQLWorkbench.exe"
