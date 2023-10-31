@echo off

echo Disabling Windows Defender ...

reg add "HKLM\SOFTWARE\Policies\Microsoft\Microsoft Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f

echo Windows Defender disabled !

echo. & pause