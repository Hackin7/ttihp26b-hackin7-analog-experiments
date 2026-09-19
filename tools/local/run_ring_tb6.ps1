$ErrorActionPreference = "Stop"
$stage = "C:\openprobe"
New-Item -ItemType Directory -Force -Path $stage | Out-Null

$repo = "C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments"
$tb   = Join-Path $repo "analog\ring_oscillator\spice\ring_oscillator_tb.spice"
if (-not (Test-Path -LiteralPath $tb)) { throw "TB missing: $tb" }

Copy-Item -LiteralPath $tb -Destination (Join-Path $stage "ring_oscillator_tb.spice") -Force
Write-Host "staged TB to ${stage}:"
Get-ChildItem -LiteralPath $stage -Name

Write-Host ""
Write-Host "=== ngspice: ring oscillation proof (headless, self-contained TB) ==="
docker run --rm `
  -v "${stage}:/rt:ro" `
  --entrypoint bash `
  hpretl/iic-osic-tools:latest `
  -lc "cd /rt && ngspice -b ring_oscillator_tb.spice 2>&1 | grep -Ei 'osc_|oscill|period|freq|error' | head -25"
