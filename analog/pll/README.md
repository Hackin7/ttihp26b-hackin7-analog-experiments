# Analog PLL (manual): ~1.1 GHz VCO class, 50 MHz reference

Type-II PFD–CP PLL schematic in [`schematic/pll_top.sch`](schematic/pll_top.sch).
Pre-layout ngspice decks under [`sim/`](sim/). Feedback divider RTL: [`rtl/pll_div_n.v`](rtl/pll_div_n.v).

## Spec

| Item | Value |
| --- | --- |
| `f_ref` | 50 MHz |
| VCO `f_max` (pre-layout) | **≥ 1.1 GHz** |
| Feedback | `pll_div_n` with **N = 8…22** (`f_out = N × 50 MHz`) |
| Primary lock target | N=16 → **800 MHz** |
| Max-edge target | N=22 → **1.1 GHz** |

## Device sizing (after sim trim)

| Block | Sizing |
| --- | --- |
| VCO FETs (ring/starve/bias/buffer) | W **1.12u / 0.74u**, **L = 0.25u** |
| CP mirrors | ~1 µA (`R2` rhigh 0.5×260u, M1/M4/M5/M6/M7 as in sch) |
| Loop filter | `R1` rhigh **0.5×70u**, `C1` **20×20 µm**, `C2` **8×8 µm** |

`L` was reduced from the plan’s 0.38u start after open-loop sim (0.38u peaked ~0.72 GHz @ vctrl=0.9).

## Open-loop VCO sweep (`lch=0.25u`, mos_tt, 1.2 V)

From [`sim/out/vco_sweep.txt`](sim/out/vco_sweep.txt):

| vctrl (V) | freq |
| --- | --- |
| 0.40–0.50 | no solid oscillation in 50 ns window |
| 0.60 | **610 MHz** |
| 0.70 | **911 MHz** |
| 0.80 | **1.12 GHz** |
| 0.90 | **1.24 GHz** |
| 1.00 | **1.32 GHz** |

**Pass:** `f_max > 1.1 GHz`. Usable band roughly **~0.6–1.3 GHz** → lockable N ≈ **12…26** with 50 MHz ref (N=22 = 1.1 GHz is inside).

Point check: vctrl=0.78 → **1.068 GHz** (near 1.1 GHz / N=22).

## Verilog divider

```bash
docker run --rm -v "$PWD:/repo" -w /repo/analog/pll/sim \
  --entrypoint /bin/bash hpretl/iic-osic-tools -lc 'bash ./run_div_rtl.sh'
```

Result: **PASS** `pll_div_n` N=8/16/22 (edge counts 1250/625/455 at 1 GHz / 10 µs).

## Closed-loop note

`tb_pll_lock.spice` instantiates [`schematic/pll_top.spice`](schematic/pll_top.spice) (transistor PFD/CP/filter/VCO) plus a behavioral switch ÷16 on `vco_out_div`. RTL `pll_div_n` remains a separate digital check.

## Layout (xschem Mag seed)

Primary Mag cell: [`layout/pll_analog.mag`](layout/pll_analog.mag) — Mag seed from earlier gencell import + snaked `rhigh`.

| Resistor | Snaked Mag bbox |
| --- | --- |
| R2 (~700 kΩ) | **21 × 16** µm (`rhigh_R2_snake`, `nx=20`) |
| R1 (~191 kΩ) | **11 × 10** µm (`rhigh_R1_snake`, `nx=10`) |
| `pll_analog` seed | ~62 × 51 µm (~10% of a TT die) |

Rebuild snaked leaf:

```bash
docker run --rm --entrypoint /bin/bash \
  -v "$PWD:/repo" -w /repo/analog/pll/layout \
  hpretl/iic-osic-tools -lc \
  'magic -dnull -noconsole -rcfile /foss/pdks/ihp-sg13g2/libs.tech/magic/ihp-sg13g2.magicrc rebuild_analog_snake.tcl'
```

PFD stdcells (`sg13g2_dfrbpq_1` ×2, `sg13g2_and2_1`, `sg13g2_inv_1`) are imported into [`layout/pll_analog.mag`](layout/pll_analog.mag) as instances `x1`–`x4` (see [`layout/import_pfd_stdcells.tcl`](layout/import_pfd_stdcells.tcl)).

Floorplan is schematic-ordered L→R via [`layout/relayout_sections.tcl`](layout/relayout_sections.tcl): **PFD | CP | bias | filter | VCO**.

Manhattan layer-aware seed routing (Metal1 verticals, Metal2 trunks, Via1):
[`layout/gen_route_pll.py`](layout/gen_route_pll.py) → [`layout/route_pll.tcl`](layout/route_pll.tcl).

LVS (extract + netgen): [`layout/extract_lvs.tcl`](layout/extract_lvs.tcl), [`layout/run_lvs_osic.sh`](layout/run_lvs_osic.sh) → [`macro/lvs.out`](macro/lvs.out). **Currently FAIL** — Mag extract sees top ports shorted together by the seed routes.

**Not done yet:** DRC-clean / LVS-clean routing, macro export, TT bind.

## Simulate

Spice decks include [`schematic/pll_top.spice`](schematic/pll_top.spice). Open-loop forces hierarchical `Xpll.vctrl`; closed-loop drives `clk_ref_gate` and feedback into `vco_out_div`.

```bash
# VCO single point (force Xpll.vctrl)
TB=tb_vco_point.spice bash sim/run_sim_docker.sh

# VCO sweep
SWEEP=1 bash sim/run_sim_docker.sh

# Closed-loop lock
TB=tb_pll_lock.spice bash sim/run_sim_docker.sh

# Divider RTL
bash sim/run_div_rtl.sh   # inside IIC-OSIC image
```

## Files

| Path | Role |
| --- | --- |
| `schematic/pll_top.sch` | xschem source |
| `schematic/pll_top.spice` | Netlist DUT for ngspice (+ Mag/LVS intent) |
| `layout/pll_analog.mag` | Mag seed + snaked R |
| `layout/rebuild_analog_snake.tcl` | Regenerate Mag seed |
| `rtl/pll_div_n.v` | Parameterized ÷N |
| `sim/tb_vco_point.spice` | Open-loop via `Xpll.vctrl` force |
| `sim/tb_pll_lock.spice` | Closed-loop `pll_top` + behavioral ÷16 |
| `sim/` | runners + RTL TB |

