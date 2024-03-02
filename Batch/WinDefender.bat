@echo off
echo Choose an option:
echo 1. Disable Windows Defender
echo 2. Enable Windows Defender
set /p option=Enter option number:

if "%option%"=="1" (
    call :disableDefender
) else if "%option%"=="2" (
    call :enableDefender
) else (
    echo Invalid option. Please enter 1 or 2.
    pause
    exit /b
)

:disableDefender
echo Disabling Windows Defender...

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f >nul 2>&1

echo Windows Defender has been disabled.
pause
exit /b

:enableDefender
echo Enabling Windows Defender...

reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /f >nul 2>&1

echo Windows Defender has been enabled.
pause
exit /b
