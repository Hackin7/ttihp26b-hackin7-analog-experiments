$ErrorActionPreference = "Stop"
$stage = "C:\openprobe"
New-Item -ItemType Directory -Force -Path $stage | Out-Null
$repo = "C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments"
$local = Join-Path $repo "tools\local"

Copy-Item -LiteralPath (Join-Path $local "emit_and_run_sg13g2_gates.sh") -Destination $stage -Force
Write-Host "staged consolidated real-gate ring emitter -> ${stage}:"
Write-Host ""
Write-Host "=== SG13G2 REAL-gate ring oscillation proof (consolidated, headless) ==="
docker run --rm -v "${stage}:/rt" `
  --entrypoint bash `
  hpretl/iic-osic-tools:latest `
  -lc "cd /rt && sed -i 's|grep .Ei .osc|grep -Ei .osc|' emit_and_run_sg13g2_gates.sh; bash emit_and_run_sg13g2_gates.sh 2>&1 | grep -Ei 'gate-deck|mos-model-deck|osc_|period|freq|osc_freq|error' | head -25"
