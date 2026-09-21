#!/usr/bin/env bash
# Run analog/fullchip_lvs_sim/run_sim.sh inside IIC-OSIC docker.
# Copies the sim tree to the container's /tmp so ngspice is not on drvfs.
set -euo pipefail
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
FLAGS=""
for arg in "$@"; do
  FLAGS="$FLAGS $arg"
done
docker run --rm --entrypoint /bin/bash \
  -v "$REPO:/repo" \
  -e "FLAGS=$FLAGS" \
  hpretl/iic-osic-tools \
  -lc 'set -euo pipefail
    mkdir -p /tmp/fullchip
    cp -a /repo/analog/fullchip_lvs_sim/. /tmp/fullchip/
    rm -rf /tmp/fullchip/out
    export LVS_SPICE=/repo/runs/wokwi/final/spice/tt_um_hackin7_analog_experiments.spice
    cd /tmp/fullchip
    bash ./run_sim.sh $FLAGS
    mkdir -p /repo/analog/fullchip_lvs_sim/out
    cp -a /tmp/fullchip/out/. /repo/analog/fullchip_lvs_sim/out/
  '
