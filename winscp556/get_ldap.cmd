@echo off
if exist %1 (
del -f %1
)
WinSCP.com /ini=WinSCP.ini /script=get_ldap.txt /log=%1
SET winscp_res=%ERRORLEVEL%
copy D:\LDAP\ldapdailydelta.txt D:\_CodeCopyArea\PentahoFlow\config
rem exit %winscp_res%
echo %winscp_res%