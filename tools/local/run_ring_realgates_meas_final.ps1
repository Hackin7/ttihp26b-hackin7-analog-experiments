$ErrorActionPreference = "Stop"
$stage = "C:\openprobe"
New-Item -ItemType Directory -Force -Path $stage | Out-Null
$repo = "C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments"
$local = Join-Path $repo "tools\local"
Copy-Item -LiteralPath (Join-Path $local "emit_and_run_sg13g2_gates.sh") -Destination $stage -Force
Copy-Item -LiteralPath (Join-Path $local "ring_gates_consolidated_tb.spice") -Destination $stage -Force
Write-Host "staged consolidate-and-run real-gate ring proof -> ${stage}:"
Get-ChildItem -LiteralPath $stage -Name | Select-String -Pattern "sh$|spice$" | ForEach-Object { $_.Line }
Write-Host ""
Write-Host "=== ngspice headless: SG13G2 REAL-gate ring OSC proof (meas block only) ==="
docker run --rm -v "${stage}:/rt" --entrypoint bash `
  hpretl/iic-osic-tools:latest `
  -lc "cd /rt && ngspice -b ring_gates_consolidated_tb.spice 2>&1 \
        | grep -E 'osc_period|osc_freq|osc_freq|tr_[ab]|SG13G2.*GATE|OSCILLATION|period|freq' \
        | grep -viE 'redefinition|osdi|can.t find|warning' | head -20"
