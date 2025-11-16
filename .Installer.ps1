$ErrorActionPreference = 'Stop'

# ========= BASIC SETTINGS (edit these) =========

$SERVER_NAME        = "My New VEIN Server"
$SERVER_DESC        = "Vanilla Server"
$PUBLIC             = "True"          # "True" or "False"
$MAX_PLAYERS        = 16
$PASSWORD           = ""              # "" = no password
$PORT               = 7777
$QUERY_PORT         = 27015
$VAC_ENABLED        = 0               # 0 = off, 1 = on
$HEARTBEAT_INTERVAL = 5.0
$BIND_ADDR          = "0.0.0.0"

# SteamID64s – put your IDs here (or leave empty)
# Example: $SUPER_ADMIN_IDS = @("765123123123123")
$SUPER_ADMIN_IDS = @()
$ADMIN_IDS       = @()
$WHITELIST_IDS   = @()               # if any entries exist, only these can join (0.023+)

# ServerSettings
$SHOW_SCOREBOARD_BADGES = 1          # 1 = show admin badges, 0 = hide

# Engine.ini / console variables
$PVP_ENABLED     = $true
$AI_ENABLED      = $true
$TIME_MULTIPLIER = 16

# ========= INSTALL PATHS (relative to this script) =========

$BaseDir      = Split-Path -Parent $MyInvocation.MyCommand.Path
$INSTALL_PATH = Join-Path $BaseDir "vein-server"
$STEAMCMD_DIR = Join-Path $BaseDir "steamcmd"
$LOG_FILE     = Join-Path $BaseDir "vein-install.log"

"==== $(Get-Date) ==== Starting installer" | Out-File -FilePath $LOG_FILE -Encoding UTF8

function Log([string]$msg) {
    $msg | Tee-Object -FilePath $LOG_FILE -Append
}

function BuildIdLines([string]$Key, [string[]]$Ids) {
    if (-not $Ids -or $Ids.Count -eq 0) { return "" }

    $lines = @()
    $first = $true
    foreach ($id in $Ids) {
        if (-not $id -or $id.Trim() -eq "") { continue }
        if ($first) {
            $lines += "$Key=$id"
            $first = $false
        } else {
            $lines += "+$Key=$id"
        }
    }

    if ($lines.Count -eq 0) { return "" }
    return ($lines -join "`r`n")
}

try {
    Clear-Host
    Log "Base dir: $BaseDir"
    Log "Install dir: $INSTALL_PATH"
    Log "SteamCMD dir: $STEAMCMD_DIR"

    # 1) STEAMCMD
    Log "Step 1: Installing SteamCMD..."
    if (-not (Test-Path $STEAMCMD_DIR)) {
        New-Item -ItemType Directory -Path $STEAMCMD_DIR -Force | Out-Null
    }

    $steamExe = Join-Path $STEAMCMD_DIR "steamcmd.exe"

    if (-not (Test-Path $steamExe)) {
        $zip = Join-Path $STEAMCMD_DIR "steamcmd.zip"
        $url = "https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip"
        Log "Downloading SteamCMD from $url"
        Invoke-WebRequest -Uri $url -OutFile $zip -UseBasicParsing

        Log "Extracting SteamCMD..."
        Expand-Archive -Path $zip -DestinationPath $STEAMCMD_DIR -Force
        Remove-Item $zip -Force
    } else {
        Log "SteamCMD already present, skipping download"
    }

    # 2) VEIN SERVER
    Log "Step 2: Installing VEIN server (app 2131400)..."
    if (-not (Test-Path $INSTALL_PATH)) {
        New-Item -ItemType Directory -Path $INSTALL_PATH -Force | Out-Null
    }

    if (-not (Test-Path $steamExe)) {
        throw "steamcmd.exe not found at $steamExe"
    }

    $args = "+force_install_dir `"$INSTALL_PATH`" +login anonymous +app_update 2131400 validate +quit"
    Log "Running SteamCMD with args: $args"

    $proc = Start-Process -FilePath $steamExe -ArgumentList $args -NoNewWindow -PassThru -Wait

    # Treat 0 and 7 as success (7 is common even when it prints 'Success!')
    if ($proc.ExitCode -ne 0 -and $proc.ExitCode -ne 7) {
        throw "SteamCMD failed with exit code $($proc.ExitCode)"
    }
    Log "SteamCMD finished with exit code $($proc.ExitCode)"

    # 3) CONFIG DIR
    Log "Step 3: Writing config files..."
    $configDir = Join-Path $INSTALL_PATH "Vein\Saved\Config\WindowsServer"
    New-Item -ItemType Directory -Path $configDir -Force | Out-Null

    # 3a) Game.ini
    $configFile = Join-Path $configDir "Game.ini"

    $superAdminBlock = BuildIdLines "SuperAdminSteamIDs" $SUPER_ADMIN_IDS
    $adminBlock      = BuildIdLines "AdminSteamIDs"       $ADMIN_IDS

    if ($WHITELIST_IDS -and $WHITELIST_IDS.Count -gt 0) {
        $whitelistBlock = BuildIdLines "WhitelistedPlayers" $WHITELIST_IDS
    } else {
        $whitelistBlock = "WhitelistedPlayers="
    }

    $configContent = @"
[/Script/Engine.GameSession]
MaxPlayers=$MAX_PLAYERS

[/Script/Vein.VeinGameSession]
bPublic=$PUBLIC
ServerName="$SERVER_NAME"
ServerDescription="$SERVER_DESC"
BindAddr=$BIND_ADDR
$superAdminBlock
$adminBlock
HeartbeatInterval=$HEARTBEAT_INTERVAL
Password="$PASSWORD"

[/Script/Vein.VeinGameStateBase]
$whitelistBlock

[/Script/Vein.ServerSettings]
GS_ShowScoreboardBadges=$SHOW_SCOREBOARD_BADGES

[OnlineSubsystemSteam]
GameServerQueryPort=$QUERY_PORT
bVACEnabled=$VAC_ENABLED

[URL]
Port=$PORT
"@

    $configContent | Set-Content -Path $configFile -Encoding UTF8
    Log "Game.ini written to $configFile"

    # 3b) Engine.ini
    $engineFile = Join-Path $configDir "Engine.ini"
    $pvpValue   = if ($PVP_ENABLED) { "True" } else { "False" }
    $aiValue    = if ($AI_ENABLED)  { "True" } else { "False" }

    $engineContent = @"
[ConsoleVariables]
vein.PvP=$pvpValue
vein.AISpawner.Enabled=$aiValue
vein.TimeMultiplier=$TIME_MULTIPLIER
"@

    $engineContent | Set-Content -Path $engineFile -Encoding UTF8
    Log "Engine.ini written to $engineFile"

    # 4) START BAT
    Log "Step 4: Creating Start-VeinServer.bat..."
    $startBat   = Join-Path $INSTALL_PATH "Start-VeinServer.bat"
    $batContent = @"
@echo off
cd /d "%~dp0"
echo Starting VEIN server...
"VeinServer.exe" -QueryPort=$QUERY_PORT -Port=$PORT -multihome=$BIND_ADDR -log
echo.
echo Server process exited.
pause
"@
    $batContent | Set-Content -Path $startBat -Encoding OEM

    Log "Done."

    Write-Host ""
    Write-Host "===============================================" -ForegroundColor Green
    Write-Host " VEIN server installed successfully."           -ForegroundColor Green
    Write-Host " Install directory: $INSTALL_PATH"
    Write-Host " Start script:     $startBat"
    Write-Host " Log file:         $LOG_FILE"
    Write-Host "===============================================" -ForegroundColor Green
}
catch {
    Write-Host ""
    Write-Host "INSTALL FAILED!" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red

    if ($_.ScriptStackTrace) {
        Write-Host ""
        Write-Host "Stack trace:" -ForegroundColor DarkRed
        Write-Host $_.ScriptStackTrace -ForegroundColor DarkRed
    }

    "ERROR: $($_.Exception.Message)" | Out-File -FilePath $LOG_FILE -Append
}
finally {
    Write-Host ""
    Read-Host "Press ENTER to close this window" | Out-Null
}
