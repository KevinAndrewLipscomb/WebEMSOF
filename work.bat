REM
REM $Id$
REM
cd "C:\Inetpub\wwwroot\WebEMSOF"
start /max explorer /e,/select,C:\Inetpub\wwwroot\WebEMSOF\.svn
start "" /max "C:\Program Files\WinSCP\WinSCP.exe" alentus.com/ssl/WebEMSOF_x
start "" /max "C:\Program Files\WinSCP\WinSCP.exe" aplus.net/WebEMSOF/
start /max WebEMSOF.sln
start "" /max "C:\Program Files\MySQL\MySQL Tools for 5.0\MySQLQueryBrowser.exe"
