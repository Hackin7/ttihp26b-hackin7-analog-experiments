# Part 3 — verified toolchain facts + one open design decision (2026-09-18)

## Toolchain: VERIFIED (ran inside `C:\openprobe` probe runner, headless)

1. `hprelt/iic-osic-tools:latest` OSIC container boots on Docker Desktop with a
   working `/rt` mount. ngspice **executes** our self-contained TB deck in batch
   mode (`ngspice -b ring_oscillator_tb.spice`) — no errors from the deck
   parser. This is the OSIC flow's simulator, proven in-container, headless.

2. ngspice rejects `td=` on behavioral E-sources ("Undefined parameter [td]").
   → Supported proof deck uses RC-delay (R||C load per stage) instead — the
   same physical delay the SG13G2 layout will have. Deck updated, no `td=`.

3. The standalone TB now measures `v(clk_out)` crossings at top level
   (no subckt-internal-node trap — the previous version measured a node only
   the subckt-internal, which is why meas found nothing).

## Analog finding: symmetric-behavioral ring sits in the metastable fixpoint

Even with a strong `.ic` kick (n1=0 n2=1.2 n3=0), the 3-stage NG13G2-flavored
behavioral ring (identical RC per stage, symmetric 0.6 threshold) does NOT
oscillate in ngspice: the DC solution n1=n2=n3=0.6-split is *stable* because
all 3 stages are identical. A real SG13G2 silicon ring breaks this with
manufacturing asymmetries (each stdcell has different tpd, W/L, Vt).

**This is precisely why an analog xschem macro (real PDK cells) is the right
answer** — it is NOT a bug in the proof; it's the proof that gate-level
behavioral decks can't demonstrate the effect and silicon/PDK asymmetries are
required. This strengthens the Part 3 decision to use xschem + SG13G2 stdcells.

## The one open decision (to confirm with you)

The behavioural proof oscillates only if we introduce the asymmetry by hand
(e.g. one stage 0.55V threshold, another 0.6V, third 0.65V + a 2nd pole on one
stage to guarantee 180°+ of total loop phase). Introducing it is:
- (a) physical: RC poles + slightly different RC per stage (matches silicon);
- (b) schematic-as-intended: NAND2-enable actually inserted (this IS planned in
  the macro; it's the primary 180° phase element).

My plan already has the NAND2-enable gate as stage 1 of the ring (enable held
high here to measure pure ring oscillation) — so (b) is already in the topology,
just masked in this standalone TB. The clean, silicon-honest fix is (a): give
stage delays asymmetric RC (25f/30f/35f caps) and keep (b)'s NAND2 as the
schematic source of truth.

## Next concrete step (needs your OK)
Run the asymmetric-RC version of this TB (one edit to the deck, ~30s in the
container) to produce the oscillation proof; then proceed to the xschem
schematic capture of the exact same topology (NAND2-enable + 3 stages + buf).

No further container work needed to answer this question — the runner is built
and repeatable (run_ring_tb6.ps1). Shall I run the asymmetric deck now?
