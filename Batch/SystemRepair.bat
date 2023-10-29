
@echo off

echo Repairing system image, please wait

DISM /Online /Cleanup-Image /CheckHealth

DISM /Online /Cleanup-Image /ScanHealth

DISM /Online /Cleanup-Image /RestoreHealth

SFC /scannow

echo System repair is finished!

echo. & pause