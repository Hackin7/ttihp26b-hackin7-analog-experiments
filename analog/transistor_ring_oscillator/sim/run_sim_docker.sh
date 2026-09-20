#!/usr/bin/env bash
# Run analog/transistor_ring_oscillator/sim/run_sim.sh inside IIC-OSIC docker.
set -euo pipefail
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
docker run --rm --entrypoint /bin/bash \
  -v "$REPO:/repo" \
  -w /repo/analog/transistor_ring_oscillator/sim \
  hpretl/iic-osic-tools \
  -lc 'bash ./run_sim.sh'
