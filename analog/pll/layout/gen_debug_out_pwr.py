#!/usr/bin/env python3
"""Debug: route only out + power with spine; check XMn4/XMp4 extract."""
from pathlib import Path

LAYOUT = Path(__file__).resolve().parent
W, VIA, SPINE = 0.16, 0.16, 82.0


def paint_h(x0, x1, y, layer, w=W):
    lo, hi = sorted([x0, x1])
    hw = w / 2
    return [f"box {lo-hw:.3f}um {y-hw:.3f}um {hi+hw:.3f}um {y+hw:.3f}um", f"paint {layer}"]


def paint_v(x, y0, y1, layer, w=W):
    lo, hi = sorted([y0, y1])
    hw = w / 2
    return [f"box {x-hw:.3f}um {lo-hw:.3f}um {x+hw:.3f}um {hi+hw:.3f}um", f"paint {layer}"]


def via(lv, below, above, x, y, s=VIA):
    h, e = s / 2, 0.025
    return [
        f"box {x-h-e:.3f}um {y-h-e:.3f}um {x+h+e:.3f}um {y+h+e:.3f}um", f"paint {below}",
        f"box {x-h:.3f}um {y-h:.3f}um {x+h:.3f}um {y+h:.3f}um", f"paint {lv}",
        f"box {x-h-e:.3f}um {y-h-e:.3f}um {x+h+e:.3f}um {y+h+e:.3f}um", f"paint {above}",
    ]


def stack_m4(x, y):
    return via("via1", "metal1", "metal2", x, y) + via("via2", "metal2", "metal3", x, y) + via("via3", "metal3", "metal4", x, y)


lines = [
    "drc off", "cd /repo/analog/pll/layout",
    "file copy -force pll_analog_bare.mag pll_analog.mag",
    "load pll_analog", "select top cell",
    "box -15um -60um 115um 55um",
    "foreach L {metal1 metal2 metal3 metal4 metal5 via1 via2 via3 via4 error_s} { catch {erase $L} }",
    "catch {erase labels}",
]
for name, x, y in [
    ("clk_ref_gate", -1.5, 7.0), ("vco_out_div", -1.5, 2.0),
    ("VPWR", 20.5, 12.5), ("VGND", 20.5, -19.0), ("out", 66.97, -11.92),
]:
    lines += [
        f"box {x-0.25:.3f}um {y-0.25:.3f}um {x+0.25:.3f}um {y+0.25:.3f}um",
        "paint metal1", f"label {name} FreeSans 0.7um 0 0 0",
        "port make", "port connections n s e w",
    ]

# out: PORT, XMp4/D, XMn4/D — columns left, trunk -27, all M4 jog
ty = -27.0
for px, py, cx in [
    (66.97, -11.92, 66.30),
    (65.04, -10.71, 64.40),
    (64.73, -13.30, 64.10),
]:
    lines += [f"box {px-0.08:.3f}um {py-0.08:.3f}um {px+0.08:.3f}um {py+0.08:.3f}um", "paint metal1"]
    lines += stack_m4(px, py)
    lines += paint_h(px, cx, py, "metal4")
    lines += via("via3", "metal3", "metal4", cx, py)
    lines += paint_v(cx, py, ty, "metal3")
    lines += via("via3", "metal3", "metal4", cx, ty)
lines += paint_h(64.10, 66.30, ty, "metal4")

# power rails + spine taps for XMp4/S, XMn4/S, ports
lines += [
    "box -5.0um 12.1um 90.0um 12.9um", "paint metal5",
    "box -5.0um -19.4um 90.0um -18.6um", "paint metal5",
]


def power_tap(px, py, rail_y):
    esc = py + 0.70 if rail_y > py else py - 0.70
    c = [f"box {px-0.08:.3f}um {py-0.08:.3f}um {px+0.08:.3f}um {py+0.08:.3f}um", "paint metal1"]
    c += via("via1", "metal1", "metal2", px, py)
    c += paint_v(px, py, esc, "metal2")
    c += paint_h(px, SPINE, esc, "metal2")
    c += via("via2", "metal2", "metal3", SPINE, esc)
    c += via("via3", "metal3", "metal4", SPINE, esc)
    c += via("via4", "metal4", "metal5", SPINE, esc)
    c += paint_v(SPINE, esc, rail_y, "metal5", 0.20)
    return c


for px, py, ry in [
    (65.670, -10.710, 12.5), (65.360, -13.300, -19.0),
    (20.5, 12.5, 12.5), (20.5, -19.0, -19.0),
]:
    lines += power_tap(px, py, ry)

lines += ["save pll_analog", "puts DONE", "quit -noprompt"]
(LAYOUT / "debug_out_pwr.tcl").write_text("\n".join(lines) + "\n")
print("wrote debug_out_pwr.tcl")
