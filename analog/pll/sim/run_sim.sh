#!/usr/bin/env bash
# PLL pre-layout ngspice (IIC-OSIC /foss/pdks or PDK_ROOT).
set -euo pipefail

SIM_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT_DIR="${SIM_DIR}/out"
mkdir -p "$OUT_DIR"
cd "$SIM_DIR"

if [ -d /foss/pdks/ihp-sg13g2 ]; then
  PDK_ROOT=/foss/pdks
elif [ -n "${PDK_ROOT:-}" ]; then
  :
elif [ -d "${HOME}/ttsetup/pdk/ihp-sg13g2" ]; then
  PDK_ROOT="${HOME}/ttsetup/pdk"
else
  echo "IHP PDK not found. Set PDK_ROOT or run inside IIC-OSIC." >&2
  exit 2
fi
export PDK_ROOT PDK=ihp-sg13g2

MODELS="$PDK_ROOT/ihp-sg13g2/libs.tech/ngspice/models"
MOS_LIB="$MODELS/cornerMOSlv.lib"
RES_LIB="$MODELS/cornerRES.lib"
CAP_LIB="$MODELS/cornerCAP.lib"
for f in "$MOS_LIB" "$RES_LIB" "$CAP_LIB"; do
  if [ ! -f "$f" ]; then
    echo "missing library: $f" >&2
    exit 2
  fi
done
{
  printf '.lib %s mos_tt\n' "$MOS_LIB"
  printf '.lib %s res_typ\n' "$RES_LIB"
  printf '.lib %s cap_typ\n' "$CAP_LIB"
} > "$OUT_DIR/pdk.lib"

SPICEINIT="$PDK_ROOT/ihp-sg13g2/libs.tech/ngspice/.spiceinit"
if [ -f "$SPICEINIT" ]; then
  cp "$SPICEINIT" "$SIM_DIR/.spiceinit"
fi

LCH="${LCH:-0.25u}"
TB="${TB:-tb_vco_point.spice}"
printf '.param lch=%s\n' "$LCH" > "$OUT_DIR/lch.param"
echo "[run_sim] PDK_ROOT=$PDK_ROOT lch=$LCH tb=$TB"
ngspice -b -o "$OUT_DIR/ngspice.log" "$TB"
tail -n 40 "$OUT_DIR/ngspice.log" || true
