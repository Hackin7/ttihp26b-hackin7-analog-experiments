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

`tb_pll_lock.spice` exercises VCO + ideal PD + switch-based ÷16. Full transistor PFD/CP + robust digital ÷N lock is a follow-up (XSPICE `d_dff` pin syntax differs on ngspice-47; switch TFF was unreliable at GHz). Open-loop + RTL cover the sizing and divider goals.

## Simulate

```bash
# VCO single point
LCH=0.25u TB=tb_vco_point.spice bash sim/run_sim_docker.sh

# VCO sweep
SWEEP=1 LCH=0.25u bash sim/run_sim_docker.sh

# Divider RTL
bash sim/run_div_rtl.sh   # inside IIC-OSIC image
```

## Files

| Path | Role |
| --- | --- |
| `schematic/pll_top.sch` | xschem source |
| `schematic/pll_vco.spice` | VCO netlist for ngspice |
| `schematic/pll_cp_filt.spice` | CP + filter (sim) |
| `schematic/pll_pfd.spice` | NAND PFD (sim) |
| `rtl/pll_div_n.v` | Parameterized ÷N |
| `sim/` | TBs + docker runners |
