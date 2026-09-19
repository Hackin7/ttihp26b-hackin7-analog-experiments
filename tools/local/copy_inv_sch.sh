#!/usr/bin/env bash
set -u
set -e
OUT=/rt/sg13g2_inv_1.sch
{
  cat /foss/pdks/ihp-sg13g2/libs.ref/sg13g2_stdcell/sch/xschem/sg13g2_inv_1.sch
} > "$OUT" 2>/dev/null || {
  echo "fallback: search"
  F=$(find /foss/pdks -path "*stdcell*" -name "sg13g2_inv_1.sch" 2>/dev/null | head -1)
  echo "FALLBACK_F=$F"
  [ -n "$F" ] && cat "$F" > "$OUT"
}
echo "===COPIED_TO_$OUT==="
ls -la "$OUT"
echo "===HEAD==="
head -60 "$OUT"
echo "===STDCELL_XSCHEM_LIB_CONTENTS (example cells)==="
ls /foss/pdks/ihp-sg13g2/libs.ref/sg13g2_stdcell/sch/xschem 2>/dev/null | head -40
