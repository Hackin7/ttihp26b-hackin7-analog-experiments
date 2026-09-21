# 5-stage transistor ring ~1 GHz

Duplicate of `analog/transistor_ring_oscillator/` sized for **1 GHz**.
LibreLane cell / blackbox: **`ring_oscillator_1ghz`**. Instantiated in
`src/project.v` beside the 100 MHz leaf; clock select via `ui_in[1]` /
`ui_in[5]` (see `docs/hierarchy.md`).

| | 100 MHz leaf | This copy |
| --- | --- | --- |
| L | 1.45 µm | **0.555 µm** |
| W | Wn=0.74 µm, Wp=1.12 µm | same |
| Pre-layout | 100.9 MHz | **540.6 MHz** (`mos_tt`, 1.2 V) |
| PEX + C | 95.7 MHz | **499.2 MHz** |
| TT cell | `ring_oscillator` | `ring_oscillator_1ghz` |

Schematic: `schematic/main_5.sch` / `transistor_ring_oscillator_5.spice`
(`.subckt trosc5`). Layout: `layout_5/` same flow as the 100 MHz ring
(`gen_layout.py`, DRC, extract, netgen LVS, `tools/local/normalize_transistor_ring_1ghz.py`).

```bash
# pre-layout
TB=tb_tran5.spice LCH=0.555u bash analog/transistor_ring_oscillator_1ghz/sim/run_sim_docker.sh

# layout + LVS
py -3 analog/transistor_ring_oscillator_1ghz/layout_5/gen_layout.py
docker run --rm --entrypoint /bin/bash \
  -v "$PWD:/repo" -w /repo/analog/transistor_ring_oscillator_1ghz/layout_5 \
  hpretl/iic-osic-tools -lc \
  'bash ./run_drc_osic.sh && bash ./run_export_osic.sh && bash ./run_lvs_osic.sh'
py -3 tools/local/normalize_transistor_ring_1ghz.py
```
