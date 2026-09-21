# Snapshot current placement as bare (strip route metals, keep instances + ports)
drc off
cd /repo/analog/pll/layout
catch {file delete {*}[glob -nocomplain *.mag.lock]}
load pll_analog
select top cell
box -20um -60um 150um 60um
foreach L {metal1 metal2 metal3 metal4 metal5 via1 via2 via3 via4 error_s} { catch {erase $L} }
catch {erase labels}
foreach {name x y isport} {
  clk_ref_gate -1.5 7.0 1
  vco_out_div -1.5 2.0 1
  VPWR 20.5 12.5 1
  VGND 20.5 -19.0 1
  out 74.5 -10.7 1
  vctrl 36.5 23.0 0
} {
  box [expr {$x-0.25}]um [expr {$y-0.25}]um [expr {$x+0.25}]um [expr {$y+0.25}]um
  paint metal1
  label $name FreeSans 0.7um 0 0 0
  if {$isport} {
    port make
    port connections n s e w
  }
}
save pll_analog_bare
save pll_analog
puts BARE_OK
quit -noprompt
