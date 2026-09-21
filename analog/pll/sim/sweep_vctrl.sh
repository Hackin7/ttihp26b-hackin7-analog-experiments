#!/usr/bin/env bash
# VCO frequency vs vctrl sweep (open-loop).
set -euo pipefail
SIM_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SIM_DIR"
OUT="$SIM_DIR/out/vco_sweep.txt"
mkdir -p "$SIM_DIR/out"
echo "vctrl_v freq_hz" > "$OUT"
LCH="${LCH:-0.25u}"
for V in 0.40 0.50 0.60 0.70 0.80 0.90 1.00; do
  echo "[sweep] vctrl=$V lch=$LCH"
  # Patch param into a temp tb (default in tb_vco_point.spice is 0.72)
  sed "s/vctrl_dc=0.72/vctrl_dc=$V/" tb_vco_point.spice > out/tb_tmp.spice
  TB=out/tb_tmp.spice LCH="$LCH" bash ./run_sim.sh || true
  F=$(grep -E '^freq_hz' out/ngspice.log | tail -1 | awk '{print $3}')
  if [ -z "$F" ]; then
    F=$(grep -E 'freq_hz' out/ngspice.log | tail -1 | sed -n 's/.*freq_hz *= *//p' | awk '{print $1}')
  fi
  echo "$V ${F:-nan}" | tee -a "$OUT"
done
echo "wrote $OUT"
cat "$OUT"
