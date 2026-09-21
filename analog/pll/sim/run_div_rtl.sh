#!/usr/bin/env bash
set -euo pipefail
SIM_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RTL="$SIM_DIR/../rtl"
cd "$SIM_DIR"
iverilog -g2012 -o out/div_n.vvp "$RTL/pll_div_n.v" tb_div_n.v
vvp out/div_n.vvp
