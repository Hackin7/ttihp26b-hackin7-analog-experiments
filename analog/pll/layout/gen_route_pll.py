#!/usr/bin/env python3
"""Smarter DRC-aware LVS router for pll_analog.

Signals:
  Via up at the pin, jog on M4/M3 (or M5 in side channels) over the cell
  field with Y-stagger, then M3 vertical to an exclusive M4 trunk.
  Jog and vertical use different layers so they don't cross-block.
  Leaf-cell metal1/2/5 rectangles are PaintDB obstacles. Pin via landings may
  touch existing pin metal; M1/M2 straps and power escapes keep full CLEAR.
  Exclusive M3 columns feed M4 trunks. Same-net paint may touch.

Power: short M2 escape beside the pin → via-up to M5 → rail.
"""
from __future__ import annotations

from pathlib import Path
import re

LAYOUT = Path(__file__).resolve().parent
UM = 0.005
SECTION_LABELS = {"PFD", "CP", "BIAS", "FILTER", "VCO"}
SCH_PORTS = {"clk_ref_gate", "vco_out_div", "VGND", "out", "VPWR"}

NETS: dict[str, list[tuple[str, str]]] = {
    "clk_ref_gate": [("PORT", "clk_ref_gate"), ("x1", "CLK")],
    "vco_out_div": [("PORT", "vco_out_div"), ("x2", "CLK")],
    "pfd_up": [("x1", "Q"), ("x3", "B"), ("x4", "A")],
    "pfd_down": [("x2", "Q"), ("x3", "A"), ("XM2", "G")],
    "net1": [("x1", "RESET_B"), ("x2", "RESET_B"), ("x3", "X")],
    "net2": [("x4", "Y"), ("XM3", "G")],
    "vctrl": [
        ("PORT", "vctrl"), ("XM2", "D"), ("XM3", "D"), ("XR1", "R1"),
        ("XC2", "C1"), ("XMn5", "G"), ("XMn6", "G"), ("XMn7", "G"), ("XMn8", "G"),
    ],
    "net4": [("XM1", "D"), ("XM3", "S")],
    "net3": [("XM2", "S"), ("XM4", "D")],
    "vbp": [("XM1", "G"), ("XM5", "D"), ("XM7", "D"), ("XM7", "G")],
    "vbn": [("XM4", "G"), ("XM5", "G"), ("XM6", "D"), ("XM6", "G"), ("XR2", "R2")],
    "net15": [("XR1", "R2"), ("XC1", "C1")],
    "net6": [
        ("XMp2", "D"), ("XMn2", "D"), ("XMp3", "G"), ("XMn3", "G"),
        ("XMp4", "G"), ("XMn4", "G"),
    ],
    "net7": [("XMp1", "D"), ("XMn1", "D"), ("XMp2", "G"), ("XMn2", "G")],
    "net9": [("XMp3", "D"), ("XMn3", "D"), ("XMp1", "G"), ("XMn1", "G")],
    "net11": [("XMp2", "S"), ("XMp5", "D")],
    "net13": [("XMp1", "S"), ("XMp6", "D")],
    "net14": [("XMp3", "S"), ("XMp7", "D")],
    "net5": [("XMn2", "S"), ("XMn6", "D")],
    "net8": [("XMn1", "S"), ("XMn5", "D")],
    "net10": [("XMn3", "S"), ("XMn7", "D")],
    "net12": [
        ("XMp5", "G"), ("XMp6", "G"), ("XMp7", "G"),
        ("XMp8", "D"), ("XMp8", "G"), ("XMn8", "D"),
    ],
    "out": [("PORT", "out"), ("XMp4", "D"), ("XMn4", "D")],
    "VPWR": [
        ("x1", "VDD"), ("x2", "VDD"), ("x3", "VDD"), ("x4", "VDD"),
        ("x1", "D"), ("x2", "D"),
        ("XM1", "S"), ("XM7", "S"), ("XR2", "R1"),
        ("XMp4", "S"), ("XMp5", "S"), ("XMp6", "S"), ("XMp7", "S"), ("XMp8", "S"),
    ],
    "VGND": [
        ("x1", "VSS"), ("x2", "VSS"), ("x3", "VSS"), ("x4", "VSS"),
        ("XM4", "S"), ("XM5", "S"), ("XM6", "S"),
        ("XR1", "B"), ("XR2", "B"),
        ("XC1", "C2"), ("XC2", "C2"),
        ("XMn4", "S"),
        ("XMn5", "S"), ("XMn6", "S"), ("XMn7", "S"), ("XMn8", "S"),
    ],
}

UPPER_NETS = {
    "clk_ref_gate", "vco_out_div", "pfd_up", "pfd_down", "net1", "net2",
    "vctrl", "net4", "net3", "vbp", "vbn", "net15",
}
LOWER_NETS = {
    "net6", "net7", "net9", "net11", "net13", "net14",
    "net5", "net8", "net10", "net12", "out",
}

W = 0.20
VIA = 0.20
ENCL = 0.10
CLEAR = 0.21
PITCH_Y = 1.00  # trunk pitch; leave room for near-trunk jogs
PITCH_X = 0.65  # M4 column pitch over cells
OBS = "__obs__"

Rect = tuple[float, float, float, float]


def overlaps(a: Rect, b: Rect, clear: float = CLEAR) -> bool:
    return not (
        a[2] + clear <= b[0] or b[2] + clear <= a[0]
        or a[3] + clear <= b[1] or b[3] + clear <= a[1]
    )


class PaintDB:
    """Layer paint with per-net clearance (same net may touch)."""

    def __init__(self):
        self.layers: dict[str, list[tuple[Rect, str | None]]] = {
            L: [] for L in ("metal1", "metal2", "metal3", "metal4", "metal5")
        }

    def can(
        self,
        layer: str,
        r: Rect,
        net: str | None = None,
        clear: float = CLEAR,
        obs_clear: float | None = None,
    ) -> bool:
        """obs_clear overrides clearance to OBS (e.g. 0 to land on pin metal)."""
        oc = clear if obs_clear is None else obs_clear
        for e, enet in self.layers[layer]:
            if enet == OBS:
                c = oc
            elif net is not None and enet == net:
                c = 0.0
            else:
                c = clear
            if overlaps(r, e, c):
                return False
        return True

    def add(self, layer: str, r: Rect, net: str | None = None):
        self.layers[layer].append((r, net))

    def h(self, x0, x1, y, w=W) -> Rect:
        lo, hi = sorted([x0, x1])
        hw = w / 2
        return (lo - hw, y - hw, hi + hw, y + hw)

    def v(self, x, y0, y1, w=W) -> Rect:
        lo, hi = sorted([y0, y1])
        hw = w / 2
        return (x - hw, lo - hw, x + hw, hi + hw)


def parse_uses(mag: Path) -> dict[str, tuple]:
    uses = {}
    lines = mag.read_text().splitlines()
    i = 0
    while i < len(lines):
        m = re.match(r"use\s+(\S+)\s+(\S+)", lines[i])
        if m:
            cell, inst = m.group(1), m.group(2)
            j = i + 1
            while j < len(lines) and not lines[j].startswith("transform"):
                j += 1
            if j < len(lines):
                uses[inst] = (cell, *map(int, lines[j].split()[1:7]))
            i = j + 1
            continue
        i += 1
    return uses


def parse_ports(mag: Path) -> dict[str, tuple[float, float]]:
    text = mag.read_text()
    scale = 2 if (mag.name.startswith("cap_cmim") and "magscale" not in text[:120]) else 1
    ports = {}
    for m in re.finditer(
        r"^rlabel\s+\S+\s+(-?\d+)\s+(-?\d+)\s+(-?\d+)\s+(-?\d+)\s+\d+\s+(\S+)\s*$",
        text, re.M,
    ):
        x1, y1, x2, y2, name = m.groups()
        x1, y1, x2, y2 = map(int, (x1, y1, x2, y2))
        ports[name] = (scale * (x1 + x2) / 2.0, scale * (y1 + y2) / 2.0)
    for m in re.finditer(
        r"^flabel\s+\S+(?:\s+[a-z])?\s+(-?\d+)\s+(-?\d+)\s+(-?\d+)\s+(-?\d+)\s+\d+\s+\S+\s+\d+\s+\d+\s+\d+\s+\d+\s+(\S+)\s*$",
        text, re.M,
    ):
        x1, y1, x2, y2, name = m.groups()
        x1, y1, x2, y2 = map(int, (x1, y1, x2, y2))
        ports[name] = (scale * (x1 + x2) / 2.0, scale * (y1 + y2) / 2.0)
    return ports


def parse_cell_metals_um(mag: Path) -> dict[str, list[Rect]]:
    """Per-layer metal rectangles of a leaf cell in local µm."""
    text = mag.read_text()
    scale = 2 if (mag.name.startswith("cap_cmim") and "magscale" not in text[:120]) else 1
    want = {"metal1", "metal2", "metal3", "metal4", "metal5"}
    out: dict[str, list[Rect]] = {L: [] for L in want}
    cur = None
    for line in text.splitlines():
        m = re.match(r"<<\s+(\S+)\s+>>", line)
        if m:
            cur = m.group(1)
            continue
        m = re.match(r"rect\s+(-?\d+)\s+(-?\d+)\s+(-?\d+)\s+(-?\d+)", line)
        if not m or cur not in want:
            continue
        x1, y1, x2, y2 = map(int, m.groups())
        out[cur].append(
            (
                scale * min(x1, x2) * UM,
                scale * min(y1, y2) * UM,
                scale * max(x1, x2) * UM,
                scale * max(y1, y2) * UM,
            )
        )
    return out


def xform(pt, t):
    x, y = pt
    a, b, c, d, e, f = t
    return (a * x + b * y + c, d * x + e * y + f)


def xform_bbox_um(bbox: Rect, t) -> Rect:
    """Transform local-µm bbox corners through Mag transform (mag units)."""
    x0, y0, x1, y1 = bbox
    corners = [
        (x0 / UM, y0 / UM), (x1 / UM, y0 / UM),
        (x0 / UM, y1 / UM), (x1 / UM, y1 / UM),
    ]
    abs_pts = [um(xform(p, t)) for p in corners]
    xs = [p[0] for p in abs_pts]
    ys = [p[1] for p in abs_pts]
    return (min(xs), min(ys), max(xs), max(ys))


def parse_top_labels(mag: Path) -> dict[str, tuple[float, float]]:
    out = {}
    for m in re.finditer(
        r"flabel\s+metal1\s+(-?\d+)\s+(-?\d+)\s+(-?\d+)\s+(-?\d+)\s+\d+\s+\S+\s+\d+\s+\d+\s+\d+\s+\d+\s+(\S+)",
        mag.read_text(),
    ):
        x1, y1, x2, y2, name = m.groups()
        if name in SECTION_LABELS:
            continue
        x1, y1, x2, y2 = map(int, (x1, y1, x2, y2))
        out[name] = ((x1 + x2) / 2.0, (y1 + y2) / 2.0)
    return out


def um(p):
    return (p[0] * UM, p[1] * UM)


def paint_h(x0, x1, y, layer, w=W):
    lo, hi = sorted([x0, x1])
    hw = w / 2
    return [
        f"box {lo-hw:.3f}um {y-hw:.3f}um {hi+hw:.3f}um {y+hw:.3f}um",
        f"paint {layer}",
    ]


def paint_v(x, y0, y1, layer, w=W):
    lo, hi = sorted([y0, y1])
    hw = w / 2
    return [
        f"box {x-hw:.3f}um {lo-hw:.3f}um {x+hw:.3f}um {hi+hw:.3f}um",
        f"paint {layer}",
    ]


def via(layer_via, layer_below, layer_above, x, y, s=VIA, e=ENCL, paint_below=True):
    h = s / 2
    cmd = []
    if paint_below:
        cmd += [
            f"box {x-h-e:.3f}um {y-h-e:.3f}um {x+h+e:.3f}um {y+h+e:.3f}um",
            f"paint {layer_below}",
        ]
    cmd += [
        f"box {x-h:.3f}um {y-h:.3f}um {x+h:.3f}um {y+h:.3f}um",
        f"paint {layer_via}",
        f"box {x-h-e:.3f}um {y-h-e:.3f}um {x+h+e:.3f}um {y+h+e:.3f}um",
        f"paint {layer_above}",
    ]
    return cmd


def via_pad_rect(x, y) -> Rect:
    h = VIA / 2 + ENCL
    return (x - h, y - h, x + h, y + h)


def via_cut_rect(x, y) -> Rect:
    h = VIA / 2
    return (x - h, y - h, x + h, y + h)


def expand(r: Rect, m: float) -> Rect:
    return (r[0] - m, r[1] - m, r[2] + m, r[3] + m)


def main():
    bare = LAYOUT / "pll_analog_bare.mag"
    mag_path = bare if bare.exists() else LAYOUT / "pll_analog.mag"
    uses = parse_uses(mag_path)
    top = parse_top_labels(mag_path)
    for k, (x, y) in {
        "clk_ref_gate": (-1.5, 7.0),
        "vco_out_div": (-1.5, 2.0),
        "VPWR": (20.5, 12.5),
        "VGND": (20.5, -19.0),
        "out": (74.5, -10.7),
        "vctrl": (36.5, 23.0),
    }.items():
        if k not in top:
            top[k] = (x / UM, y / UM)

    leaf_ports: dict[str, dict] = {}
    leaf_metals: dict[str, dict[str, list[Rect]]] = {}
    for inst, (cell, *_) in uses.items():
        p = LAYOUT / f"{cell}.mag"
        if not p.exists():
            continue
        if cell not in leaf_ports:
            leaf_ports[cell] = parse_ports(p)
        if cell not in leaf_metals:
            leaf_metals[cell] = parse_cell_metals_um(p)

    def abs_pin(inst, pin):
        if inst == "PORT":
            return um(top[pin]) if pin in top else None
        if inst not in uses:
            return None
        cell, *t = uses[inst]
        if cell not in leaf_ports or pin not in leaf_ports[cell]:
            print(f"WARN {inst}/{pin}")
            return None
        return um(xform(leaf_ports[cell][pin], tuple(t)))

    resolved = {}
    for net, pins in NETS.items():
        pts = []
        for inst, pin in pins:
            p = abs_pin(inst, pin)
            if p:
                pts.append((p, f"{inst}/{pin}"))
            else:
                print(f"SKIP {net} {inst}/{pin}")
        resolved[net] = pts

    with (LAYOUT / "pin_report.txt").open("w", encoding="utf-8") as f:
        for net, pts in resolved.items():
            f.write(net + "\n")
            for p, name in pts:
                f.write(f"  {name:20s} {p[0]:8.3f} {p[1]:8.3f}\n")

    upper = sorted(n for n in UPPER_NETS if len(resolved.get(n, [])) >= 2)
    lower = sorted(n for n in LOWER_NETS if len(resolved.get(n, [])) >= 2)

    def vco_score(net: str) -> tuple:
        pts = resolved.get(net, [])
        n_vco = sum(1 for (x, y), _ in pts if x > 55)
        return (-n_vco, net)

    lower = sorted(lower, key=vco_score)

    track = {}
    for i, n in enumerate(upper):
        track[n] = 14.0 + i * PITCH_Y
    for i, n in enumerate(lower):
        track[n] = -21.0 - i * PITCH_Y

    db = PaintDB()

    # Per-layer leaf metal as obstacles — no carveouts.
    # Straps/jogs/power keep full CLEAR to cell metal. Pin via landings use
    # obs_clear=0 on M1/M2 so the stack may sit on existing pin metal.
    n_obs = 0
    for inst, (cell, *t) in uses.items():
        metals = leaf_metals.get(cell)
        if not metals:
            continue
        for layer, rects in metals.items():
            for lr in rects:
                ar = expand(xform_bbox_um(lr, tuple(t)), 0.01)
                db.add(layer, ar, OBS)
                n_obs += 1
    print(f"cell metal obstacles: {n_obs} rects")

    vdd_y, vss_y = 12.5, -19.0
    power_ox_map: dict[tuple[float, float], float] = {}
    used_ox: set[int] = set()

    def q(x: float) -> int:
        return int(round(x / 0.01))

    def claim_ox(px: float, py: float) -> float:
        """M2 escape X that clears cell obstacles and existing M2/M4 paint."""
        for k in range(0, 80):
            for sign in (1, -1):
                cand = px + sign * (0.80 + k * 0.65)
                jog = db.h(px, cand, py)
                if not db.can("metal2", jog, net=None):
                    continue
                # via stack landing must be free on M3-M5 too
                pad = via_pad_rect(cand, py)
                if not all(db.can(L, pad, net=None) for L in ("metal3", "metal4", "metal5")):
                    continue
                qc = q(cand)
                if any((qc + d) in used_ox for d in range(-40, 41)):
                    continue
                for d in range(-40, 41):
                    used_ox.add(qc + d)
                return cand
        return px + 1.0

    def power_ox(px, py, net):
        key = (round(px, 3), round(py, 3))
        if key not in power_ox_map:
            power_ox_map[key] = claim_ox(px, py)
        return power_ox_map[key]

    # Only reserve M5 power rails before signals (signals use M4)
    db.add("metal5", (-10.0, vdd_y - 0.5, 120.0, vdd_y + 0.5), OBS)
    db.add("metal5", (-10.0, vss_y - 0.5, 120.0, vss_y + 0.5), OBS)

    lines = [
        "# Smarter up-and-over M4 spine router",
        "drc off",
        "cd /repo/analog/pll/layout",
        "if {[file exists pll_analog_bare.mag]} {",
        "  file copy -force pll_analog_bare.mag pll_analog.mag",
        "} elseif {[file exists pll_analog_routed_backup.mag]} {",
        "  file copy -force pll_analog_routed_backup.mag pll_analog.mag",
        "}",
        "load pll_analog",
        "select top cell",
        "box -15um -60um 150um 55um",
        "foreach L {metal1 metal2 metal3 metal4 metal5 via1 via2 via3 via4 error_s} { catch {erase $L} }",
        "catch {erase labels}",
    ]

    for name, xy in top.items():
        if name not in SCH_PORTS and name != "vctrl":
            continue
        xu, yu = um(xy)
        lines += [
            f"box {xu-0.25:.3f}um {yu-0.25:.3f}um {xu+0.25:.3f}um {yu+0.25:.3f}um",
            "paint metal1",
            f"label {name} FreeSans 0.7um 0 0 0",
        ]
        if name in SCH_PORTS:
            lines += ["port make", "port connections n s e w"]

    failures = []

    def stack_to_m3(x, y, on_pin=False):
        # On existing pin metal, skip re-painting M1 enclosure (avoids M1 spacing DRC)
        return (
            via("via1", "metal1", "metal2", x, y, paint_below=not on_pin)
            + via("via2", "metal2", "metal3", x, y)
        )

    def stack_to_m4(x, y, on_pin=False):
        return stack_to_m3(x, y, on_pin=on_pin) + via("via3", "metal3", "metal4", x, y)

    used_m3_cols: set[int] = set()

    def col_q(x: float) -> int:
        return int(round(x / PITCH_X))

    def claim_m3_col(x: float) -> bool:
        q = col_q(x)
        if any((q + d) in used_m3_cols for d in (-1, 0, 1)):
            return False
        used_m3_cols.add(q)
        return True

    def release_m3_col(x: float):
        used_m3_cols.discard(col_q(x))

    def try_attach(net: str, px: float, py: float, ty: float, pname: str) -> float | None:
        """Via-up at pin (or M2 escape), M4 jog, exclusive M3 column to trunk."""
        pad = 0.50 if pname.endswith("/C1") else 0.12
        candidates = [px]
        for k in range(1, 100):
            candidates.append(px + k * PITCH_X)
            candidates.append(px - k * PITCH_X)
        for k in range(0, 40):
            candidates.append(100.0 + k * PITCH_X)
            candidates.append(-8.0 - k * PITCH_X)

        # Prefer stack at pin; fall back to a few M2-escape sites if jogs fail
        sites: list[tuple[float, float, tuple | None]] = [(px, py, None)]
        pin_m2_ok = db.can(
            "metal2", via_cut_rect(px, py), net, clear=0.0, obs_clear=0.0
        )
        if pin_m2_ok:
            for k in range(1, 25):
                dist = k * 0.40
                for dx, dy in ((dist, 0.0), (-dist, 0.0), (0.0, dist), (0.0, -dist)):
                    vx, vy = px + dx, py + dy
                    pad_v = via_pad_rect(vx, vy)
                    if not all(db.can(L, pad_v, net) for L in ("metal2", "metal3", "metal4")):
                        continue
                    parts = []
                    if abs(vx - px) > 0.01:
                        parts.append(db.h(px, vx, py, W))
                    if abs(vy - py) > 0.01:
                        parts.append(db.v(vx, py, vy, W))
                    if parts and all(db.can("metal2", r, net) for r in parts):
                        sites.append((vx, vy, ("metal2", parts)))
                        if len(sites) >= 12:
                            break
                if len(sites) >= 12:
                    break

        jog_ys_base = [0.0]
        for k in range(1, 12):
            jog_ys_base.append(k * 0.35)
            jog_ys_base.append(-k * 0.35)

        for sx, sy, strap in sites:
            at_pin = abs(sx - px) < 0.01 and abs(sy - py) < 0.01
            for jl in ("metal4", "metal3", "metal5"):
                for cx in candidates:
                    if jl == "metal5" and -5 < cx < 95:
                        continue  # M5 jogs only in side channels
                    if not claim_m3_col(cx):
                        continue
                    for dy in jog_ys_base:
                        jy = sy + dy
                        jog = db.h(sx, cx, jy, W) if abs(cx - sx) > 0.01 else None
                        stub = db.v(sx, sy, jy, W) if abs(jy - sy) > 0.01 else None
                        vert = db.v(cx, jy, ty, W)
                        pad_bend = via_pad_rect(cx, jy)
                        pad_top = via_pad_rect(cx, ty)

                        if stub is not None and not db.can(jl, stub, net):
                            continue
                        if jog is not None and not db.can(jl, jog, net):
                            continue
                        if not db.can("metal3", vert, net):
                            continue
                        if not db.can("metal3", pad_bend, net):
                            continue
                        if not db.can("metal4", pad_top, net):
                            continue
                        if not db.can(jl, pad_bend, net):
                            continue

                        if strap is not None:
                            s_layer, s_rects = strap
                            for r in s_rects:
                                db.add(s_layer, r, net)
                        if stub is not None:
                            db.add(jl, stub, net)
                        if jog is not None:
                            db.add(jl, jog, net)
                        db.add("metal3", vert, net)
                        db.add(jl, pad_bend, net)
                        db.add("metal3", pad_bend, net)
                        db.add("metal4", pad_top, net)
                        if not at_pin:
                            sc = via_cut_rect(sx, sy)
                            db.add("metal2", sc, net)
                            db.add("metal3", sc, net)
                            if jl in ("metal4", "metal5"):
                                db.add("metal4", sc, net)

                        cmd = [
                            f"box {px-pad:.3f}um {py-pad:.3f}um {px+pad:.3f}um {py+pad:.3f}um",
                            "paint metal1",
                        ]
                        if strap is not None:
                            cmd += via("via1", "metal1", "metal2", px, py, paint_below=False)
                            if abs(sx - px) > 0.01:
                                cmd += paint_h(px, sx, py, "metal2", W)
                            if abs(sy - py) > 0.01:
                                cmd += paint_v(sx, py, sy, "metal2", W)
                            cmd += via("via2", "metal2", "metal3", sx, sy)
                            if jl in ("metal4", "metal5"):
                                cmd += via("via3", "metal3", "metal4", sx, sy)
                            if jl == "metal5":
                                cmd += via("via4", "metal4", "metal5", sx, sy)
                        else:
                            if jl == "metal5":
                                cmd += stack_to_m4(sx, sy, on_pin=at_pin)
                                cmd += via("via4", "metal4", "metal5", sx, sy)
                            elif jl == "metal4":
                                cmd += stack_to_m4(sx, sy, on_pin=at_pin)
                            else:
                                cmd += stack_to_m3(sx, sy, on_pin=at_pin)
                        if stub is not None:
                            cmd += paint_v(sx, sy, jy, jl, W)
                        if jog is not None:
                            cmd += paint_h(sx, cx, jy, jl, W)
                        if jl == "metal5":
                            cmd += via("via4", "metal4", "metal5", cx, jy)
                            cmd += via("via3", "metal3", "metal4", cx, jy)
                        elif jl == "metal4":
                            cmd += via("via3", "metal3", "metal4", cx, jy)
                        cmd += paint_v(cx, jy, ty, "metal3", W)
                        cmd += via("via3", "metal3", "metal4", cx, ty)
                        lines.extend(cmd)
                        return cx
                    release_m3_col(cx)
        return None

    failures = []
    trunk_xs: dict[str, list[float]] = {n: [] for n in track}
    pending: list[tuple[str, float, float, float, str]] = []

    for net, ty in track.items():
        pts = sorted(resolved[net], key=lambda t: (-t[0][0], t[0][1]))
        lines.append(f"# net {net}  trunk={ty:.3f}")
        for (px, py), pname in pts:
            cx = try_attach(net, px, py, ty, pname)
            if cx is None:
                pending.append((net, px, py, ty, pname))
            else:
                trunk_xs[net].append(cx)

    for net, px, py, ty, pname in pending:
        # Retry without exclusive-column guard (clearance still enforced in PaintDB)
        cx = None
        # Temporarily allow denser columns
        saved = set(used_m3_cols)
        used_m3_cols.clear()
        cx = try_attach(net, px, py, ty, pname)
        used_m3_cols.update(saved)
        if cx is not None:
            used_m3_cols.add(col_q(cx))
            trunk_xs[net].append(cx)
        else:
            failures.append(f"{net} {pname} @ {px:.3f},{py:.3f}")

    for net, xs in trunk_xs.items():
        if not xs:
            continue
        ty = track[net]
        trunk = db.h(min(xs), max(xs), ty)
        db.add("metal4", trunk, net)
        lines += paint_h(min(xs), max(xs), ty, "metal4", W)

    if failures:
        print(f"FAILED to place {len(failures)} pins:")
        for f in failures[:25]:
            print(" ", f)

    # Power spine
    xs_all = [p[0] for pts in resolved.values() for p, _ in pts] or [0.0, 70.0]
    x_lo, x_hi = min(xs_all) - 4, max(max(xs_all) + 4, 95.0)
    lines += [
        f"box {x_lo:.3f}um {vdd_y-0.4:.3f}um {x_hi:.3f}um {vdd_y+0.4:.3f}um",
        "paint metal5",
        f"box {x_lo:.3f}um {vss_y-0.4:.3f}um {x_hi:.3f}um {vss_y+0.4:.3f}um",
        "paint metal5",
    ]

    def power_tap(px, py, rail_y, net):
        ox = power_ox(px, py, net)
        c = [
            f"box {px-0.12:.3f}um {py-0.12:.3f}um {px+0.12:.3f}um {py+0.12:.3f}um",
            "paint metal1",
        ]
        c += via("via1", "metal1", "metal2", px, py, paint_below=False)
        c += paint_h(px, ox, py, "metal2", W)
        c += via("via2", "metal2", "metal3", ox, py)
        c += via("via3", "metal3", "metal4", ox, py)
        c += via("via4", "metal4", "metal5", ox, py)
        c += paint_v(ox, py, rail_y, "metal5", 0.20)
        return c

    lines.append("# VPWR")
    for p, _ in resolved["VPWR"]:
        lines += power_tap(p[0], p[1], vdd_y, "VPWR")
    lines.append("# VGND")
    for p, name in resolved["VGND"]:
        if name.endswith("/C2"):
            x, y = p
            lines += [
                f"box {x-0.25:.3f}um {y-0.25:.3f}um {x+0.25:.3f}um {y+0.25:.3f}um",
                "paint metal5",
            ]
            lines += paint_v(x, y, vss_y, "metal5", 0.25)
            continue
        lines += power_tap(p[0], p[1], vss_y, "VGND")
    for pname, rail_y in (("VPWR", vdd_y), ("VGND", vss_y)):
        if pname in top:
            xu, yu = um(top[pname])
            lines += power_tap(xu, yu, rail_y, pname)

    lines += ["save pll_analog", "puts DONE", "quit -noprompt"]
    (LAYOUT / "route_pll.tcl").write_text("\n".join(lines) + "\n", encoding="utf-8")
    print("wrote route_pll.tcl")
    print(f"placed trunks for {len(track)} nets; failures={len(failures)}")


if __name__ == "__main__":
    main()
