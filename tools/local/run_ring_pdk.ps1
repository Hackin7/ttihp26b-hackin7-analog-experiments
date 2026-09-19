$ErrorActionPreference = "Stop"
$stage = "C:\openprobe"
New-Item -ItemType Directory -Force -Path $stage | Out-Null

$repo = "C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments"
$src  = Join-Path $repo "analog\ring_oscillator\spice"

Copy-Item -LiteralPath (Join-Path $src "ring_oscillator_sg13g2.spice") -Destination $stage -Force
Copy-Item -LiteralPath (Join-Path $src "ring_oscillator_tb.spice")           -Destination $stage -Force
Write-Host "staged real-deck + TB to $stage:"
Get-ChildItem -LiteralPath $stage -Name

Write-Host ""
Write-Host "=== ngspice: SG13G2 stdcell ring oscillation proof ==="
docker run --rm -v "$stage`:/rt:ro" `
  --entrypoint bash `
  hpretl/iic-osic-tools:latest `
  -lc '
    cd /rt &&
    NAND=$(find /foss/pdks/ihp-sg13g2 -iname "*nand2*.spi*" -o -iname "*nand2_1*" 2>/dev/null | grep -vi xschem | head -1) &&
    INV=$(find /foss/pdks/ihp-sg13g2 -iname "*inv_1*" 2>/dev/null | grep -vi xschem | head -1) &&
    [ -z "$NAND" ] && NAND=$(find /foss/pdks/ihp-sg13g2 -iname "*.spi" 2>/dev/null | head -1) &&
    [ -z "$INV" ]  && INV=$NAND &&
    echo "  NAND model: $NAND" &&
    echo "  INV  model: $INV"  &&
    cp ring_oscillator_tb.spice /tmp/tb.spice &&
    sed -i "s|__NAND2_MODEL_SPICE__|$NAND|; s|__INV_MODEL_SPICE__|$INV|" /tmp/tb.spice &&
    ngspice -b /tmp/tb.spice 2>&1 | grep -Ei "period|freq|osc|error|warning" | head -20
  '
