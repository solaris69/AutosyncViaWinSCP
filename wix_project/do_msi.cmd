@echo off
IF EXIST AutosyncLDAP ( rd /s /q AutosyncLDAP )
mkdir AutosyncLDAP

copy ..\winscp556\WinSCP.exe AutosyncLDAP
copy ..\winscp556\WinSCP.com AutosyncLDAP
copy ..\winscp556\get_ldap.cmd AutosyncLDAP
copy ..\winscp556\get_ldap.txt AutosyncLDAP

IF EXIST winscp.wxs ( del /F winscp.wxs )
IF EXIST AutosyncLDAP.wxs ( del /F AutosyncLDAP.wxs )
copy AutosyncLDAP.wxs.template AutosyncLDAP.wxs
copy AutosyncLDAP.ico AutosyncLDAP

SET wixbin="D:\WiX Toolset v3.9\bin"
SET workingdir="%~dp0AutosyncLDAP"
SET wixobj="%~dp0AutosyncLDAP\*.wixobj"
SET heatfile="%~dp0winscp.wxs"
SET mainfile="%~dp0AutosyncLDAP.wxs"
SET msifile="%~dp0AutosyncLDAP-%1.msi"
SET fnrdir="%~dp0fnr.exe"
SET wixfile="%~dp0"
pushd %wixbin%
ECHO Gen Group folder
heat.exe dir %workingdir% -o %heatfile% -cg BinaryGroup -sfrag -gg -g1
%fnrdir% --cl --dir %wixfile:~0,-2%" --fileMask "AutosyncLDAP.wxs" --find "@MAJORVERSION@" --replace "%1"
candle.exe %heatfile% %mainfile% -o %workingdir:~0,-1%\\"
light.exe -b %workingdir% -out %msifile% %wixobj%
popd