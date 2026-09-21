from collections import Counter
import re

text = open("drc_why.txt", encoding="utf-8", errors="replace").read()
lines = [l.strip() for l in text.splitlines() if l.strip()]
print("lines", len(lines))
kinds = Counter()
for l in lines:
    m = re.search(
        r"([A-Za-z0-9_.]+)\s+(spacing|width|enclosure|area|overlap|surround)",
        l,
        re.I,
    )
    if m:
        kinds[f"{m.group(1)} {m.group(2).lower()}"] += 1
        continue
    kinds[l[:80]] += 1
print("top kinds:")
for k, v in kinds.most_common(30):
    print(f"{v:5d}  {k}")
