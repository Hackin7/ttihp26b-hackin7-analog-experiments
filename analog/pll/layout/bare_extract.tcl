# Bare extract: no routing, only port pads
drc off
cd /repo/analog/pll/layout
load pll_analog_routed_backup
cellname rename pll_analog_routed_backup pll_analog_bare
box -10um -50um 105um 45um
foreach L {metal1 metal2 metal3 metal4 metal5 via1 via2 via3 via4 error_s} {
  catch {erase $L}
}
catch {erase labels}

proc pad {name x y} {
  box [expr {$x-0.3}]um [expr {$y-0.3}]um [expr {$x+0.3}]um [expr {$y+0.3}]um
  paint metal1
  label $name FreeSans 0.6um 0 0 0
  port make
  port connections n s e w
}
pad clk_ref_gate -1.5 7.0
pad vco_out_div  -1.5 2.0
pad VPWR         20.5 12.5
pad VGND         20.5 -19.0
pad out          66.97 -11.92

save pll_analog_bare
extract do local
extract all
ext2spice lvs
ext2spice subcircuits on
ext2spice -o /repo/analog/pll/macro/pll_bare_extracted.spice
puts BARE_DONE
quit -noprompt
