#!/usr/bin/env python3
import re, sys
keep = re.compile(r'osc_period|osc_freq|OSC|osc|SG13G2 REAL-GATE|SG13G2|ring|period|freq|period =|freq =', re.I)
drop = re.compile(r'osdi|redefin|osdi, can|osdi,|warning, can|osdi =|osdi lib|redefinition of', re.I)
out = []
for line in sys.stdin:
    if not keep.search(line): continue
    if drop.search(line): continue
    s = line.strip()
    if 'redefin' in s or 'osdi' in s: continue
    out.append(s)
seen = []
for s in out:
    if s not in seen: seen.append(s)
print("=== SG13G2 REAL-GATE RING: measurement echoes (dedup) ===")
for s in seen[-4:]:
    print(s)
