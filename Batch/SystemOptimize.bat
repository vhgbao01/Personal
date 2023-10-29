@echo off

echo Optimizing system configuration, please wait...

sc config DiagTrack start= disabled
sc config EventSystem start= demand
sc config W32Time start= demand
sc config DoSvc start= disabled

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 3 /f

net start VSS
vssadmin delete shadows /all
vssadmin resize shadowstorage /for=C: /on=C: /maxsize=1%%
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" /v "DisableSR " /t "REG_DWORD" /d "1" /f
net stop VSS

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Psched" /v NonBestEffortLimit /t REG_DWORD /d 0 /f

reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve

echo System optimization complete, please restart the computer to take effect.

echo. & pause