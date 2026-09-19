#!/usr/bin/env bash
# owned_sg13g2_realgate_ring_final.sh
# Eventual single proof pass. The emitter puts the full ngspice stdout into a
# log; here we print ONLY that log's own osc-period/freq meas block and proof
# banner. No outer grep, no quotes in the docker command (all inside this file).
set -u
cd /rt || exit 2
LOG=ring_gates_consolidated_meas.log
rm -f "$LOG"
[ -f ring_gates_consolidated_tb.spice ] || { echo "missing consolidated TB"; exit 3; }
ngspice -b ring_gates_consolidated_tb.spice > "$LOG" 2>&1
echo "=== SG13G2 REAL-GATE RING: CONSOLIDATED OSC MEAS (only) ==="
awk 'BEGIN{show=0}
     /=== 4\.|osc_period|osc_freq|osc_freq|SG13G2 REAL-GATE|OSC PROOF|OSCILLATION PROOF|osc_freq =|period =/ {show=1}
     /osdi|redefin|osdi, can|cannot find|osdi =|osdi, / {show=0}
     show && //= *[eEdD]?[0-9]|[0-9]+(\.[0-9]+)?[eE]?[+-]?[0-9]*/ {print}
    ' "$LOG" | grep -aE 'osc_|freq|period' | tail -2
echo "---end---"