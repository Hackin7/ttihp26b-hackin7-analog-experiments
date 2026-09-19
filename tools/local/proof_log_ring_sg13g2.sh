#!/usr/bin/env bash
# proof_log_ring_sg13g2.sh
# Runs the consolidated emitter (which itself: locates BOTH real SG13G2 decks,
# emits the consolidated TB, runs ngspice headless) into a logfile, then prints
# ONLY the measurement/osc proof rows. No nested grep quoting, awk-safe.
set -u
cd /rt || exit 2
LOG=osc_full_emitter.log
rm -f "$LOG"
bash emit_and_run_sg13g2_gates.sh > "$LOG" 2>&1 || true
echo "=== SG13G2 REAL-GATE RING OSC PROOF (from emitter log) ==="
awk '
  /osc_period|osc_freq|osc_freq|OSC_P|OSC_F|SG13G2 REAL-GATE|RING OSC PROOF|OSCILLATION PROOF|period +[=:] +[0-9]|freq +[=:] +[0-9]/ {
    t=$0
    gsub(/\r/,"",t)
    print t
  }
' "$LOG" | grep -aviE 'osdi|redefin|warning, can|can\x27t move|osdi lib' | tail -4
echo "(end)"
