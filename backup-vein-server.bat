@echo off
setlocal EnableDelayedExpansion

:: ================================
:: VEIN Server Backup Manager (Windows, simple)
:: Manual backup + restore only
:: ================================

goto :Start

:: ---------------------------
:: SUB: recompute SAVE_PARENT / SAVE_BASENAME
:: ---------------------------
:RecomputeSaveDirParts
for %%d in ("%SAVE_DIR%") do (
    set "SAVE_PARENT=%%~dpd"
    set "SAVE_BASENAME=%%~nxd"
)
goto :EOF

:: SUB: build backup list (folders)
:BuildBackupList
set /a BACKUP_COUNT=0
for /f "delims=" %%f in ('dir /b /ad "%BACKUP_DIR%" 2^>nul') do (
    set /a BACKUP_COUNT+=1
    set "BACKUP_!BACKUP_COUNT!=%%f"
)
goto :EOF

:: SUB: timestamp
:GetTimestamp
for /f %%a in ('powershell -NoProfile -Command "(Get-Date).ToString('yyyy-MM-dd_HH-mm-ss')"') do set "TIMESTAMP=%%a"
goto :EOF

:: ---------------------------
:: SUB: restore from a specific backup folder
:: arg1 = folder name under BACKUP_DIR
:: ---------------------------
:DoRestore
set "BACKNAME=%~1"
set "BACKPATH=%BACKUP_DIR%\%BACKNAME%"

if not exist "%BACKPATH%" (
    echo [ERROR] Backup folder not found:
    echo   "%BACKPATH%"
    echo.
    pause
    goto :EOF
)

echo.
echo Checking for running VeinServer.exe...
tasklist /FI "IMAGENAME eq VeinServer.exe" | find /I "VeinServer.exe" >nul
if not errorlevel 1 (
    echo Found running VeinServer.exe - killing process...
    taskkill /IM VeinServer.exe /F >nul 2>&1
) else (
    echo VeinServer.exe not running.
)

:: Pre-restore backup of current save
if exist "%SAVE_DIR%" (
    call :GetTimestamp
    set "preDir=%BACKUP_DIR%\pre_restore_%TIMESTAMP%"
    echo.
    echo Creating pre-restore backup in:
    echo   "%preDir%"
    mkdir "%preDir%" >nul 2>&1
    robocopy "%SAVE_DIR%" "%preDir%" /E /R:2 /W:2 >nul
)

:: Remove current save dir
if exist "%SAVE_DIR%" (
    echo.
    echo Removing current save directory:
    echo   "%SAVE_DIR%"
    rmdir /s /q "%SAVE_DIR%"
)

:: Recreate save dir + restore files
echo.
echo Restoring from:
echo   "%BACKPATH%"
mkdir "%SAVE_DIR%" >nul 2>&1
robocopy "%BACKPATH%" "%SAVE_DIR%" /MIR /R:2 /W:2 >nul
set "RC=%ERRORLEVEL%"
if %RC% GEQ 8 (
    echo [ERROR] robocopy returned error code %RC%.
) else (
    echo [OK] Restore completed.
)

echo.
if exist "%START_BAT%" (
    set "restart="
    set /p "restart=Start server now? (y/n): "
    if /I "%restart%"=="y" (
        echo Launching server...
        start "" "%START_BAT%"
    )
)

echo.
pause
goto :EOF

:: ================================
:: MAIN START
:: ================================
:Start
set "BASE_DIR=%~dp0"

:: Default paths (you can change these later from menu option 3)
set "SAVE_DIR=%BASE_DIR%vein-server\Vein\Saved\SaveGames"
set "BACKUP_DIR=%BASE_DIR%vein-server-backups"
set "START_BAT=%BASE_DIR%vein-server\Start-VeinServer.bat"

if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%" >nul 2>&1

call :RecomputeSaveDirParts

:MainMenu
cls
echo =======================================
echo      VEIN Server Backup Manager
echo =======================================
echo.
echo Save dir   : "%SAVE_DIR%"
echo Backups dir: "%BACKUP_DIR%"
echo.
echo  1^) Manual backup
echo  2^) Restore from backup
echo  3^) Configure paths
echo  4^) Exit
echo.
set "choice="
set /p "choice=Select option [1-4]: "

if "%choice%"=="1" goto ManualBackup
if "%choice%"=="2" goto RestoreMenu
if "%choice%"=="3" goto ConfigurePaths
if "%choice%"=="4" goto ExitOK

echo Invalid option.
pause
goto MainMenu

:: ---------------------------
:: Manual Backup
:: ---------------------------
:ManualBackup
cls
echo ========= Manual Backup =========
echo.
call :GetTimestamp
set "defaultName=backup_%TIMESTAMP%"
set "backupName="
set /p "backupName=Backup name [%defaultName%]: "
if not defined backupName set "backupName=%defaultName%"

if not exist "%SAVE_DIR%" (
    echo [ERROR] Save directory does not exist:
    echo   "%SAVE_DIR%"
    echo.
    pause
    goto MainMenu
)

set "backupDest=%BACKUP_DIR%\%backupName%"

if exist "%backupDest%" (
    echo.
    echo Backup folder "%backupName%" already exists.
    set "ovr="
    set /p "ovr=Override? (y/n): "
    if /I not "%ovr%"=="y" (
        echo Backup cancelled.
        pause
        goto MainMenu
    )
    rmdir /s /q "%backupDest%"
)

echo.
echo Creating backup at:
echo   "%backupDest%"
echo This may take a while for large saves...
echo.

mkdir "%backupDest%" >nul 2>&1
robocopy "%SAVE_DIR%" "%backupDest%" /E /R:2 /W:2
set "RC=%ERRORLEVEL%"
if %RC% GEQ 8 (
    echo [ERROR] robocopy returned error code %RC%.
) else (
    echo [OK] Backup created successfully.
)

echo.
pause
goto MainMenu

:: ---------------------------
:: Restore Menu
:: ---------------------------
:RestoreMenu
cls
echo ========= Restore Backup =========
echo.
call :BuildBackupList
if !BACKUP_COUNT! EQU 0 (
    echo No backup folders found in:
    echo   "%BACKUP_DIR%"
    echo.
    pause
    goto MainMenu
)

for /L %%i in (1,1,!BACKUP_COUNT!) do (
    set "F=!BACKUP_%%i!"
    echo %%i^) !F!
)
echo 0^) Cancel
echo.
set "sel="
set /p "sel=Select backup [number]: "

if "%sel%"=="0" goto MainMenu

:: basic numeric check
for /f "delims=0123456789" %%x in ("%sel%") do (
    echo Invalid selection.
    pause
    goto RestoreMenu
)

if %sel% LEQ 0 goto RestoreMenu
if %sel% GTR !BACKUP_COUNT! goto RestoreMenu

set "SELECTED=!BACKUP_%sel%!"
cls
echo You selected backup folder:
echo   "%SELECTED%"
echo.
set "confirm="
set /p "confirm=Are you sure you want to restore this backup? (y/n): "
if /I not "%confirm%"=="y" goto MainMenu

call :DoRestore "%SELECTED%"
goto MainMenu

:: ---------------------------
:: Configure Paths
:: ---------------------------
:ConfigurePaths
cls
echo ========= Configure Paths =========
echo.
echo Current backup directory:
echo   %BACKUP_DIR%
echo.
set "tmp="
set /p "tmp=New backup directory (leave blank to keep): "
if defined tmp set "BACKUP_DIR=%tmp%"

echo.
echo Current save directory:
echo   %SAVE_DIR%
echo.
set "tmp="
set /p "tmp=New save directory (leave blank to keep): "
if defined tmp set "SAVE_DIR=%tmp%"

if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%" >nul 2>&1

call :RecomputeSaveDirParts

echo.
echo Settings updated.
echo.
pause
goto MainMenu

:: ---------------------------
:: Exit
:: ---------------------------
:ExitOK
echo.
echo Exiting VEIN Backup Manager.
echo.
pause
endlocal
exit /b 0
