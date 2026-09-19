#!/bin/bash
set -u
cd /rt
echo "=== SG13G2 REAL-GATE ring: consolidate-and-measure (final) ==="
ngspice -b ring_gates_consolidated_tb.spice > ring_gates_consolidated_out.txt 2>&1
echo "--- raw tail (proof block) ---"
grep -Ei "tr_a|tr_b|osc_period|osc_freq|osc_freq|SG13G2|ring" ring_gates_consolidated_out.txt \
  | grep -viE "osdi|redefinition|warning, can|error opening" | tail -12
echo "--- measured (from .meas in ngspice stdout) ---"
ngspice -b ring_gates_consolidated_tb.spice 2>&1 \
  | grep -Ei "osc_period|osc_freq|osc_freq|period|freq" \
  | grep -viE "osdi|redefinition|warning, can" | tail -8
