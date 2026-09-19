$ErrorActionPreference = "Stop"
$stage = "C:\openprobe"
New-Item -ItemType Directory -Force -Path $stage | Out-Null
$repo = "C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments"
$local = Join-Path $repo "tools\local"

# erase stale copies from prior ro-staged probes (only keep the ORIGINAL deck
# so this runner is self-documenting)
Get-ChildItem -LiteralPath $stage -Filter "*.ps1" -ErrorAction SilentlyContinue | Remove-Item -Force
Copy-Item -LiteralPath (Join-Path $local "emit_and_run_sg13g2_gates.sh") -Destination $stage -Force
Copy-Item -LiteralPath (Join-Path $repo "analog\ring_oscillator\spice\ring_oscillator.spice") -Destination $stage -Force
Write-Host "staged consolidator -> ${stage}:"
Get-ChildItem -LiteralPath $stage -Name
Write-Host ""
Write-Host "=== ngspice: SG13G2 REAL-gate + REAL-mos consolidated ring oscillation proof ==="
docker run --rm -v "${stage}:/rt" `
  --entrypoint bash `
  hpretl/iic-osic-tools:latest `
  -lc "cd /rt && bash emit_and_run_sg13g2_gates.sh"