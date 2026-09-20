drc off
load ring_oscillator
extract do local
extract all
ext2spice lvs
ext2spice -o ../macro/ring_oscillator_extracted.spice
gds write ../macro/main_fixed.gds
puts "FB_ERROR=[feedback count error]"
puts "FB_WARNING=[feedback count warning]"
foreach nm [feedback names warning] {
    puts "W: [feedback get $nm]"
}
quit -noprompt
