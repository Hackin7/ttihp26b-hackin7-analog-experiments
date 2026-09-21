drc off
load ring_oscillator
extract do local
extract all
ext2spice cthresh 0.1
ext2spice rthresh infinite
ext2spice -o ../macro/ring_oscillator_pex.spice
puts "PEX_DONE"
set pex ../macro/ring_oscillator_pex.spice
set fp [open $pex r]
set data [read $fp]
close $fp
if {![regexp {\.subckt} $data]} {
  set out ""
  set inserted 0
  foreach line [split $data "\n"] {
    if {!$inserted && ![string match "#*" $line] && ![string match "\\**" $line] && [string trim $line] ne ""} {
      append out ".subckt ring_oscillator out VPWR VGND\n"
      set inserted 1
    }
    append out $line
    append out "\n"
  }
  append out ".ends\n"
  set fp [open $pex w]
  puts -nonewline $fp $out
  close $fp
  puts "PEX_WRAPPED_SUBCKT"
}
quit -noprompt
