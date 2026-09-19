$ErrorActionPreference = "Stop"
$repo = "C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments"
$probe = Join-Path $repo "tools\local\probe_osic2.sh"
if (-not (Test-Path -LiteralPath $probe)) { throw "probe missing: $probe" }
$hostPath = "C:\tools\local\probe_osic2.sh"
New-Item -ItemType Directory -Force -Path "C:\tools\local" | Out-Null
Copy-Item -LiteralPath $probe -Destination $hostPath -Force
& docker run --rm `
  -v "${hostPath}:/probe2.sh:ro" `
  --entrypoint bash `
  hpretl/iic-osic-tools:latest `
  -lc "bash /probe2.sh"
