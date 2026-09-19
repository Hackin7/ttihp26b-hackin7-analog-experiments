$ErrorActionPreference = "Stop"
$repo = "C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments"
docker run --rm `
  -v "${repo}\tools\local:/runner:ro" `
  -v "${repo}\analog:/analog:ro" `
  --entrypoint bash `
  hpretl/iic-osic-tools:latest `
  -lc "bash /runner/run_ring_osic.sh" 2>&1
