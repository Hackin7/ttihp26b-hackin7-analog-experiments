# 5-stage transistor ring ~500 MHz

Duplicate of `analog/transistor_ring_oscillator/` sized for **500 MHz**.
Not bound in `src/config.json` (the 100 MHz leaf is still the Tiny Tapeout
macro).

| | 100 MHz leaf | This copy |
| --- | --- | --- |
| L | 1.45 µm | **0.555 µm** |
| W | Wn=0.74 µm, Wp=1.12 µm | same |
| Pre-layout | 100.9 MHz | **540.6 MHz** (`mos_tt`, 1.2 V) |
| PEX + C | 95.7 MHz | **499.2 MHz** |

Schematic: `schematic/main_5.sch` / `transistor_ring_oscillator_5.spice`
(`.subckt trosc5`). Layout: `layout_5/` same flow as the 100 MHz ring
(`gen_layout.py`, DRC, extract, netgen LVS, `tools/local/normalize_transistor_ring_500mhz.py`).

```bash
# pre-layout
TB=tb_tran5.spice LCH=0.555u bash analog/transistor_ring_oscillator_500mhz/sim/run_sim_docker.sh

# layout + LVS
py -3 analog/transistor_ring_oscillator_500mhz/layout_5/gen_layout.py
docker run --rm --entrypoint /bin/bash \
  -v "$PWD:/repo" -w /repo/analog/transistor_ring_oscillator_500mhz/layout_5 \
  hpretl/iic-osic-tools -lc \
  'bash ./run_drc_osic.sh && bash ./run_export_osic.sh && bash ./run_lvs_osic.sh'
py -3 tools/local/normalize_transistor_ring_500mhz.py
```
