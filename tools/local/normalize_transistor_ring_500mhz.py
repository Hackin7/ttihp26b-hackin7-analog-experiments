"""Origin-normalize the 500 MHz transistor ring for LibreLane.

Magic writes ring_oscillator with negative coordinates. LibreLane needs cell
origin (0, 0), a PR-boundary, pins out/VPWR/VGND, and a unique cell name
ring_oscillator_500mhz (distinct from the 100 MHz leaf).
"""

from pathlib import Path
import re
import struct

ROOT = Path(__file__).resolve().parents[2]
MACRO = ROOT / "analog/transistor_ring_oscillator_500mhz/macro"
SOURCE_GDS = MACRO / "main_fixed.gds"
SOURCE_LEF = MACRO / "ring_oscillator.lef"
OUTPUT_GDS = MACRO / "ring_oscillator_500mhz.gds"
OUTPUT_LEF = MACRO / "ring_oscillator_500mhz.lef"
EXTRACTED_SPICE = MACRO / "ring_oscillator_extracted.spice"
OUTPUT_SPICE = MACRO / "ring_oscillator_500mhz.spice"

CELL_NAME = "ring_oscillator_500mhz"
MAGIC_CELL = "ring_oscillator"

SHIFT_UM = (0.930, 0.730)
SHIFT_DBU = (930, 730)  # 1 nm database units
SIZE_UM = (16.130, 5.330)
SIZE_DBU = (16130, 5330)
PR_BOUNDARY_LAYER = 189
PR_BOUNDARY_DATATYPE = 4

PIN_OUT_M1 = (13.730, 2.130, 14.730, 3.130)
PIN_VPWR_M1 = (0.930, 4.290, 15.330, 4.730)
PIN_VPWR_TM1 = (0.000, 3.690, 2.200, 5.330)
PIN_VGND_M1 = (0.930, 0.510, 15.330, 0.950)
PIN_VGND_TM1 = (13.930, 0.000, 16.130, 1.640)


def record(record_type, data_type, payload):
    if len(payload) % 2:
        payload += b"\0"
    return struct.pack(">HBB", len(payload) + 4, record_type, data_type) + payload


def pr_boundary_element(width, height):
    xy = struct.pack(
        ">10i",
        0, 0,
        width, 0,
        width, height,
        0, height,
        0, 0,
    )
    return b"".join(
        [
            record(0x08, 0, b""),
            record(0x0D, 2, struct.pack(">H", PR_BOUNDARY_LAYER)),
            record(0x0E, 2, struct.pack(">H", PR_BOUNDARY_DATATYPE)),
            record(0x10, 3, xy),
            record(0x11, 0, b""),
        ]
    )


def normalize_gds():
    raw = SOURCE_GDS.read_bytes()
    output = []
    offset = 0
    structure = None
    while offset < len(raw):
        length, record_type, data_type = struct.unpack(">HBB", raw[offset : offset + 4])
        payload = raw[offset + 4 : offset + length]
        offset += length

        if record_type == 0x06:
            structure = payload.rstrip(b"\0").decode("ascii")
            if structure == MAGIC_CELL:
                payload = CELL_NAME.encode("ascii")
                # Keep tracking as MAGIC_CELL so XY shift still applies.
            # structure variable stays MAGIC_CELL for shift matching
        elif structure == MAGIC_CELL and record_type == 0x10 and data_type == 3:
            values = list(struct.unpack(">" + "i" * (len(payload) // 4), payload))
            for index in range(0, len(values), 2):
                values[index] += SHIFT_DBU[0]
                values[index + 1] += SHIFT_DBU[1]
            payload = struct.pack(">" + "i" * len(values), *values)

        output.append(record(record_type, data_type, payload))

    OUTPUT_GDS.write_bytes(b"".join(output))
    inject_pr_boundary(OUTPUT_GDS)


def inject_pr_boundary(path):
    raw = path.read_bytes()
    output = []
    offset = 0
    in_top = False
    has_pr = False
    while offset < len(raw):
        length, record_type, data_type = struct.unpack(">HBB", raw[offset : offset + 4])
        payload = raw[offset + 4 : offset + length]
        chunk = raw[offset : offset + length]
        offset += length

        if record_type == 0x06:
            structure = payload.rstrip(b"\0").decode("ascii")
            in_top = structure == CELL_NAME
            has_pr = False
        elif in_top and record_type == 0x0D and len(payload) >= 2:
            if struct.unpack(">H", payload[:2])[0] == PR_BOUNDARY_LAYER:
                has_pr = True
        elif in_top and record_type == 0x07 and not has_pr:
            output.append(pr_boundary_element(SIZE_DBU[0], SIZE_DBU[1]))
            in_top = False

        output.append(chunk)

    path.write_bytes(b"".join(output))


def shifted_rect(line):
    match = re.match(
        r"(\s*RECT\s+)([-0-9.]+)\s+([-0-9.]+)\s+([-0-9.]+)\s+([-0-9.]+)(\s*;)",
        line,
    )
    if not match:
        return line
    x0, y0, x1, y1 = (float(match.group(i)) for i in range(2, 6))
    return (
        "%s%.3f %.3f %.3f %.3f%s"
        % (
            match.group(1),
            x0 + SHIFT_UM[0],
            y0 + SHIFT_UM[1],
            x1 + SHIFT_UM[0],
            y1 + SHIFT_UM[1],
            match.group(6),
        )
    )


def fmt_rect(rect):
    return "        RECT %.3f %.3f %.3f %.3f ;" % rect


def via_stack_obs_lines():
    """Block M2-M5 via-stack pads so PnR fill cannot violate M2.b against GDS metal.

    Magic puts Metal2-5 on VPWR/VGND PIN ports; the normalized LEF only exposes
    Metal1 + TopMetal1 pins, so without OBS LibreLane metal fill lands ~0.03 um
    from the VGND Metal2 pad (KLayout M2.b). Extend OBS to the PR-boundary on
    the pad side so the fill channel is closed.
    """
    # Source LEF (pre-shift) stack pads + SHIFT_UM, then extend to edge.
    sx, sy = SHIFT_UM
    w, _h = SIZE_UM
    vpwr_m2 = (round(-0.030 + sx, 3), round(3.670 + sy, 3), round(0.370 + sx, 3), round(4.070 + sy, 3))
    vgnd_m2 = (round(13.900 + sx, 3), round(-0.200 + sy, 3), round(14.300 + sx, 3), round(0.200 + sy, 3))
    vpwr_m5 = (round(-0.240 + sx, 3), round(3.460 + sy, 3), round(0.580 + sx, 3), round(4.280 + sy, 3))
    vgnd_m5 = (round(13.690 + sx, 3), round(-0.410 + sy, 3), round(14.510 + sx, 3), round(0.410 + sy, 3))
    # Extend pad-side OBS out to the macro edge (closes fill gap).
    vpwr_m2_obs = (0.000, vpwr_m2[1], vpwr_m2[2], vpwr_m2[3])
    vgnd_m2_obs = (vgnd_m2[0], vgnd_m2[1], w, vgnd_m2[3])
    vpwr_m5_obs = (0.000, vpwr_m5[1], vpwr_m5[2], vpwr_m5[3])
    vgnd_m5_obs = (vgnd_m5[0], vgnd_m5[1], w, vgnd_m5[3])
    lines = []
    for layer, rects in (
        ("Metal2", (vpwr_m2_obs, vgnd_m2_obs)),
        ("Metal3", (vpwr_m2_obs, vgnd_m2_obs)),
        ("Metal4", (vpwr_m2_obs, vgnd_m2_obs)),
        ("Metal5", (vpwr_m5_obs, vgnd_m5_obs)),
    ):
        lines.append("      LAYER %s ;" % layer)
        for rect in rects:
            lines.append(fmt_rect(rect))
    return lines


def normalize_lef():
    source = SOURCE_LEF.read_text(encoding="ascii").splitlines()
    obs_lines = []
    in_obs = False
    layer = None
    pin_rectangles = {
        "Metal1": [PIN_OUT_M1, PIN_VPWR_M1, PIN_VGND_M1],
        "TopMetal1": [PIN_VPWR_TM1, PIN_VGND_TM1],
    }
    for line in source:
        stripped = line.strip()
        if stripped == "OBS":
            in_obs = True
            continue
        if in_obs and stripped == "END":
            break
        if in_obs:
            layer_match = re.match(r"LAYER\s+(\S+)\s*;", stripped)
            if layer_match:
                layer = layer_match.group(1)
                obs_lines.append(line)
                continue
            obs_rect = shifted_rect(line)
            rect_match = re.match(
                r"\s*RECT\s+([-0-9.]+)\s+([-0-9.]+)\s+([-0-9.]+)\s+([-0-9.]+)\s*;",
                obs_rect,
            )
            if rect_match and layer in pin_rectangles:
                rect = tuple(float(rect_match.group(index)) for index in range(1, 5))
                overlaps_pin = any(
                    rect[0] < pin[2]
                    and rect[2] > pin[0]
                    and rect[1] < pin[3]
                    and rect[3] > pin[1]
                    for pin in pin_rectangles[layer]
                )
                if overlaps_pin:
                    continue
            obs_lines.append(obs_rect)

    obs_lines.extend(via_stack_obs_lines())

    lef = [
        "VERSION 5.7 ;",
        "NOWIREEXTENSIONATPIN ON ;",
        'DIVIDERCHAR "/" ;',
        'BUSBITCHARS "[]" ;',
        "MACRO %s" % CELL_NAME,
        "  CLASS BLOCK ;",
        "  FOREIGN %s 0.000 0.000 ;" % CELL_NAME,
        "  ORIGIN 0.000 0.000 ;",
        "  SIZE %.3f BY %.3f ;" % SIZE_UM,
        "  PIN out",
        "    DIRECTION OUTPUT ;",
        "    USE SIGNAL ;",
        "    PORT",
        "      LAYER Metal1 ;",
        fmt_rect(PIN_OUT_M1),
        "    END",
        "  END out",
        "  PIN VPWR",
        "    DIRECTION INOUT ;",
        "    USE POWER ;",
        "    PORT",
        "      LAYER Metal1 ;",
        fmt_rect(PIN_VPWR_M1),
        "      LAYER TopMetal1 ;",
        fmt_rect(PIN_VPWR_TM1),
        "    END",
        "  END VPWR",
        "  PIN VGND",
        "    DIRECTION INOUT ;",
        "    USE GROUND ;",
        "    PORT",
        "      LAYER Metal1 ;",
        fmt_rect(PIN_VGND_M1),
        "      LAYER TopMetal1 ;",
        fmt_rect(PIN_VGND_TM1),
        "    END",
        "  END VGND",
        "  OBS",
        *obs_lines,
        "  END",
        "END %s" % CELL_NAME,
        "END LIBRARY",
        "",
    ]
    OUTPUT_LEF.write_text("\n".join(lef), encoding="ascii")


def copy_spice():
    if not EXTRACTED_SPICE.exists():
        return
    text = EXTRACTED_SPICE.read_text(encoding="ascii")
    text = re.sub(
        r"\.subckt\s+%s\b" % re.escape(MAGIC_CELL),
        ".subckt %s" % CELL_NAME,
        text,
    )
    text = re.sub(
        r"\.ends\s+%s\b" % re.escape(MAGIC_CELL),
        ".ends %s" % CELL_NAME,
        text,
    )
    OUTPUT_SPICE.write_text(text, encoding="ascii")


def main():
    if not SOURCE_GDS.exists():
        raise SystemExit("missing %s; run layout_5/run_export_osic.sh first" % SOURCE_GDS)
    if not SOURCE_LEF.exists():
        raise SystemExit("missing %s" % SOURCE_LEF)
    normalize_gds()
    normalize_lef()
    copy_spice()
    print("wrote %s shift_dbu=%s cell=%s" % (OUTPUT_GDS, SHIFT_DBU, CELL_NAME))
    print("wrote %s SIZE %.3f x %.3f um" % (OUTPUT_LEF, SIZE_UM[0], SIZE_UM[1]))
    print("wrote %s" % OUTPUT_SPICE)


if __name__ == "__main__":
    main()
