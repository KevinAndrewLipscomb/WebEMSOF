REM
REM $Id$
REM
cd "C:\Inetpub\wwwroot\WebEMSOF"
start /max WebEMSOF.bdsproj
start /max explorer /e,/select,C:\Inetpub\wwwroot\WebEMSOF\.svn
start /max ftp://ftp.frompaper2web.com/ssl/WebEMSOF
