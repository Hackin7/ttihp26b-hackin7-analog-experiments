#!/usr/bin/env bash
# integrate_sg13g2_meas_into_openlane_sdc.sh
# B lane: promote the REAL-GATE ngspice ring measurement into OpenLane timing.
# Reads the emitter's own proof raw log, extracts osc period/freq, writes the
# derived create_clock into src/sdc/timing.sdc. Completely host-reviewable.
set -u
cd /rt || exit 2

PLOG=/rt/proof.raw.log
[ -f "$PLOG" ] || { echo "no proof.raw.log on stage; run emitter first"; exit 3; }

# osc lines: ngspice '.meas echo' rows. Filter ngspice env noise.
OSCLINE=$(awk '/osc_|osc_freq|osc_period|oscfreq|oscperiod/ && !/osdi|redefin|PATH|PYTHON|writ|writeline|SPICEOPT|Echo line/ { sub(/^ *"* */,""); gsub(/"$/,""); print; exit }' "$PLOG")
echo "raw osc line: $OSCLINE"

PERIOD=$(printf '%s\n' "$OSCLINE" | awk -F'[= ]+' '/osc_period|oscperiod|osc_freq|oscfreq/ { for(i=1;i<=NF;i++){ if($i ~ /[0-9]/){ print $i; exit } } }')
FREQ=$(printf '%s\n' "$OSCLINE" | awk -F'[= ]+' '/osc_freq|oscfreq/ { for(i=1;i<=NF;i++){ if($i ~ /[0-9]/){ print $i; exit } } }')

echo "derived period: ${PERIOD:-unset}  freq: ${FREQ:-unset}"

mkdir -p /rt/src/sdc
cat > /rt/src/sdc/timing.sdc <<SDC
# timing.sdc — derived from SG13G2 REAL-GATE ring measurement
# osc_period echoed by ngspice .meas from the consolidated gate ring TB.
# (Fallback 10ns = 100MHz if the meas row was clipped upstream.)
create_clock -name ring_osc -period ${PERIOD:-10.0n} [get_ports {out outb}]
set_clock_groups -asynchronous -group [get_clocks {clk}] -group [get_clocks {ring_osc}]
SDC
echo "=== wrote src/sdc/timing.sdc ==="
cat /rt/src/sdc/timing.sdc