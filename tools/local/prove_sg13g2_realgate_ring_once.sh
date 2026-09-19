#!/usr/bin/env bash
# prove_sg13g2_realgate_ring_once.sh
# Run the ALREADY-EMITTED consolidated real-gate SG13G2 ring headless and print
# ONLY its osc measurement echoes. Quote-safe: no nested grep filters, awk only.
set -u
cd /rt || exit 2
TBOUT=ring_gates_consolidated_tb.log
ngspice -b ring_gates_consolidated_tb.spice > "$TBOUT" 2>&1
echo "=== SG13G2 REAL-GATE RING: HEADLESS OSC PROOF (meas echoes only) ==="
grep -aE 'osc_|osc_period|osc_freq|osc_freq|SG13G2 REAL-GATE|RING OSC PROOF|OSC PROOF' "$TBOUT" \
  | grep -avE 'osdi|redefin|osdi, can|osdi =|osdi, ' | tail -6