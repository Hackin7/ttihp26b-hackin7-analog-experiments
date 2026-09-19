#!/usr/bin/env bash
# emit_once_marker_only.awk.sh
# Runs the consolidated SG13G2 REAL-gate ring TB headless; prints ONLY the two
# ngspice .meas echoes (osc_period / osc_freq) plus the emitter's own proof
# banner. No nested grep, no PS-visible quoting.
set -u
cd /rt || exit 2
OUT=osc_meas_block.txt
ngspice -b ring_gates_consolidated_tb.spice > "$OUT" 2>&1
echo "=== SG13G2 REAL-GATE RING HEADLESS: measurement echoes ==="
awk '
  /osc_period|osc_freq|osc_freq|period +[=:] +[0-9eE]|freq +[=:] +[0-9eE]|SG13G2 REAL-GATE|OSC PROOF/ {
    print
  }
' "$OUT" | grep -avE 'osdi|redefin|osdi, ' | tail -3