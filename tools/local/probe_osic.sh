#!/usr/bin/env bash
set -u
echo "===TOOLS (login shell PATH)==="
for t in xschem magic netgen ngspice klayout klayout_py gaw; do
  printf "%-12s " "$t"; command -v "$t" >/dev/null 2>&1 && echo OK || echo MISSING
done
echo "===VERSIONS==="
xschem --version 2>&1 | head -1
magic -version 2>&1 | head -1
netgen -batch 'gexit' 2>&1 | grep -i netgen | head -1
ngspice --version 2>&1 | grep -i ngspice | head -1
klayout -v 2>&1 | head -1
echo "===PDK ROOTS==="
for d in /foss/pdks /usr/local/share/pdk /usr/share/pdk; do
  [ -d "$d" ] && echo "$d:" && ls "$d" | head
done
echo "===SG13G2 DIRS (shallow)==="
find / -maxdepth 10 -type d -iname "sg13g2" 2>/dev/null | head
echo "===IHPSG13G2 PDK (matching TT layout templates)==="
find / -maxdepth 10 -type d \( -iname "ihp-sg13g2" -o -iname "sg13g2-*" \) 2>/dev/null | head
echo "===XSchem libs (IHP examples)==="
find / -maxdepth 10 -type d -iname "sg13g2_xschem*" 2>/dev/null | head
find / -maxdepth 10 -iname "*.sch" -path "*sg13g2*" 2>/dev/null | head -8
echo "===magic tech (analog DEF template mirror)==="
find / -maxdepth 12 -iname "*.tcl" -path "*analog*" 2>/dev/null | grep -i -E "magic|def" | head
find / -maxdepth 12 -iname "tt_analog*.def" 2>/dev/null | head
echo "===TAPE-OUT ANALOG EXAMPLE (from TT ihp analog)==="
find / -maxdepth 12 -iname "tt_um_*analog*" -type f 2>/dev/null | head
echo "===KLAYOUT IHP TECH==="
find / -maxdepth 10 -iname "*sg13g2*.lyt" 2>/dev/null | head
find / -maxdepth 10 -iname "*sg13g2*.layermap" 2>/dev/null | head
echo "===NGSPICE IHP + xschem symbols==="
find / -maxdepth 10 -iname "sg13g2_inv*" 2>/dev/null | head
