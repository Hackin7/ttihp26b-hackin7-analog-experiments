"""Create origin-normalized ring_oscillator GDS and LEF views.

The source Magic/GDS cell is named ``main`` and spans
(-1.90, -0.30) to (8.08, 4.60) microns.  LibreLane needs a leaf macro
whose cell name matches the RTL module and whose geometry starts at (0, 0).
"""

from __future__ import annotations

import re
import struct
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
GENERATED_GDS = ROOT / "analog/inverter_ring_oscillator/macro/main_fixed.gds"
SOURCE_GDS = (
    GENERATED_GDS
    if GENERATED_GDS.exists()
    else ROOT / "analog/inverter_ring_oscillator/gds/main.gds"
)
SOURCE_LEF = ROOT / "analog/inverter_ring_oscillator/gds/lef.lef"
OUTPUT_DIR = ROOT / "analog/inverter_ring_oscillator/macro"
OUTPUT_GDS = OUTPUT_DIR / "ring_oscillator.gds"
OUTPUT_LEF = OUTPUT_DIR / "ring_oscillator.lef"
EXTRACTED_SPICE = OUTPUT_DIR / "ring_oscillator_extracted.spice"

SHIFT_DBU = (1900, 300)
SHIFT_UM = (1.9, 0.3)
SIZE_DBU = (9980, 4900)  # LEF SIZE 9.980 x 4.900 µm at 1 nm database units
PR_BOUNDARY_LAYER = 189  # IHP BOUND / prBoundary
PR_BOUNDARY_DATATYPE = 4

TOP_CELLS = ("main", "ring_oscillator")


def record(record_type: int, data_type: int, payload: bytes) -> bytes:
    if len(payload) % 2:
        payload += b"\0"
    return struct.pack(">HBB", len(payload) + 4, record_type, data_type) + payload


def pr_boundary_element(width: int, height: int) -> bytes:
    """GDS BOUNDARY on the IHP PR-boundary layer covering the LEF outline."""
    x1, y1 = 0, 0
    x2, y2 = width, height
    xy = struct.pack(
        ">10i",
        x1, y1,
        x2, y1,
        x2, y2,
        x1, y2,
        x1, y1,
    )
    return b"".join(
        [
            record(0x08, 0, b""),  # BOUNDARY
            record(0x0D, 2, struct.pack(">H", PR_BOUNDARY_LAYER)),
            record(0x0E, 2, struct.pack(">H", PR_BOUNDARY_DATATYPE)),
            record(0x10, 3, xy),  # XY
            record(0x11, 0, b""),  # ENDEL
        ]
    )


def normalize_gds() -> None:
    raw = SOURCE_GDS.read_bytes()
    output: list[bytes] = []
    offset = 0
    structure = None

    while offset < len(raw):
        length, record_type, data_type = struct.unpack(">HBB", raw[offset : offset + 4])
        payload = raw[offset + 4 : offset + length]
        offset += length

        if record_type == 0x06:  # STRNAME
            structure = payload.rstrip(b"\0").decode("ascii")
            if structure in TOP_CELLS:
                payload = b"ring_oscillator"
        elif structure in TOP_CELLS and record_type == 0x10:  # XY
            values = list(struct.unpack(">" + "i" * (len(payload) // 4), payload))
            for index in range(0, len(values), 2):
                values[index] += SHIFT_DBU[0]
                values[index + 1] += SHIFT_DBU[1]
            payload = struct.pack(">" + "i" * len(values), *values)
        elif structure in TOP_CELLS and record_type == 0x19:  # STRING
            label = payload.rstrip(b"\0").decode("ascii")
            if label == "VDD":
                payload = b"VPWR"
            elif label in ("VSS", "GND"):
                payload = b"VGND"

        output.append(record(record_type, data_type, payload))

    OUTPUT_GDS.write_bytes(b"".join(output))
    inject_pr_boundary(OUTPUT_GDS)


def inject_pr_boundary(path: Path, width: int = SIZE_DBU[0], height: int = SIZE_DBU[1]) -> None:
    """Insert a PR-boundary box on cell ring_oscillator if one is not present."""
    raw = path.read_bytes()
    output: list[bytes] = []
    offset = 0
    structure = None
    in_top = False
    has_pr = False
    while offset < len(raw):
        length, record_type, data_type = struct.unpack(">HBB", raw[offset : offset + 4])
        payload = raw[offset + 4 : offset + length]
        chunk = raw[offset : offset + length]
        offset += length

        if record_type == 0x06:  # STRNAME
            structure = payload.rstrip(b"\0").decode("ascii")
            in_top = structure == "ring_oscillator"
            has_pr = False
        elif in_top and record_type == 0x0D and len(payload) >= 2:
            if struct.unpack(">H", payload[:2])[0] == PR_BOUNDARY_LAYER:
                has_pr = True
        elif in_top and record_type == 0x07 and not has_pr:
            output.append(pr_boundary_element(width, height))
            in_top = False

        output.append(chunk)

    path.write_bytes(b"".join(output))


def shifted_rect(line: str) -> str:
    match = re.match(r"(\s*RECT\s+)([-0-9.]+)\s+([-0-9.]+)\s+([-0-9.]+)\s+([-0-9.]+)(\s*;)", line)
    if not match:
        return line
    x0, y0, x1, y1 = (float(match.group(i)) for i in range(2, 6))
    return (
        f"{match.group(1)}{x0 + SHIFT_UM[0]:.3f} {y0 + SHIFT_UM[1]:.3f} "
        f"{x1 + SHIFT_UM[0]:.3f} {y1 + SHIFT_UM[1]:.3f}{match.group(6)}"
    )


def normalize_lef() -> None:
    if not SOURCE_LEF.exists():
        # Keep the already-written pin LEF; only GDS origin/name is regenerated.
        return
    source = SOURCE_LEF.read_text(encoding="ascii").splitlines()
    obs_lines: list[str] = []
    in_obs = False
    layer = None
    pin_rectangles = {
        "Metal1": [
            (8.950, 1.780, 9.950, 2.780),  # out
            (0.210, 4.150, 9.890, 4.600),  # VPWR
            (0.160, 0.230, 9.960, 0.860),  # VGND
        ]
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

            shifted = shifted_rect(line)
            rect_match = re.match(
                r"\s*RECT\s+([-0-9.]+)\s+([-0-9.]+)\s+([-0-9.]+)\s+([-0-9.]+)\s*;",
                shifted,
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
            obs_lines.append(shifted)

    lef = [
        "VERSION 5.7 ;",
        "NOWIREEXTENSIONATPIN ON ;",
        'DIVIDERCHAR "/" ;',
        'BUSBITCHARS "[]" ;',
        "MACRO ring_oscillator",
        "  CLASS BLOCK ;",
        "  FOREIGN ring_oscillator 0.000 0.000 ;",
        "  ORIGIN 0.000 0.000 ;",
        "  SIZE 9.980 BY 4.900 ;",
        "  PIN out",
        "    DIRECTION OUTPUT ;",
        "    USE SIGNAL ;",
        "    PORT",
        "      LAYER Metal1 ;",
        "        RECT 8.950 1.780 9.950 2.780 ;",
        "    END",
        "  END out",
        "  PIN VPWR",
        "    DIRECTION INOUT ;",
        "    USE POWER ;",
        "    PORT",
        "      LAYER Metal1 ;",
        "        RECT 0.210 4.150 9.890 4.600 ;",
        "    END",
        "  END VPWR",
        "  PIN VGND",
        "    DIRECTION INOUT ;",
        "    USE GROUND ;",
        "    PORT",
        "      LAYER Metal1 ;",
        "        RECT 0.160 0.230 9.960 0.860 ;",
        "    END",
        "  END VGND",
        "  OBS",
        *obs_lines,
        "  END",
        "END ring_oscillator",
        "END LIBRARY",
        "",
    ]
    OUTPUT_LEF.write_text("\n".join(lef), encoding="ascii")


def normalize_extracted_spice() -> None:
    if not EXTRACTED_SPICE.exists():
        return
    text = EXTRACTED_SPICE.read_text(encoding="ascii")
    text = text.replace(".subckt main out VPWR VGND", ".subckt ring_oscillator out VPWR VGND")
    EXTRACTED_SPICE.write_text(text, encoding="ascii")


def main() -> None:
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    normalize_gds()
    normalize_lef()
    normalize_extracted_spice()
    print(f"wrote {OUTPUT_GDS}")
    print(f"wrote {OUTPUT_LEF}")


if __name__ == "__main__":
    main()
