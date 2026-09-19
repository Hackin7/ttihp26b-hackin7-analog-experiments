#!/usr/bin/env bash
set -u
echo "===TOOLS (login PATH)==="
for t in xschem magic magic_ext magic_lef magic_gds netgen ngspice klayout klayout_py gaw; do
  printf "%-14s " "$t"; command -v "$t" >/dev/null 2>&1 && echo OK || echo MISSING
done
echo "===VERSIONS==="
xschem --version 2>&1 | head -1
magic -version 2>&1 | head -1
netgen -batch '' 2>&1 | head -1
ngspice --version 2>&1 | grep -i ngspice | head -1
klayout -v 2>&1 | head -1
echo "===PDK (IHP SG13G2 / analog flow material)==="
find / -maxdepth 10 -type d \( -iname "ihp-sg13g2" -o -iname "sg13g2" \) 2>/dev/null | head
echo "---TT analog DEF template (same as repo tt/tech/.../def/analog)---"
find / -maxdepth 12 -iname "tt_analog*.def" 2>/dev/null | head
echo "---magic analog init (IHP)---"
find / -maxdepth 12 -iname "magic_init_*.tcl" -path "*analog*" 2>/dev/null | head
echo "---IHP analog xschem library examples---"
find / -maxdepth 12 -iname "*.sch" -path "*sg13g2*" 2>/dev/null | head -6
echo "===KLAYOUT IHP tech + GDS II==="
find / -maxdepth 12 -iname "sg13g2*.lyt" 2>/dev/null | head -3
echo "===ngspice IHP model / behavioral==="
find / -maxdepth 12 -iname "*.va" -path "*sg13*" 2>/dev/null | head -3
echo "===DONE==="
