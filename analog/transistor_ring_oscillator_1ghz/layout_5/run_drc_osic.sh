#!/usr/bin/env bash
set -euo pipefail
export PDK_ROOT="${PDK_ROOT:-/foss/pdks}"
export PDK="${PDK:-ihp-sg13g2}"
cd /repo/analog/transistor_ring_oscillator_1ghz/layout_5
if [ -f "$PDK_ROOT/$PDK/libs.tech/magic/ihp-sg13g2.magicrc" ]; then
  MAGICRC="$PDK_ROOT/$PDK/libs.tech/magic/ihp-sg13g2.magicrc"
else
  MAGICRC=$(find "$PDK_ROOT" -name "ihp-sg13g2.magicrc" | head -1)
fi
echo "MAGICRC=$MAGICRC"
magic -dnull -noconsole -rcfile "$MAGICRC" drc_macro.tcl
