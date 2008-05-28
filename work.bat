REM
REM $Id$
REM
cd "C:\Inetpub\wwwroot\WebEMSOF"
start /max explorer /e,/select,C:\Inetpub\wwwroot\WebEMSOF\.svn
start /max explorer ftp://ftp.frompaper2web.com/ssl/WebEMSOF_x
start /max WebEMSOF.dproj
start "" /max "C:\Program Files\MySQL\MySQL Tools for 5.0\MySQLQueryBrowser.exe"
