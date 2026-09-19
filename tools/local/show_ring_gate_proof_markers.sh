#!/usr/bin/env bash
# show_ring_gate_proof_markers.sh -- print ONLY the consolidated real-gate ring
# osc proof numbers/re-echoed markers; never the deck/OSDi noise.
set -u
cd /rt || exit 1
TB=ring_gates_consolidated_tb.spice
[ -f "$TB" ] || { echo "!! missing consolidated TB: ${TB}"; exit 2; }
echo "=== ngspice headless: SG13G2 real-gate HOLD-osc proof (meas pass only) ==="
ngspice -b "$TB" 2>&1 \
  | grep -aEi "osc_period|osc_freq|osc_freq|osc_freq|period =|freq   =|SG13G2 REAL-GATE|OSC PROOF|RING PROOF|tr_a|tr_b" \
  | grep -aviE "osdi|redefin|warning|can.t move|osdi bs|osdi lib" \
  | sed -E 's/^\s+//; s/[[:space:]]+/ /g' \
  | grep -aEi "osc_period|osc_freq|= [0-9]|SG13G2 REAL-GATE|OSC PROOF|RING PROOF" \
  | head -8