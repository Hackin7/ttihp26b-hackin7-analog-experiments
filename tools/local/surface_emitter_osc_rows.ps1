$log = 'C:\openprobe\emitter3.full.log'
if (-not (Test-Path -LiteralPath $log)) { Write-Output 'emitter3.full.log not present'; exit 0 }
$keep = New-Object System.Collections.Generic.List[string]
$lines = [System.IO.File]::ReadAllLines($log)
foreach ($l in $lines) {
  if ($l -match 'osc_|osc_period|osc_freq|osc freq|osc period|period|freq' -and
      $l -notmatch 'osdi|redefin|PATH|PYTHONPATH|SPICEOPT|ngspice -|writ') {
    $keep.Add($l.Trim())
  }
}
if ($keep.Count -ge 1) { $keep | Select-Object -Last 3 } else { Write-Output 'no osc rows in emitter log' }