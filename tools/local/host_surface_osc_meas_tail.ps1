$log = 'C:\openprobe\proof.raw.log'
if (-not (Test-Path -LiteralPath $log)) { $log = 'C:\openprobe\proof.raw.log' }
if (-not (Test-Path -LiteralPath $log)) {
  Write-Output 'proof.raw.log not found on host stage'
  exit ostic
}
$lines = [System.IO.File]::ReadAllLines($log)
$hits = @()
foreach ($l in $lines) {
  if ($l -match 'osc_|osc_period|osc_freq|osc freq|period[ =]|freq[ =]|PROOF|REAL-GATE|SG13G2') {
    if ($l -notmatch 'osdi|redefin|syntax|warning|Debug|\[INFO\]|PATH|PYTHON') {
      $hits += $l.Trim()
    }
  }
}
Write-Output ('osc meas echoes found: ' + $hits.Count)
if ($hits.Count -ge 1) {
  $hits | Select-Object -Last 2
} else {
  Write-Output 'no osc echoes in log tail; echo-based meas may be clipped'
}