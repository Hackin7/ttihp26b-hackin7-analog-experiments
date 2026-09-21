#!/usr/bin/env bash
# Sweep channel length and record pre-layout ring frequency.
set -euo pipefail
SIM_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT_DIR="${SIM_DIR}/out"
mkdir -p "$OUT_DIR"
SWEEP="${OUT_DIR}/sweep_l.txt"
: > "$SWEEP"
echo "lch_um freq_hz" >> "$SWEEP"

for LCH in ${LCH_LIST:-0.40u 0.50u 0.55u 0.60u 0.70u}; do
  echo "===== sweep lch=$LCH tb=${TB:-tb_tran.spice} ====="
  LCH="$LCH" TB="${TB:-tb_tran.spice}" bash "$SIM_DIR/run_sim.sh" --no-plot
  freq=$(awk -F= '/^freq_hz=/{print $2}' "$OUT_DIR/freq.txt")
  um="${LCH%u}"
  echo "$um $freq" | tee -a "$SWEEP"
done

echo "===== sweep done ====="
cat "$SWEEP"
