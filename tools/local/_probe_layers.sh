#!/bin/bash
set -e
echo "== find via_VHGR6D cell source =="
find / -name 'via_VHGR6D*' 2>/dev/null | head
echo "== grep analog magical layout for via_VHGR6D =="
grep -rn 'via_VHGR6D' /foss/pdks/ihp-sg13g2 2>/dev/null | head -5