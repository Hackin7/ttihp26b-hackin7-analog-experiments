<#
.SYNOPSIS
Hardens digital_counter only (no Tiny Tapeout tile template, no analog macro).

.PARAMETER SkipSetup
Skip venv / tt clone / pip installs.

.PARAMETER ForceSetup
Re-run setup even if a setup marker exists.
#>
[CmdletBinding()]
param(
    [switch]$SkipSetup,
    [switch]$ForceSetup
)

$ErrorActionPreference = 'Continue'
$repoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)

function ConvertTo-WslPath {
    param([string]$Path)
    if ($Path -match '^([A-Za-z]):(.*)$') {
        $drive = $matches[1].ToLower()
        $rest = $matches[2].Replace('\', '/')
        return "/mnt/$drive$rest"
    }
    return $Path
}

function Test-DockerEngine {
    & docker info 2>$null | Out-Null
    return ($LASTEXITCODE -eq 0)
}

function Ensure-DockerDesktopEngine {
    if (Test-DockerEngine) {
        Write-Host "[build_digital] docker engine already running"
        return
    }
    Write-Host "[build_digital] starting Docker Desktop..."
    $dockerDesktop = 'C:\Program Files\Docker\Docker\Docker Desktop.exe'
    if (Test-Path $dockerDesktop) {
        Start-Process $dockerDesktop | Out-Null
    }
    $deadline = (Get-Date).AddMinutes(4)
    while ((Get-Date) -lt $deadline) {
        Start-Sleep -Seconds 5
        if (Test-DockerEngine) {
            Write-Host "[build_digital] docker engine is up"
            return
        }
    }
    throw "Docker engine did not become ready within 4 minutes."
}

function Ensure-WslDockerd {
    $running = & wsl -e bash -c "docker info >/dev/null 2>&1 && echo OK" 2>$null
    if ($running -eq 'OK') {
        Write-Host "[build_digital] dockerd already running inside WSL"
        return
    }
    Write-Host "[build_digital] starting dockerd inside WSL..."
    & wsl -u root -e bash -c "nohup dockerd --iptables=false >/var/log/dockerd.log 2>&1 &"
    $deadline = (Get-Date).AddMinutes(1)
    while ((Get-Date) -lt $deadline) {
        Start-Sleep -Seconds 3
        $running = & wsl -e bash -c "docker info >/dev/null 2>&1 && echo OK" 2>$null
        if ($running -eq 'OK') {
            Write-Host "[build_digital] dockerd is ready inside WSL"
            return
        }
    }
    throw "dockerd failed to start inside WSL within 60 seconds."
}

Ensure-DockerDesktopEngine
Ensure-WslDockerd

$wslRepo = ConvertTo-WslPath $repoRoot
$wslScript = ConvertTo-WslPath (Join-Path $PSScriptRoot 'build_digital.sh')
$flags = @()
if ($SkipSetup) { $flags += '--skip-setup' }
if ($ForceSetup) { $flags += '--force-setup' }

Write-Host "[build_digital] running inside WSL2: bash $wslScript $($flags -join ' ')"
& wsl -e bash -c "$wslScript $($flags -join ' ') '$wslRepo'"
$exit = $LASTEXITCODE

Write-Host ""
Write-Host "[build_digital] artifacts:"
$gdsDir = Join-Path $repoRoot 'runs\digital_counter\final\gds'
if (Test-Path $gdsDir) {
    Get-ChildItem "$gdsDir\*.gds" | ForEach-Object { Write-Host "  $($_.FullName)" }
} else {
    Write-Host "  (no GDS under runs\digital_counter\final\gds)"
}

exit $exit
