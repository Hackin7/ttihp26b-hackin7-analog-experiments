$ErrorActionPreference = "Stop"
$stage = "C:\openprobe"
New-Item -ItemType Directory -Force -Path $stage | Out-Null
$repo = "C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments"
$local = Join-Path $repo "tools\local"

Copy-Item -LiteralPath (Join-Path $local "probe_and_run_sg13g2_gate.sh") -Destination $stage -Force
$src = Join-Path $repo "analog\ring_oscillator\spice"
Copy-Item -LiteralPath (Join-Path $src "ring_oscillator_real_pdk_tb.spice") -Destination $stage -Force
Copy-Item -LiteralPath (Join-Path $src "ring_oscillator.spice") -Destination $stage -Force
Write-Host "staged finder+deck+TB->${stage}:"
Get-ChildItem -LiteralPath $stage -Name
Write-Host ""
Write-Host "=== ngspice: SG13G2 real-gate-subckt ring proof (gate deck auto-located) ==="
docker run --rm   -v "${stage}:/rt" `
  --entrypoint bash `
  hpretl/iic-osic-tools:latest `
  -lc "cd /rt && bash probe_and_run_sg13g2_gate.sh"
