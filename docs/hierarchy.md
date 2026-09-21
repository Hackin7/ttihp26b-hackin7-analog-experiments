# Hierarchical mixed-signal top

The Tiny Tapeout cell `tt_um_hackin7_analog_experiments` is a thin assembler:

- Analog leaves:
  - `ring_oscillator` (~100 MHz, `analog/transistor_ring_oscillator/`) at `[53.28, 18.90]`
  - `ring_oscillator_500mhz` (~500 MHz, `analog/transistor_ring_oscillator_500mhz/`) at `[53.28, 40.0]`
- Decorative `chips_art` (TopMetal1 COVER macro)
- Digital leaf: `digital_counter` (RTL in `src/counter.v`, synthesized into the top)
- Digital leaf: `pll_digital` (÷N feedback + ÷M output; `clk_vco` stubbed until `pll_analog`)
- Glue: clock mux in `src/project.v`
  - `ui_in[7]=1` → PLL ÷M (`pll_clk_out`, stubbed idle for now)
  - `ui_in[1]=0` → Tiny Tapeout `clk`
  - `ui_in[1]=1`, `ui_in[5]=0` → 100 MHz ring
  - `ui_in[1]=1`, `ui_in[5]=1` → 500 MHz ring
  - `uio[0]` = PLL ÷M probe; `uio[4:1]` = N select; `{ui[6],uio[7:5]}` = M select

`tt_tool.py --harden` runs LibreLane on this top. Every Verilog signal net is
auto-routed, including `clk_ring_100` / `clk_ring_500`. Power uses PDN.

How the analog leaf was built and swapped in:
[transistor_ring_flow.md](transistor_ring_flow.md).

## How to add another analog block

1. Author layout/schematic under `analog/<name>/`.
2. Emit `analog/<name>/macro/<cell>.{gds,lef,spice}` with cell name `<cell>`.
3. Add `src/<cell>.v` as a `(* blackbox *)` module with the CMOS signal ports only.
4. List that Verilog file in `info.yaml` `source_files`.
5. Instantiate it in `src/project.v`.
6. Add a `MACROS` entry in `src/config.json` whose key is `<cell>`, instance
   name matches RTL, and `gds`/`lef`/`spice` point at the macro views.
7. If it has `VPWR`/`VGND`, append a `PDN_MACRO_CONNECTIONS` line:
   `"<inst> VPWR VGND VPWR VGND"`.
8. If it needs TopMetal1 PDN jumpers like the rings, extend
   `tools/local/pdn_cfg.tcl` `analog_fix_power_pins` for the new instance.

## How to add another digital block

Add RTL under `src/` and instantiate it from `src/project.v` (same as
`digital_counter`). Only pre-harden it to GDS/LEF and list it under `MACROS`
if it must stay a separate island.
