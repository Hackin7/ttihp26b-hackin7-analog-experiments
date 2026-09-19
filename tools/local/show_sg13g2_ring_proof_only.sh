#!/usr/bin/env bash
# show_sg13g2_ring_proof_only.sh -- run the consolidated real-gate SG13G2 ring
# TB headless and print ONLY the oscillation-proof measurement echoes.
set -u
cd /rt || exit 2
TB=ring_gates_consolidated_tb.spice
[ -f "$TB" ] || { echo "missing consolidated TB"; exit 3; }
ngspice -b "$TB" 2>&1 \
  | grep -aiE 'osc_|osc_|period|osc_freq|osc_freq|tr_[ab]|SG13G2 REAL-GATE|OSC PROOF|RING.*OSC|oscillation' \
  | grep -aviE 'osdi|osdi|redef|warning, can|warning, can|osdi_bootstrap|osdi' \
  | tail -8