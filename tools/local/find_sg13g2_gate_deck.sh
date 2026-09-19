#!/usr/bin/env bash
# find the SG13G2 deck that actually defines the GATE subckts
# (nand2_1 / inv_1 / buf_2) consumable by ngspice
set -u
echo "=== files whose content defines sg13g2 gate subckts ==="
grep -rilE "^\.subckt[[:space:]]+(sg13g2_nand2|sg13g2_inv|sg13g2_buf)" \
  /foss/pdks/ihp-sg13g2/libs.ref/sg13g2_stdcell 2>/dev/null | head -10

echo ""
echo "=== the stdcell dir listing (what decks exist) ==="
find /foss/pdks/ihp-sg13g2/libs.ref/sg13g2_stdcell -type f -name "*.spice" 2>/dev/null | head -15
