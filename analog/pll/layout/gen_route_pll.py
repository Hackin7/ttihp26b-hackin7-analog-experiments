#!/usr/bin/env python3
"""Generate Magic TCL to route pll_analog with layer-aware M1/M2 + vias.

Routing rules (avoid same-layer shorts):
  - Signal horizontals: Metal2 on unique track Y per net
  - Signal verticals:   Metal1 from pin to track
  - Via1 at each (pin_x, track_y) junction
  - Power: Metal2 rails; Metal1 stubs + Via1 up to rail
"""
from __future__ import annotations

from pathlib import Path
import re

LAYOUT = Path(__file__).resolve().parent
UM = 0.005

SECTION_LABELS = {"PFD", "CP", "BIAS", "FILTER", "VCO"}

NETS: dict[str, list[tuple[str, str]]] = {
    "clk_ref_gate": [("PORT", "clk_ref_gate"), ("x1", "CLK")],
    "vco_out_div": [("PORT", "vco_out_div"), ("x2", "CLK")],
    "pfd_up": [("x1", "Q"), ("x3", "B"), ("x4", "A")],
    "pfd_down": [("x2", "Q"), ("x3", "A"), ("XM2", "G")],
    "net1": [("x1", "RESET_B"), ("x2", "RESET_B"), ("x3", "X")],
    "net2": [("x4", "Y"), ("XM3", "G")],
    "vctrl": [
        ("PORT", "vctrl"),
        ("XM2", "D"),
        ("XM3", "D"),
        ("XR1", "R1"),
        ("XC2", "C1"),
        ("XMn5", "G"),
        ("XMn6", "G"),
        ("XMn7", "G"),
        ("XMn8", "G"),
    ],
    "net4": [("XM1", "D"), ("XM3", "S")],
    "net3": [("XM2", "S"), ("XM4", "D")],
    "vbp": [("XM1", "G"), ("XM5", "D"), ("XM7", "D"), ("XM7", "G")],
    "vbn": [("XM4", "G"), ("XM5", "G"), ("XM6", "D"), ("XM6", "G"), ("XR2", "R2")],
    "net15": [("XR1", "R2"), ("XC1", "C1")],
    "net6": [
        ("XMp2", "D"), ("XMn2", "D"),
        ("XMp3", "G"), ("XMn3", "G"),
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
        ("XM1", "S"), ("XM7", "S"),
        ("XR2", "R1"),
        ("XMp4", "S"), ("XMp5", "S"), ("XMp6", "S"), ("XMp7", "S"), ("XMp8", "S"),
    ],
    "VGND": [
        ("x1", "VSS"), ("x2", "VSS"), ("x3", "VSS"), ("x4", "VSS"),
        ("XM4", "S"), ("XM5", "S"), ("XM6", "S"),
        ("XR1", "B"), ("XR2", "B"),
        ("XC1", "C2"), ("XC2", "C2"),
        ("XMn1", "S"), ("XMn2", "S"), ("XMn3", "S"), ("XMn4", "S"),
        ("XMn5", "S"), ("XMn6", "S"), ("XMn7", "S"), ("XMn8", "S"),
    ],
}

# Nets routed in the upper M2 channel vs lower (near VCO)
UPPER_NETS = {
    "clk_ref_gate", "vco_out_div", "pfd_up", "pfd_down", "net1", "net2",
    "vctrl", "net4", "net3", "vbp", "vbn", "net15",
}
LOWER_NETS = {
    "net6", "net7", "net9", "net11", "net13", "net14",
    "net5", "net8", "net10", "net12", "out",
}

W = 0.28          # signal wire width (µm)
PITCH = 0.55      # M2 track pitch (µm) — keeps ~0.27 µm spacing
VIA = 0.22        # via1 square (µm)


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
                t = list(map(int, lines[j].split()[1:7]))
                uses[inst] = (cell, *t)
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


def via1(x, y, s=VIA):
    h = s / 2
    # via + landing pads on both metals
    return [
        f"box {x-h-0.04:.3f}um {y-h-0.04:.3f}um {x+h+0.04:.3f}um {y+h+0.04:.3f}um",
        "paint metal1",
        f"box {x-h:.3f}um {y-h:.3f}um {x+h:.3f}um {y+h:.3f}um",
        "paint via1",
        f"box {x-h-0.04:.3f}um {y-h-0.04:.3f}um {x+h+0.04:.3f}um {y+h+0.04:.3f}um",
        "paint metal2",
    ]


def main():
    uses = parse_uses(LAYOUT / "pll_analog.mag")
    top = parse_top_labels(LAYOUT / "pll_analog.mag")
    leaf: dict[str, dict] = {}
    for inst, (cell, *_) in uses.items():
        p = LAYOUT / f"{cell}.mag"
        if p.exists():
            leaf[cell] = parse_ports(p)

    def abs_pin(inst, pin):
        if inst == "PORT":
            return um(top[pin]) if pin in top else None
        if inst not in uses:
            print("WARN no inst", inst)
            return None
        cell, *t = uses[inst]
        if cell not in leaf or pin not in leaf[cell]:
            print(f"WARN no pin {inst}/{pin} ({cell})")
            return None
        return um(xform(leaf[cell][pin], tuple(t)))

    resolved: dict[str, list[tuple[tuple[float, float], str]]] = {}
    for net, pins in NETS.items():
        pts = []
        for inst, pin in pins:
            p = abs_pin(inst, pin)
            if p:
                pts.append((p, f"{inst}/{pin}"))
            else:
                print(f"SKIP {net} {inst}/{pin}")
        resolved[net] = pts

    with (LAYOUT / "pin_report.txt").open("w") as f:
        for net, pts in resolved.items():
            f.write(f"{net}\n")
            for p, name in pts:
                f.write(f"  {name:20s} {p[0]:8.3f} {p[1]:8.3f}\n")

    # --- assign unique M2 horizontal tracks ---
    upper = [n for n in resolved if n in UPPER_NETS and len(resolved[n]) >= 2]
    lower = [n for n in resolved if n in LOWER_NETS and len(resolved[n]) >= 2]
    # stable order by name for reproducibility
    upper.sort()
    lower.sort()

    track: dict[str, float] = {}
    # Upper channel above stdcells / CP (avoid stdcell VDD rail ~8.9)
    y_u = 11.0
    for i, n in enumerate(upper):
        track[n] = y_u + i * PITCH
    # Lower channel below VCO nmos bank
    y_l = -18.5
    for i, n in enumerate(lower):
        track[n] = y_l - i * PITCH

    lines = [
        "# Auto-generated by gen_route_pll.py — layer-aware M1/M2 routing",
        "drc off",
        "cd /repo/analog/pll/layout",
        "load pll_analog",
        "select top cell",
        "# wipe prior routing + all labels (ports recreated below)",
        "box -5um -40um 95um 40um",
        "catch {erase metal1}",
        "catch {erase metal2}",
        "catch {erase metal3}",
        "catch {erase metal4}",
        "catch {erase metal5}",
        "catch {erase via1}",
        "catch {erase via2}",
        "catch {erase via3}",
        "catch {erase via4}",
        "catch {erase error_s}",
        "catch {erase labels}",
    ]

    vdd_y = abs_pin("x1", "VDD")[1]
    vss_y = abs_pin("x1", "VSS")[1]

    # Power rails on Metal2 (keep clear of signal track bands)
    lines += [
        "# === power rails (Metal2) ===",
        f"box -2.000um {vdd_y-0.30:.3f}um 72.000um {vdd_y+0.30:.3f}um",
        "paint metal2",
        f"box -2.000um {vss_y-0.30:.3f}um 72.000um {vss_y+0.30:.3f}um",
        "paint metal2",
        "box 56.000um -7.200um 70.500um -6.600um",
        "paint metal2",
        "box 56.000um -16.800um 70.500um -16.200um",
        "paint metal2",
        f"box 56.000um -7.200um 56.600um {vdd_y+0.30:.3f}um",
        "paint metal2",
        f"box 56.000um -16.800um 56.600um {vss_y+0.30:.3f}um",
        "paint metal2",
    ]

    # --- signal nets: M1 vertical + M2 trunk + via1 ---
    for net, ty in track.items():
        pts = [p for p, _ in resolved[net]]
        if len(pts) < 2:
            continue
        xs = [p[0] for p in pts]
        lines.append(f"# net {net}  M2 trunk y={ty:.3f}")
        # M2 horizontal trunk
        lines += paint_h(min(xs), max(xs), ty, "metal2", W)
        for (x, y), name in resolved[net]:
            # M1 vertical pin → track
            lines += paint_v(x, y, ty, "metal1", W)
            # via at junction
            lines += via1(x, ty)
            # small M1 pad on pin for contact (helps FET/stdcell hit)
            lines += [
                f"box {x-0.20:.3f}um {y-0.20:.3f}um {x+0.20:.3f}um {y+0.20:.3f}um",
                "paint metal1",
            ]
            # Cap top plate (C1) needs a larger M1 landing on mimcapcontact
            if name.endswith("/C1"):
                lines += [
                    f"box {x-0.80:.3f}um {y-0.80:.3f}um {x+0.80:.3f}um {y+0.80:.3f}um",
                    "paint metal1",
                ]

    # --- VPWR stubs: M1 to via to M2 rail ---
    lines.append("# === VPWR stubs ===")
    for p, name in resolved["VPWR"]:
        ty = -6.9 if p[1] < -5 else vdd_y
        lines += paint_v(p[0], p[1], ty, "metal1", 0.30)
        lines += via1(p[0], ty)

    # --- VGND stubs ---
    lines.append("# === VGND stubs ===")
    for p, name in resolved["VGND"]:
        if name.endswith("/C2"):
            # Metal5 bottom plate → via stack → Metal2 → VGND rail
            x, y = p
            lines += [
                f"box {x-0.50:.3f}um {y-0.50:.3f}um {x+0.50:.3f}um {y+0.50:.3f}um",
                "paint metal5",
            ]
            sx = x + 1.0
            lines += paint_h(x, sx, y, "metal5", 0.40)
            yy = y
            for via_l, met_l in (
                ("via4", "metal4"),
                ("via3", "metal3"),
                ("via2", "metal2"),
            ):
                h = 0.16
                lines += [
                    f"box {sx-h:.3f}um {yy-h:.3f}um {sx+h:.3f}um {yy+h:.3f}um",
                    f"paint {via_l}",
                    f"box {sx-0.28:.3f}um {yy-0.35:.3f}um {sx+0.28:.3f}um {yy+0.10:.3f}um",
                    f"paint {met_l}",
                ]
                yy -= 0.40
            ty = -16.5 if y < -5 else vss_y
            lines += paint_v(sx, yy, ty, "metal2", 0.30)
            continue
        ty = -16.5 if p[1] < -5 else vss_y
        lines += paint_v(p[0], p[1], ty, "metal1", 0.30)
        lines += via1(p[0], ty)

    # --- restore real ports only (no section labels) ---
    lines.append("# === ports ===")
    for name, xy in top.items():
        xu, yu = um(xy)
        lines += [
            f"box {xu-0.5:.3f}um {yu-0.5:.3f}um {xu+0.5:.3f}um {yu+0.5:.3f}um",
            "paint metal1",
            f"label {name} FreeSans 0.8um 0 0 0",
            "port make",
            "port connections n s e w",
        ]

    lines += [
        "save pll_analog",
        "puts DONE",
        "quit -noprompt",
    ]

    out = LAYOUT / "route_pll.tcl"
    out.write_text("\n".join(lines) + "\n")
    print(f"wrote {out}")
    print(f"  upper tracks ({len(upper)}): y={y_u:.2f} .. {y_u+(len(upper)-1)*PITCH:.2f}")
    print(f"  lower tracks ({len(lower)}): y={y_l:.2f} .. {y_l-(len(lower)-1)*PITCH:.2f}")
    for n, ty in sorted(track.items(), key=lambda kv: -kv[1]):
        print(f"    {n:14s}  M2 y={ty:7.3f}")


if __name__ == "__main__":
    main()
