$ErrorActionPreference = "Stop"
$repo = "C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments"
$src = Join-Path $repo "tools\local\probe_osic2.sh"
if (-not (Test-Path -LiteralPath $src)) { throw "probe missing: $src" }
$hostP = "C:\openprobe\probe_osic2.sh"
New-Item -ItemType Directory -Force -Path "C:\openprobe" | Out-Null
Copy-Item -LiteralPath $src -Destination $hostP -Force
& docker run --rm `
  -v "${hostP}:/probe2.sh:ro" `
  --entrypoint bash `
  hpretl/iic-osic-tools:latest `
  -lc "bash /probe2.sh"
