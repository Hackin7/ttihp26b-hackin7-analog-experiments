$ErrorActionPreference = "Stop"
$repo = "C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments"
$dst  = "C:\openprobe"
New-Item -ItemType Directory -Force -Path $dst | Out-Null
$spiceHome = Join-Path $repo "analog\ring_oscillator\spice"

foreach ($n in @("ring_oscillator.spice", "ring_oscillator_tb.spice")) {
    $p = Join-Path $spiceHome $n
    if (-not (Test-Path -LiteralPath $p)) { throw "missing: $p" }
    Copy-Item -LiteralPath $p -Destination (Join-Path $dst $n) -Force
}
Write-Host "staged both decks"

Write-Host ""
Write-Host "=== ngspice|base science deck for ring_oscillator.spice standalone ==="
docker run --rm -v "$dst`:/rt:ro" `
  hpretl/iic-osic-tools:latest `
  ngspice -b /rt/ring_oscillator.spice 2>&1 | Select-Object -Last 25
