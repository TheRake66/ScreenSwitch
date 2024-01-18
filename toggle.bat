:: ==========================================================
::
:: READ THIS PLEASE.
::
:: ----------------------------------------------------------
::
:: You must indicate the video ports to exchange on.
::
:: To find them, run "ControlMyMonitor.exe" and find the line with the value "60" in the "VCP Code" column.
::
:: On this same line, the value of the "Current Value" column corresponds to the Windows video port.
::
:: The values present in the "Possible values" column correspond to the video ports on your screen.
::
:: Test with each value until you find the right one.
::
:: When you have found the right value, put it just below.
::
:: ----------------------------------------------------------
::
:: You can set a keyboard shortcut to switch between ports.
::
:: "Right click" on this script.
::
:: Hover the cursor over "Send to >".
::
:: Click on "Desktop (create shortcut)".
::
:: When the shortcut is created, "Right click" on this shortcut.
::
:: Click on "Properties".
::
:: Click  on "Shortcut key".
::
:: And press the key you want to make as a shortcut.
::
:: You can also rename it "ScreenSwitch".
::
:: You can click on "Change icon..." to put the logo present in the script.
::
:: ==========================================================

set "first_port="
set "second_port="

:: ==========================================================


@echo off
title ScreenSwitch
cls

if not defined first_port (
    call :editScript
    exit
)

if not defined second_port (
    call :editScript
    exit
)

cd /d "%~dp0"

ControlMyMonitor.exe /GetValue Primary 60
if %errorlevel% equ %first_port% (
    set "target_port=%second_port%"
    set "message=Switching to the second video port..."
) else (
    set "target_port=%first_port%"
    set "message=Switching to the first video port..."
)

call :changeInput %message% %target_port%
timeout /nobreak /t 5 > nul
exit

:editScript
echo You must specify the video ports.
notepad.exe "%~dp0%~nx0"
goto :eof

:changeInput
echo %1
ControlMyMonitor.exe /SetValue Primary 60 %2
goto :eof