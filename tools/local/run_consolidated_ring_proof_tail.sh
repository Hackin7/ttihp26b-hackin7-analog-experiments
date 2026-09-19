#!/usr/bin/env bash
# rec_ring_gates_consolidated.sh -- run the SAILED consolidated real-gate
# SG13G2 ring TB headless and keep only its meas-echo tail (no redef/osdi noise).
# Stage: C:\openprobe  (rw; emitter + consolidated TB pre-staged)
set -u
cd /rt
TB=ring_gates_consolidated_tb.spice
[ -f "$TB" ] || TB=ring_gates_consolidated_tb.spice
ngspice -b "$TB" 2>&1 \
  | grep -aEi 'osc_period|osc_freq|osc_period|osc_freq|osc_freq =|osc_period =|tr_a|tr_b' \
  | grep -aviE 'osdi|redefin|osdi lib|can.t move' \
  | tail -3