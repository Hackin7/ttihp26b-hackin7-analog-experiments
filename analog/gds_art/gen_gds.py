"""Rasterize analog/gds_art/chips.png into a minimal IHP TopMetal1 GDS macro.

Uses a downscaled bitmap with horizontal run merging to keep the GDS small.
Run: py -3.11 analog/gds_art/gen_gds.py
"""

from __future__ import annotations

import argparse
from pathlib import Path

import gdstk
import numpy as np
from PIL import Image

ROOT = Path(__file__).resolve().parent
SRC = ROOT / "chips.png"
OUT_DIR = ROOT / "macro"
CELL_NAME = "chips_art"

ART_LAYER = 126
BOUNDARY_LAYER = 189
BOUNDARY_DATATYPE = 4

# IHP TopMetal1 min width/spacing ~1.64 um; pitch keeps merged rects DRC-friendly.
PITCH_UM = 3.28
METAL_UM = 1.64

DEFAULT_WIDTH_PX = 24


def foreground_mask(rgb: np.ndarray) -> np.ndarray:
    """Mask out the light-blue PNG backdrop; keep the bag/logo pixels."""
    r = rgb[:, :, 0]
    g = rgb[:, :, 1]
    b = rgb[:, :, 2]
    is_blue_bg = (b > r + 10) & (b > g - 10) & (b > 130)
    return ~is_blue_bg


def crop_foreground(im: Image.Image) -> Image.Image:
    rgb = np.array(im.convert("RGB"))
    mask = foreground_mask(rgb)
    ys, xs = np.where(mask)
    if len(xs) == 0:
        raise SystemExit("no foreground detected in source image")
    return im.crop((int(xs.min()), int(ys.min()), int(xs.max()) + 1, int(ys.max()) + 1))


def rasterize(im: Image.Image, width_px: int) -> np.ndarray:
    height_px = max(1, round(width_px * im.height / im.width))
    small = im.resize((width_px, height_px), Image.Resampling.LANCZOS).convert("RGB")
    rgb = np.array(small).astype(float)
    silhouette = foreground_mask(rgb)

    lum = 0.299 * rgb[:, :, 0] + 0.587 * rgb[:, :, 1] + 0.114 * rgb[:, :, 2]
    detail = silhouette & (lum < 220)
    # Below ~18 px the logo collapses; use the full bag silhouette instead.
    if min(width_px, height_px) >= 18:
        return detail
    return silhouette


def merge_runs(bitmap: np.ndarray) -> list[tuple[float, float, float, float]]:
    """Return TopMetal1 rectangles (um) with horizontal run merging."""
    height, width = bitmap.shape
    gap = PITCH_UM - METAL_UM
    rects: list[tuple[float, float, float, float]] = []
    for row in range(height):
        col = 0
        while col < width:
            if not bitmap[row, col]:
                col += 1
                continue
            start = col
            while col < width and bitmap[row, col]:
                col += 1
            x0 = start * PITCH_UM + gap / 2
            y0 = (height - 1 - row) * PITCH_UM + gap / 2
            x1 = col * PITCH_UM - gap / 2
            y1 = y0 + METAL_UM
            rects.append((x0, y0, x1, y1))
    return rects


def write_lef(path: Path, cell_name: str, width_um: float, height_um: float) -> None:
    path.write_text(
        "\n".join(
            [
                "# Minimal LEF for decorative TopMetal1 macro",
                "VERSION 5.8 ;",
                "NAMESCASESENSITIVE ON ;",
                "DIVIDERCHAR \"/\" ;",
                "BUSBITCHARS \"[]\" ;",
                "UNITS",
                "   DATABASE MICRONS 1000 ;",
                "END UNITS",
                "",
                f"MACRO {cell_name}",
                "   CLASS COVER ;",
                f"   FOREIGN {cell_name} 0 0 ;",
                f"   SIZE {width_um:.3f} BY {height_um:.3f} ;",
                "   SYMMETRY X Y ;",
                f"END {cell_name}",
                "",
            ]
        ),
        encoding="ascii",
    )


def generate(width_px: int, out_dir: Path) -> dict:
    im = crop_foreground(Image.open(SRC))
    bitmap = rasterize(im, width_px)
    height_px, width_px = bitmap.shape
    width_um = width_px * PITCH_UM
    height_um = height_px * PITCH_UM

    lib = gdstk.Library()
    cell = lib.new_cell(CELL_NAME)
    cell.add(
        gdstk.rectangle(
            (0, 0),
            (width_um, height_um),
            layer=BOUNDARY_LAYER,
            datatype=BOUNDARY_DATATYPE,
        )
    )
    rects = merge_runs(bitmap)
    for x0, y0, x1, y1 in rects:
        cell.add(gdstk.rectangle((x0, y0), (x1, y1), layer=ART_LAYER))

    out_dir.mkdir(parents=True, exist_ok=True)
    gds_path = out_dir / f"{CELL_NAME}.gds"
    lef_path = out_dir / f"{CELL_NAME}.lef"
    svg_path = out_dir / f"{CELL_NAME}.svg"
    preview_path = out_dir / f"{CELL_NAME}_preview.png"

    lib.write_gds(gds_path)
    write_lef(lef_path, CELL_NAME, width_um, height_um)
    cell.write_svg(str(svg_path), background="#eef6fb")

    preview = Image.fromarray((~bitmap * 255).astype(np.uint8), mode="L")
    preview = preview.resize((preview.width * 16, preview.height * 16), Image.Resampling.NEAREST)
    preview.save(preview_path)

    gds_size = gds_path.stat().st_size
    return {
        "width_px": width_px,
        "height_px": height_px,
        "width_um": width_um,
        "height_um": height_um,
        "rects": len(rects),
        "on_pixels": int(bitmap.sum()),
        "gds_bytes": gds_size,
        "gds_path": gds_path,
        "lef_path": lef_path,
        "svg_path": svg_path,
        "preview_path": preview_path,
    }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--width",
        type=int,
        default=DEFAULT_WIDTH_PX,
        help=f"Bitmap width in pixels (default {DEFAULT_WIDTH_PX})",
    )
    parser.add_argument(
        "--sweep",
        action="store_true",
        help="Try several widths and print a comparison table",
    )
    args = parser.parse_args()

    if args.sweep:
        print("width_px height_px on_px rects gds_bytes footprint_um")
        for w in range(12, 33, 2):
            stats = generate(w, OUT_DIR / f"_sweep_{w}")
            print(
                f"{stats['width_px']:8d} {stats['height_px']:9d} "
                f"{stats['on_pixels']:5d} {stats['rects']:5d} "
                f"{stats['gds_bytes']:9d} "
                f"{stats['width_um']:.1f}x{stats['height_um']:.1f}"
            )
        return

    stats = generate(args.width, OUT_DIR)
    print(
        f"wrote {stats['gds_path']} "
        f"({stats['width_px']}x{stats['height_px']} px, "
        f"{stats['width_um']:.2f}x{stats['height_um']:.2f} um, "
        f"{stats['rects']} rects, {stats['gds_bytes']} bytes)"
    )
    print(f"preview {stats['preview_path']}")
    print(f"svg     {stats['svg_path']}")


if __name__ == "__main__":
    main()
