#!/usr/bin/env python3
"""Read full-chip wrdata and report uo_out samples after reset."""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

MIDRAIL = 0.6
SIM_DIR = Path(__file__).resolve().parent
OUT_DIR = SIM_DIR / "out"
LOG_PATH = OUT_DIR / "ngspice.log"
DAT_PATH = OUT_DIR / "chip.dat"
REPORT_PATH = OUT_DIR / "counts.txt"


def extract_op() -> int:
    if not LOG_PATH.exists():
        print(f"missing {LOG_PATH}", file=sys.stderr)
        return 1
    text = LOG_PATH.read_text(encoding="ascii", errors="replace")
    if "Error" in text and "OP_RESULT" not in text:
        print("ngspice reported Error before OP_RESULT", file=sys.stderr)
        return 1
    if "OP_RESULT" not in text and "No. of Data Rows : 1" not in text:
        print("operating point did not complete", file=sys.stderr)
        return 1
    values: dict[str, float] = {}
    for line in text.splitlines():
        line = line.strip().lower()
        if line.startswith("v(") and "=" in line:
            name, _, rest = line.partition("=")
            name = name.strip()
            try:
                values[name] = float(rest.split()[0])
            except ValueError:
                continue
    lines = ["mode=op", f"log={LOG_PATH}"]
    for key in ("v(vpwr)", "v(rst_n)", "v(clk)", "v(uo_out_0)", "v(uo_out_1)", "v(uo_out_7)"):
        if key in values:
            lines.append(f"{key}={values[key]:.6g}")
    vpwr = values.get("v(vpwr)", 0.0)
    u0 = values.get("v(uo_out_0)", 1.0)
    ok = vpwr > 1.1 and abs(u0) < 0.2
    lines.append("op=" + ("ok" if ok else "FAIL"))
    REPORT_PATH.write_text("\n".join(lines) + "\n", encoding="ascii")
    print("\n".join(lines))
    print(f"wrote {REPORT_PATH}")
    return 0 if ok else 1


def load_wrdata(path: Path, names: list[str] | None = None) -> dict[str, list[float]]:
    """Parse ngspice wrdata: interleaved time/value columns per vector."""
    rows: list[list[float]] = []
    with path.open(encoding="ascii") as handle:
        for line in handle:
            line = line.strip()
            if not line or line.startswith("*"):
                continue
            rows.append([float(x) for x in line.split()])
    if not rows or len(rows[0]) < 2:
        raise SystemExit(f"unexpected wrdata in {path}")
    if names is None:
        names = [
            "clk",
            "rst_n",
            "ui_in_0",
            "ui_in_1",
            "uo_out_0",
            "uo_out_1",
            "uo_out_2",
            "uo_out_3",
            "uo_out_4",
            "uo_out_5",
            "uo_out_6",
            "uo_out_7",
            "ring_n1",
            "ring_out",
        ]
    t = [row[0] for row in rows]
    data = {"t": t}
    for i, name in enumerate(names):
        col = 2 * i + 1
        if col >= len(rows[0]):
            break
        data[name] = [row[col] for row in rows]
    return data


def crossings(t: list[float], v: list[float], thresh: float, rising: bool) -> list[float]:
    edges: list[float] = []
    for i in range(len(v) - 1):
        a, b = v[i], v[i + 1]
        hit = (a < thresh <= b) if rising else (a > thresh >= b)
        if not hit or b == a:
            continue
        frac = (thresh - a) / (b - a)
        edges.append(t[i] + frac * (t[i + 1] - t[i]))
    return edges


def sample_at(t: list[float], v: list[float], ts: float) -> float:
    for i in range(len(t) - 1):
        if t[i] <= ts <= t[i + 1]:
            if t[i + 1] == t[i]:
                return v[i]
            frac = (ts - t[i]) / (t[i + 1] - t[i])
            return v[i] + frac * (v[i + 1] - v[i])
    return v[-1]


def byte_at(data: dict[str, list[float]], ts: float) -> int:
    value = 0
    for bit in range(8):
        if sample_at(data["t"], data[f"uo_out_{bit}"], ts) >= MIDRAIL:
            value |= 1 << bit
    return value


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--mode", choices=("extclk", "ring", "ringpath", "op"), default="extclk")
    args = parser.parse_args()

    if args.mode == "op":
        return extract_op()

    if not DAT_PATH.exists():
        print(f"missing {DAT_PATH}; run run_sim.sh first", file=sys.stderr)
        return 1

    if args.mode == "ringpath":
        data = load_wrdata(
            DAT_PATH,
            ["rst_n", "ui_in_1", "clk_ring", "clk_sel", "counter_clk", "ring_n1", "sel"],
        )
        t = data["t"]
        lines = [f"mode={args.mode}", f"samples={len(t)}", f"t_end_s={t[-1]:.6e}"]
        lines.append(f"rst_n={data['rst_n'][-1]:.3f} (reset disabled if ~1.2)")
        lines.append(f"ui_in_1={data['ui_in_1'][-1]:.3f} (ring select if ~1.2)")
        if "sel" in data:
            lines.append(f"sel={data['sel'][-1]:.3f} (mux S after input buf)")

        def swing(name: str) -> str:
            v = data[name]
            return f"{name}_v={min(v):.3f}..{max(v):.3f} end={v[-1]:.3f}"

        lines.append(swing("clk_ring"))
        lines.append(swing("clk_sel"))
        lines.append(swing("counter_clk"))
        t_skip = 10e-9
        edges = [e for e in crossings(t, data["clk_ring"], MIDRAIL, rising=True) if e >= t_skip]
        n = max(len(edges) - 1, 0)
        lines.append(f"ring_rising_edges={len(edges)}")
        if n >= 2:
            periods = [edges[i + 1] - edges[i] for i in range(n)]
            period = sum(periods) / n
            lines.append(f"ring_period_s={period:.6e}")
            lines.append(f"ring_freq_hz={1.0 / period:.6e}")
            lines.append(f"ring_freq_mhz={1.0 / period / 1e6:.1f}")
        mux_rise = [e for e in crossings(t, data["clk_sel"], MIDRAIL, rising=True) if e >= t_skip]
        mux_fall = [e for e in crossings(t, data["clk_sel"], MIDRAIL, rising=False) if e >= t_skip]
        tree_rise = [e for e in crossings(t, data["counter_clk"], MIDRAIL, rising=True) if e >= t_skip]
        lines.append(f"mux_rising_edges={len(mux_rise)}")
        lines.append(f"mux_falling_edges={len(mux_fall)}")
        lines.append(f"counter_clk_rising_edges={len(tree_rise)}")
        print("\n".join(lines))
        REPORT_PATH.write_text("\n".join(lines) + "\n", encoding="ascii")
        print(f"wrote {REPORT_PATH}")
        return 0 if n >= 2 else 1

    data = load_wrdata(DAT_PATH)
    t = data["t"]
    lines = [f"mode={args.mode}", f"samples={len(t)}", f"t_end_s={t[-1]:.6e}"]

    if args.mode == "ring":
        if "ring_out" not in data:
            print("wrdata has no ring_out column", file=sys.stderr)
            return 1
        edges = [e for e in crossings(t, data["ring_out"], MIDRAIL, rising=True) if e >= 0.4e-9]
        n = max(len(edges) - 1, 0)
        lines.append(f"rst_n_end={data['rst_n'][-1]:.3f}")
        lines.append(f"ui_in_1_end={data['ui_in_1'][-1]:.3f}")
        if "uo_out_0" in data:
            lines.append(f"uo_out_0_end={data['uo_out_0'][-1]:.3f}")
        lines.append(f"ring_rising_edges={len(edges)}")
        if n >= 2:
            periods = [edges[i + 1] - edges[i] for i in range(n)]
            period = sum(periods) / n
            lines.append(f"ring_period_s={period:.6e}")
            lines.append(f"ring_freq_hz={1.0 / period:.6e}")
        print("\n".join(lines))
        REPORT_PATH.write_text("\n".join(lines) + "\n", encoding="ascii")
        print(f"wrote {REPORT_PATH}")
        return 0 if n >= 2 else 1

    clk_rise = crossings(t, data["clk"], MIDRAIL, rising=True)
    samples: list[tuple[float, int]] = []
    for edge in clk_rise:
        ts = edge + 10e-9
        if ts > t[-1]:
            break
        if sample_at(t, data["rst_n"], ts) < MIDRAIL:
            continue
        if sample_at(t, data["ui_in_0"], ts) < MIDRAIL:
            continue
        samples.append((ts, byte_at(data, ts)))

    lines.append(f"uo_out_samples={len(samples)}")
    for ts, val in samples:
        lines.append(f"t={ts:.6e} uo_out={val}")

    ok = len(samples) >= 1
    if len(samples) >= 3:
        values = [val for _, val in samples]
        expected = list(range(values[0], values[0] + len(values)))
        ok = values == expected
        lines.append("count_sequence=" + ("ok" if ok else "FAIL"))
    elif ok:
        lines.append("count_sequence=short_run")
    else:
        lines.append("count_sequence=FAIL")

    text = "\n".join(lines) + "\n"
    REPORT_PATH.write_text(text, encoding="ascii")
    print(text, end="")
    print(f"wrote {REPORT_PATH}")
    return 0 if ok else 1


if __name__ == "__main__":
    raise SystemExit(main())
