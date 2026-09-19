$ErrorActionPreference = "Stop"
$stage = "C:\openprobe"
New-Item -ItemType Directory -Force -Path $stage | Out-Null
$repo = "C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments"
$local = Join-Path $repo "tools\local"

Copy-Item -LiteralPath (Join-Path $local "emit_and_run_sg13g2_gates.sh") -Destination $stage -Force
Copy-Item -LiteralPath (Join-Path $local "resg2_models_finder.sh") -Destination $stage -Force -ErrorAction SilentlyContinue
Copy-Item -LiteralPath (Join-Path $repo "analog\ring_oscillator\spice\ring_oscillator_real_pdk_tb.spice") -Destination $stage -Force -ErrorAction SilentlyContinue
Write-Host "staged consolidated real-gate runner -> ${stage}:"
Write-Host ""
Get-ChildItem -LiteralPath $stage -Name | ForEach-Object { Write-Host "  $_" }
Write-Host ""

Write-Host "=== SG13G2 REAL-gate ring: consolidated deck, oscillation proof ==="
docker run --rm -v "${stage}:/rt" `
  --entrypoint bash `
  hpretl/iic-osic-tools:latest `
  -lc "cd /rt && bash emit_and_run_sg13g2_gates.sh 2>&1 | grep -aEi 'osc_period|osc_freq|osc_freq|SG13G2 REAL-GATE|OSC PROOF|oscillation proof|period =|freq =' | grep -aviE 'osdi|redefin|osdi|warning, can' | tail -5"