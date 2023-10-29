
@echo off

echo Cleaning system junk files, please wait

del /f /s /q %systemdrive%\*.tmp
del /f /s /q %systemdrive%\*._mp
del /f /s /q %systemdrive%\*.log
del /f /s /q %systemdrive%\*.gid
del /f /s /q %systemdrive%\*.chk
del /f /s /q %systemdrive%\*.old

del /f /s /q %windir%\*.bak

del /f /s /q %windir%\prefetch\*.*
del /f /s /q %temp%\*.* && FOR /D %%p IN ("%temp%\*.*") DO rmdir "%%p" /s /q
del /f /s /q %windir%\temp\*.* && FOR /D %%p IN ("%windir%\temp\*.*") DO rmdir "%%p" /s /q

del /f /q %userprofile%\cookies\*.*
del /f /q %userprofile%\recent\*.*
del /f /s /q “%userprofile%\Local Settings\Temporary Internet Files\*.*”
del /f /s /q “%userprofile%\Local Settings\Temp\*.*”
del /f /s /q “%userprofile%\recent\*.*”

net stop bits
net stop wuauserv
net stop cryptsvc   
del /s /q /f %SystemRoot%\SoftwareDistribution\*.* && FOR /D %%p IN ("%SystemRoot%\SoftwareDistribution\*.*") DO rmdir "%%p" /s /q
net start bits
net start wuauserv
net start cryptsvc

netsh windsock reset
netsh int ip reset
netsh int tcp reset
ipconfig /release
ipconfig /flushdns
ipconfig /renew
ipconfig /registerdns
netsh interface ipv4 reset
netsh interface ipv6 reset
netsh windsock reset catalog
netsh int ipv4 reset reset.log
netsh int ipv6 reset reset.log

echo Cleaning of junk files is finished!

echo. & pause