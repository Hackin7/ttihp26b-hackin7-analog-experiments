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

The clock mux is intentionally the simple combinational form:

```verilog
wire selected_clk = ui_in[1] ? clk_ring : clk;
```

Changing the selector while operating can create shortened or extra pulses; software should select the source while reset or counting is inactive.

## Work Plan

### 1. Project configuration and CI/CD

- Use the current [Tiny Tapeout IHP Verilog template](https://github.com/TinyTapeout/ttihp-verilog-template).
- Configure `info.yaml` for IHP SG13G2, `1x1`, Verilog, and 50 MHz.
- Use the standard `TinyTapeout/tt-gds-action@ttihp26b` LibreLane build, precheck, viewer, and documentation workflows.
- Keep the generated configuration compatible with a future `MACROS` entry for the oscillator.

### 2. Digital counter and simulation

- Add a parameterized counter core instantiated at 64 bits.
- Reset to zero on `negedge rst_n`; increment on `posedge selected_clk` when `ena && ui_in[0]`.
- Select one of the eight counter bytes with `ui_in[4:2]`.
- Add RTL and gate-level cocotb tests for reset, enable, both clocks, byte selection, rollover, and tied-off outputs.

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

## Current CI Status

- Documentation workflow: passing.
- GDS workflow: still failing during LibreLane PDN generation after the offset adjustments.
- Original failure was:

  ```text
  PDN-0185: Insufficient width (18.24 um) to add straps on TopMetal1
  ```

- Current repository state is clean and synchronized with `origin/main`.
- Detailed GitHub job logs were not available through the unauthenticated API; the next implementation step is to obtain the latest GDS log or reproduce the flow locally with the IHP PDK and LibreLane.

Latest failed run: [GitHub Actions run 35046784810](https://github.com/Hackin7/ttihp26b-hackin7-analog-experiments/actions/runs/35046784810)
