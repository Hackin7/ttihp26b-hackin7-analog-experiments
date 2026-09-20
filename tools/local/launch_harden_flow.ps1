$base = 'C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments'
$build = Join-Path $base 'tools\local\build.ps1'
$log   = 'C:\Users\zunmun\AppData\Local\Temp\opencode\ttihp26b_harden_flow.log'
$pidFile = 'C:\Users\zunmun\AppData\Local\Temp\opencode\ttihp26b_harden_flow.pid'

if (-not (Test-Path -LiteralPath $build)) { throw "launcher missing: $build" }

if (Test-Path -LiteralPath $pidFile) {
    $old = Get-Content -LiteralPath $pidFile -Raw
    $oldPid = $null
    if ($old -match '\d+') { $oldPid = [int]($matches[0]) }
    if ($oldPid -and (Get-Process -Id $oldPid -ErrorAction SilentlyContinue)) {
        Write-Output ("ALREADY RUNNING pid=" + $oldPid)
        Set-Content -LiteralPath $pidFile -Value $oldPid
        exit 0
    }
}

$ps = [System.Diagnostics.Process]::Start(@{
    FileName               = 'powershell.exe'
    Arguments              = '-NoProfile -NoExit -ExecutionPolicy Bypass -File "' + $build + '"'
    WorkingDirectory       = $base
    RedirectStandardOutput = $log
    RedirectStandardError  = (Join-Path 'C:\Users\zunmun\AppData\Local\Temp\opencode' 'ttihp26b_harden_flow.err.log')
    UseShellExecute        = $false
    CreateNoWindow         = $true
})

Set-Content -LiteralPath $pidFile -Value $ps.Id
Write-Output ("LAUNCHED pid=" + $ps.Id)
Write-Output ("log=" + $log)
