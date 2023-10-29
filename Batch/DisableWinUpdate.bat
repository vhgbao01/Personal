@echo off

echo Disabling Windows Update ...

net stop wuauserv

sc config "wuauserv" start=disabled

echo Windows Update disabled !

echo. & pause