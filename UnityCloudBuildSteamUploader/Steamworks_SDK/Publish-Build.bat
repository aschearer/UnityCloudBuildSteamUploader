echo off
set username=%1
set password=%2
set appId=%3
set appScript=%4
set appExe=%5
"%~dp0\builder\steamcmd" +login %username% %password% %appId% "%appExe%" "%appExe%" +run_app_build ..\scripts\%appScript% +quit