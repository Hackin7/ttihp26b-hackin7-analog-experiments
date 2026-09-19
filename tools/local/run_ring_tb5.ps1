$ErrorActionPreference = "Stop"
$stage = "C:\openprobe"
New-Item -ItemType Directory -Force -Path $stage | Out-Null

$repo = "C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments"
$tb   = Join-Path $repo "analog\ring_oscillator\spice\ring_oscillator_tb.spice"
Copy-Item -LiteralPath $tb -Destination $stage -Force

$mnt = $stage + ":/rt:rw"
Write-Host "mount = $mnt"
docker run --rm -v $mnt `
  --entrypoint bash `
  hpretl/iic-osic-tools:latest `
  -lc "cd /rt && ngspice -b ring_oscillator_tb.spice 2>&1 | grep -Ei 'osc|period|freq|error' | head -25"
