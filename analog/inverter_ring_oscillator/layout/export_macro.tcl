drc off
load ring_oscillator
gds readonly true
gds rescale false
cif *hier write disable
cif *array write disable
gds write ../macro/main_fixed.gds
puts "GDS_WRITE_DONE"
drc on
select top cell
drc check
drc catchup
puts "DRC_COUNT=[drc count total]"
extract do local
extract all
ext2spice lvs
ext2spice -o ../macro/ring_oscillator_extracted.spice
puts "EXTRACT_DONE"
puts "FB_ERROR=[feedback count error]"
puts "FB_WARNING=[feedback count warning]"
quit -noprompt
