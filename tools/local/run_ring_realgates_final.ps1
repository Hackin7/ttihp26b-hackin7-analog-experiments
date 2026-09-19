$ErrorActionPreference = "Stop"
$stage = "C:\openprobe"
New-Item -ItemType Directory -Force -Path $stage | Out-Null
$repo = "C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments"
$local = Join-Path $repo "tools\local"

docker run --rm -v "${stage}:/rt" --entrypoint bash `
  hpretl/iic-osic-tools:latest `
  -lc "cd /rt && bash emit_and_run_sg13g2_gates.sh"
