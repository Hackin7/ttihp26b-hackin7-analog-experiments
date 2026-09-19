#!/usr/bin/env bash
# proof_only_sg13g2_ring.sh -- run the already-emitted consolidated REAL-gate
# ring TB and print ONLY the oscillation-proof echoes (period/freq/crossings).
set -u
cd /rt || exit 1
TB=ring_gates_consolidated_tb.spice
[ -f "$TB" ] || { echo "missing $TB (consolidate runner must emit first)"; exit 2; }
ngspice -b "$TB" 2>&1 \
  | grep -E 'osc_period|osc_freq|osc_freq|tr_a[[:space:]]*=|tr_b[[:space:]]*=|SG13G2 REAL-GATE|RING OSC|OSCILLATION PROOF|period[[:space:]]*=|freq[[:space:]]*=' \
  | grep -viE 'osdi|redefin|warning, can|redefinition' \
  | head -10
