#!/usr/bin/env python3
"""Generate Magic layout for the 5-stage SG13G2 transistor ring.

Stretches analog/inverter_ring_oscillator/layout/sg13g2_inv_1.mag in X so the
shared poly gate is L=1.45 um (290 magic units at magscale 1 2 = 5 nm/unit).
VDD/VSS tap rails are tiled (not stretched) so 32x32 contacts stay legal.
"""

from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
INV1 = ROOT / "analog/inverter_ring_oscillator/layout/sg13g2_inv_1.mag"
OUT_DIR = Path(__file__).resolve().parent

UNIT_UM = 0.005
L_UM = 1.45
ORIG_GATE_L = 26
GATE_R = 156
DX = int(round(L_UM / UNIT_UM)) - ORIG_GATE_L  # 264
ORIG_W = 288
FIXED_W = ORIG_W * 2  # 576 — one extra stdcell-width of tap rail
FIXED_H = 756
PITCH = FIXED_W
N_STAGES = 5
TS = 1789919000

Y_X1, Y_Y1, Y_X2, Y_Y2 = 171 + DX, 122, 217 + DX, 635
A_X1, A_Y1, A_X2, A_Y2 = 62, 304, 125, 370
VDD_Y1, VDD_Y2 = 712, 800
VSS_Y1, VSS_Y2 = -44, 44
CHILD_BOX = (-48, -56, 336 + (FIXED_W - ORIG_W), 834)  # -48,-56,624,834
TRACK = 32
JUNC_Y1, JUNC_Y2 = 321, 353

RAIL_LAYERS = {"psubdiff", "nsubdiff", "psubdiffcont", "nsubdiffcont"}


def tx(x):
    return x if x < GATE_R else x + DX


def is_m1_rail(y1, y2):
    return y1 >= 712 or y2 <= 44


def emit_rect(x1, y1, x2, y2):
    return "rect %d %d %d %d\n" % (x1, y1, x2, y2)


def rail_tiles(x1, y1, x2, y2):
    """Keep original tap geometry and copy it one site to the right."""
    rects = [(x1, y1, x2, y2)]
    nx1, nx2 = x1 + ORIG_W, x2 + ORIG_W
    if nx1 < FIXED_W:
        rects.append((nx1, y1, min(nx2, FIXED_W), y2))
    return rects


def transform_inv(src):
    out = []
    layer = ""
    for raw in src.splitlines(True):
        line = raw.rstrip("\r\n")
        if line.startswith("<< ") and line.endswith(" >>"):
            layer = line[3:-3]
            out.append(line + "\n")
            continue
        if line.startswith("rect "):
            _r, sx1, sy1, sx2, sy2 = line.split()
            x1, y1, x2, y2 = int(sx1), int(sy1), int(sx2), int(sy2)
            if layer in RAIL_LAYERS or (layer == "metal1" and is_m1_rail(y1, y2)):
                for rx1, ry1, rx2, ry2 in rail_tiles(x1, y1, x2, y2):
                    out.append(emit_rect(rx1, ry1, rx2, ry2))
            elif layer in ("nwell", "pwell"):
                out.append(emit_rect(x1, y1, x2 + ORIG_W, y2))
            else:
                out.append(emit_rect(tx(x1), y1, tx(x2), y2))
            continue
        if line.startswith("flabel "):
            parts = line.split()
            i = 2
            if parts[i] == "s":
                i = 3
            x1, x2 = int(parts[i]), int(parts[i + 2])
            name = parts[-1]
            if name in ("VSS", "VDD"):
                parts[i] = str(x1)
                parts[i + 2] = str(FIXED_W)
            else:
                parts[i] = str(tx(x1))
                parts[i + 2] = str(tx(x2))
            out.append(" ".join(parts) + "\n")
            continue
        if line.startswith("string FIXED_BBOX"):
            out.append("string FIXED_BBOX 0 0 %d %d\n" % (FIXED_W, FIXED_H))
            continue
        if line.startswith("timestamp "):
            out.append("timestamp %d\n" % TS)
            continue
        out.append(line + "\n")
    return "".join(out)


def write_cmos_inv():
    mag = transform_inv(INV1.read_text(encoding="ascii"))
    (OUT_DIR / "cmos_inv.mag").write_text(mag, encoding="ascii", newline="\n")


def origins():
    return [i * PITCH for i in range(N_STAGES)]


def stack_from_via1(via, metal6):
    """IHP TopMetal1 stack copied from inverter_ring_oscillator (via5 >= 0.62 um)."""
    x1, y1, x2, y2 = via
    # original VPWR: via1 40x40, metal2 +20, metal5 +62, via5 124x124, metal6 from args
    mx1, my1, mx2, my2 = x1 - 20, y1 - 20, x2 + 20, y2 + 20
    m5x1, m5y1, m5x2, m5y2 = x1 - 62, y1 - 62, x2 + 62, y2 + 62
    v5x1, v5y1, v5x2, v5y2 = x1 - 42, y1 - 42, x2 + 42, y2 + 42
    return "".join(
        [
            "<< via1 >>\n" + emit_rect(x1, y1, x2, y2),
            "<< metal2 >>\n" + emit_rect(mx1, my1, mx2, my2),
            "<< via2 >>\n" + emit_rect(x1, y1, x2, y2),
            "<< metal3 >>\n" + emit_rect(mx1, my1, mx2, my2),
            "<< via3 >>\n" + emit_rect(x1, y1, x2, y2),
            "<< metal4 >>\n" + emit_rect(mx1, my1, mx2, my2),
            "<< via4 >>\n" + emit_rect(x1, y1, x2, y2),
            "<< metal5 >>\n" + emit_rect(m5x1, m5y1, m5x2, m5y2),
            "<< via5 >>\n" + emit_rect(v5x1, v5y1, v5x2, v5y2),
            "<< metal6 >>\n" + emit_rect(*metal6),
        ]
    )


def ring_paint():
    ox = origins()
    last = ox[-1]
    total_w = last + FIXED_W
    lines = []

    def m1(x1, y1, x2, y2):
        lines.append(emit_rect(x1, y1, x2, y2))

    for i in range(N_STAGES - 1):
        m1(ox[i] + Y_X1, JUNC_Y1, ox[i + 1] + A_X2, JUNC_Y2)

    fb_r1 = total_w + 48
    fb_r2 = fb_r1 + TRACK
    fb_l1 = -80
    fb_l2 = fb_l1 + TRACK
    fb_b1 = -128
    fb_b2 = fb_b1 + TRACK

    m1(last + Y_X1, JUNC_Y1, fb_r2, JUNC_Y2)
    m1(fb_r1, fb_b1, fb_r2, JUNC_Y2)
    m1(fb_l1, fb_b1, fb_r2, fb_b2)
    m1(fb_l1, fb_b1, fb_l2, JUNC_Y2)
    m1(fb_l2, JUNC_Y1, ox[0] + A_X2, JUNC_Y2)

    m1(0, VSS_Y1, total_w, VSS_Y2)
    m1(0, VDD_Y1, total_w, VDD_Y2)

    # 1.0 µm Metal1 pad on last-stage Y so LibreLane can route clk_ring.
    pad = (last + Y_X1, 280, last + Y_X1 + 200, 480)
    m1(*pad)

    paint = "<< metal1 >>\n" + "".join(lines)

    # Exact VPWR stack from the working stdcell ring (left, on VDD rail)
    vpwr_via = (14, 754, 54, 794)
    vpwr_m6 = (-186, 592, 254, 920)
    paint += stack_from_via1(vpwr_via, vpwr_m6)

    # VGND stack: same relative geometry, via1 sitting on the ground rail
    vgnd_via = (total_w - 80, -20, total_w - 40, 20)
    vx1 = vgnd_via[0]
    vy1 = vgnd_via[1]
    vgnd_m6 = (vx1 - 200, vy1 - 126, vx1 + 240, vy1 + 202)
    paint += stack_from_via1(vgnd_via, vgnd_m6)
    return paint, vpwr_m6, vgnd_m6, total_w, pad


def write_ring():
    paint, vpwr_m6, vgnd_m6, total_w, out_pad = ring_paint()
    ox = origins()
    bx1, by1, bx2, by2 = CHILD_BOX
    uses = []
    for i, x in enumerate(ox):
        uses.append(
            "use cmos_inv  x%d\n"
            "timestamp %d\n"
            "transform 1 0 %d 0 1 0\n"
            "box %d %d %d %d\n" % (i, TS, x, bx1, by1, bx2, by2)
        )
    # Label out on top-level M1 that shorts to last-stage Y (not on child paint).
    labels = (
        "<< labels >>\n"
        "flabel metal1 %d %d %d %d 0 FreeSans 1600 0 0 0 out\n"
        "port 0 nsew\n"
        "flabel metal1 0 %d %d %d 0 FreeSans 1600 0 0 0 VPWR\n"
        "port 1 nsew\n"
        "flabel metal6 %d %d %d %d 0 FreeSans 1600 0 0 0 VPWR\n"
        "port 1 nsew\n"
        "flabel metal1 0 %d %d %d 0 FreeSans 1600 0 0 0 VGND\n"
        "port 2 nsew\n"
        "flabel metal6 %d %d %d %d 0 FreeSans 1600 0 0 0 VGND\n"
        "port 2 nsew\n"
        "<< end >>\n"
        % (
            out_pad[0],
            out_pad[1],
            out_pad[2],
            out_pad[3],
            VDD_Y1,
            total_w,
            VDD_Y2,
            vpwr_m6[0],
            vpwr_m6[1],
            vpwr_m6[2],
            vpwr_m6[3],
            VSS_Y1,
            total_w,
            VSS_Y2,
            vgnd_m6[0],
            vgnd_m6[1],
            vgnd_m6[2],
            vgnd_m6[3],
        )
    )
    mag = (
        "magic\n"
        "tech ihp-sg13g2\n"
        "magscale 1 2\n"
        "timestamp %d\n" % TS
        + paint
        + "".join(uses)
        + labels
    )
    (OUT_DIR / "ring_oscillator.mag").write_text(mag, encoding="ascii", newline="\n")


def main():
    if not INV1.exists():
        raise SystemExit("missing template %s" % INV1)
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    write_cmos_inv()
    write_ring()
    print(
        "wrote %s  (L=%sum, pitch=%su, DX=%s, W=%s)"
        % (OUT_DIR / "cmos_inv.mag", L_UM, PITCH, DX, FIXED_W)
    )
    print(
        "wrote %s  (%s stages, width=%su)"
        % (OUT_DIR / "ring_oscillator.mag", N_STAGES, N_STAGES * PITCH)
    )


if __name__ == "__main__":
    main()
