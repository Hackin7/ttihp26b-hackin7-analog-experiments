drc off
load ring_oscillator
gds readonly true
gds rescale false
cif *hier write disable
cif *array write disable
gds write ../macro/main_fixed.gds
file copy -force ../macro/main_fixed.gds ../macro/ring_oscillator.gds
puts "GDS_WRITE_DONE"
lef write ../macro/ring_oscillator.lef
puts "LEF_WRITE_DONE"
extract do local
extract all
ext2spice lvs
ext2spice -o ../macro/ring_oscillator_extracted.spice
puts "EXTRACT_DONE"
puts "FB_ERROR=[feedback count error]"
puts "FB_WARNING=[feedback count warning]"
quit -noprompt
