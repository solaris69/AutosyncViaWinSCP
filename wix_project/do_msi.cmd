@echo off
IF EXIST winscp ( rd /s /q winscp )
mkdir winscp

copy ..\winscp556\WinSCP.exe winscp
copy ..\winscp556\WinSCP.com winscp
copy ..\winscp556\get_ldap.cmd winscp
copy ..\winscp556\get_ldap.txt winscp

IF EXIST winscp.wxs ( del /F winscp.wxs )
IF EXIST AutosyncLDAP.wxs ( del /F AutosyncLDAP.wxs )
copy AutosyncLDAP.wxs.template AutosyncLDAP.wxs
copy AutosyncLDAP.ico winscp

SET wixbin="D:\WiX Toolset v3.9\bin"
SET workingdir="%~dp0PS1MonService"
SET wixobj="%~dp0PS1MonService\*.wixobj"
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