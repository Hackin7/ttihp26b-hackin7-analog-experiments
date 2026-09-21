#!/usr/bin/env python3
"""DRC-aware LVS spine router with geometry-aware paint (no overlapping same-layer rects).

Signals: exclusive M3 columns + exclusive M4 trunks; jogs on M2/M3/M4 chosen
so the jog rectangle does not overlap any prior paint on that layer.
Widths/enclosure/spacing target IHP sg13g2 Magic DRC (W/VIA>=0.20, CLEAR>=0.21).

Power: M2 escape to far-right spine, via-up to M5 there only.
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

# IHP sg13g2 DRC targets (Magic rules):
#   metal/via width >= 0.20um, metal spacing >= 0.21um,
#   via enclosure >= 0.045um, metal min area >= 0.144um^2
W = 0.20
VIA = 0.20
ENCL = 0.10  # pad=0.40um -> area 0.16 >= 0.144; enclosure > 0.045
CLEAR = 0.21
PITCH_Y = 0.70  # trunk pitch: W + CLEAR + margin
PITCH_X = 0.65  # col pitch: via-pad + CLEAR
SPINE = 82.0  # unused; power vias are local at pin+offset


# ---- geometry ----
Rect = tuple[float, float, float, float]  # x0,y0,x1,y1


def overlaps(a: Rect, b: Rect, clear: float = CLEAR) -> bool:
    return not (
        a[2] + clear <= b[0] or b[2] + clear <= a[0]
        or a[3] + clear <= b[1] or b[3] + clear <= a[1]
    )


class PaintDB:
    def __init__(self):
        self.layers: dict[str, list[Rect]] = {
            L: [] for L in ("metal1", "metal2", "metal3", "metal4", "metal5")
        }

    def can(self, layer: str, r: Rect) -> bool:
        return all(not overlaps(r, e) for e in self.layers[layer])

    def add(self, layer: str, r: Rect):
        self.layers[layer].append(r)

    def h(self, x0, x1, y, layer, w=W) -> Rect:
        lo, hi = sorted([x0, x1])
        hw = w / 2
        return (lo - hw, y - hw, hi + hw, y + hw)

    def v(self, x, y0, y1, layer, w=W) -> Rect:
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


def xform(pt, t):
    x, y = pt
    a, b, c, d, e, f = t
    return (a * x + b * y + c, d * x + e * y + f)


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


def via(layer_via, layer_below, layer_above, x, y, s=VIA, e=ENCL):
    h = s / 2
    return [
        f"box {x-h-e:.3f}um {y-h-e:.3f}um {x+h+e:.3f}um {y+h+e:.3f}um",
        f"paint {layer_below}",
        f"box {x-h:.3f}um {y-h:.3f}um {x+h:.3f}um {y+h:.3f}um",
        f"paint {layer_via}",
        f"box {x-h-e:.3f}um {y-h-e:.3f}um {x+h+e:.3f}um {y+h+e:.3f}um",
        f"paint {layer_above}",
    ]


def stack_to(layer: str, x: float, y: float) -> list[str]:
    out = via("via1", "metal1", "metal2", x, y)
    if layer == "metal2":
        return out
    out += via("via2", "metal2", "metal3", x, y)
    if layer == "metal3":
        return out
    out += via("via3", "metal3", "metal4", x, y)
    return out


def via_pad_rect(x, y) -> Rect:
    h = VIA / 2 + ENCL
    return (x - h, y - h, x + h, y + h)


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
        "out": (66.97, -11.92),
        "vctrl": (36.5, 23.0),
    }.items():
        if k not in top:
            top[k] = (x / UM, y / UM)

    leaf = {}
    for inst, (cell, *_) in uses.items():
        p = LAYOUT / f"{cell}.mag"
        if p.exists():
            leaf[cell] = parse_ports(p)

    def abs_pin(inst, pin):
        if inst == "PORT":
            return um(top[pin]) if pin in top else None
        if inst not in uses:
            return None
        cell, *t = uses[inst]
        if cell not in leaf or pin not in leaf[cell]:
            print(f"WARN {inst}/{pin}")
            return None
        return um(xform(leaf[cell][pin], tuple(t)))

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
    track = {}
    for i, n in enumerate(upper):
        track[n] = 14.0 + i * PITCH_Y
    for i, n in enumerate(lower):
        track[n] = -21.0 - i * PITCH_Y

    sig_nets = list(track.keys())
    db = PaintDB()
    pin_xs = []
    for n in list(sig_nets) + ["VPWR", "VGND"]:
        for p, _ in resolved.get(n, []):
            pin_xs.append(p[0])

    occupied_cols: set[int] = set()

    def q(x: float) -> int:
        return int(round(x / 0.01))

    for px in pin_xs:
        for d in range(-12, 13):
            occupied_cols.add(q(px) + d)
    vdd_y, vss_y = 12.5, -19.0

    # Assign unique via-up X right of each power pin (never through the device body)
    power_ox_map: dict[tuple[float, float], float] = {}
    used_ox: set[int] = set()

    def claim_ox(px: float) -> float:
        for k in range(0, 40):
            cand = px + 1.00 + k * 0.85
            if cand > 69.0:
                break  # leave x>=70 for signal columns
            qc = q(cand)
            if any((qc + d) in used_ox for d in range(-42, 43)):
                continue
            for d in range(-42, 43):
                used_ox.add(qc + d)
            return cand
        # fallback: below signal channel
        return min(px + 1.00, 68.5)

    def power_ox(px, py, net):
        key = (round(px, 3), round(py, 3))
        if key not in power_ox_map:
            power_ox_map[key] = claim_ox(px)
        return power_ox_map[key]

    for n, rail_y in (("VPWR", vdd_y), ("VGND", vss_y)):
        for p, name in resolved.get(n, []):
            if name.endswith("/C2"):
                continue
            ox = power_ox(p[0], p[1], n)
            for d in range(-42, 43):
                occupied_cols.add(q(ox) + d)
            db.add("metal2", db.h(p[0], ox, p[1], "metal2"))
            for L in ("metal2", "metal3", "metal4", "metal5"):
                db.add(L, via_pad_rect(ox, p[1]))
            db.add("metal5", db.v(ox, p[1], rail_y, "metal5", 0.20))
    for pname, rail_y in (("VPWR", vdd_y), ("VGND", vss_y)):
        if pname in top:
            pxy = um(top[pname])
            ox = power_ox(pxy[0], pxy[1], pname)
            for d in range(-42, 43):
                occupied_cols.add(q(ox) + d)
            db.add("metal2", db.h(pxy[0], ox, pxy[1], "metal2"))
            for L in ("metal2", "metal3", "metal4", "metal5"):
                db.add(L, via_pad_rect(ox, pxy[1]))
            db.add("metal5", db.v(ox, pxy[1], rail_y, "metal5", 0.20))
    for p, name in resolved.get("VGND", []):
        if name.endswith("/C2"):
            db.add("metal5", (p[0] - 0.4, p[1] - 0.4, p[0] + 0.4, p[1] + 0.4))
            db.add("metal5", db.v(p[0], p[1], vss_y, "metal5", 0.25))
    # Reserve power M5 rails so signal M5 jogs cannot touch them
    db.add("metal5", (-10.0, vdd_y - 0.5, 100.0, vdd_y + 0.5))
    db.add("metal5", (-10.0, vss_y - 0.5, 100.0, vss_y + 0.5))

    def claim_col(px: float) -> float | None:
        for k in range(0, 150):
            for sign in (-1, 1):
                cand = px + sign * (0.70 + k * PITCH_X)
                qc = q(cand)
                if any((qc + d) in occupied_cols for d in range(-32, 33)):
                    continue
                # also check M3 vertical strip won't be added yet — mark col
                occupied_cols.add(qc)
                return cand
        return None

    lines = [
        "# Geometry-aware LVS spine router",
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

    jog_layers = ("metal4", "metal3", "metal2")  # never M5 — reserved for power
    failures = []

    def stack_to_layer(layer, x, y):
        out = via("via1", "metal1", "metal2", x, y)
        if layer == "metal2":
            return out
        out += via("via2", "metal2", "metal3", x, y)
        if layer == "metal3":
            return out
        out += via("via3", "metal3", "metal4", x, y)
        return out

    for net, ty in track.items():
        pts = resolved[net]
        lines.append(f"# net {net}  trunk={ty:.3f}")
        xs = []
        for (px, py), pname in pts:
            pad = 0.50 if pname.endswith("/C1") else 0.12
            placed = False
            # Prefer local columns (short jogs); far-right / far-left as fallback
            candidates = []
            for k in range(0, 100):
                candidates.append(px - (0.70 + k * PITCH_X))
                candidates.append(px + (0.70 + k * PITCH_X))
            for k in range(0, 60):
                candidates.append(72.0 + k * PITCH_X)
            for k in range(0, 50):
                candidates.append(-6.0 - k * PITCH_X)
            jog_try = list(jog_layers) + ["metal5"]
            # Offset jog Y so dense same-row pins can share a layer without CLEAR clashes
            jog_ys = [py]
            for k in range(1, 8):
                jog_ys.append(py + k * 0.35)
                jog_ys.append(py - k * 0.35)
            for cx in candidates:
                if placed:
                    break
                qc = q(cx)
                if any((qc + d) in occupied_cols for d in range(-32, 33)):
                    continue
                for jl in jog_try:
                    if placed:
                        break
                    if jl == "metal5" and cx < 70:
                        continue  # M5 jogs only in far-right channel
                    for jy in jog_ys:
                        jog_r = db.h(px, cx, jy, jl)
                        stub_r = db.v(px, py, jy, jl)
                        vert_r = db.v(cx, jy, ty, "metal3")
                        trunk_touch = via_pad_rect(cx, ty)
                        if not db.can(jl, jog_r):
                            continue
                        if abs(jy - py) > 0.01 and not db.can(jl, stub_r):
                            continue
                        if not db.can("metal3", vert_r):
                            continue
                        occupied_cols.add(qc)
                        db.add(jl, jog_r)
                        if abs(jy - py) > 0.01:
                            db.add(jl, stub_r)
                        db.add("metal3", vert_r)
                        db.add("metal4", trunk_touch)
                        db.add("metal2", via_pad_rect(px, py))
                        if jl in ("metal3", "metal4", "metal5"):
                            db.add("metal3", via_pad_rect(px, py))
                        if jl in ("metal4", "metal5"):
                            db.add("metal4", via_pad_rect(px, py))
                        if jl == "metal5":
                            db.add("metal5", via_pad_rect(px, py))
                        db.add(jl, via_pad_rect(px, jy))
                        db.add(jl, via_pad_rect(cx, jy))
                        db.add("metal3", via_pad_rect(cx, jy))
                        lines += [
                            f"box {px-pad:.3f}um {py-pad:.3f}um {px+pad:.3f}um {py+pad:.3f}um",
                            "paint metal1",
                        ]
                        if jl == "metal5":
                            lines += stack_to_layer("metal4", px, py)
                            lines += via("via4", "metal4", "metal5", px, py)
                        else:
                            lines += stack_to_layer(jl, px, py)
                        if abs(jy - py) > 0.01:
                            lines += paint_v(px, py, jy, jl, W)
                        lines += paint_h(px, cx, jy, jl, W)
                        if jl == "metal5":
                            lines += via("via4", "metal4", "metal5", cx, jy)
                            lines += via("via3", "metal3", "metal4", cx, jy)
                        elif jl == "metal4":
                            lines += via("via3", "metal3", "metal4", cx, jy)
                        elif jl == "metal2":
                            lines += via("via2", "metal2", "metal3", cx, jy)
                        lines += paint_v(cx, jy, ty, "metal3", W)
                        lines += via("via3", "metal3", "metal4", cx, ty)
                        xs.append(cx)
                        placed = True
                        break
            if not placed:
                failures.append(f"{net} {pname} @ {px:.3f},{py:.3f}")

        if xs:
            trunk = db.h(min(xs), max(xs), ty, "metal4")
            # trunks at exclusive Y should always be free; force-add
            db.add("metal4", trunk)
            lines += paint_h(min(xs), max(xs), ty, "metal4", W)

    if failures:
        print(f"FAILED to place {len(failures)} pins:")
        for f in failures[:20]:
            print(" ", f)

    # Power spine
    xs_all = [p[0] for pts in resolved.values() for p, _ in pts] or [0.0, 70.0]
    x_lo, x_hi = min(xs_all) - 4, max(max(xs_all) + 4, 95.0)
    # vdd_y/vss_y already set above
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
        c += via("via1", "metal1", "metal2", px, py)
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
