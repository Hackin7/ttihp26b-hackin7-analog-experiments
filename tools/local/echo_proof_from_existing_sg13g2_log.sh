#!/usr/bin/env bash
# proof_echo_from_existing_log.sh
# Print ONLY the SG13G2 real-gate ring meas echoes from the already-written raw
# ngspice log. No docker-level quoting: all filtering lives in this file.
set -u
cd /rt || exit 2
LOG=proof.raw.log
[ -f "$LOG" ] || LOG=ring_gates_consolidated_meas.log
[ -f "$LOG" ] || { echo "no meas log found in /rt"; exit 3; }
echo "=== SG13G2 REAL-GATE RING: osc proof echoes (from $LOG) ==="
awk 'NF && /osc_|oscill|period|freq|OSC|SG13G2|tr_a|tr_b|PROOF/ && !/osdi|redefin|osdi, can|cannot move|osdi =|redefin, can/' "$LOG" \
  | grep -aE '= ?[0-9]|PROOF|REAL-GATE' | tail -2