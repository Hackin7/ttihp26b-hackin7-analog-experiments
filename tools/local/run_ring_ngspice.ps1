$ErrorActionPreference = "Stop"
$repo = "C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments"
$dst  = "C:\openprobe"

# stage both decks
$spiceHome = Join-Path $repo "analog\ring_oscillator\spice"
Copy-Item -LiteralPath (Join-Path $spiceHome "ring_oscillator.spice")  -Destination $dst -Force
Copy-Item -LiteralPath (Join-Path $spiceHome "ring_oscillator_tb.spice") -Destination $dst -Force

Write-Host "=== staged decks in C:\openprobe ==="
Get-ChildItem -LiteralPath $dst -Name

Write-Host ""
Write-Host "=== ngspice ring oscillation proof (login shell, full PATH) ==="
docker run --rm -v "${dst}:/rt:ro" `
  --entrypoint bash `
  hpretl/iic-osic-tools:latest `
  -lc "cd /rt && ngspice -b ring_oscillator_tb.spice 2>&1 | tail -25"
