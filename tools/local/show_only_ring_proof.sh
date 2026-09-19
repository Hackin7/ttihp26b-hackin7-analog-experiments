#!/usr/bin/env bash
# show_only_ring_proof.sh -- run ngspice on the ALREADY-EMITTED consolidated
# real-gate SG13G2 ring TB, print ONLY the deck's own oscillation-proof echo
# block (osc_period / osc_freq / crossing markers), burying OSDI+redef noise.
set -u
cd /rt || exit 1

TB=ring_gates_consolidated_tb.spice
[ -f "$TB" ] || { echo "missing consolidated TB (run the emitter first)"; exit 2; }

echo "=== ngspice headless: SG13G2 REAL-GATE ring oscillation proof (meas block) ==="
ngspice -b "$TB" 2>&1 \
  | sed -n '/====/,$p' \
  | grep -Ei 'osc|period|freq|tr_a|tr_b|cross|oscillation|freq' \
  | grep -viE 'osdi|redefin|warning, can|error opening' \
  | tail -14
