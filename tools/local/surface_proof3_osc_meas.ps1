$log = 'C:\openprobe\proof3.raw.log'
$pat = 'osc_|osc |period|freq|meas|PROOF|REAL-GATE|SG13G2|\.meas|osc'
$skip = 'osdi|redefin|osdi, |redefin, |PATH|PYTHONPATH|writ|Debug|amp|SPICEOPT|ngspice -b|cling'
$rows = New-Object System.Collections.Generic.List[string]
if (-not (Test-Path -LiteralPath $log)) { Write-Output 'proof3.raw.log NOT on stage'; exit 0 }
foreach ($l in [System.IO.File]::ReadAllLines($log)) {
  $t = $l.Trim()
  if ($t -match $pat -and $t -notmatch $skip) { $rows.Add($t) }
}
if ($rows.Count -ge 1) {
  Write-Output ('=== osc meas rows proofed: {0} ===' -f $rows.Count)
  $rows | Select-Object -Last 3
} else {
  Write-Output 'no osc meas rows surfaced; last raw lines:'
  [System.IO.File]::ReadAllLines($log) | Select-Object -Last 3
}