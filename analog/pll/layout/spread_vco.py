#!/usr/bin/env python3
"""Spread VCO FET instances horizontally for routing channels."""
import re
from pathlib import Path

LAYOUT = Path(__file__).resolve().parent
mag_path = LAYOUT / "pll_analog_bare.mag"
mag = mag_path.read_text().splitlines()

uses = {}
i = 0
while i < len(mag):
    m = re.match(r"use\s+(\S+)\s+(\S+)", mag[i])
    if m:
        cell, inst = m.group(1), m.group(2)
        block = [mag[i]]
        j = i + 1
        while j < len(mag) and not mag[j].startswith("use ") and not mag[j].startswith("<< "):
            block.append(mag[j])
            j += 1
        uses[inst] = (cell, block, i, j)
        i = j
        continue
    i += 1


def get_tx(block):
    for l in block:
        if l.startswith("transform"):
            return list(map(int, l.split()[1:7]))
    return None


vco_insts = [k for k in uses if k.startswith("XMp") or k.startswith("XMn")]
items = []
for inst in vco_insts:
    t = get_tx(uses[inst][1])
    items.append((t[2], inst, t))
items.sort()

new_tx = {}
cursor = items[0][0] if items else 0
for idx, (tx, inst, t) in enumerate(items):
    if idx == 0:
        new_tx[inst] = tx
        cursor = tx
    else:
        # 4 µm min center-to-center delta (800 mag units at 0.005 µm)
        cursor = max(tx, cursor + 800)
        new_tx[inst] = cursor

out = []
i = 0
while i < len(mag):
    m = re.match(r"use\s+(\S+)\s+(\S+)", mag[i])
    if m and m.group(2) in new_tx:
        block = uses[m.group(2)][1]
        old = get_tx(block)[2]
        for l in block:
            if l.startswith("transform"):
                t = list(map(int, l.split()[1:7]))
                t[2] = new_tx[m.group(2)]
                out.append("transform " + " ".join(map(str, t)))
            else:
                out.append(l)
        print(f"{m.group(2)}: {old} -> {new_tx[m.group(2)]}")
        i = uses[m.group(2)][3]
        continue
    out.append(mag[i])
    i += 1

mag_path.write_text("\n".join(out) + "\n")
print("updated", mag_path)
