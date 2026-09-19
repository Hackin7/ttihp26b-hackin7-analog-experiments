$ErrorActionPreference = "Stop"
$stage = "C:\openprobe"
New-Item -ItemType Directory -Force -Path $stage | Out-Null

$repo = "C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments"
$src  = Join-Path $repo "analog\ring_oscillator\spice"

Copy-Item -LiteralPath (Join-Path $src "ring_oscillator.ngs")   -Destination (Join-Path $stage "ring_oscillator.spice") -Force
Copy-Item -LiteralPath (Join-Path $src "ring_oscillator_tb.spice") -Destination $stage -Force
Write-Host "staged deck+tb to ${stage}:"
Get-ChildItem -LiteralPath $stage -Name

Write-Host ""
Write-Host "=== ngspice ring oscillation proof (headless) ==="
docker run --rm -v "$stage`:/rt:ro" `
  --entrypoint bash `
  hpretl/iic-osic-tools:latest `
  -lc "cd /rt && ngspice -b ring_oscillator_tb.spice 2>&1 | tail -30"
