# IHP26b Mixed-Signal Tiny Tapeout Plan

## Goal

Build a Tiny Tapeout IHP SG13G2 `1x1` mixed-signal project containing:

- a three-inverter analog ring oscillator;
- a 64-bit continuously counting digital counter;
- a selectable clock source: Tiny Tapeout `clk` or the ring oscillator;
- LibreLane/OpenLane integration of the analog macro and digital logic.

The IHP 1x1 tile is 202.08 x 154.98 um. Ring-clock timing is an integration experiment in version 1; the digital path is qualified against a 50 MHz external clock.

## Fixed Interface

| Pin | Function |
|---|---|
| `ui_in[0]` | Counter enable, combined with `ena` |
| `ui_in[1]` | Clock select: `0=clk`, `1=ring oscillator` |
| `ui_in[4:2]` | Counter byte select, selecting bytes 0-7 |
| `ui_in[7:5]` | Unused |
| `uo_out[7:0]` | Selected byte of the 64-bit counter |
| `uio_in[7:0]` | Unused |
| `uio_out[7:0]` | Tied low |
| `uio_oe[7:0]` | Tied low |
| `rst_n` | Active-low asynchronous reset |

Part 2 implements the clock select by folding it into the counter enable,
because the ring oscillator is not built yet:

```verilog
wire ctr_ena = ena && ui_in[0] && !ui_in[1];
```

With `clk_ring` tied to `0`, muxing the clock and freezing the counter are
observably identical, and this keeps all combinational logic off the clock
path. A combinational clock mux would form a gated clock and fail OpenROAD's
half-period clock-gating hold check at timing signoff (the select must hold
across the fall edge of `clk`, which an async `ui_in[1]` cannot satisfy).

Part 3 reintroduces the physical mux with the ring oscillator and a registered
select, per the TT guidance on auxiliary clocks (`set_clock_groups
-asynchronous` via a custom SDC):

## Work Plan

### 1. Project configuration and CI/CD

- Use the current [Tiny Tapeout IHP Verilog template](https://github.com/TinyTapeout/ttihp-verilog-template).
- Configure `info.yaml` for IHP SG13G2, `1x1`, Verilog, and 50 MHz.
- Use the standard `TinyTapeout/tt-gds-action@ttihp26b` LibreLane build, precheck, viewer, and documentation workflows.
- Keep the generated configuration compatible with a future `MACROS` entry for the oscillator.

### 2. Digital counter and simulation

- Add a parameterized counter core instantiated at 64 bits.
- Reset to zero on `negedge rst_n`; increment on `posedge clk` when `ctr_ena` (`ena && ui_in[0] && !ui_in[1]`).
- Select one of the eight counter bytes with `ui_in[4:2]`.
- Add RTL and gate-level cocotb tests for reset, enable, clock-freeze (select), byte selection, rollover, and tied-off outputs. *(deferred to a later pass — not required for the Figure submission flow)*

### 3. Analog macro integration

- Move the existing three-inverter layout work into `/analog`.
- Normalize the macro as `ring_oscillator` with physical pins `VPWR`, `VGND`, and `clk_out`.
- Generate matching GDS, pin-only LEF, and black-box/LVS views.
- Add a LibreLane `MACROS` definition, fixed placement, and explicit PDN macro hooks.
- Validate macro DRC, extraction, transient oscillation, final GDS hierarchy, and routed clock/power connectivity.

### 4. Future analog work

- Preserve Magic sources and establish `/analog/xschem`, `/analog/magic`, `/analog/spice`, `/analog/gds`, and `/analog/lef` conventions.
- Add a transistor-level PMOS/NMOS inverter schematic and three-stage Xschem testbench later.
- Replace the standard-cell oscillator with custom-transistor layout without changing the macro cell or pin contract.

## Completed

### Part 1 - committed and pushed

- Converted metadata to an IHP26b `1x1` Verilog project.
- Replaced the analog-only Verilog stub with the standard Tiny Tapeout digital wrapper.
- Added `src/config.json` with 50 MHz clock settings.
- Replaced the custom-GDS workflow with the standard IHP26b LibreLane workflow.
- Updated checkout actions to version 6.
- Updated README project description.
- Left the existing top-level analog GDS/LEF untouched for Part 3.

Commits pushed to `origin/main`:

- `06e1d73` - initial IHP26b 1x1 flow setup
- `690c9d0` - use standard IHP timing configuration
- `c379354` - adjust vertical PDN offset
- `781cc5e` - align vertical and horizontal PDN offsets

### Part 2 - counter RTL and local hardening

- Implemented the parameterized `CTR_W = 64` counter on `clk` with async reset,
  enable (`ui_in[0]` + `ena`), byte select (`ui_in[4:2]`), and tied-off IOs.
- Folded the clock select (`ui_in[1]`) into the increment enable; see the
  Fixed Interface section for why the combinational mux was deferred.
- Added `DIODE_ON_PORTS: "in"` to `src/config.json`; disconnected-pins check
  passes.
- Local LibreLane build is green end-to-end (LVS/DRC/antenna/timing signoff).
- CI `gds` and `docs` workflows pass on the pushed commits.
- cocotb tests (RTL + gate-level) deferred to a later pass.

Commits pushed to `origin/main`:

- `aee5385` - feat: add 64-bit counter with clock-select freeze
- `10a67ff` - chore: add local LibreLane hardening tooling
- `834686c` - docs: record Part 2 counter progress and timing findings

## Current CI Status

- Documentation workflow: passing.
- GDS workflow (LibreLane build + precheck): **passing** on the Part 2 counter
  commits; the Part 1 `PDN-0185` failure is resolved.
- Local LibreLane hardening: **green** (80/80 stages). LVS, DRC, antenna, setup,
  and hold timing all pass; final GDS/LEF written to `runs/wokwi/final/`.
- Flow notes for Part 3:
  - `DIODE_ON_PORTS: "in"` is set in `src/config.json` so incoming pins get
    antenna diodes and the disconnected-pins check has no dangling inputs.
  - `PNR_SDC_FILE` / `SIGNOFF_SDC_FILE` unset (generic fallback SDC). A custom
    SDC with clock groups is needed once the ring clock is real.
  - The combinational clock mux caused a half-period clock-gating hold
    violation on `ui_in[1]` (endpoint `sg13g2_nor2b_1`, ~-6.2 ns WNS) that
    OpenROAD `repair_timing -hold` cannot repair; this motivated the Part 2
    enable-fold above.
