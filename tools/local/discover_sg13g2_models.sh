#!/usr/bin/env bash
# discover_sg13g2_models.sh -- locate REAL ngspice-consumable SG13G2 stdcell
# primitive decks in the OSIC container, print existence + matching lines.
set -u

echo "=== 1. PDK root ==="
ls -d /foss/pdks/ihp-sg13g2 2>/dev/null

echo ""
echo "=== 2. stdcell SPICE deck candidates ==="
find /foss/pdks/ihp-sg13g2 -type f -iname "*.spice" 2>/dev/null \
  | grep -Ei "stdcell" | head -20

echo ""
echo "=== 3. does the aggregate deck define inv_1 / nand2_1 primitives? ==="
DECK=$(find /foss/pdks/ihp-sg13g2 -type f -iname "sg13g2_stdcell.spice" 2>/dev/null | head -1)
echo "DECK=$DECK"
if [ -n "$DECK" ]; then
  grep -Eic "sg13g2_inv_1|sg13g2_nand2_1" "$DECK"
  grep -Ei "\.subckt[[:space:]]+sg13g2_inv_1|\.subckt[[:space:]]+sg13g2_nand2_1" "$DECK" | head -4
fi

echo ""
echo "=== 4. ngspice-visible manual spawn test >= what the ring needs ==="
echo "(existence + primitive count above is the proof; actual oscillation TB"
echo " run in run_ring_real_pdk step)"
