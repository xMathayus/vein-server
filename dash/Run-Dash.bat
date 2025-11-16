@echo off
setlocal

cd /d "%~dp0"

echo Checking for Python...
py --version >nul 2>&1
if errorlevel 1 (
    echo Python is not installed or not on PATH.
    echo Install Python from https://www.python.org and try again.
    pause
    exit /b
)

echo Installing/Updating Flask (if needed)...
py -m pip install --user flask >nul 2>&1

echo Starting VEIN dashboard...
start "VEIN Dashboard" py app.py

echo Opening dashboard in your browser...
start "" http://127.0.0.1:5000

echo.
echo Dashboard launched. Leave this window open or close it if you want.
pause

endlocal
