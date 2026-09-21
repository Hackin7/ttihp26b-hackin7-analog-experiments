import re, math
from collections import defaultdict

path = r"C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments\analog\pll\schematic\pll_top.sch"
text = open(path, encoding="utf-8").read()

wires = []
for m in re.finditer(
    r"^N\s+([-\d.]+)\s+([-\d.]+)\s+([-\d.]+)\s+([-\d.]+)\s+\{lab=([^}]*)\}",
    text,
    re.M,
):
    wires.append(
        (
            float(m.group(1)),
            float(m.group(2)),
            float(m.group(3)),
            float(m.group(4)),
            m.group(5),
        )
    )

# IHP Open-PDK pin centers from official .sym B5 boxes
PMOS = {"G": (-20.0, 0.0), "D": (20.0, 30.0), "S": (20.0, -30.0), "B": (20.0, 0.0)}
NMOS = {"G": (-20.0, 0.0), "D": (20.0, -30.0), "S": (20.0, 30.0), "B": (20.0, 0.0)}
RPPD = {"P": (0.0, -30.0), "M": (0.0, 30.0)}
CAP = {"c0": (0.0, -30.0), "c1": (0.0, 30.0)}

comps = []
lines = text.splitlines()
i = 0
while i < len(lines):
    line = lines[i]
    if line.startswith("C {"):
        block = line
        if not line.rstrip().endswith("}") or line.count("{") > line.count("}"):
            i += 1
            while i < len(lines):
                block += "\n" + lines[i]
                if lines[i].strip() == "}" or (
                    lines[i].endswith("}") and block.count("{") <= block.count("}")
                ):
                    break
                i += 1
        m = re.match(
            r"C \{([^}]+)\}\s+([-\d.]+)\s+([-\d.]+)\s+(\d+)\s+(\d+)\s+\{(.*)\}\s*$",
            block,
            re.S,
        )
        if m:
            sym = m.group(1)
            x, y = float(m.group(2)), float(m.group(3))
            rot, flip = int(m.group(4)), int(m.group(5))
            attrs = m.group(6)
            name_m = re.search(r"name=(\S+)", attrs)
            name = name_m.group(1) if name_m else "?"
            comps.append(
                dict(sym=sym, x=x, y=y, rot=rot, flip=flip, attrs=attrs, name=name)
            )
    i += 1

print(f"Parsed {len(wires)} wires, {len(comps)} components")
print("Components:")
for c in comps:
    print(
        f"  {c['name']:8} {c['sym'][:48]:48} @({c['x']},{c['y']}) rot={c['rot']} flip={c['flip']}"
    )


def transform(px, py, x, y, rot, flip):
    if flip:
        px = -px
    for _ in range(rot % 4):
        px, py = -py, px
    return x + px, y + py


def point_on_seg(px, py, x1, y1, x2, y2, tol=0.05):
    dx, dy = x2 - x1, y2 - y1
    if abs(dx) < 1e-9 and abs(dy) < 1e-9:
        return abs(px - x1) < tol and abs(py - y1) < tol
    cross = (px - x1) * dy - (py - y1) * dx
    if abs(cross) > tol * max(1, math.hypot(dx, dy)):
        return False
    dot = (px - x1) * dx + (py - y1) * dy
    if dot < -tol:
        return False
    if dot > dx * dx + dy * dy + tol:
        return False
    return True


class UF:
    def __init__(self):
        self.p = {}

    def add(self, a):
        self.p.setdefault(a, a)

    def find(self, a):
        self.add(a)
        while self.p[a] != a:
            self.p[a] = self.p[self.p[a]]
            a = self.p[a]
        return a

    def union(self, a, b):
        ra, rb = self.find(a), self.find(b)
        if ra != rb:
            self.p[rb] = ra


uf = UF()
for i in range(len(wires)):
    uf.add(i)


def segs_touch(a, b, tol=0.05):
    x1, y1, x2, y2, _ = a
    x3, y3, x4, y4, _ = b
    for p in [(x1, y1), (x2, y2)]:
        for q in [(x3, y3), (x4, y4)]:
            if abs(p[0] - q[0]) <= tol and abs(p[1] - q[1]) <= tol:
                return True
    for p in [(x1, y1), (x2, y2)]:
        if point_on_seg(p[0], p[1], x3, y3, x4, y4, tol):
            return True
    for p in [(x3, y3), (x4, y4)]:
        if point_on_seg(p[0], p[1], x1, y1, x2, y2, tol):
            return True

    def is_h(xa, ya, xb, yb):
        return abs(ya - yb) <= tol

    def is_v(xa, ya, xb, yb):
        return abs(xa - xb) <= tol

    ah, av = is_h(x1, y1, x2, y2), is_v(x1, y1, x2, y2)
    bh, bv = is_h(x3, y3, x4, y4), is_v(x3, y3, x4, y4)
    if ah and bv:
        y = y1
        x = x3
        if (
            min(x1, x2) - tol <= x <= max(x1, x2) + tol
            and min(y3, y4) - tol <= y <= max(y3, y4) + tol
        ):
            return True
    if av and bh:
        x = x1
        y = y3
        if (
            min(y1, y2) - tol <= y <= max(y1, y2) + tol
            and min(x3, x4) - tol <= x <= max(x3, x4) + tol
        ):
            return True
    return False


for i in range(len(wires)):
    for j in range(i + 1, len(wires)):
        if segs_touch(wires[i], wires[j]):
            uf.union(i, j)

groups = defaultdict(set)
for i, w in enumerate(wires):
    groups[uf.find(i)].add(w[4])

print("\n=== Connected wire groups with MULTIPLE labels (shorts/conflicts) ===")
multi = False
for g, labs in groups.items():
    if len(labs) > 1:
        multi = True
        print(" SHORT/MERGE:", sorted(labs))
if not multi:
    print(" (none)")


def resolved_at(ax, ay, tol=0.51):
    resolved = set()
    for i, w in enumerate(wires):
        if (
            point_on_seg(ax, ay, w[0], w[1], w[2], w[3], tol=tol)
            or (abs(ax - w[0]) <= tol and abs(ay - w[1]) <= tol)
            or (abs(ax - w[2]) <= tol and abs(ay - w[3]) <= tol)
        ):
            resolved |= groups[uf.find(i)]
    return resolved


print("\n=== Charge pump FET pin nets ===")
cp = [
    ("M1", "pmos", 360, -210, 0, 0),
    ("M3", "pmos", 360, -120, 0, 0),
    ("M2", "nmos", 360, -30, 0, 0),
    ("M4", "nmos", 360, 50, 0, 0),
]
for name, typ, x, y, rot, flip in cp:
    pins = PMOS if typ == "pmos" else NMOS
    print(f"\n{name} {typ} @({x},{y}):")
    for pname, (px, py) in pins.items():
        ax, ay = transform(px, py, x, y, rot, flip)
        resolved = resolved_at(ax, ay)
        print(f"  {pname} @({ax},{ay}): {resolved or '{FLOATING}'}")

print("\n=== #net22 / out crossing analysis ===")
net22_ids = [i for i, w in enumerate(wires) if w[4] == "#net22"]
out_ids = [i for i, w in enumerate(wires) if w[4] == "out"]
print("net22 segments:")
for i in net22_ids:
    print(" ", wires[i])
print("out segments near x=1790:")
for i in out_ids:
    w = wires[i]
    if min(w[0], w[2]) - 1 <= 1790 <= max(w[0], w[2]) + 1:
        print(" ", w)
print("cross point (1790,0) resolved:", resolved_at(1790, 0))
print("net22 roots", {uf.find(i) for i in net22_ids})
print("out roots", {uf.find(i) for i in out_ids})
same = (
    uf.find(net22_ids[0]) == uf.find(out_ids[0]) if net22_ids and out_ids else None
)
print("same group?", same)
print("merged labs for net22 group:", groups[uf.find(net22_ids[0])])
print("merged labs for out group:", groups[uf.find(out_ids[0])])
for i in net22_ids:
    for j in out_ids:
        if segs_touch(wires[i], wires[j]):
            print(" TOUCHING pair:", wires[i], "<->", wires[j])

print("\n=== All FET pin connectivity ===")
for c in comps:
    if "sg13_lv_pmos" in c["sym"] or "sg13_lv_nmos" in c["sym"]:
        typ = "pmos" if "pmos" in c["sym"] else "nmos"
        pins = PMOS if typ == "pmos" else NMOS
        parts = []
        for pname, (px, py) in pins.items():
            ax, ay = transform(px, py, c["x"], c["y"], c["rot"], c["flip"])
            resolved = resolved_at(ax, ay)
            lab = "/".join(sorted(resolved)) if resolved else "FLOAT"
            parts.append(f"{pname}@({ax:g},{ay:g})={lab}")
        print(f"{c['name']}: " + "; ".join(parts))

print("\n=== Filter passives ===")
for c in comps:
    if "rppd" in c["sym"] or "cap_cmim" in c["sym"]:
        pins = RPPD if "rppd" in c["sym"] else CAP
        parts = []
        for pname, (px, py) in pins.items():
            ax, ay = transform(px, py, c["x"], c["y"], c["rot"], c["flip"])
            resolved = resolved_at(ax, ay)
            parts.append(f"{pname}@({ax:g},{ay:g})={resolved or 'FLOAT'}")
        print(c["name"], "; ".join(parts))
        if "rppd" in c["sym"]:
            wm = re.search(r"w=([^\n]+)", c["attrs"])
            lm = re.search(r"l=([^\n]+)", c["attrs"])
            print("  w=", wm.group(1) if wm else "?", "l=", lm.group(1) if lm else "?")
            w = 0.5e-6
            l = 0.5e-6
            b = 0
            R = 70.0e-6 / w + 260.0 * ((b + 1) * l) / (w + 6.0e-9)
            print(f"  approx R (b=0, simplified): {R:.3g} ohm")

print("\n=== Pins ===")
for c in comps:
    if any(x in c["sym"] for x in ("ipin", "opin", "iopin")):
        lab = re.search(r"lab=(\S+)", c["attrs"])
        print(
            f"  {c['name']} {c['sym']} @({c['x']},{c['y']}) lab={lab.group(1) if lab else '?'}"
        )

print("\n=== Stdcell supplies ===")
for c in comps:
    if c["sym"].startswith("sg13g2_") and "/sg13g2_pr/" not in c["sym"] and "sg13g2_pr/" not in c["sym"]:
        print(
            f"  {c['name']}: {c['attrs'].strip()} @({c['x']},{c['y']}) rot={c['rot']}"
        )

pin_pts = []
for c in comps:
    if "pmos" in c["sym"]:
        pins = PMOS
    elif "nmos" in c["sym"]:
        pins = NMOS
    elif "rppd" in c["sym"]:
        pins = RPPD
    elif "cap_cmim" in c["sym"]:
        pins = CAP
    else:
        continue
    for pname, (px, py) in pins.items():
        ax, ay = transform(px, py, c["x"], c["y"], c["rot"], c["flip"])
        pin_pts.append((ax, ay, c["name"], pname))

print("\n=== Stub net analysis ===")
for stub in [
    "#net9",
    "#net13",
    "#net16",
    "#net8",
    "#net12",
    "#net15",
    "#net7",
    "#net21",
    "#net17",
    "#net19",
    "#net20",
    "#net18",
    "#net4",
    "#net6",
    "#net5",
    "#net3",
    "#net2",
    "#net1",
    "#net22",
    "#net10",
    "#net11",
    "#net14",
]:
    idxs = [i for i, w in enumerate(wires) if w[4] == stub]
    segs = [wires[i] for i in idxs]
    if not segs:
        continue
    print(f"\n{stub} segments: {segs}")
    print(f"  group labels: {groups[uf.find(idxs[0])]}")
    for w in segs:
        for pt in [(w[0], w[1]), (w[2], w[3])]:
            hits = [
                f"{nm}.{pn}"
                for ax, ay, nm, pn in pin_pts
                if abs(pt[0] - ax) <= 0.51 and abs(pt[1] - ay) <= 0.51
            ]
            other = []
            for j, ww in enumerate(wires):
                if ww == w:
                    continue
                if point_on_seg(pt[0], pt[1], ww[0], ww[1], ww[2], ww[3], tol=0.51):
                    other.append(ww[4])
            print(f"  endpoint {pt}: pins={hits or 'none'} other_wires={other or 'none'}")

print("\n=== Floating FET pins summary ===")
for c in comps:
    if "sg13_lv_pmos" in c["sym"] or "sg13_lv_nmos" in c["sym"]:
        typ = "pmos" if "pmos" in c["sym"] else "nmos"
        pins = PMOS if typ == "pmos" else NMOS
        for pname, (px, py) in pins.items():
            ax, ay = transform(px, py, c["x"], c["y"], c["rot"], c["flip"])
            resolved = resolved_at(ax, ay)
            if not resolved:
                print(f" FLOAT {c['name']}.{pname} @({ax:g},{ay:g})")

print("\n=== Bulk pin detail ===")
for c in comps:
    if "sg13_lv_pmos" in c["sym"] or "sg13_lv_nmos" in c["sym"]:
        pins = PMOS if "pmos" in c["sym"] else NMOS
        ax, ay = transform(*pins["B"], c["x"], c["y"], c["rot"], c["flip"])
        print(f" {c['name']}.B @({ax:g},{ay:g}) -> {resolved_at(ax, ay) or 'FLOAT'}")
