#!/usr/bin/env bash
# emit_and_run_sg13g2_gates.sh -- ONE consolidated proof:
#   - locate REAL gate-subckt deck (defines sg13g2_nand2_1 subckt, references
#     sg13_lv_nmos/pmos primitives)
#   - locate REAL MOS-model deck (defines .model sg13_lv_nmos/sg13_lv_pmos)
#   - emit a TB that .includes BOTH (no sed, no manual path) and runs the
#     3-stage gated ring of REAL gates, measuring osc period + frequency.
set -u
PDK=/foss/pdks/ihp-sg13g2
cd /rt

echo "=== 1. locate gate-subckt deck ==="
GATED=$(grep -rlisE '^[[:space:]]*\.subckt[[:space:]]+sg13g2_nand2_1([[:space:]]|$)' \
          "${PDK}/libs.ref" 2>/dev/null | head -1)
GATED=${GATED:-$(find ${PDK}/libs.ref -type f \( -name '*.spice' -o -name '*.cdl' \) \
           -exec grep -lE '^\.subckt[[:space:]]+sg13g2_nand2_1([[:space:]]|$)' {} \; 2>/dev/null | head -1)}
echo "gate-deck        = ${GATED:-MISSING}"

echo "=== 2. locate MOS-model deck (any file mentioning sg13_lv_nmos) ==="
MOSD=$(find ${PDK}/libs.ref -type f \( -name '*.spice' -o -name '*.cdl' -o -name '*.lib' \) \
       -exec grep -lE 'sg13_lv_nmos' {} \; 2>/dev/null \
       | grep -vF "${GATED}" | head -1)
echo "mos-model-deck   = ${MOSD:-MISSING}"
if [ -z "${GATED}" ] || [ -z "${MOSD}" ]; then
  echo "!! could not auto-locate both decks -> abort (no oscillation proof possible)"
  exit 2
fi

echo "=== 3. emit consolidated TB (both includes) ==="
cat > ring_gates_consolidated_tb.spice <<TBEOF
* ring_gates_consolidated_tb.spice -- REAL SG13G2 gate-level ring proof
.include ${GATED}
.include ${MOSD}

* supplies + enable
vvdd VPWR 0 DC 1.2
ven  enable 0 DC 1.2

* ---------------- gated 3-stage ring of REAL gate subckts ----------------
* stage A: nand2(enable, n3) -> n1  (SG13G2 real gate)
xnandA VPWR 0 m0 xg0 RWN sg13g2_nand2_1
* placeholder replaced below
TBEOF
echo "  (deck emit begins; actual instance body emitted in step 4)"

echo "=== 3b. rewrite with real ngspice-parseable body ==="
cat > ring_gates_consolidated_tb.spice <<TBEOF
* ring_gates_consolidated_tb.spice -- REAL SG13G2 gate-level ring proof
.include ${GATED}
.include ${MOSD}

* supplies + enable
vvdd VPWR 0 DC 1.2
ven  enable 0 DC 1.2

* ---------------- gated 3-stage ring of REAL SG13G2 gate subckts ----------
* stage A: nand2(enable, n3) -> n1
xnandA VPWR 0 n1 enable n3 sg13g2_nand2_1
ra n1 0 3400
ca n1 0 18f

* stage B: inv(n1) -> n2
xinvB VPWR 0 n2 n1 sg13g2_inv_1
rb n2 0 1500
cb n2 0 20f

* stage C: inv(n2) -> n3
xinvC VPWR 0 n3 n2 sg13g2_inv_1
rc n3 0 2500
cc n3 0 15f

* output: buf(n1) -> clk_out
xbufD VPWR 0 clk_out n1 sg13g2_buf_2
rbuf clk_out 0 100
cbuf clk_out 0 60f

* deterministic asymmetric start (break degenerate fixpoint deterministically)
.ic v(n1)=0.0 v(n2)=1.2 v(n3)=0.0

* ---------------- transient + crossing-based period/freq measurement --------
.control
  tran 5p 250n uic
  meas tran tr_a when v(clk_out)=0.6 rise=6
  meas tran tr_b when v(clk_out)=0.6 rise=16
  let osc_period = (tr_b - tr_a)/10
  let osc_freq   = 1/osc_period
  echo "=================================================="
  echo " SG13G2 REAL-GATE 3-STAGE RING -- OSCILLATION PROOF"
  echo "  tr_a       = $&tr_a s"
  echo "  tr_b       = $&tr_b s"
  echo "  osc_period = $&osc_period s"
  echo "  osc_freq   = $&osc_freq Hz"
  echo "  osc_freq   = $&osc_freq/1meg MHz"
  echo "=================================================="
  write ring_gates_consolidated.raw v(clk_out) v(n1) v(n2) v(n3)
.endc

.end
TBEOF
echo "  wrote $(wc -l < ring_gates_consolidated_tb.spice) lines"

echo "=== 4. ngspice headless: SG13G2 real-gate ring (consolidated) ==="
ngspice -b ring_gates_consolidated_tb.spice 2>&1 \
  | grep -EiE 'osc_|osc_period|osc_freq|SG13G2 REAL-GATE|tr_[ab]|meas|period|freq' \
  | grep -viE 'redefinition|osdi|warning, can|osdi lib' | head -12
