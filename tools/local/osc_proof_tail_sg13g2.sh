#!/usr/bin/env bash
# osc_proof_tail.sh -- run the consolidated real-gate SG13G2 ring headless and
# print ONLY ngspice's own meas echoes, suppressing the PDK import/redefinition
# wall that floods stdout. Uses awk (tab-safe), no nested sed/grep quoting.
set -u
cd /rt || exit 2
TB=ring_gates_consolidated_tb.spice
[ -f "$TB" ] || { echo "missing consolidated TB"; exit 3; }
echo "=== SG13G2 REAL-GATE RING: ngspice measurement echoes ==="
ngspice -b "$TB" 2>&1 | awk '
  /redefini|osdi|Redefined|reserved word|osdi 2.5/ { next }
  /^\s*osc_|osc_period|osc_freq|OSC PROOF|SG13G2 REAL-GATE|PERIOD|FREQ/ {
    ln = $0
    gsub(/^[ \t]+|[ \t]+$/, "", ln)
    print ln
  }
' | tail -6