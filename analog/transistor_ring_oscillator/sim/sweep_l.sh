#!/usr/bin/env bash
# Sweep channel length and record pre-layout ring frequency.
set -euo pipefail
SIM_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT_DIR="${SIM_DIR}/out"
mkdir -p "$OUT_DIR"
SWEEP="${OUT_DIR}/sweep_l.txt"
: > "$SWEEP"
echo "lch_um freq_hz" >> "$SWEEP"

for LCH in 0.5u 0.8u 1.1u 1.5u 2.0u; do
  echo "===== sweep lch=$LCH ====="
  LCH="$LCH" bash "$SIM_DIR/run_sim.sh" --no-plot
  freq=$(awk -F= '/^freq_hz=/{print $2}' "$OUT_DIR/freq.txt")
  um="${LCH%u}"
  echo "$um $freq" | tee -a "$SWEEP"
done

echo "===== sweep done ====="
cat "$SWEEP"
