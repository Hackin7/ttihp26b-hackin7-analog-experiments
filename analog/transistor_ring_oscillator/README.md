# Transistor ring oscillator

Discrete IHP SG13G2 LV CMOS ring. This is the Tiny Tapeout analog leaf
(`src/config.json` → `macro/ring_oscillator.{gds,lef,spice}`).

**Full flow** (schematic → sim → Magic → DRC → LVS → normalize → chip GDS):
[docs/transistor_ring_flow.md](../../docs/transistor_ring_flow.md).

| Role | Path |
| --- | --- |
| 5-stage schematic | `schematic/main_5.sch` → `transistor_ring_oscillator_5.spice` (`trosc5`) |
| 3-stage schematic (not laid out) | `schematic/main.sch` → `transistor_ring_oscillator.spice` (`trosc`) |
| Magic | `layout_5/` (`cmos_inv.mag`, `ring_oscillator.mag`) |
| Leaf views | `macro/ring_oscillator.{gds,lef,spice}` |
| Sims | `sim/` |

Schematic uses IHP primitive MOS symbols. Layout is custom Magic paint
(`tech ihp-sg13g2`), not a stdcell instance. LVS is the only schematic↔layout
link. The previous stdcell ring is under `analog/inverter_ring_oscillator/`.
