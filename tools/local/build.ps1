<#
.SYNOPSIS
Hardens this Tiny Tapeout IHP26b project locally with LibreLane, mirroring the
CI gds workflow (TinyTapeout/tt-gds-action@ttihp26b).

.DESCRIPTION
Windows wrapper around tools/local/build.sh:
  1. Ensures Docker Desktop is running (for general Docker availability).
  2. Starts dockerd inside the WSL2 distro (so LibreLane --dockerized
     bind-mounts of /mnt/c paths resolve correctly — Docker Desktop's
     VM cannot see deep /mnt/c paths).
  3. Runs the official Tiny Tapeout "local hardening" flow inside WSL2:
         python tt/t_tool.py --create-user-config --ihp
         python tt/t_tool.py --harden --ihp
         python tt/t_tool.py --print-warnings --ihp
  4. Reports the produced GDS/LEF artifact paths.

The flow runs in WSL because LibreLane's dependency lln-libparse ships
manylinux wheels but no Windows wheels (it would build the Yosys C++
bindings from source and fail under MSVC). CI itself runs this same
flow on Linux.

.PARAMETER SkipSetup
Skip the one-time setup (venv / tt clone / pip installs). Use on re-runs.

.PARAMETER ForceSetup
Re-run the setup steps and pip installs even if a setup marker already exists.

.EXAMPLE
powershell -NoProfile -ExecutionPolicy Bypass -File tools/local/build.ps1
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
        Write-Host "[build] docker engine already running"
        return
    }
    Write-Host "[build] docker engine not responding - starting Docker Desktop..."
    $dockerDesktop = 'C:\Program Files\Docker\Docker\Docker Desktop.exe'
    if (Test-Path $dockerDesktop) {
        Start-Process $dockerDesktop | Out-Null
    }
    $deadline = (Get-Date).AddMinutes(4)
    while ((Get-Date) -lt $deadline) {
        Start-Sleep -Seconds 5
        if (Test-DockerEngine) {
            Write-Host "[build] docker engine is up"
            return
        }
    }
    throw "Docker engine did not become ready within 4 minutes."
}

function Ensure-WslDockerd {
    # dockerd inside WSL gives LibreLane's --dockerized mode native bind mounts
    # (Docker Desktop's VM cannot resolve deep /mnt/c paths).
    $running = & wsl -e bash -c "docker info >/dev/null 2>&1 && echo OK" 2>$null
    if ($running -eq 'OK') {
        Write-Host "[build] dockerd already running inside WSL"
        return
    }
    Write-Host "[build] starting dockerd inside WSL..."
    & wsl -u root -e bash -c "nohup dockerd --iptables=false >/var/log/dockerd.log 2>&1 &"
    # wait for socket
    $deadline = (Get-Date).AddMinutes(1)
    while ((Get-Date) -lt $deadline) {
        Start-Sleep -Seconds 3
        $running = & wsl -e bash -c "docker info >/dev/null 2>&1 && echo OK" 2>$null
        if ($running -eq 'OK') {
            Write-Host "[build] dockerd is ready inside WSL"
            return
        }
    }
    throw "dockerd failed to start inside WSL within 60 seconds."
}

Ensure-DockerDesktopEngine
Ensure-WslDockerd

$wslRepo = ConvertTo-WslPath $repoRoot
$wslScript = ConvertTo-WslPath (Join-Path $PSScriptRoot 'build.sh')

$flags = @()
if ($SkipSetup) { $flags += '--skip-setup' }
if ($ForceSetup) { $flags += '--force-setup' }

Write-Host "[build] running inside WSL2: bash $wslScript $($flags -join ' ')"
& wsl -e bash -c "$wslScript $($flags -join ' ') '$wslRepo'"
$exit = $LASTEXITCODE

Write-Host ""
Write-Host "[build] hardened artifacts:"
if (Test-Path "$repoRoot\runs\wokwi\final\gds\*.gds") {
    Get-ChildItem "$repoRoot\runs\wokwi\final\gds\*.gds" | ForEach-Object { Write-Host "  $($_.FullName)" }
} elseif ($exit -eq 0) {
    Write-Host "  (no GDS found under runs\wokwi\final\gds)"
}
if (Test-Path "$repoRoot\runs\wokwi\final\lef\*.lef") {
    Get-ChildItem "$repoRoot\runs\wokwi\final\lef\*.lef" | ForEach-Object { Write-Host "  $($_.FullName)" }
}

exit $exit