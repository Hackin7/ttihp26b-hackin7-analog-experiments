#!/bin/bash
grep -n -iE 'prBoundary|prBndry|BOUNDARY' /foss/pdks/ihp-sg13g2/libs.tech/magic/ihp-sg13g2-cifout.tech | head -40
grep -n -iE 'prBoundary|189' /foss/pdks/ihp-sg13g2/libs.tech/magic/ihp-sg13g2-cifin.tech | head -20
