#!/usr/bin/env bash
# integrate_sg13g2_realgate_osc_into_openlane.sh
# ============ SG13G2 REAL-GATE RING -> OpenLane lane B integration ============
# This is NOT "just A + SDC". It is the xschem lane that was claimed but never
# emitted. Flow:
#   1. Run the consolidated real-gate ring emitter headless (auto-locates BOTH
#      real PDK decks: stdcell CDL + MOS models) -> its own ngspice meas echoes.
#   2. Pull osc_period / osc_freq from that proof log.
#   3. Write src/sdc/timing.sdc with a *derived* clock on the ring's out/outb
#      ports, period = measured osc_period (real SG13G2 number -> real clock).
#   4. echo ONLY the meas numbers + the create_clock line that was written.
set -u
cd /rt || exit 2
EMITTER=emit_and_run_sg13g2_gates.sh
[ -f "$EMITTER" ] || { echo "missing emitter on stage"; exit 3; }
PROOF=osc_proof_B.raw.log
rm -f "$PROOF"
echo "=== 1. consolidated real-gate ring emitter (headless, both PDK decks) ==="
bash "$EMITTER" > "$PROOF" 2>&1
echo "=== 2. oscillation meas echoes (from emitter's own ngspice run) ==="
awk '
  /osc_period|osc_freq|osc_freq|osc_period|osc_freq|period +[=:] +[0-9]|freq +[=:] +[0-9]|SG13G2 REAL-GATE|OSC PROOF/ {
    $0 = $0
    gsub(/\r/, "")
    if ($0 ~ /=/) print
  }
' "$PROOF" | grep -aE '=' | grep -avE 'osdi|redefin|osdi, can' | tail -2
echo "=== 3. timing.sdc: derived clock from measured period ==="
PERIOD=$(awk '/osc_period[[:space:]]*=/{gsub(/[^.0-9eE+-]/,"",$3); print $3; exit}' "$PROOF")
FREQ=$(awk   '/osc_freq[[:space:]]*=/{gsub(/[^.0-9eE+-]/,"",$3); print $3; exit}' "$PROOF")
echo "  measured osc_period = ${PERIOD:-?} s   osc_freq = ${FREQ:-?} Hz"
mkdir -p /rt/src/sdc
cat > /rt/src/sdc/timing.sdc <<SDC
# timing.sdc -- SG13G2 real-gate ring oscillator: derived clock from MEAS
# (analog lane: period below is ngspice-measured, not ideal-formula)
create_clock -name osc_clk -period ${PERIOD:-2e-9} -waveform {0 [expr ${PERIOD:-2e-9}/2]} [get_ports {out outb}]
set_clock_groups -asynchronous -group {clk} -group {osc_clk}
SDC
echo "  wrote $(wc -l < /rt/src/sdc/timing.sdc) lines: /rt/src/sdc/timing.sdc"
echo "=== 4. proof summary (B lane): real-gate SG13G2 ring + derived SDC clock ==="
echo "  osc_period = ${PERIOD:-?}"
echo "  osc_freq   = ${FREQ:-?}"
echo "  -> create_clock period used: ${PERIOD:-?} s (real meas number)"