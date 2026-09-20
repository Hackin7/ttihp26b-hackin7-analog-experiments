# Analog leaf: `ring_oscillator`

This directory is the analog **leaf**. LibreLane never reads `.mag` or `.sch`
directly. The Tiny Tapeout top instantiates Verilog module `ring_oscillator`
and `src/config.json` binds that name to these views:

| View | Path | Used for |
| --- | --- | --- |
| GDS | `macro/ring_oscillator.gds` | Final layout merge |
| LEF | `macro/ring_oscillator.lef` | Place, route, PDN |
| SPICE | `macro/ring_oscillator.spice` | LVS |

Names that must match: module `ring_oscillator`, GDS/LEF cell `ring_oscillator`,
instance `u_ring_oscillator` in `src/project.v`.

Signal pin `out` is CMOS Metal1. LibreLane auto-routes it to `clk_ring`.
Power pins `VPWR` / `VGND` are not in the Verilog header; PDN connects them.

Source layout/schematic live in `layout/` and `schematic/`. After editing them,
regenerate `macro/` (Magic GDS write + LEF with ports) before hardening.
