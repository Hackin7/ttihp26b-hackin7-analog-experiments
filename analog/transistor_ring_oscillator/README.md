# Transistor ring oscillator

Discrete IHP SG13G2 LV CMOS ring. This **is** the Tiny Tapeout analog leaf:
`src/config.json` binds module `ring_oscillator` to `macro/ring_oscillator.{gds,lef,spice}`.

The previous stdcell ring under `analog/inverter_ring_oscillator/` is kept as
reference only.

| Role | Path |
| --- | --- |
| 3-stage schematic | `schematic/main.sch` → `transistor_ring_oscillator.spice` (`trosc`) |
| 5-stage schematic | `schematic/main_5.sch` → `transistor_ring_oscillator_5.spice` (`trosc5`) |
| 5-stage Magic | `layout_5/` (`cmos_inv.mag`, `ring_oscillator.mag`) |
| Exported views | `macro/ring_oscillator.{gds,lef,spice}` |
| Sims | `sim/` |

Schematic symbols are IHP primitives `sg13g2_pr/sg13_lv_nmos.sym` and
`sg13_lv_pmos.sym`. There is no `cmos_inv` symbol and no schematic→layout
library bind. Layout is custom Magic paint on tech `ihp-sg13g2`. LVS is the
only link between the two.

Target: **5-stage, ~100 MHz**, `Wn=0.74 µm`, `Wp=1.12 µm` (same as
`sg13g2_inv_1`), `L=1.45 µm`. 3-stage `main.sch` was sized but **not** laid
out in this pass.

## 1. Schematic and pre-layout sim

xschem `main_5.sch` is five CMOS inverters in a ring (`out` → n1 → n2 → n3 →
n4 → `out`). Netlist subckt is `trosc5 out VPWR VGND`.

Pre-layout ngspice (IIC-OSIC, `mos_tt`, 1.2 V, 200 ns):

```bash
docker run --rm --entrypoint /bin/bash \
  -e TB=tb_tran5.spice -e LCH=1.45u \
  -v "$PWD:/repo" -w /repo/analog/transistor_ring_oscillator/sim \
  hpretl/iic-osic-tools -lc 'bash ./run_sim.sh'
```

Result: **100.9 MHz** (`sim/out/freq.txt`, `waveform.png`).
`sim/sweep_l.sh` was used earlier to pick `L` (3-stage 1.97 µm → 100 MHz;
5-stage 1.45 µm → 100 MHz).

## 2. Generate Magic layout

`cmos_inv.mag` is not an IHP stdcell instance. `layout_5/gen_layout.py`
stretches a **copy of the painted** `analog/inverter_ring_oscillator/layout/sg13g2_inv_1.mag`:

- Magic `tech ihp-sg13g2`, `magscale 1 2` (1 unit = 5 nm)
- Gate L 26 → 290 units (0.13 µm → **1.45 µm**); W and contact size kept
- VDD/VSS tap rails **tiled** one extra 1.44 µm site (not stretched), so
  32×32 contacts stay legal
- Cell pitch 576 units (2.88 µm)

`ring_oscillator.mag` places five `cmos_inv` cells, Metal1 Y→A jumpers,
Metal1 feedback **around** the array (not through VGND), and VPWR/VGND on
Metal1 + TopMetal1.

```bash
py -3 analog/transistor_ring_oscillator/layout_5/gen_layout.py
```

## 3. DRC (Magic, IHP tech)

```bash
docker run --rm --entrypoint /bin/bash \
  -v "$PWD:/repo" -w /repo/analog/transistor_ring_oscillator/layout_5 \
  hpretl/iic-osic-tools -lc 'bash ./run_drc_osic.sh'
```

`drc_macro.tcl` loads the top cell, `drc check`, writes `drc_report.txt`.
`drc_inv.tcl` checks `cmos_inv` alone.

Result: **0 DRC errors** on both the inverter and the five-stage top.

## 4. Extract LVS netlist (Magic)

```bash
docker run --rm --entrypoint /bin/bash \
  -v "$PWD:/repo" -w /repo/analog/transistor_ring_oscillator/layout_5 \
  hpretl/iic-osic-tools -lc 'bash ./run_export_osic.sh'
```

`export_macro.tcl`:

1. `gds write` → `macro/main_fixed.gds`, copy to `macro/ring_oscillator.gds`
2. `lef write` → `macro/ring_oscillator.lef`
3. `extract do local` / `extract all` → `layout_5/*.ext`
4. `ext2spice lvs` → `macro/ring_oscillator_extracted.spice` (devices only)

Then `tools/local/normalize_transistor_ring_macro.py` shifts the GDS/LEF to
origin (0, 0), injects a PR-boundary, and writes LibreLane pin shapes. That
normalized `macro/ring_oscillator.{gds,lef,spice}` is what `src/config.json`
points at.

IHP Magic maps painted `nmos`/`pmos` to `sg13_lv_nmos` / `sg13_lv_pmos` with
extracted `w`/`l`. The LVS spice is hierarchical: `.subckt cmos_inv` (1 NMOS +
1 PMOS) used five times.

PEX (coupling C, not for LVS) is `export_pex.tcl` →
`macro/ring_oscillator_pex.spice`.

## 5. LVS compare (netgen)

```bash
docker run --rm --entrypoint /bin/bash \
  -v "$PWD:/repo" -w /repo/analog/transistor_ring_oscillator/layout_5 \
  hpretl/iic-osic-tools -lc 'bash ./run_lvs_osic.sh'
```

`run_lvs_osic.sh` runs:

```text
netgen -batch lvs \
  "macro/ring_oscillator_extracted.spice ring_oscillator" \
  "schematic/transistor_ring_oscillator_5.spice trosc5" \
  $PDK_ROOT/ihp-sg13g2/libs.tech/netgen/ihp-sg13g2_setup.tcl \
  macro/lvs.out
```

Netgen flattens `cmos_inv` and compares to flat `trosc5`.

Result in `macro/lvs.out`: **Circuits match uniquely**
(5 PMOS + 5 NMOS, 7 nets, pins `out` / `VPWR` / `VGND`).

## 6. Post-layout sim

Same docker sim wrapper; testbenches instantiate extracted `ring_oscillator`:

| TB | Netlist | Result |
| --- | --- | --- |
| `sim/tb_pex.spice` | LVS devices only | **100.9 MHz** (same as schematic) |
| `sim/tb_pex_c.spice` | PEX + coupling C | **95.7 MHz** (~5% slow) |

```bash
# devices only
TB=tb_pex.spice LCH=1.45u bash analog/transistor_ring_oscillator/sim/run_sim_docker.sh

# with extracted C
TB=tb_pex_c.spice LCH=1.45u bash analog/transistor_ring_oscillator/sim/run_sim_docker.sh
```

`sim/extract_freq.py` reads `sim/out/ring.dat`. Comparison:
`sim/out/freq_compare.txt`. L was **not** retuned (PEX still near 100 MHz).

## Reproduce all layout checks

From the repo root, with Docker and `hpretl/iic-osic-tools`:

```bash
py -3 analog/transistor_ring_oscillator/layout_5/gen_layout.py

docker run --rm --entrypoint /bin/bash \
  -v "$PWD:/repo" -w /repo/analog/transistor_ring_oscillator/layout_5 \
  hpretl/iic-osic-tools -lc \
  'bash ./run_drc_osic.sh && bash ./run_export_osic.sh && bash ./run_lvs_osic.sh'

py -3 tools/local/normalize_transistor_ring_macro.py
```
