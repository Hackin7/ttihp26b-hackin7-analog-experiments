#!/usr/bin/env bash
# Run analog/transistor_ring_oscillator/sim/run_sim.sh inside IIC-OSIC docker.
set -euo pipefail
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
docker run --rm --entrypoint /bin/bash \
  -e "LCH=${LCH:-}" \
  -e "SWEEP=${SWEEP:-}" \
  -e "TB=${TB:-}" \
  -e "LCH_LIST=${LCH_LIST:-}" \
  -v "$REPO:/repo" \
  -w /repo/analog/transistor_ring_oscillator_1ghz/sim \
  hpretl/iic-osic-tools \
  -lc 'if [ "${SWEEP:-}" = 1 ]; then bash ./sweep_l.sh; else bash ./run_sim.sh; fi'
