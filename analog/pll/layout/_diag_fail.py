"""Count why try_attach fails for one pin mid-route."""
from gen_route_pll import *

bare = LAYOUT / "pll_analog_bare.mag"
uses = parse_uses(bare)
top = parse_top_labels(bare)
for k, (x, y) in {
    "clk_ref_gate": (-1.5, 7.0), "vco_out_div": (-1.5, 2.0),
    "VPWR": (20.5, 12.5), "VGND": (20.5, -19.0),
    "out": (74.5, -10.7), "vctrl": (36.5, 23.0),
}.items():
    if k not in top:
        top[k] = (x / UM, y / UM)

leaf_ports, leaf_metals = {}, {}
for inst, (cell, *_) in uses.items():
    p = LAYOUT / f"{cell}.mag"
    if not p.exists():
        continue
    leaf_ports.setdefault(cell, parse_ports(p))
    leaf_metals.setdefault(cell, parse_cell_metals_um(p))


def abs_pin(inst, pin):
    if inst == "PORT":
        return um(top[pin]) if pin in top else None
    cell, *t = uses[inst]
    if pin not in leaf_ports[cell]:
        return None
    return um(xform(leaf_ports[cell][pin], tuple(t)))


resolved = {
    net: [(abs_pin(i, p), f"{i}/{p}") for i, p in pins if abs_pin(i, p)]
    for net, pins in NETS.items()
}
upper = sorted(n for n in UPPER_NETS if len(resolved.get(n, [])) >= 2)
lower = sorted(
    (n for n in LOWER_NETS if len(resolved.get(n, [])) >= 2),
    key=lambda n: (-sum(1 for (x, y), _ in resolved[n] if x > 55), n),
)
track = {}
for i, n in enumerate(upper):
    track[n] = 14.0 + i * PITCH_Y
for i, n in enumerate(lower):
    track[n] = -21.0 - i * PITCH_Y

db = PaintDB()
for inst, (cell, *t) in uses.items():
    metals = leaf_metals.get(cell)
    if not metals:
        continue
    for layer, rects in metals.items():
        for lr in rects:
            db.add(layer, expand(xform_bbox_um(lr, tuple(t)), 0.01), OBS)

# Replay simplified attaches: at-pin stack + exclusive M3 column + M4 jog
used_cols = set()


def claim_col(x):
    q = int(round(x / PITCH_X))
    for d in range(-1, 2):
        if (q + d) in used_cols:
            return False
    used_cols.add(q)
    return True


fail_target = "pfd_down XM2/G"
stats = {"ok": 0, "no_col": 0, "vert": 0, "jog": 0}

for net, ty in track.items():
    pts = sorted(resolved[net], key=lambda t: (-t[0][0], t[0][1]))
    for (px, py), pname in pts:
        label = f"{net} {pname}"
        placed = False
        for k in range(0, 80):
            for sign in (1, -1) if k else (1,):
                cx = px + sign * k * PITCH_X
                if k == 0 and sign == -1:
                    continue
                if not claim_col(cx):
                    continue
                jy = py
                jog = db.h(px, cx, jy, W) if abs(cx - px) > 0.01 else None
                vert = db.v(cx, jy, ty, W)
                pad_bend = via_pad_rect(cx, jy)
                pad_top = via_pad_rect(cx, ty)
                if jog is not None and not db.can("metal4", jog, net):
                    used_cols.discard(int(round(cx / PITCH_X)))
                    continue
                if not db.can("metal3", vert, net):
                    used_cols.discard(int(round(cx / PITCH_X)))
                    continue
                if not db.can("metal3", pad_bend, net) or not db.can("metal4", pad_top, net):
                    used_cols.discard(int(round(cx / PITCH_X)))
                    continue
                if jog is not None:
                    db.add("metal4", jog, net)
                db.add("metal3", vert, net)
                db.add("metal3", pad_bend, net)
                db.add("metal4", pad_top, net)
                placed = True
                stats["ok"] += 1
                break
            if placed:
                break
        if not placed:
            if label == fail_target or stats["ok"] < 3:
                # detailed
                n_jog = n_vert = n_pad = 0
                for k in range(0, 40):
                    cx = px + k * PITCH_X
                    jog = db.h(px, cx, py, W) if k else None
                    vert = db.v(cx, py, ty, W)
                    if jog is not None and not db.can("metal4", jog, net):
                        n_jog += 1
                        continue
                    if not db.can("metal3", vert, net):
                        n_vert += 1
                        continue
                    n_pad += 1
                print(f"FAIL {label} @ {px:.3f},{py:.3f} ty={ty} jog_block={n_jog} vert_block={n_vert} padish={n_pad}")
            stats["vert"] += 1

print("stats", stats, "cols", len(used_cols))
