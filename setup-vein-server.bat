@echo off
setlocal

set "SCRIPT=%~dp0.Installer.ps1"

if not exist "%SCRIPT%" (
    echo ERROR: "%SCRIPT%" not found.
    echo Make sure .Installer.ps1 is in the same folder as this bat file.
    echo.
    pause
    exit /b 1
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT%"

echo.
echo (If you can still see this window, press any key to close it.)
pause >nul
endlocal
