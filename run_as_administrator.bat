@echo off
title DKjunkie's PC Optimization Console
mode con: cols=70 lines=20

echo ---- Performing PC Optimization ----

REM Clear temporary files
echo Clearing temporary files...
del /q /f /s "%TEMP%\*.*"
del /q /f /s "%USERPROFILE%\AppData\Local\Temp\*.*"

REM Clean up disk space
echo Cleaning up disk space...
cleanmgr /sagerun:1

REM Disable unnecessary startup programs
echo Disabling unnecessary startup programs...
for /f "skip=2 delims='=' tokens=2" %%A in ('wmic startup listfull ^| findstr /c:"HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run"') do (
    reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "%%A" /f >nul 2>&1
)

for /f "skip=2 delims='=' tokens=2" %%B in ('wmic startup listfull ^| findstr /c:"HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run"') do (
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "%%B" /f >nul 2>&1
)

REM Disable unnecessary services
echo Disabling unnecessary services...
sc config "wuauserv" start=disabled
sc config "BITS" start=disabled
sc config "Fax" start=disabled
sc config "Print Spooler" start=disabled

echo ---- Optimization completed! ----
echo ""
echo ---- press any key to run file check  ----
echo ---- it checks if theres a corruption ----

pause
echo ---- checking files ----

sfc /scannow
echo ---- scan completed ----
echo ---- next up driver check ----
echo ---- press any key to start ----
pause
echo ---- opening driver check ----
sigverif
echo ---- check completed ----
echo ---- next up simple virus check ----
echo ---- its recommended to use malwarebytes
echo ---- press any key to start ----
pause
mrt
pause