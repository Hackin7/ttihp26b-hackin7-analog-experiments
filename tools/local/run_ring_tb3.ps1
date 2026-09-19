$ErrorActionPreference = "Stop"
$repo = "C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments"
$tb   = Join-Path $repo "analog\ring_oscillator\spice\ring_oscillator_tb.spice"
if (-not (Test-Path -LiteralPath $tb)) { throw "missing TB" }

$stage = "C:\openprobe"
New-Item -ItemType Directory -Force -Path $stage | Out-Null
Copy-Item -LiteralPath $tb -Destination (Join-Path $stage "ring_oscillator_tb.spice") -Force
Write-Host "staged: $(Get-ChildItem -LiteralPath $stage -Name)"

Write-Host ""
Write-Host "=== ring oscillation transient, ngspice inside OSIC container ==="
docker run --rm -v "$stage`:/rt:ro" `
  --entrypoint bash hpretl/iic-osic-tools:latest `
  -lc "cd /rt && ngspice -b ring_oscillator_tb.spice 2>&1 | grep -Ei 'period|freq|t_r|osc' | tail -20"
