#!/usr/bin/env bash
set -euo pipefail
export PDK_ROOT="${PDK_ROOT:-/foss/pdks}"
export PDK="${PDK:-ihp-sg13g2}"
EXT=/repo/analog/transistor_ring_oscillator/macro/ring_oscillator_extracted.spice
SCH=/repo/analog/transistor_ring_oscillator/schematic/transistor_ring_oscillator_5.spice
SETUP="$PDK_ROOT/$PDK/libs.tech/netgen/${PDK}_setup.tcl"
OUT=/repo/analog/transistor_ring_oscillator/macro/lvs.out
if [ ! -f "$SETUP" ]; then
  SETUP=$(find "$PDK_ROOT" -name '*netgen*setup*.tcl' | head -1)
fi
echo "NETGEN_SETUP=$SETUP"
netgen -batch lvs "$EXT ring_oscillator" "$SCH trosc5" "$SETUP" "$OUT"
