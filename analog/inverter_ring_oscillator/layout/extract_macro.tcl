drc off
load main
extract do local
extract all
ext2spice lvs
ext2spice -o ../macro/ring_oscillator_extracted.spice
gds write ../macro/main_fixed.gds
quit -noprompt
