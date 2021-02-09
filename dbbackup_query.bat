#!/bin/bash
@echo off

set dbUser=ulink
set dbPassword=ulink
set mysqlDataDir="C:\Program Files\MySQL\MySQL Server 5.7\bin\mysql.exe"
set path="C:\Users\TestClientPC\Desktop\Database Script\querybatch.sql"

:: get date
for /F "tokens=2-4 delims=/ " %%i in ('date /t') do (
	set mm=%%i
	set dd=%%j
	set yy=%%k
)

if %mm%==01 set Month="Jan"
if %mm%==02 set Month="Feb"
if %mm%==03 set Month="Mar"
if %mm%==04 set Month="Apr"
if %mm%==05 set Month="May"
if %mm%==06 set Month="Jun"
if %mm%==07 set Month="Jul"
if %mm%==08 set Month="Aug"
if %mm%==09 set Month="Sep"
if %mm%==10 set Month="Oct"
if %mm%==11 set Month="Nov"
if %mm%==12 set Month="Dec"

set mysqlscript="C:\Users\TestClientPC\Desktop\Database Script\Result\ulinkObservation_%dd%-%Month%-%yy%.csv"

::Make connection
%mysqldump% --host="localhost" --user=%dbUser% --password=%dbPassword% --database ulinkdb-phase2 < %path% > %mysqlscript%

exit
@echo Done Successfully
