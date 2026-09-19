param()
$ErrorActionPreference = "Stop"
$repo = "C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments"
$script = Join-Path $repo "tools\local\probe_osic.sh"
if (-not (Test-Path -LiteralPath $script)) { throw "probe script missing: $script" }
$mappedTarget = "C:\tools\local\probe_osic.sh"
New-Item -ItemType Directory -Force -Path "C:\tools\local" | Out-Null
Copy-Item -LiteralPath $script -Destination $mappedTarget -Force
docker run --rm `
  -v "C:\tools\local\probe_osic.sh:/probe_osic.sh:ro" `
  --entrypoint bash `
  hpretl/iic-osic-tools:latest `
  -c "bash /probe_osic.sh"
