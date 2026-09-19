#!/usr/bin/env bash
set -u

SRC=/runme
MODELS=$(find /foss/pdks/ihp-sg13g2 -name "sg13g2_mos*.cmp" 2>/dev/null | head -1)
if [ -z "$MODELS" ]; then
  # fall back to whatever ngspice model file the PDK ships
  MODELS=$(find /foss/pdks/ihp-sg13g2 -iname "*.cmp" 2>/dev/null | head -1)
fi
echo "USING_MODELS=$MODELS"

# Build a corrected netlist in /work with the real PDK model included
mkdir -p /work
cp "$SRC/ring_oscillator.ngs" "/work/ring_tb.ngs"
if [ -n "$MODELS" ]; then
  sed -i "s|^\.include <pdk_models_file>|.include \"$MODELS\"|" "/work/ring_tb.ngs"
fi

cd /work
ngspice -b ring_tb.ngs | tail -60
