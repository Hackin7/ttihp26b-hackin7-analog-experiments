#!/usr/bin/env bash
set -euo pipefail
export PDK_ROOT="${PDK_ROOT:-/foss/pdks}"
export PDK="${PDK:-ihp-sg13g2}"
cd /repo/analog/inverter_ring_oscillator/layout
# Load the IHP magicrc so ihp-sg13g2 tech is available
if [ -f "$PDK_ROOT/$PDK/libs.tech/magic/ihp-sg13g2.magicrc" ]; then
  MAGICRC="$PDK_ROOT/$PDK/libs.tech/magic/ihp-sg13g2.magicrc"
else
  MAGICRC=$(find "$PDK_ROOT" -name "ihp-sg13g2.magicrc" | head -1)
fi
echo "MAGICRC=$MAGICRC"
magic -dnull -noconsole -rcfile "$MAGICRC" export_macro.tcl
ls -l ../macro/main_fixed.gds ../macro/ring_oscillator_extracted.spice 2>/dev/null || true
