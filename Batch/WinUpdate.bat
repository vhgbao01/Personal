@echo off
echo Choose an option:
echo 1. Disable Windows Update
echo 2. Enable Windows Update
set /p option=Enter option number:

if "%option%"=="1" (
    call :disableUpdate
) else if "%option%"=="2" (
    call :enableUpdate
) else (
    echo Invalid option. Please enter 1 or 2.
    pause
    exit /b
)

:disableUpdate
echo Disabling Windows Update...

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f >nul 2>&1

echo Windows Update has been disabled.
pause
exit /b

:enableUpdate
echo Enabling Windows Update...

reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /f >nul 2>&1

echo Windows Update has been enabled.
pause
exit /b
