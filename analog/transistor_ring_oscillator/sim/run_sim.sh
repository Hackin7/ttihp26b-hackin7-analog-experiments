#!/usr/bin/env bash
# Pre-layout ngspice transient for transistor_ring_oscillator.
# Prefers /foss/pdks (IIC-OSIC). Else $PDK_ROOT or ~/ttsetup/pdk (WSL harden setup).
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
  echo "IHP PDK not found. Set PDK_ROOT or run inside IIC-OSIC (/foss/pdks)." >&2
  exit 2
fi
export PDK_ROOT PDK=ihp-sg13g2

LIB="$PDK_ROOT/ihp-sg13g2/libs.tech/ngspice/models/cornerMOSlv.lib"
if [ ! -f "$LIB" ]; then
  echo "missing MOS library: $LIB" >&2
  exit 2
fi
printf '.lib %s mos_tt\n' "$LIB" > "$OUT_DIR/pdk.lib"

SPICEINIT="$PDK_ROOT/ihp-sg13g2/libs.tech/ngspice/.spiceinit"
if [ -f "$SPICEINIT" ]; then
  cp "$SPICEINIT" "$SIM_DIR/.spiceinit"
fi

echo "[run_sim] PDK_ROOT=$PDK_ROOT"
ngspice -b -o "$OUT_DIR/ngspice.log" tb_tran.spice
python3 extract_freq.py
