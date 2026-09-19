$ErrorActionPreference = "Stop"
$src = "C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments\analog\ring_oscillator\spice\ring_oscillator_tb.ngs"
if (-not (Test-Path -LiteralPath $src)) { throw "netlist missing: $src" }
New-Item -ItemType Directory -Force -Path "C:\openprobe" | Out-Null
Copy-Item -LiteralPath $src -Destination "C:\openprobe\ring_oscillator_tb.ngs" -Force
& docker run --rm `
  -v "C:\openprobe:/runme:ro" `
  --entrypoint bash `
  hpretl/iic-osic-tools:latest `
  -lc "cd /runme && ngspice -b ring_oscillator_tb.ngs 2>&1 | tail -30"
