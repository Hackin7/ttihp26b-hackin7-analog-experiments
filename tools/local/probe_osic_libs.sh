#!/usr/bin/env bash
set -u
PDK=/foss/pdks/ihp-sg13g2
echo "===XSCHEM LIB (SG13G2 stdcell symbols, names we need)==="
ls $PDK/libs.ref/sg13g2_stdcell/sch/xschem 2>/dev/null | grep -E "inv|nand|buf|nor" | head -40
echo "===XSCHEM LIB root==="
ls -d $PDK/libs.ref/sg13g2_stdcell/sch/xschem 2>/dev/null
find $PDK -maxdepth 3 -type d -iname "xschem" 2>/dev/null | head
echo "===DEFAULT XSCHEM LIB PATHS (from PDK rc)==="
find $PDK -maxdepth 4 \( -iname "*.rc" -o -iname "*.conf" \) 2>/dev/null | grep -i -E "xschem|dl" | head
echo "===MAGIC IHP analog macro init (TT template mirror in OSIC)==="
find / -maxdepth 8 -iname "magic_init*.tcl" 2>/dev/null | head
echo "===TT analog DEF 1x2 (IANHP template; might exist in osic image)==="
find / -maxdepth 8 -iname "tt_analog_1x2.def" 2>/dev/null | head
echo "===SG13G2 klayout lyt + layermap==="
ls $PDK/libs.ref/sg13g2_stdcell/klayout 2>/dev/null
find $PDK -maxdepth 4 -iname "*.lyt" 2>/dev/null | head
echo "===ngspice model include snippet (paramset)==="
grep -l "sg13g2_inv" $PDK/libs.tech/ngspice/*.cm 2>/dev/null | head
ls $PDK/libs.tech/ngspice 2>/dev/null | head
