$ErrorActionPreference = "Stop"
$stage = "C:\openprobe"
New-Item -ItemType Directory -Force -Path $stage | Out-Null

$repo = "C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments"

Copy-Item -LiteralPath (Join-Path $repo "analog\ring_oscillator\spice\ring_oscillator_tb.spice") -Destination $stage -Force
Write-Host "staged self-contained ring TB to ${stage}:"

docker run --rm -v "${stage}:/rt:rw" `
  --entrypoint bash `
  hpretl/iic-osic-tools:latest `
  -lc "cd /rt && ngspice -b ring_oscillator_tb.spice 2>&1 | tail -25"
