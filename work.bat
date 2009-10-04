REM
REM $Id$
REM
cd "C:\Inetpub\wwwroot\WebEMSOF"
start /max explorer /e,/select,C:\Inetpub\wwwroot\WebEMSOF\.svn
start "" /max "C:\Program Files\FileZilla FTP Client\filezilla.exe" --site=0/ftp.frompaper2web.com\/ssl/WebEMSOF_x
start "" /max "C:\Program Files\FileZilla FTP Client\filezilla.exe" --site=0/frompaper2web.win.aplus.net\/WWWROOT/WebEMSOF/
start /max WebEMSOF.sln
start "" /max "C:\Program Files\MySQL\MySQL Tools for 5.0\MySQLQueryBrowser.exe"
