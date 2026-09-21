drc off
cd /repo/analog/pll/layout
file copy -force pll_analog_routed_backup.mag pll_analog.mag
load pll_analog
select top cell
box -15um -60um 115um 55um
foreach L {metal1 metal2 metal3 metal4 metal5 via1 via2 via3 via4 error_s} { catch {erase $L} }
catch {erase labels}
foreach {name x y} {
  clk_ref_gate -1.5 7.0
  vco_out_div -1.5 2.0
  VPWR 20.5 12.5
  VGND 20.5 -19.0
  out 66.97 -11.92
} {
  box [expr {$x-0.25}]um [expr {$y-0.25}]um [expr {$x+0.25}]um [expr {$y+0.25}]um
  paint metal1
  label $name FreeSans 0.7um 0 0 0
  port make
  port connections n s e w
}
save pll_analog_bare
extract do local
extract all
ext2spice lvs
ext2spice
puts EXTRACT_DONE
quit -noprompt
