$ErrorActionPreference = "Stop"
$stage = "C:\openprobe"
New-Item -ItemType Directory -Force -Path $stage | Out-Null

$repo = "C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments"
$spice = Join-Path $repo "analog\ring_oscillator\spice"

Copy-Item -LiteralPath (Join-Path $spice "ring_oscillator_sg13g2_tb.spice") -Destination $stage -Force
Copy-Item -LiteralPath (Join-Path $spice "ring_oscillator.spice") -Destination $stage -Force
Write-Host "staged sg13g2 proof + behavioral cross-check to $stage:"
Get-ChildItem -LiteralPath $stage -Name

Write-Host ""
Write-Host "=== ngspice: SG13G2 real-PDK ring oscillation proof ==="
docker run --rm -v "$stage`:/rt:ro" `
  --entrypoint bash `
  hpretl/iic-osic-tools:latest `
  -lc "cd /rt && ngspice -b ring_oscillator_sg13g2_tb.spice 2>&1 | grep -Ei 'osc_period|osc_freq|period|freq|error|warning' | head -15"
