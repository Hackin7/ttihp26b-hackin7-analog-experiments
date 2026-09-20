# Hierarchical mixed-signal top

The Tiny Tapeout cell `tt_um_hackin7_analog_experiments` is a thin assembler:

- Analog leaf: `ring_oscillator` (pre-hardened GDS/LEF, see
  `analog/inverter_ring_oscillator/`)
- Digital leaf: `digital_counter` (RTL in `src/counter.v`, synthesized into the top)
- Glue: clock mux `ui_in[1] ? clk_ring : clk` in `src/project.v`

`tt_tool.py --harden` runs LibreLane on this top. Every Verilog signal net is
auto-routed, including `clk_ring`. Power uses PDN.

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

## How to add another digital block

Add RTL under `src/` and instantiate it from `src/project.v` (same as
`digital_counter`). Only pre-harden it to GDS/LEF and list it under `MACROS`
if it must stay a separate island.
