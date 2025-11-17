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

# ========= FULL VEIN CONSOLE VARIABLE LIST (defaults) =========
# These are written into Engine.ini under [ConsoleVariables].
# You can edit Engine.ini later to change any of these.

$ALL_CONSOLE_VARIABLES = @'
vein.AI.AsyncSensing                        = True          ; Compute sight from AI asynchronously.
vein.AISpawner.Enabled                      = True          ; Enable AI to spawn.
vein.AISpawner.EnableVirtualization         = True          ; Enable AI virtualization.
vein.AISpawner.FieldOfViewDot               = 0.000000      ; Player field-of-view dot product (-1 to 1).
vein.AISpawner.HordeMode                    = False         ; Enable horde mode.
vein.AISpawner.Hordes.ChancePerMinute       = 0.050000      ; Hordes spawned per minute (default 0.05).
vein.AISpawner.Hordes.Duration              = 120.000000    ; Duration of a horde event in seconds (default 120).
vein.AISpawner.Horde.Enabled                = True          ; Enable horde spawning.
vein.AISpawner.Hordes.MaxDistance           = 25000.000000  ; Distance at which horde event ends (default 25000).
vein.AISpawner.Hordes.NoiseEffect           = 0.100000      ; Bigger = more likely hordes from noise (default 0.1).
vein.AISpawner.Hordes.ScentEffect           = 0.500000      ; Bigger = more likely hordes from bad smells (default 0.5).
vein.AISpawner.SpawnCapMultiplier           = 1.000000      ; Spawn cap multiplier for AI.
vein.AISpawner.SpawnCapMultiplierZombie     = 1.000000      ; Spawn cap multiplier for zombies only.
vein.AISpawner.ZombieCrawlerPercentage      = 0.100000      ; Fraction of zombies that are crawlers.
vein.AISpawner.ZombieLayerPercentage        = 0.100000      ; Fraction of zombies asleep to start.
vein.AISpawner.ZombieWalkerPercentage       = 0.700000      ; Fraction of zombies that are walkers.

vein.AlwaysBecomeZombie                     = False         ; Dead characters always become zombies regardless of infection.
vein.AlwaysFreeLook                         = False         ; Always free-look as if holding the key.
vein.Animals.NavWalk                        = False         ; Animals use nav walking instead of walking.

vein.Animation.UpdateRateOptimizations      = False         ; Enable animation update rate optimizations (don't change at runtime).

vein.Assets.CacheDataAssets                 = True          ; Cache hard-loaded data assets (shows a warning).

vein.Autosave.Enabled                       = True          ; Enable autosaves.
vein.Autosave.Interval                      = 300.000000    ; Seconds between autosaves.
vein.Autosave.MaxQuantity                   = 10.000000     ; Maximum number of autosaves to keep.

vein.BaseDamage                             = 1.000000      ; Can bases be damaged, ever?

vein.BasicVehicleReplication.AngularVelocityInterpolationSpeed = 3.000000     ; Vehicle angular interpolation speed.
vein.BasicVehicleReplication.PositionInterpSpeed               = 10.000000    ; Vehicle position interpolation speed.
vein.BasicVehicleReplication.RotationInterpSpeed               = 5.000000     ; Vehicle rotation interpolation speed.
vein.BasicVehicleReplication.VelocityInterpolationSpeed        = 5.000000     ; Vehicle velocity interpolation speed.

vein.BatchTicks.Active                      = True          ; Batch ticking system is active / running ticks.
vein.BatchTicks.Enabled                     = True          ; Batch ticking system enabled.
vein.BatchTicks.PositionGranularity         = 500.000000    ; Size of hierarchical position query box.

vein.BuildObjectDecay                       = 1.000000      ; Build object decay / UC-related tuning.
vein.BuildObjectPvP                         = 1.000000      ; Can players damage other players' bases?

vein.Calendar.ElectricalShutoffTimeDays     = 46.000000     ; Days until the power is shut off.
vein.Calendar.WaterShutoffTimeDays          = 30.000000     ; Days until the water is shut off.

vein.Camera.EnableSprintFOV                 = True          ; Enable or disable zooming when sprinting.
vein.Camera.FirstPersonADS                  = False         ; Go first-person when ADSing in third-person.
vein.Camera.FirstPersonBody                 = True          ; Show legs in first-person.
vein.Camera.FOV                             = 90.000000     ; Field of view amount.
vein.Camera.HeadBob                         = 1.000000      ; How much head bob to apply.
vein.Camera.MeleeViewPunchMultiplier        = 1.000000      ; How much melee view punch to apply.
vein.Camera.SmoothingLocation               = 0.000000      ; Location camera smoothing amount.
vein.Camera.SmoothingRotation               = 0.000000      ; Rotation camera smoothing amount.

vein.Characters.Max                         = 100.000000    ; Maximum number of characters one player may have.

vein.ClothingHideable                       = False         ; Players can hide their clothes for roleplaying.

vein.Conditions.AlwaysShow                  = False         ; Show all conditions regardless of threshold.
vein.Conditions.NetworkInterval             = 2.000000      ; Delay between networking condition updates.

vein.Consciousness.RecoveryPerSecond        = 1.666000      ; How much consciousness to recover per second.

vein.Construction.ContinueBuilding          = True          ; Always keep building regardless of holding shift.

vein.ContainersRespawn.Enabled              = True          ; Empty containers will respawn items.
vein.ContainersRespawn.Interval             = 10800.000000  ; How frequently containers respawn contents (seconds).

vein.DeadDoorsIntact                        = False         ; True = damaging doors, False = crumble instantly.

vein.Firearm.BloodSplatter.MaxDecals        = 4.000000      ; How many blood decals to spawn from a firearm.
vein.Firearm.BloodSplatter.MaxDistance      = 300.000000    ; Max distance for blood decals from a firearm.

vein.Furniture.PhysicalFall                 = True          ; Furniture physically falls to the ground.
vein.Furniture.RespawnRate                  = 3000.000000   ; Seconds to respawn furniture.

vein.Gamma                                  = 2.200000      ; Gamma value.

vein.GoreHoles.Enabled                      = False         ; Enable gore holes.

vein.HeadshotDamageMultiplier               = 1.000000      ; How much more or less damage headshots do.

vein.HideChat                               = False         ; Hide all chat.
vein.HideNameplates                         = False         ; Hide player names.

vein.Holidays.AlwaysSpawn                   = False         ; Always spawn holiday actors, even off-season.

vein.HUD.HideAllNameplates                  = False         ; Hide all item/player/etc nameplates.

vein.Inventory.DisableNetworkFlush          = False         ; Disable automatic inventory networking from KV updates.
vein.Inventory.NetworkDelay                 = True          ; Reduce the frequency of inventory networking.
vein.Inventory.NetworkDelay.Interval        = 5.000000      ; Default network delay interval.
vein.Inventory.NetworkDelay.IntervalJitter  = 0.100000      ; Extra delay to prevent stacked frames.
vein.Inventory.QuickDismantleEnabled        = False         ; Enable alt-click dismantle on items.

vein.InvertedPitch                          = False         ; Inverted mouse pitch.

vein.ItemActorSpawner.RespawnInterval       = 3600.000000   ; Item actor spawner respawn interval (seconds).
vein.ItemActorSpawner.Respawns              = True          ; Item actor spawners ever respawn.

vein.Landscape.LODCurvesEnabled             = 0.000000      ; Enable landscape LOD curves.

vein.LightOptimizationManager.Enabled       = False         ; Enable or disable dynamic shadow culling.

vein.MeleeSlowdownDuration                  = 0.100000      ; How long to slow down melee animations on impact.
vein.MeleeSlowdownSpeed                     = 0.200000      ; How much to slow down melee animations on impact.

vein.Multiplayer.AllowDifferentVersions     = False         ; Allow different-versioned servers (may crash).

vein.Music.Enabled                          = True          ; Enable music.

vein.NoSaves                                = False         ; Players cannot save.
vein.Permadeath                             = False         ; Players cannot respawn.

vein.PersistentCorpses                      = True          ; Enable persistent corpses.
vein.PersistentCorpses.CorpseRemovalDelay   = 120.000000    ; How fast corpses are removed (seconds).

vein.PhysicsProxy.BlockSize                 = 5000.000000   ; Block size to put foliage into.
vein.PhysicsProxy.CapsuleTimeBudget         = 1.000000      ; Max time to spend updating capsules per frame.
vein.PhysicsProxy.Enabled                   = True          ; Physics proxies update when True.
vein.PhysicsProxy.MaxDistance               = 2500.000000   ; Max distance to allow physics proxies from a player.
vein.PhysicsProxy.NumProxies                = 300.000000    ; Number of physics proxies (changing in-game does nothing).

vein.Placement.MaxPlacementAttachParents    = 5.000000      ; Maximum attachment chain when placing objects.

vein.PunchInterval                          = 0.500000      ; How fast players and NPCs can punch.

vein.PvP                                    = 1.000000      ; Can players damage other players?

vein.RagdollDragForce                       = 1000000.000000 ; Force applied when dragging ragdolls.

vein.RepGraph.CellSize                      = 10000.000000  ; Replication graph cell size.
vein.RepGraph.DestructInfo.MaxDist          = 30000.000000  ; Max distance (not squared) to replicate destruct infos.
vein.RepGraph.DisableSpatialRebuilds        = 1.000000      ; Disable spatial rebuilds in replication graph.
vein.RepGraph.DisplayClientLevelStreaming   = 0.000000      ; Show debug client level streaming.
vein.RepGraph.DynamicActorFrequencyBuckets  = 3.000000      ; Number of dynamic actor frequency buckets.
vein.RepGraph.EnableFastSharedPath          = 1.000000      ; Enable fast shared replication path.
vein.RepGraph.FastSharedPathCullDistPct     = 0.800000      ; Cull distance percent for fast shared path.
vein.RepGraph.LogLazyInitClasses            = 0.000000      ; Log lazy-init classes.
vein.RepGraph.SpatialBiasX                  = -700000.000000 ; Spatial bias X for replication graph.
vein.RepGraph.SpatialBiasY                  = -700000.000000 ; Spatial bias Y for replication graph.
vein.RepGraph.TargetKBytesSecFastSharedPath = 10.000000     ; Target KB/sec for fast shared path.

vein.RespawnableDestruction.Enabled         = 1.000000      ; If this is on, furniture / destructibles respawn.

vein.Saves.Compress                         = 0.000000      ; Should save games be compressed.
vein.Saves.PathPooling                      = 0.000000      ; Pool paths in save games (slower but smaller).
vein.Saves.SkipInitialApply                 = 0.000000      ; Skip initial save application when loading the map.
vein.Saves.SkipInitialApplyCheck            = 0.000000      ; Skip initial save application check when loading actors.

vein.ScalarField.Timeout                    = 2.000000      ; Duration the scalar field cache is held for.

vein.Scarcity.Difficulty                    = 2.000000      ; Loot scarcity difficulty (0=None,1=More,2=Standard,3=Less,4=Impossible).

vein.Sky.DistanceFieldShadowDistance        = 100000.000000 ; Distance field shadow distance for the sun.
vein.Sky.DynamicShadowCascades              = 3.000000      ; Shadow cascade count for the sun.
vein.Sky.DynamicShadowDistance              = 5000.000000   ; How far the sun renders dynamic shadows.
vein.Sky.LightShaftBloom                    = 0.000000      ; Whether the sky casts shaft bloom.
vein.Sky.MoonDistanceFieldShadowDistance    = 5000.000000   ; Distance field shadow distance for the moon.
vein.Sky.MoonDynamicShadowCascades          = 1.000000      ; Shadow cascade count for the moon.
vein.Sky.MoonDynamicShadowDistance          = 2000.000000   ; How far the moon renders dynamic shadows.
vein.Sky.TickInterval                       = 0.200000      ; Seconds between sky ticks (<=0 means smooth updates).
vein.Sky.VolumetricFog                      = 1.000000      ; Should the sky fog be volumetric?

vein.Stats.NetworkInterval                  = 2.000000      ; Delay between networking stats.
vein.Stats.XPMultiplier                     = 1.000000      ; XP multiplier.

vein.Time.ContinueWithNoPlayers             = 0.000000      ; Time continues moving when no players are online.
vein.Time.NightTimeMultiplier               = 3.000000      ; How much faster nighttime runs compared to daytime.
vein.Time.NightTimeMultiplierEnd            = 6.000000      ; (24h) hour night multiplier ends.
vein.Time.NightTimeMultiplierStart          = 20.000000     ; (24h) hour night multiplier starts.
vein.Time.StartOffsetDays                   = 0.000000      ; Days to start a new game at.
vein.Time.TimeMultiplier                    = 16.000000     ; How fast the game world runs.

vein.ToggleCrouch                           = 0.000000      ; Toggle crouch vs press-and-hold.

vein.TV.AllowRemoteContent                  = 0.000000      ; TVs can play content from the web (client).
vein.TV.Server.AllowRemoteContent           = 1.000000      ; TVs can play content from the web (server).

vein.Units.Fahrenheit                       = 1.000000      ; Temperature units (0=Celsius, 1=Fahrenheit).
vein.Units.Imperial.Distance                = 1.000000      ; Distance units (0=metric, 1=imperial).
vein.Units.Imperial.Pressure                = 1.000000      ; Pressure units (0=metric, 1=imperial).
vein.Units.Imperial.Volume                  = 1.000000      ; Volume units (0=metric, 1=imperial).
vein.Units.Imperial.Weight                  = 1.000000      ; Weight units (0=metric, 1=imperial).

vein.UtilityCabinet.ContinueWithNoPlayers   = 1.000000      ; If off, UCs will not feed when no players are on the server.
vein.UtilityCabinet.Interval                = 4.000000      ; Seconds between utility cabinet feeds.

vein.Vehicles.BaseWheelFriction             = 6.000000      ; Base wheel friction for vehicles.
vein.Vehicles.BaseWheelFrictionHandbrake    = 1.500000      ; Wheel friction multiplier when handbrake is active.
vein.Vehicles.BaseWheelMaxBrakeTorque       = 15000.000000  ; Base brake torque.
vein.Vehicles.BaseWheelMaxHandBrakeTorque   = 1.300000      ; Brake torque handbrake multiplier.
vein.Vehicles.FlatTireWobbleAmplitude       = 0.100000      ; How hard to bank with a flat tire.
vein.Vehicles.NearbyKeySpawnChance          = 0.800000      ; Chance that keys spawn near locked cars.
vein.Vehicles.Optimizations.Animation       = 1.000000      ; Apply vehicle animation optimization (1=yes,0=no).
vein.Vehicles.Optimizations.Physics         = 1.000000      ; Apply vehicle physics optimization (1=yes,0=no).
vein.Vehicles.Optimizations.Physics.MaxVelocity = 50.000000 ; Velocity over which physics are not frozen.
vein.Vehicles.Optimizations.Tick            = 1.000000      ; Apply vehicle tick optimization (1=yes,0=no).
vein.Vehicles.OutgoingPlayerDamage          = 1.000000      ; Vehicles damage players on impact.
vein.Vehicles.ZombieKeySpawnChance          = 0.100000      ; Chance that keys spawn on zombies.

vein.VOIP.AlertAI                           = 0.000000      ; VOIP audio alerts AI.
vein.VOIP.BypassCompression                 = 0.000000      ; Test VOIP input (bypass compression).
vein.VOIP.FacialStrength                    = 8.000000      ; Strength of VOIP facial animations.
vein.VOIP.FFTMouths                         = 0.000000      ; Use spectrum analysis for VOIP facial animation.
vein.VOIP.Loopback                          = 0.000000      ; Hear your own voice.
vein.VOIP.PTT                               = 1.000000      ; Use push-to-talk vs open mic.
vein.VOIP.PTTDelay                          = 0.200000      ; Delay before PTT stops transmitting.
vein.VOIP.RadioLoopback                     = 0.000000      ; Hear your own voice over radio.
vein.VOIP.SelfTransmit                      = 1.000000      ; VOIP P2P should transmit to yourself.
vein.VOIP.StarvationTime                    = 3.000000      ; Out-of-date VOIP still played for this long.
vein.VOIP.UnderflowMinSamples               = 0.000000      ; Minimum samples to play VOIP (0=requested minimum).
vein.VOIP.VolumeMultiplier                  = 3.000000      ; Default VOIP volume multiplier.

vein.Wire.MaxRadius                         = 1500.000000   ; Max distance you can wire two things together.

vein.WorldMedia.Duration                    = 4.000000      ; Duration in seconds to consider radio desynced.
vein.WorldMedia.Percentage                  = 0.040000      ; Percentage offset to consider radio desynced.
vein.WorldMedia.PercentageEnabled           = 1.000000      ; Sync radio based on playback percentage.

vein.ZombieBuckets.GridSize                 = 20000.000000  ; Zombie bucket grid size.
vein.ZombieBuckets.MaxCount                 = 300.000000    ; Zombie bucket max count.
vein.ZombieBuckets.RespawnTime              = 300.000000    ; Zombie bucket respawn time (seconds).

vein.ZombieInfectionChance                  = 0.010000      ; How likely you are to get infected by a zombie attack.

vein.Zombies.AnimateYell                    = 0.000000      ; Zombie mouths open when they yell.
vein.Zombies.CanClimb                       = 1.000000      ; Zombies can climb.
vein.Zombies.DamageMultiplier               = 1.000000      ; How much more deadly zombies are.
vein.Zombies.EnableTickOptimization         = 0.000000      ; Slow-update distant zombies.
vein.Zombies.HeadshotOnly                   = 0.000000      ; Only headshots damage zombies when set to 1.
vein.Zombies.Health                         = 40.000000     ; How much health zombies have.
vein.Zombies.HearingMultiplier              = 1.000000      ; How much better hearing zombies have.
vein.Zombies.LayingDownDistance             = 500.000000    ; How far away stimuli has to be for zombies to “wake up”.
vein.Zombies.NavWalk                        = 1.000000      ; Zombies use nav walking instead of walking.
vein.Zombies.SightMultiplier                = 1.000000      ; How much better sight zombies have.
vein.Zombies.SpeedMultiplier                = 1.000000      ; How much faster zombies move.
'@

# ========= PATHS =========

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
            $first  = $false
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
    $adminBlock      = BuildIdLines "AdminSteamIDs"      $ADMIN_IDS

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
    Log "Step 3b: Writing Engine.ini (console variables)..."
    $engineFile = Join-Path $configDir "Engine.ini"
    $pvpValue   = if ($PVP_ENABLED) { "True" } else { "False" }
    $aiValue    = if ($AI_ENABLED)  { "True" } else { "False" }

    $engineContent = @"
[ConsoleVariables]
$ALL_CONSOLE_VARIABLES

vein.Zombies.LayingDownDistance             = 500.000000    ; Distance at which zombies 'wake up' from stimuli.
vein.Zombies.NavWalk                        = True          ; Zombies use nav walking instead of direct walking.
vein.Zombies.SightMultiplier                = 1.000000      ; Zombie sight multiplier.
vein.Zombies.SpeedMultiplier                = 1.000000      ; Zombie speed multiplier.

vein.PvP                                    = $pvpValue     ; Players can damage other players.
vein.AISpawner.Enabled                      = $aiValue      ; Enable or disable AI spawning via installer toggle.
vein.Time.TimeMultiplier                    = $TIME_MULTIPLIER ; Global time scale multiplier (installer toggle).
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
