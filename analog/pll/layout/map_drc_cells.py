#!/usr/bin/env python3
"""Map Magic DRC error boxes to nearby cell instances."""
import re
from pathlib import Path
from collections import Counter, defaultdict

UM = 0.005
HALO = 1.0  # um


def parse_uses(mag):
    uses = {}
    lines = Path(mag).read_text().splitlines()
    i = 0
    while i < len(lines):
        m = re.match(r"use\s+(\S+)\s+(\S+)", lines[i])
        if m:
            cell, inst = m.group(1), m.group(2)
            j = i + 1
            while j < len(lines) and not lines[j].startswith("transform"):
                j += 1
            t = list(map(int, lines[j].split()[1:7]))
            uses[inst] = (cell, t)
            i = j + 1
            continue
        i += 1
    return uses


def bbox_um(magpath):
    text = Path(magpath).read_text()
    scale = 2 if (Path(magpath).name.startswith("cap_cmim") and "magscale" not in text[:120]) else 1
    skip = {
        "checkpaint", "properties", "labels", "end", "error_p", "error_s",
        "warning", "fence", "comment",
    }
    xs, ys, cur = [], [], None
    for line in text.splitlines():
        m = re.match(r"<<\s+(\S+)\s+>>", line)
        if m:
            cur = m.group(1)
            continue
        m = re.match(r"rect\s+(-?\d+)\s+(-?\d+)\s+(-?\d+)\s+(-?\d+)", line)
        if not m or not cur or cur in skip or "fill" in cur:
            continue
        x1, y1, x2, y2 = map(int, m.groups())
        xs += [x1, x2]
        ys += [y1, y2]
    if not xs:
        return None
    return (scale * min(xs) * UM, scale * min(ys) * UM, scale * max(xs) * UM, scale * max(ys) * UM)


def xform(pt, t):
    x, y = pt
    a, b, c, d, e, f = t
    return (a * x + b * y + c, d * x + e * y + f)


def abs_bbox(bb, t):
    x0, y0, x1, y1 = bb
    corners = [(x0 / UM, y0 / UM), (x1 / UM, y0 / UM), (x0 / UM, y1 / UM), (x1 / UM, y1 / UM)]
    pts = [(xform(p, t)[0] * UM, xform(p, t)[1] * UM) for p in corners]
    xs = [p[0] for p in pts]
    ys = [p[1] for p in pts]
    return (min(xs), min(ys), max(xs), max(ys))


def main():
    uses = parse_uses("pll_analog.mag")
    bbs = {}
    for inst, (cell, t) in uses.items():
        p = Path(f"{cell}.mag")
        if not p.exists():
            continue
        local = bbox_um(p)
        if local:
            bbs[inst] = (cell, abs_bbox(local, t))

    def hits(xc, yc):
        found = []
        for inst, (cell, (x0, y0, x1, y1)) in bbs.items():
            if x0 - HALO <= xc <= x1 + HALO and y0 - HALO <= yc <= y1 + HALO:
                found.append(inst)
        return found

    raw = Path("drc_why.txt").read_text(encoding="utf-8", errors="replace")
    lines = [l.strip() for l in raw.splitlines() if l.strip()]
    rule_boxes = []
    cur = None
    for l in lines:
        if not l.startswith("{") and not re.match(r"^-?\d", l):
            cur = l
            continue
        for m in re.finditer(r"\{(-?\d+)\s+(-?\d+)\s+(-?\d+)\s+(-?\d+)\}", l):
            x1, y1, x2, y2 = map(int, m.groups())
            rule_boxes.append((cur, x1, y1, x2, y2))

    inst_count = Counter()
    inst_rules = defaultdict(Counter)
    region_all = Counter()
    unmatched = 0

    for rule, x1, y1, x2, y2 in rule_boxes:
        xc = ((x1 + x2) / 2) * UM
        yc = ((y1 + y2) / 2) * UM
        hs = hits(xc, yc)
        if not hs:
            unmatched += 1
        else:
            for inst in hs:
                inst_count[inst] += 1
                if rule:
                    short = rule.split("(")[0].strip()
                    inst_rules[inst][short] += 1
        if xc < 20:
            region_all["PFD (~x<20)"] += 1
        elif xc < 35:
            region_all["CP/bias (~20-35)"] += 1
        elif xc < 55:
            region_all["filter (~35-55)"] += 1
        else:
            region_all["VCO (~x>55)"] += 1

    print(f"Total error boxes: {len(rule_boxes)}  unmatched(top-route only): {unmatched}")
    print("\nBy region:")
    for k, v in region_all.most_common():
        print(f"  {v:5d}  {k}")

    print(f"\nTop cells by nearby DRC (halo={HALO}um):")
    for inst, c in inst_count.most_common(25):
        cell = bbs[inst][0]
        top = inst_rules[inst].most_common(3)
        rs = ", ".join(f"{r[:42]}:{n}" for r, n in top)
        print(f"  {c:5d}  {inst:8s}  {cell}")
        print(f"         {rs}")

    type_count = Counter()
    for inst, c in inst_count.items():
        prefix = re.match(r"[A-Za-z]+", inst).group(0)
        type_count[prefix] += c
    print("\nBy instance family:")
    for p, c in type_count.most_common():
        print(f"  {c:5d}  {p}*")


if __name__ == "__main__":
    main()
