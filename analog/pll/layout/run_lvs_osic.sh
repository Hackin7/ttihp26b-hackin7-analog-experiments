#!/usr/bin/env bash
# Run netgen LVS: extracted Mag vs schematic pll_top
set -euo pipefail
export PDK_ROOT="${PDK_ROOT:-/foss/pdks}"
export PDK="${PDK:-ihp-sg13g2}"

EXT=/repo/analog/pll/macro/pll_analog_extracted.spice
SCH=/repo/analog/pll/schematic/pll_top.spice
SETUP="$PDK_ROOT/$PDK/libs.tech/netgen/${PDK}_setup.tcl"
OUT=/repo/analog/pll/macro/lvs.out

if [ ! -f "$SETUP" ]; then
  SETUP=$(find "$PDK_ROOT" -name '*netgen*setup*.tcl' 2>/dev/null | head -1)
fi
if [ ! -f "$EXT" ]; then
  echo "Missing extracted spice: $EXT" >&2
  exit 1
fi
if [ ! -f "$SCH" ]; then
  echo "Missing schematic spice: $SCH" >&2
  exit 1
fi

echo "NETGEN_SETUP=$SETUP"
echo "EXT=$EXT (cell pll_analog)"
echo "SCH=$SCH (cell pll_top)"

# Layout top is pll_analog; schematic top is pll_top
netgen -batch lvs "$EXT pll_analog" "$SCH pll_top" "$SETUP" "$OUT"
echo "Wrote $OUT"
# Print summary tail
grep -E 'Final result|Result:|Networks|Mismatch|pins are|Netlists do|Equivalent' "$OUT" | tail -40 || true
tail -30 "$OUT"
