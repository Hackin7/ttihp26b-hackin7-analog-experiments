$ErrorActionPreference = "Stop"
# 1) locate real PDK stdcell SPICE inside the OSIC image and copy into the
#    mounted C:\openprobe (readonly src mount is /rt2)
$dst = "C:\openprobe"
New-Item -ItemType Directory -Force -Path $dst | Out-Null

Write-Host "=== locate + copy real sg13g2 stdcell SPICE from PDK ==="
docker run --rm -v "$dst`:results:/rt2:rw" `
  --entrypoint bash hpretl/iic-osic-tools:latest `
  -lc "
    echo '-- searching PDK for stdcell spice --'
    find /foss/pdks/ihp-sg13g2 -iname '*stdcell*.spi' -o -iname '*stdcell*.spice' 2>/dev/null | head -20
    echo '-- searching for MOS model decks --'
    find /foss/pdks/ihp-sg13g2 -iname '*.spice' | grep -iE 'mos|stdcell' | head -20
  " 2>&1

Write-Host ""
Write-Host "=== copy candidates to result dir ==="
docker run --rm -v "$dst`:results:/rt2:rw" `
  --entrypoint bash hpretl/iic-osic-tools:latest `
  -lc "
    mkdir -p /rt2/pdk
    find /foss/pdks/ihp-sg13g2 -path '*stdcell*' \( -name '*.spice' -o -name '*.spi' -o -name '*.cir' \) 2>/dev/null > /tmp/hitlist
    wc -l /tmp/hitlist
    head -40 /tmp/hitlist
    while read -r f; do
      cp \"\$f\" /rt2/pdk/ 2>/dev/null && echo \"copied: \$f\"
    done < /tmp/hitlist
    ls -la /rt2/pdk/
  " 2>&1
