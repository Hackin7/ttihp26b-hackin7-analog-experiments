#!/usr/bin/env python3
"""Turn the Magic LVS spice into an ngspice-ready chip netlist.

Strips empty black-box .subckt stubs, sanitizes bus/hierarchy node names,
and (by default) replaces fill/decap cells with empty stubs so a functional
transient does not simulate ~1800 filler transistors.
"""

from __future__ import annotations

import argparse
import re
from pathlib import Path

TOP = "tt_um_hackin7_analog_experiments"
STUB_CELLS = (
    "sg13g2_fill_1",
    "sg13g2_fill_2",
    "sg13g2_decap_4",
    "sg13g2_decap_8",
)

BUS_RE = re.compile(r"([A-Za-z_][A-Za-z0-9_]*)\[(\d+)\]")
SUBCKT_RE = re.compile(r"^\.subckt\s+(\S+)", re.IGNORECASE)


def sanitize(text: str) -> str:
    text = BUS_RE.sub(r"\1_\2", text)
    return text.replace("/", "__")


def split_subckts(text: str) -> list[tuple[str | None, str]]:
    """Return (name, block) chunks. Preamble has name None."""
    chunks: list[tuple[str | None, str]] = []
    current: list[str] = []
    name: str | None = None
    for line in text.splitlines(keepends=True):
        match = SUBCKT_RE.match(line.lstrip())
        if match:
            if current:
                chunks.append((name, "".join(current)))
            current = [line]
            name = match.group(1)
            continue
        current.append(line)
        if line.lstrip().lower().startswith(".ends"):
            chunks.append((name, "".join(current)))
            current = []
            name = None
    if current:
        chunks.append((name, "".join(current)))
    return chunks


def extract_top(src: Path) -> str:
    chunks = split_subckts(src.read_text(encoding="ascii", errors="replace"))
    for name, block in chunks:
        if name == TOP:
            return sanitize(block)
    raise SystemExit(f"{src}: no .subckt {TOP}")


def filter_stdcells(src: Path, stub_fill: bool) -> str:
    chunks = split_subckts(src.read_text(encoding="ascii", errors="replace"))
    out: list[str] = []
    stubbed: set[str] = set()
    for name, block in chunks:
        if name in STUB_CELLS and stub_fill:
            pins = block.splitlines()[0]
            pin_match = re.match(r"^\.subckt\s+\S+(.*)$", pins.strip(), re.IGNORECASE)
            pin_str = pin_match.group(1) if pin_match else " VDD VSS"
            out.append(f"* stubbed {name} (fill/decap omitted from functional sim)\n")
            out.append(f".subckt {name}{pin_str}\n.ends\n")
            stubbed.add(name)
            continue
        out.append(block if block.endswith("\n") else block + "\n")
    for name in STUB_CELLS:
        if stub_fill and name not in stubbed:
            out.append(f".subckt {name} VDD VSS\n.ends\n")
    return "".join(out)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--src", type=Path, required=True, help="Magic LVS spice")
    parser.add_argument("--stdcell", type=Path, required=True, help="PDK sg13g2_stdcell.spice")
    parser.add_argument("--chip-out", type=Path, required=True)
    parser.add_argument("--stdcell-out", type=Path, required=True)
    parser.add_argument(
        "--full",
        action="store_true",
        help="Keep PDK fill/decap transistors instead of empty stubs",
    )
    args = parser.parse_args()

    if not args.src.is_file():
        raise SystemExit(f"missing LVS spice: {args.src} (harden the project first)")
    if not args.stdcell.is_file():
        raise SystemExit(f"missing stdcell spice: {args.stdcell}")

    args.chip_out.parent.mkdir(parents=True, exist_ok=True)
    chip = extract_top(args.src)
    args.chip_out.write_text(
        "* Prepared from Magic LVS extract; black boxes removed.\n" + chip,
        encoding="ascii",
    )
    args.stdcell_out.write_text(
        filter_stdcells(args.stdcell, stub_fill=not args.full),
        encoding="ascii",
    )
    print(f"wrote {args.chip_out}")
    print(f"wrote {args.stdcell_out}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
