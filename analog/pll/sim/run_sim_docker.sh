#!/usr/bin/env bash
set -euo pipefail
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
docker run --rm --entrypoint /bin/bash \
  -e "LCH=${LCH:-0.25u}" \
  -e "TB=${TB:-tb_vco_point.spice}" \
  -e "SWEEP=${SWEEP:-0}" \
  -v "$REPO:/repo" \
  -w /repo/analog/pll/sim \
  hpretl/iic-osic-tools \
  -lc 'if [ "${SWEEP:-0}" = 1 ]; then bash ./sweep_vctrl.sh; else bash ./run_sim.sh; fi'
