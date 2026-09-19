#!/usr/bin/env bash
# Part 3 - ring oscillator hardening bootstrap via OSIC (xschem + ngspice)
set -u
RING=/repo/analog/ring_oscillator
SIM=/repo/tools/local

echo "===1. XSCHEM -> SPICE (batch netlist of ring_oscillator.sch)==="
cd "$RING/xschem" || exit 1
xschem --batch --netlist ring_oscillator.sch -o /tmp 2>&1 | tail -15
echo "--- exported netlist ---"
cat /tmp/ring_oscillator.spice 2>/dev/null | head -20 || echo "(no export, checking .sch)"

echo ""
echo "===2. NGNSPICE SIMULATION (oscillation proof)==="
cd "$RING/spice" || exit 1
cp /tmp/ring_oscillator.spice ring_oscillator_exported.spice 2>/dev/null

# use the real SG13G2 ngspice model path inside the OSIC image
MODEL=$(find /foss/pdks/ihp-sg13g2 -iname "*.spice" -path "*sg13g2_stdcell*" 2>/dev/null | head -1)
[ -z "$MODEL" ] && MODEL=$(find /foss/pdks -iname "sg13g2_mos*" 2>/dev/null | head -1)
echo "PDK_MODEL=$MODEL"

# ngspice deck with ring + tt_analog_1x2 power and 1.2V
cat > /tmp/ring_osc_tb.ngs <<EOF
* ring oscillator testbench - SG13G2 (ngspice builtin behavioral gates, PDK-models)
.option uic

* --- SG13G2 stdcell behavioral gates (delay-matched to SG13G2 stdcell) ---
.model invx d_inv(rise_tp=90p fall_tp=90p)
.model nandx d_nand(rise_tp=110p fall_tp=110p)

* ring: NAND(en,fb) -> inv -> inv -> fb (odd 3-stage, 1 NAND + 2 INV)
vNAND_en ui_en 0 PULSE(0 1.2 0 20n)
vdd VPWR 0 1.2
e_top n1 0 ui_en n0 0 1.2
xui1 n0 n1 0 0 d_inv_model

* invoke via ngspice digital primitive is messy; use analog pwl instead
* Simple analog ring using VCVS with delay? 
* Use actual SG13G2 inverter SPICE from PDK:
.include $MODEL
XU1 n0 vdd vss n1 SG13G2_INV
XU2 n1 vdd vss n2 SG13G2_INV

.control
tran 1n 20n uic
plot v(n0) v(n1) v(n2)
.endc
EOF

# First: real xschem-sourced subckt sim. Use the exported netlist from step 1:
ngspice -b /tmp/ring_osc_tb.ngs 2>&1 | tail -25

echo "===3. GDS / LEF / GDS2 hierarchy (headless, verify macro material)==="
echo "Let xschems batch netlist produce the SPICE; layout via magic + LibreLane MAGIC step later"
ls -la "$RING"/*.gds* "$RING"/*.lef* 2>/dev/null | head
