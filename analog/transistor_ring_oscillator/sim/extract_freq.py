#!/usr/bin/env python3
"""Extract ring period/frequency from ngspice wrdata and plot waveforms."""

from __future__ import annotations

import sys
from pathlib import Path

import numpy as np

SIM_DIR = Path(__file__).resolve().parent
OUT_DIR = SIM_DIR / "out"
DAT_PATH = OUT_DIR / "ring.dat"
PNG_PATH = OUT_DIR / "waveform.png"
FREQ_PATH = OUT_DIR / "freq.txt"

STARTUP_S = 0.5e-9
MIDRAIL_V = 0.6
MIN_CYCLES = 5


def load_wrdata(path: Path) -> tuple[np.ndarray, np.ndarray, np.ndarray, np.ndarray]:
    """Parse ngspice wrdata: interleaved time/value columns per vector."""
    raw = np.loadtxt(path)
    if raw.ndim != 2 or raw.shape[1] < 6:
        raise SystemExit(f"unexpected wrdata shape {raw.shape} in {path}")
    t = raw[:, 0]
    v_out = raw[:, 1]
    v_n1 = raw[:, 3]
    v_n2 = raw[:, 5]
    return t, v_out, v_n1, v_n2


def rising_crossings(t: np.ndarray, v: np.ndarray, thresh: float) -> np.ndarray:
    mask = t >= STARTUP_S
    t_s = t[mask]
    v_s = v[mask]
    over = v_s >= thresh
    idx = np.where(~over[:-1] & over[1:])[0]
    if idx.size == 0:
        return np.array([])
    t0 = t_s[idx]
    t1 = t_s[idx + 1]
    v0 = v_s[idx]
    v1 = v_s[idx + 1]
    frac = (thresh - v0) / (v1 - v0)
    return t0 + frac * (t1 - t0)


def main() -> int:
    if not DAT_PATH.exists():
        print(f"missing {DAT_PATH}; run run_sim.sh first", file=sys.stderr)
        return 1

    t, v_out, v_n1, v_n2 = load_wrdata(DAT_PATH)
    edges = rising_crossings(t, v_out, MIDRAIL_V)
    n_cycles = max(len(edges) - 1, 0)
    if n_cycles < MIN_CYCLES:
        print(
            f"only {n_cycles} cycles after {STARTUP_S * 1e9:.1f} ns "
            f"(need {MIN_CYCLES}); lengthen the transient",
            file=sys.stderr,
        )
        return 1

    periods = np.diff(edges)
    period_s = float(np.mean(periods))
    freq_hz = 1.0 / period_s

    OUT_DIR.mkdir(parents=True, exist_ok=True)
    FREQ_PATH.write_text(
        f"period_s={period_s:.6e}\n"
        f"freq_hz={freq_hz:.6e}\n"
        f"n_cycles={n_cycles}\n"
        f"period_std_s={float(np.std(periods)):.6e}\n",
        encoding="utf-8",
    )

    import matplotlib

    matplotlib.use("Agg")
    import matplotlib.pyplot as plt

    fig, ax = plt.subplots(figsize=(10, 4))
    ax.plot(t * 1e9, v_out, label="out")
    ax.plot(t * 1e9, v_n1, label="n1")
    ax.plot(t * 1e9, v_n2, label="n2")
    ax.axhline(MIDRAIL_V, color="gray", linestyle="--", linewidth=0.8)
    ax.set_xlabel("time (ns)")
    ax.set_ylabel("voltage (V)")
    ax.set_title(f"transistor ring  f = {freq_hz / 1e9:.3f} GHz")
    ax.legend(loc="upper right")
    ax.grid(True, alpha=0.3)
    fig.tight_layout()
    fig.savefig(PNG_PATH, dpi=120)
    plt.close(fig)

    print(f"period_s={period_s:.6e}")
    print(f"freq_hz={freq_hz:.6e} ({freq_hz / 1e9:.3f} GHz)")
    print(f"n_cycles={n_cycles}")
    print(f"wrote {FREQ_PATH}")
    print(f"wrote {PNG_PATH}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
