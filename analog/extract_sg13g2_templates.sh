#!/usr/bin/env bash
# Copy real SG13G2 stdcell xschem examples + the TT analog DEF/magic template
# into the repo analog/ tree so we can author the ring macro in xschem locally.
set -u
PDK_LIB=/foss/pdks/ihp-sg13g2/libs.ref/sg13g2_stdcell
DST=/carry/analog/ring_oscillator
mkdir -p "$DST/xschem" "$DST/refs"

echo "===copying SG13G2 stdcell xschem example schematics (authoring templates)==="
for c in sg13g2_inv_1 sg13g2_nand2_1 sg13g2_nand3_1 sg13g2_buf_1; do
  f="$PDK_LIB/sch/xschem/$c.sch"
  if [ -f "$f" ]; then cp "$f" "$DST/xschem/"; echo "copied $c.sch"; else echo "MISSING $c.sch"; fi
done

echo "=== xschem symbol library for these cells (the .sym we reference in instances) ==="
ls "$PDK_LIB/sch/xschem" | grep -E "inv_1|nand2_1|nand3_1|buf_1" | head

echo "=== IHP SG13G2 .die_resistance / .graphical / .annotate examples (for our own .sch) ==="
ls /foss/pdks/ihp-sg13g2/libs.ref/sg13g2_dummy/*/ -R 2>/dev/null | head -20 || true

echo "=== is there a TT analog magic init / DEF template in the image's tt-support-tools? ==="
find / -maxdepth 12 -path "*analog*" -name "*.def" 2>/dev/null | head
find / -maxdepth 12 -path "*analog*" -name "magic_init_*.tcl" 2>/dev/null | head

echo "=== sizes ==="
ls -la "$DST/xschem"
