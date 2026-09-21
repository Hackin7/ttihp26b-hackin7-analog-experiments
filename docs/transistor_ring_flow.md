# Transistor ring oscillator: full flow

End-to-end path from xschem to the Tiny Tapeout GDS. The analog leaf
`ring_oscillator` is a **5-stage discrete IHP SG13G2 CMOS ring** (~100 MHz).
The older 3-inverter stdcell ring under `analog/inverter_ring_oscillator/` is
kept as reference only.

LibreLane never reads `.sch` or `.mag`. It only merges
`analog/transistor_ring_oscillator/macro/ring_oscillator.{gds,lef,spice}`.

```text
xschem main_5.sch
        │  netlist trosc5
        ▼
ngspice (schematic) ──► ~100.9 MHz
        │
        ▼
Magic layout_5/  (cmos_inv × 5, painted on ihp-sg13g2)
        │
        ├─ DRC
        ├─ extract + ext2spice lvs
        └─ netgen LVS vs trosc5
        │
        ▼
normalize origin (0,0) + PR-boundary + LEF pins
        │
        ▼
src/config.json MACROS ──► LibreLane harden ──► chip GDS
```

## Files

| Role | Path |
| --- | --- |
| 5-stage schematic | `analog/transistor_ring_oscillator/schematic/main_5.sch` |
| Schematic netlist | `…/schematic/transistor_ring_oscillator_5.spice` (`.subckt trosc5`) |
| 3-stage schematic (not laid out) | `…/schematic/main.sch` / `transistor_ring_oscillator.spice` (`trosc`) |
| Layout generator | `…/layout_5/gen_layout.py` |
| Magic source | `…/layout_5/cmos_inv.mag`, `ring_oscillator.mag` |
| DRC / export / LVS scripts | `…/layout_5/run_*_osic.sh`, `*.tcl` |
| Pre-LibreLane GDS | `…/macro/main_fixed.gds` (Magic write, negative origin) |
| Leaf views (what TT uses) | `…/macro/ring_oscillator.{gds,lef,spice}` |
| LVS log | `…/macro/lvs.out` |
| Origin normalizer | `tools/local/normalize_transistor_ring_macro.py` |
| TT bind | `src/config.json` `MACROS.ring_oscillator` |
| Blackbox RTL | `src/ring_oscillator.v` |
| Instantiation | `src/project.v` (`u_ring_oscillator`) |
| PDN jumpers | `tools/local/pdn_cfg.tcl` |
| Sims | `analog/transistor_ring_oscillator/sim/` |

Sizing: `Wn=0.74 µm`, `Wp=1.12 µm` (same as `sg13g2_inv_1`), **`L=1.45 µm`**,
five stages. 3-stage `main.sch` used `L=1.97 µm` for the same 100 MHz target
and was not laid out.

Schematic and layout are **not** library-linked. xschem places IHP primitive
symbols `sg13g2_pr/sg13_lv_nmos.sym` and `sg13_lv_pmos.sym`. Magic `cmos_inv`
is custom paint on tech `ihp-sg13g2` (a stretched copy of painted
`sg13g2_inv_1.mag`, not a stdcell `use`). LVS is the only connection.

## 1. Schematic

`main_5.sch` is five CMOS inverters in a ring:

`out` → n1 → n2 → n3 → n4 → `out`

Ports: `out`, `VPWR`, `VGND`. Subckt name `trosc5`. Feedback must not short
`out` to `VGND` (the drop from the last drain goes around the ground rail).

## 2. Pre-layout simulation (pick L)

IIC-OSIC docker, `mos_tt`, 1.2 V, 200 ns transient. `sim/extract_freq.py`
reads `sim/out/ring.dat`.

```bash
docker run --rm --entrypoint /bin/bash \
  -e TB=tb_tran5.spice -e LCH=1.45u \
  -v "$PWD:/repo" -w /repo/analog/transistor_ring_oscillator/sim \
  hpretl/iic-osic-tools -lc 'bash ./run_sim.sh'
```

`sim/sweep_l.sh` swept gate length. Results used:

| Circuit | L | Frequency |
| --- | --- | --- |
| 3-stage `main.sch` | 1.97 µm | 100.3 MHz |
| 5-stage `main_5.sch` | 1.45 µm | **100.9 MHz** |

Lmin 3-stage was ~6.45 GHz; the ring is self-loaded so **L is the frequency
knob**, W barely moves f.

## 3. Generate Magic layout

```bash
py -3 analog/transistor_ring_oscillator/layout_5/gen_layout.py
```

`gen_layout.py` copies `analog/inverter_ring_oscillator/layout/sg13g2_inv_1.mag`
and stretches the shared poly gate in X:

- `tech ihp-sg13g2`, `magscale 1 2` (1 unit = 5 nm)
- Gate 26 → 290 units (0.13 µm → 1.45 µm); W and 32×32 contacts kept
- VDD/VSS tap rails **tiled** one extra 1.44 µm site (not stretched) so
  contacts stay 0.16 µm
- Inverter pitch 576 units (2.88 µm)

`ring_oscillator.mag` then:

1. Places five `cmos_inv` instances
2. Routes Metal1 Y→A between stages
3. Closes the ring with Metal1 **around** the array (not through VGND)
4. Adds a 1.0 µm Metal1 `out` pad for LibreLane routing
5. Puts `VPWR` / `VGND` on Metal1 rails plus TopMetal1 pads

## 4. DRC

```bash
docker run --rm --entrypoint /bin/bash \
  -v "$PWD:/repo" -w /repo/analog/transistor_ring_oscillator/layout_5 \
  hpretl/iic-osic-tools -lc 'bash ./run_drc_osic.sh'
```

Uses `$PDK_ROOT/ihp-sg13g2/libs.tech/magic/ihp-sg13g2.magicrc`.
`drc_macro.tcl` checks the top cell; `drc_inv.tcl` checks `cmos_inv`.
Report: `layout_5/drc_report.txt`.

**Result: 0 DRC errors.**

## 5. Extract layout netlist (LVS spice)

```bash
docker run --rm --entrypoint /bin/bash \
  -v "$PWD:/repo" -w /repo/analog/transistor_ring_oscillator/layout_5 \
  hpretl/iic-osic-tools -lc 'bash ./run_export_osic.sh'
```

`export_macro.tcl`:

1. `gds write` → `macro/main_fixed.gds`
2. `lef write` → `macro/ring_oscillator.lef` (Magic coords, negative origin)
3. `extract do local` / `extract all` → `layout_5/*.ext`
4. `ext2spice lvs` → `macro/ring_oscillator_extracted.spice` (devices only)

IHP Magic maps painted `nmos`/`pmos` to `sg13_lv_nmos` / `sg13_lv_pmos` with
extracted `w`/`l`. Hierarchy is five `cmos_inv` (1 NMOS + 1 PMOS each).

PEX (coupling C, **not** for LVS): `export_pex.tcl` →
`macro/ring_oscillator_pex.spice`.

## 6. LVS (netgen)

```bash
docker run --rm --entrypoint /bin/bash \
  -v "$PWD:/repo" -w /repo/analog/transistor_ring_oscillator/layout_5 \
  hpretl/iic-osic-tools -lc 'bash ./run_lvs_osic.sh'
```

```text
netgen -batch lvs \
  "macro/ring_oscillator_extracted.spice ring_oscillator" \
  "schematic/transistor_ring_oscillator_5.spice trosc5" \
  $PDK_ROOT/ihp-sg13g2/libs.tech/netgen/ihp-sg13g2_setup.tcl \
  macro/lvs.out
```

Netgen flattens `cmos_inv` and compares to flat `trosc5`.

**Result (`macro/lvs.out`): Circuits match uniquely** — 5 PMOS + 5 NMOS, 7
nets, pins `out` / `VPWR` / `VGND`.

## 7. Post-layout simulation

Same docker sim wrapper; TBs instantiate extracted `ring_oscillator`:

| TB | Netlist | Frequency |
| --- | --- | --- |
| `sim/tb_tran5.spice` | Schematic `trosc5` | **100.9 MHz** |
| `sim/tb_pex.spice` | LVS devices only | **100.9 MHz** |
| `sim/tb_pex_c.spice` | PEX + coupling C | **95.7 MHz** (~5% slow) |

```bash
TB=tb_pex.spice LCH=1.45u bash analog/transistor_ring_oscillator/sim/run_sim_docker.sh
TB=tb_pex_c.spice LCH=1.45u bash analog/transistor_ring_oscillator/sim/run_sim_docker.sh
```

L was **not** retuned. Comparison: `sim/out/freq_compare.txt`.

## 8. Normalize leaf for LibreLane

Magic GDS/LEF sit at a negative origin (feedback and TopMetal1 overhang).
LibreLane needs origin (0, 0), a PR-boundary, and simple pin shapes.

```bash
py -3 tools/local/normalize_transistor_ring_macro.py
```

That script:

- Shifts top-cell GDS XY by (0.930, 0.730) µm (930, 730 nm DBU)
- Injects IHP PR-boundary layer 189/4 covering **16.130 × 5.330 µm**
- Rewrites LEF: `ORIGIN 0 0`, `CLASS BLOCK`, pins
  - `out` Metal1 `14.625 2.130 15.625 3.130`
  - `VPWR` Metal1 rail + TopMetal1 `0.000 3.690 2.200 5.330`
  - `VGND` Metal1 rail + TopMetal1 `13.930 0.000 16.130 1.640`
- Copies extracted spice to `macro/ring_oscillator.spice`

Run this **once** on a fresh Magic export (it overwrites the LEF).

## 9. Bind as the Tiny Tapeout analog leaf

`src/config.json`:

```json
"MACROS": {
  "ring_oscillator": {
    "instances": {
      "u_ring_oscillator": { "location": [53.28, 18.90], "orientation": "N" }
    },
    "gds": ["dir::../analog/transistor_ring_oscillator/macro/ring_oscillator.gds"],
    "lef": ["dir::../analog/transistor_ring_oscillator/macro/ring_oscillator.lef"],
    "spice": ["dir::../analog/transistor_ring_oscillator/macro/ring_oscillator.spice"]
  }
}
```

RTL already instantiates `ring_oscillator u_ring_oscillator` in
`src/project.v`; `out` is auto-routed as `clk_ring`. Power is
`PDN_MACRO_CONNECTIONS`: `"u_ring_oscillator VPWR VGND VPWR VGND"`.

`tools/local/pdn_cfg.tcl` TopMetal1 jumpers must match the **normalized**
pads (relative to the instance origin):

| Net | X range (µm) |
| --- | --- |
| VPWR | 0.00 – 2.20 |
| VGND | 13.93 – 16.13 |

`src/ring_oscillator.v` stays a `(* blackbox *)` with CMOS `out` only
(power pins appear in the powered netlist).

## 10. Harden chip GDS

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools/local/build.ps1
```

Same flow as CI (`tt-support-tools` + LibreLane). Merged GDS lands under
`runs/wokwi/final/`. Digital STA still qualifies **50 MHz on `clk`**; the
ring is not in the SDC and is not a qualified counter clock.

## Reproduce analog checks + leaf views

From the repo root, Docker + `hpretl/iic-osic-tools`:

```bash
py -3 analog/transistor_ring_oscillator/layout_5/gen_layout.py

docker run --rm --entrypoint /bin/bash \
  -v "$PWD:/repo" -w /repo/analog/transistor_ring_oscillator/layout_5 \
  hpretl/iic-osic-tools -lc \
  'bash ./run_drc_osic.sh && bash ./run_export_osic.sh && bash ./run_lvs_osic.sh'

py -3 tools/local/normalize_transistor_ring_macro.py
```

Then harden (step 10) if the chip GDS must pick up the new leaf.

## 500 MHz duplicate

A second 5-stage ring sized for 500 MHz lives in
`analog/transistor_ring_oscillator_500mhz/` (`L=0.555 µm`, schematic 540.6 MHz,
PEX+C 499.2 MHz). LibreLane cell name is `ring_oscillator_500mhz`. It is
instantiated beside the 100 MHz leaf; select with `ui_in[1]`/`ui_in[5]` (see
`docs/hierarchy.md`).
