#!/usr/bin/env bash
# harden_sg13g2_mosloc.sh -- dump EVERY real .model-sg13_lv_nmos/sg13_lv_pmos
# declaration site in the IHP SG13G2 PDK (unglobbed, case-insensitive), so the
# consolidated ring TB includes the deck that ACTUALLY defines the MOS models.
set -u
PDK=/foss/pdks/ihp-sg13g2
cd /rt || exit 1

echo "=== 1. every file declaring .model for sg13_lv_nmos (case-insens) ==="
find ${PDK}/libs.ref -type f \
     \( -name '*.spice' -o -name '*.cdl' -o -name '*.spi' -o -name '*.lib' -o -name '*.l' \) \
  -exec grep -lEi '\.model[[:space:]]+sg13_lv_nmos' {} \; 2>/dev/null | sort -u

echo ""
echo "=== 2. every file declaring .model for sg13_lv_pmos (case-insens) ==="
find ${PDK}/libs.ref -type f \
     \( -name '*.spice' -o -name '*.cdl' -o -name '*.spi' -o -name '*.lib' -o -name '*.l' \) \
  -exec grep -lEi '\.model[[:space:]]+sg13_lv_pmos' {} \; 2>/dev/null | sort -u

echo ""
echo "=== 3. the actual declaration lines in the standard-cell spice deck ==="
STD=$(find ${PDK}/libs.ref -path '*sg13g2_stdcell*spice*' -name 'sg13g2_stdcell.spice' 2>/dev/null | head -1)
echo "stdcell-spice-deck = ${STD:-MISSING}"
if [ -n "${STD}" ]; then
  grep -niE '\.model[[:space:]]+sg13_lv_(n|p)mos|^[[:space:]]*\.include' "${STD}" | head -12
fi

echo ""
echo "=== 4. MOS-primitive reference form inside the real gate CDL ==="
GATED=$(find ${PDK}/libs.ref -path '*sg13g2_stdcell*cdl*' -name 'sg13g2_stdcell.cdl' 2>/dev/null | head -1)
echo "gate-cdl-deck = ${GATED:-MISSING}"
if [ -n "${GATED}" ]; then
  grep -niE 'sg13_lv_(n|p)mos' "${GATED}" | head -3
fi
