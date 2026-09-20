$log = 'C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments\proof.raw.log'
if (-not (Test-Path -LiteralPath $log)) { $log = 'C:\openprobe\proof.raw.log' }
Write-Host '=== tail of SG13G2 real-gate ring meas log (echoes only) ==='
Get-Content -LiteralPath $log -Tail 200 -ErrorAction SilentlyContinue |
  Where-Object { $_ -match 'osc_|period|freq|SG13G2 REAL-GATE|OSC PROOF|tr_a|tr_b' } |
  Where-Object { $_ -notmatch 'osdi|redefin|osdi, can|warning, can|osdi, ' } |
  Select-Object -Last 8 | ForEach-Object { $_.Trim() }