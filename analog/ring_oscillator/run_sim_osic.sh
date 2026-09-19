#!/usr/bin/env bash
# Part 3 - ring oscillator SPICE -> ngspice batch (OSIC container)
# Note: uses the ring netlist already exported from the xschem schematic
# (analog/ring_oscillator/xschem/ring_oscillator.sch). Gate delays use the
# SG13G2 stdcell routable targets, matched to the IHP 1x1.2V cells.
set -u
SIMROOT=/runme/analog/ring_oscillator/spice
cd "$SIMROOT"

echo "=== 0. xschem -> SPICE (batch, headless; .sch already checked in) ==="
# xschem --batch netlist export (same env used to build the .spice):
#   xschem --netlist ring_oscillator.sch   (run interactively in the GUI container)
echo "(schematic checked in; manual xschem --netlist export is a GUI-side step)"

echo
echo "=== 1. ngspice: 3-stage NAND-gated ring @1.2V, 200ns transient ==="
ngspice -b ring_oscillator_tb.spice 2>&1 | grep -Ei "period|freq|oscill|v\(clk|error" | head -30

echo
echo "=== 2. ngspice: ring dot-model quick check (behavioral gates) ==="
# fallback smoke: verify the deck parses and the enable path toggles
ngspice -b ring_oscillator.spice 2>&1 | grep -Ei "error|warning|reading|calculate" | head -10
echo "DONE"
