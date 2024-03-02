@echo off

echo Optimizing system configuration, please wait...

echo Disabling some services...
sc config DiagTrack start=disabled > NUL 2>&1
sc config dmwappushservice start=disabled > NUL 2>&1
sc config RetailDemo start=disabled > NUL 2>&1
sc config EventSystem start=demand > NUL 2>&1
sc config W32Time start=demand > NUL 2>&1

@REM echo Disabling tasks...
@REM echo Application Experience
@REM schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable > NUL 2>&1
@REM schtasks /change /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /disable > NUL 2>&1
@REM echo Customer Experience Improvement Program
@REM schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable > NUL 2>&1
@REM schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /disable > NUL 2>&1
@REM schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable > NUL 2>&1

echo Disabling telemetry...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f

echo Adjusting for best performance of Windows appearance...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012038010000000 /f
:: Animate controls and elements inside windows | UserPreferencesMask
:: Animate windows when minimizing and maximizing
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics" /V MinAnimate /T REG_SZ /D 0 /F
:: Animations in taskbar
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V TaskbarAnimations /T REG_DWORD /D 0 /F
:: Enable Peek
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V DisablePreviewDesktop /T REG_DWORD /D 0 /F
:: Fade or slide menus into view | UserPreferencesMask
:: Fade or slide Tooltips into view | UserPreferencesMask
:: Fade out menu items after clicking | UserPreferencesMask
:: Show shadows under windows | UserPreferencesMask
:: Save taskbar thumbnail previews
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\DWM" /V AlwaysHibernateThumbnails /T REG_DWORD /D 0 /F
:: Show shadows under mouse pointer | UserPreferencesMask
:: Show thumbnails instead of icons
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V IconsOnly /T REG_DWORD /D 0 /F
:: Show translucent selection rectangle
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V ListviewAlphaSelect /T REG_DWORD /D 0 /F
:: Show window contents while dragging
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop"  /V DragFullWindows /T REG_SZ /D 0 /F
:: Slide open combo boxes | UserPreferencesMask
:: Smooth edges of screen fonts
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop"  /V FontSmoothing /T REG_SZ /D 2 /F
:: Smooth-scroll list boxes | UserPreferencesMask
:: Use drop shadows for icon labels on the desktop
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V ListviewShadow /T REG_DWORD /D 0 /F

echo Changing UAC settings to notify but not dim the desktop...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d "5" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorUser" /t REG_DWORD /d "3" /f

echo Clearing system restore points and setting the maximum size to 1%...
net start VSS
vssadmin delete shadows /all
vssadmin resize shadowstorage /for=C: /on=C: /maxsize=1%%
@REM reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" /v "DisableSR " /t "REG_DWORD" /d "1" /f
net stop VSS

echo Disabling limit reserval bandwidth...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Psched" /v NonBestEffortLimit /t REG_DWORD /d 0 /f

echo Disabling Delivery Optimization...
sc config DoSvc start=disabled > NUL 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DoSvc" /v "Start" /t REG_DWORD /d "4" /f

echo Disabling Windows Defender features...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SpyNetReporting" /t REG_DWORD /d "0" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d "2" /f
powershell -ExecutionPolicy Bypass -NoProfile -NoExit -Command '& {Add-MpPreference -ExclusionPath \"C:\Program Files\Windows Defender\"}'

echo Switching to High Performance power plan...
set Balanced=381b4222-f694-41f0-9685-ff5bb260df2e
set HighPerf=8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
for /f "tokens=2 Delims=:(" %%a in ('powercfg /getactivescheme') do for /f %%b in ("%%a") do set CurrentPlan=%%b
if "%CurrentPlan%"=="%Balanced%" (Powercfg /s "%HighPerf%")

@REM echo Restoring classic context menu... 
@REM reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve

echo Opening privacy settings...
start ms-settings:privacy

echo System optimization complete, please restart the computer to take effect.

echo. & pause