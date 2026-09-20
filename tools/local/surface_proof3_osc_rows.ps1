$p = 'C:\openprobe\proof3.raw.log'
if (-not (Test-Path -LiteralPath $p)) { Write-Output 'proof3.raw.log not present on host stage'; exit 0 }
$tail = Get-Content -LiteralPath $p -Tail 96
$hits = New-Object System.Collections.Generic.List[string]
foreach ($l in $tail) {
  $t = $l.Trim()
  if ($t -match 'osc_|period|freq|meas|Sg13|real|gate' -and $t -notmatch 'osdi|redefin|osdi, |redefin, |PATH|PYTHONPATH|writ|Debug|amp|SPICEOPT|ngspice -b') {
    $hits.Add($t)
  }
}
if ($hits.Count -ge 1) {
  Write-Output ("=== osc meas rows surfaced: {0} ===" -f $hits.Count)
  $hits | Select-Object -Last 6
} else {
  Write-Output '=== no osc meas rows in tail (showing last 6 raw lines) ==='
  $tail | Select-Object -Last 6
}