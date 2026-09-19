#!/usr/bin/env bash
# locate the deck that DEFINES sg13g2_nand2_1 gate subckt, patch the staged
# real-PDK TB include to that absolute path, then run the headless proof.
set -eu

TB=/rt/ring_oscillator_real_pdk_tb.spice

echo "=== 1. find gate-deck defining sg13g2_nand2_1 ==="
DECK=$(grep -rilE '^\.subckt[[:space:]]+sg13g2_nand2_1([[:space:]]|$)' \
        /foss/pdks/ihp-sg13g2/libs.ref 2>/dev/null | head -1)
echo "gate deck = ${DECK:-NONE}"

if [ -z "${DECK}" ]; then
  echo "!! no subckt deck found; listing all sg13g2_stdcell spice files:"
  find /foss/pdks/ihp-sg13g2 -type f -iname '*.spice' 2>/dev/null \
    | grep -i stdcell | head
  exit 2
fi

echo ""
echo "=== 2. repoint include in TB ==="
sed -i -E "s#\.include[[:space:]].*#.include ${DECK}#" "$TB"
grep -n '^\.include' "$TB"

echo ""
echo "=== 3. ngspice headless: SG13G2 real-gate ring oscillation ==="
cd /rt && ngspice -b ring_oscillator_real_pdk_tb.spice 2>&1 \
  | grep -Ei 'osc|period|freq|error|warning' | head -20
