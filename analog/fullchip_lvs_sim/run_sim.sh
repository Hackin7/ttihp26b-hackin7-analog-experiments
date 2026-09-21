#!/usr/bin/env bash
# Transistor-level transient of the Magic LVS full-tile netlist.
# Prefers /foss/pdks (IIC-OSIC). Else $PDK_ROOT or ~/ttsetup/pdk.
#
# Usage:
#   analog/fullchip_lvs_sim/run_sim.sh [--op|--ring|--ring-full] [--full]
# --op        DC operating point of the full LVS netlist (fast).
# --ring      Ring clock on, reset released: tapeout 5-stage ring + mux + first CTS buffer.
# --ring-full Full tile with ring clock (very slow; thousands of PSP103 MOSFETs).
set -euo pipefail

SIM_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO="$(cd "$SIM_DIR/../.." && pwd)"
OUT_DIR="${SIM_DIR}/out"
MODE=extclk
FULL=""
for arg in "$@"; do
  case "$arg" in
    --op) MODE=op ;;
    --ring) MODE=ringpath ;;
    --ring-full) MODE=ring ;;
    --full) FULL=--full ;;
    *) echo "unknown arg: $arg" >&2; exit 2 ;;
  esac
done

mkdir -p "$OUT_DIR"
cd "$SIM_DIR"

find_ihp() {
  local candidates=()
  if [ -d /foss/pdks/ihp-sg13g2 ]; then
    candidates+=(/foss/pdks/ihp-sg13g2)
  fi
  if [ -n "${PDK_ROOT:-}" ]; then
    candidates+=("${PDK_ROOT}/ihp-sg13g2" "${PDK_ROOT}")
  fi
  candidates+=("${HOME}/ttsetup/pdk/ihp-sg13g2")
  if [ -d "${HOME}/ttsetup/pdk/ciel/ihp-sg13g2/versions" ]; then
    local ver
    for ver in "${HOME}/ttsetup/pdk/ciel/ihp-sg13g2/versions"/*/ihp-sg13g2; do
      [ -d "$ver" ] && candidates+=("$ver")
    done
  fi
  local root
  for root in "${candidates[@]}"; do
    if [ -f "$root/libs.ref/sg13g2_stdcell/spice/sg13g2_stdcell.spice" ]; then
      printf '%s\n' "$root"
      return 0
    fi
  done
  return 1
}

IHP_ROOT="$(find_ihp)" || {
  echo "IHP PDK not found (need libs.ref/sg13g2_stdcell/spice/sg13g2_stdcell.spice)." >&2
  echo "Set PDK_ROOT or run inside IIC-OSIC (/foss/pdks)." >&2
  exit 2
}

# .spiceinit expects PDK_ROOT/PDK/libs.tech/...
if [ "$(basename "$IHP_ROOT")" = "ihp-sg13g2" ]; then
  export PDK_ROOT="$(dirname "$IHP_ROOT")"
  export PDK=ihp-sg13g2
else
  export PDK_ROOT="$IHP_ROOT"
  export PDK=ihp-sg13g2
fi

MOSLIB="$IHP_ROOT/libs.tech/ngspice/models/cornerMOSlv.lib"
DIOLIB="$IHP_ROOT/libs.tech/ngspice/models/cornerDIO.lib"
STDCELL="$IHP_ROOT/libs.ref/sg13g2_stdcell/spice/sg13g2_stdcell.spice"
LVS_SPICE="${LVS_SPICE:-$REPO/runs/wokwi/final/spice/tt_um_hackin7_analog_experiments.spice}"

for f in "$MOSLIB" "$DIOLIB" "$STDCELL"; do
  if [ ! -f "$f" ]; then
    echo "missing $f" >&2
    exit 2
  fi
done

printf '.lib %s mos_tt\n' "$MOSLIB" > "$OUT_DIR/pdk.lib"
printf '.lib %s dio_tt\n' "$DIOLIB" > "$OUT_DIR/dio.lib"

SPICEINIT="$IHP_ROOT/libs.tech/ngspice/.spiceinit"
if [ -f "$SPICEINIT" ]; then
  cp "$SPICEINIT" "$SIM_DIR/.spiceinit"
  printf '\nset noinit\n' >> "$SIM_DIR/.spiceinit"
fi

python3 "$SIM_DIR/prepare_netlist.py" \
  --src "$LVS_SPICE" \
  --stdcell "$STDCELL" \
  --chip-out "$OUT_DIR/chip.spice" \
  --stdcell-out "$OUT_DIR/stdcells.spice" \
  $FULL

DUMP='v(clk) v(rst_n) v(ui_in_0) v(ui_in_1) v(uo_out_0) v(uo_out_1) v(uo_out_2) v(uo_out_3) v(uo_out_4) v(uo_out_5) v(uo_out_6) v(uo_out_7) v(xdut.xu_ring_oscillator.n1) v(xdut.xu_ring_oscillator.out)'

if [ "$MODE" = op ]; then
  cp "$SIM_DIR/ring_oscillator_dc.spice" "$OUT_DIR/ring.spice"
  cat > "$OUT_DIR/stim.spice" <<'EOF'
* Held in reset for a DC operating-point smoke of the LVS netlist.
vrst rst_n 0 dc 0
vclk clk 0 dc 0
vui0 ui_in_0 0 dc 0
vui1 ui_in_1 0 dc 0
EOF
  cat > "$OUT_DIR/analysis.spice" <<'EOF'
.control
  set noinit
  op
  echo OP_RESULT
  print v(VPWR) v(rst_n) v(clk) v(uo_out_0) v(uo_out_1) v(uo_out_7)
.endc
EOF
elif [ "$MODE" = ringpath ]; then
  cp "$SIM_DIR/ring_oscillator_lvs.spice" "$OUT_DIR/ring.spice"
  cat > "$OUT_DIR/stim.spice" <<'EOF'
* Ring clock selected (ui_in_1=1.2), reset disabled (rst_n=1.2).
* 5-stage L=1.45u tapeout ring is ~100 MHz; 80 ns covers ~8 cycles.
vrst rst_n 0 dc 1.2
vclk clk 0 dc 0
vui1 ui_in_1 0 dc 1.2
.ic v(xu_ring_oscillator.x1___A)=1.2 v(xu_ring_oscillator.x2___A)=0
+ v(xu_ring_oscillator.x3___A)=1.2 v(xu_ring_oscillator.x4___A)=0
+ v(clk_ring)=0 v(sel)=1.2
EOF
  cat > "$OUT_DIR/analysis.spice" <<'EOF'
.control
  set noinit
  tran 50p 80n uic
  wrdata out/chip.dat v(rst_n) v(ui_in_1) v(clk_ring) v(clk_sel) v(counter_clk) v(xu_ring_oscillator.x1___A) v(sel)
.endc
EOF
  TB=tb_ring_path.spice
elif [ "$MODE" = ring ]; then
  cp "$SIM_DIR/ring_oscillator_sim.spice" "$OUT_DIR/ring.spice"
  cat > "$OUT_DIR/stim.spice" <<'EOF'
* Ring clock on (ui_in_1), reset released after 0.3 ns, counter enabled.
vrst rst_n 0 pwl(0 0 0.3n 0 0.4n 1.2)
vclk clk 0 dc 0
vui0 ui_in_0 0 dc 1.2
vui1 ui_in_1 0 dc 1.2
.ic v(xdut.xu_ring_oscillator.n1)=1.2 v(xdut.xu_ring_oscillator.n2)=0 v(xdut.xu_ring_oscillator.out)=0
EOF
  cat > "$OUT_DIR/analysis.spice" <<EOF
.control
  set noinit
  option maxstep=5p
  tran 5p 1.5n uic
  wrdata out/chip.dat $DUMP
.endc
EOF
else
  cp "$SIM_DIR/ring_oscillator_dc.spice" "$OUT_DIR/ring.spice"
  cat > "$OUT_DIR/stim.spice" <<'EOF'
* External 50 MHz clk, ui_in_1=0. Ring is a DC stub so GHz oscillation
* does not dominate the timestep; use --ring for the live oscillator.
vrst rst_n 0 pwl(0 0 40n 0 41n 1.2)
vclk clk 0 pulse(0 1.2 50n 100p 100p 9.9n 20n)
vui0 ui_in_0 0 pwl(0 0 50n 0 51n 1.2)
vui1 ui_in_1 0 dc 0
EOF
  cat > "$OUT_DIR/analysis.spice" <<EOF
.control
  set noinit
  option acct
  op
  option maxstep=1n
  tran 1n 85n
  wrdata out/chip.dat $DUMP
.endc
EOF
fi

echo "[fullchip_lvs_sim] IHP_ROOT=$IHP_ROOT mode=$MODE"
ngspice -b -o "$OUT_DIR/ngspice.log" "${TB:-tb_fullchip.spice}"
python3 "$SIM_DIR/extract_counts.py" --mode "$MODE"
