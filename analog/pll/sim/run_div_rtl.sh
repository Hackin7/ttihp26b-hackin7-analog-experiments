#!/usr/bin/env bash
set -euo pipefail
SIM_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RTL="$SIM_DIR/../rtl"
mkdir -p "$SIM_DIR/out"
cd "$SIM_DIR"

echo "== pll_div_n =="
iverilog -g2012 -o out/div_n.vvp "$RTL/pll_div_n.v" tb_div_n.v
vvp out/div_n.vvp

echo "== pll_digital =="
iverilog -g2012 -o out/pll_digital.vvp "$RTL/pll_div_n.v" "$RTL/pll_digital.v" tb_pll_digital.v
vvp out/pll_digital.vvp
