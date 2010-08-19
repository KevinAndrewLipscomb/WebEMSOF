@REM $Id$
@REM
set the_host=localhost
set the_user=root
if "%1"=="x" set the_host=elm.phpwebhosting.com
if "%1"=="x" set the_user=kalipso5
echo on
mysql --host=%the_host% --user=%the_user% --password=%2 --execute="drop schema emsidb_%1"
mysql --host=%the_host% --user=%the_user% --password=%2 --execute="create schema emsidb_%1"
mysql --host=%the_host% --user=%the_user% --password=%2 --database=emsidb_%1 <"%USERPROFILE%\my-documents\SANDBOX\vocational\kalipso-infogistics\db-dump\emsidb.sql"
mysql --host=%the_host% --user=%the_user% --password=%2 --database=emsidb_%1 <0-render-safe-for-d-or-x.sql
