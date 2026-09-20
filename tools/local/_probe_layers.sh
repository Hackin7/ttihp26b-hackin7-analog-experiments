#!/bin/bash
set -e
echo "== find tech lefs / via defs in osic-tools =="
grep -rn -l "LAYER Via1 " /foss/pdks 2>/dev/null | head -5
echo "== if none, search python pdk lef =="
grep -rn -l "LAYER Via1 " /usr/local/lib/python3.12/dist-packages 2>/dev/null | head -5