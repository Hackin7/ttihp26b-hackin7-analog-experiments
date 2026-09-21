# Debug: only route `out` + power from bare, then extract
drc off
cd /repo/analog/pll/layout
file copy -force pll_analog_bare.mag pll_analog.mag
load pll_analog
select top cell
box -15um -60um 115um 55um
foreach L {metal1 metal2 metal3 metal4 metal5 via1 via2 via3 via4 error_s} { catch {erase $L} }
catch {erase labels}

# ports
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

proc via1234 {x y} {
  # via1
  box [expr {$x-0.105}]um [expr {$y-0.105}]um [expr {$x+0.105}]um [expr {$y+0.105}]um
  paint metal1
  box [expr {$x-0.08}]um [expr {$y-0.08}]um [expr {$x+0.08}]um [expr {$y+0.08}]um
  paint via1
  box [expr {$x-0.105}]um [expr {$y-0.105}]um [expr {$x+0.105}]um [expr {$y+0.105}]um
  paint metal2
  # via2
  paint metal2
  box [expr {$x-0.08}]um [expr {$y-0.08}]um [expr {$x+0.08}]um [expr {$y+0.08}]um
  paint via2
  box [expr {$x-0.105}]um [expr {$y-0.105}]um [expr {$x+0.105}]um [expr {$y+0.105}]um
  paint metal3
  # via3
  box [expr {$x-0.08}]um [expr {$y-0.08}]um [expr {$x+0.08}]um [expr {$y+0.08}]um
  paint via3
  box [expr {$x-0.105}]um [expr {$y-0.105}]um [expr {$x+0.105}]um [expr {$y+0.105}]um
  paint metal4
  # via4
  box [expr {$x-0.08}]um [expr {$y-0.08}]um [expr {$x+0.08}]um [expr {$y+0.08}]um
  paint via4
  box [expr {$x-0.105}]um [expr {$y-0.105}]um [expr {$x+0.105}]um [expr {$y+0.105}]um
  paint metal5
}

# Power rails
box -5um 12.1um 75um 12.9um
paint metal5
box -5um -19.4um 75um -18.6um
paint metal5

# VPWR taps: XMp4/S 65.670 -10.710, port
foreach {px py} {65.670 -10.710  63.370 -8.110  20.5 12.5} {
  set ox [expr {$px + 1.2}]
  box [expr {$px-0.08}]um [expr {$py-0.08}]um [expr {$px+0.08}]um [expr {$py+0.08}]um
  paint metal1
  # via1 at pin
  box [expr {$px-0.105}]um [expr {$py-0.105}]um [expr {$px+0.105}]um [expr {$py+0.105}]um
  paint metal1
  box [expr {$px-0.08}]um [expr {$py-0.08}]um [expr {$px+0.08}]um [expr {$py+0.08}]um
  paint via1
  box [expr {$px-0.105}]um [expr {$py-0.105}]um [expr {$px+0.105}]um [expr {$py+0.105}]um
  paint metal2
  # M2 jog
  box [expr {min($px,$ox)-0.08}]um [expr {$py-0.08}]um [expr {max($px,$ox)+0.08}]um [expr {$py+0.08}]um
  paint metal2
  via1234 $ox $py
  box [expr {$ox-0.1}]um [expr {min($py,12.5)-0.1}]um [expr {$ox+0.1}]um [expr {max($py,12.5)+0.1}]um
  paint metal5
}

# VGND taps: XMn4/S 65.360 -13.300, port
foreach {px py} {65.360 -13.300  20.5 -19.0} {
  set ox [expr {$px + 1.2}]
  box [expr {$px-0.08}]um [expr {$py-0.08}]um [expr {$px+0.08}]um [expr {$py+0.08}]um
  paint metal1
  box [expr {$px-0.105}]um [expr {$py-0.105}]um [expr {$px+0.105}]um [expr {$py+0.105}]um
  paint metal1
  box [expr {$px-0.08}]um [expr {$py-0.08}]um [expr {$px+0.08}]um [expr {$py+0.08}]um
  paint via1
  box [expr {$px-0.105}]um [expr {$py-0.105}]um [expr {$px+0.105}]um [expr {$py+0.105}]um
  paint metal2
  box [expr {min($px,$ox)-0.08}]um [expr {$py-0.08}]um [expr {max($px,$ox)+0.08}]um [expr {$py+0.08}]um
  paint metal2
  via1234 $ox $py
  box [expr {$ox-0.1}]um [expr {min($py,-19.0)-0.1}]um [expr {$ox+0.1}]um [expr {max($py,-19.0)+0.1}]um
  paint metal5
}

# Cap C2 bottoms to VGND on M5
foreach {x y} {44.620 -5.910  54.450 -11.950} {
  box [expr {$x-0.25}]um [expr {$y-0.25}]um [expr {$x+0.25}]um [expr {$y+0.25}]um
  paint metal5
  box [expr {$x-0.125}]um [expr {min($y,-19.0)-0.125}]um [expr {$x+0.125}]um [expr {max($y,-19.0)+0.125}]um
  paint metal5
}

# Route out only: PORT 66.97 -11.92, XMp4/D 65.04 -10.71, XMn4/D 64.73 -13.30
# cols left of pins, trunk y=-27
set ty -27.0
foreach {px py cx} {
  66.97 -11.92 66.57
  65.04 -10.71 64.64
  64.73 -13.30 64.33
} {
  box [expr {$px-0.08}]um [expr {$py-0.08}]um [expr {$px+0.08}]um [expr {$py+0.08}]um
  paint metal1
  # stack to m4
  box [expr {$px-0.105}]um [expr {$py-0.105}]um [expr {$px+0.105}]um [expr {$py+0.105}]um
  paint metal1
  box [expr {$px-0.08}]um [expr {$py-0.08}]um [expr {$px+0.08}]um [expr {$py+0.08}]um
  paint via1
  box [expr {$px-0.105}]um [expr {$py-0.105}]um [expr {$px+0.105}]um [expr {$py+0.105}]um
  paint metal2
  box [expr {$px-0.08}]um [expr {$py-0.08}]um [expr {$px+0.08}]um [expr {$py+0.08}]um
  paint via2
  box [expr {$px-0.105}]um [expr {$py-0.105}]um [expr {$px+0.105}]um [expr {$py+0.105}]um
  paint metal3
  box [expr {$px-0.08}]um [expr {$py-0.08}]um [expr {$px+0.08}]um [expr {$py+0.08}]um
  paint via3
  box [expr {$px-0.105}]um [expr {$py-0.105}]um [expr {$px+0.105}]um [expr {$py+0.105}]um
  paint metal4
  # M4 jog
  box [expr {min($px,$cx)-0.08}]um [expr {$py-0.08}]um [expr {max($px,$cx)+0.08}]um [expr {$py+0.08}]um
  paint metal4
  # via3 at col
  box [expr {$cx-0.105}]um [expr {$py-0.105}]um [expr {$cx+0.105}]um [expr {$py+0.105}]um
  paint metal3
  box [expr {$cx-0.08}]um [expr {$py-0.08}]um [expr {$cx+0.08}]um [expr {$py+0.08}]um
  paint via3
  box [expr {$cx-0.105}]um [expr {$py-0.105}]um [expr {$cx+0.105}]um [expr {$py+0.105}]um
  paint metal4
  # M3 vertical
  box [expr {$cx-0.08}]um [expr {min($py,$ty)-0.08}]um [expr {$cx+0.08}]um [expr {max($py,$ty)+0.08}]um
  paint metal3
  # via3 at trunk
  box [expr {$cx-0.105}]um [expr {$ty-0.105}]um [expr {$cx+0.105}]um [expr {$ty+0.105}]um
  paint metal3
  box [expr {$cx-0.08}]um [expr {$ty-0.08}]um [expr {$cx+0.08}]um [expr {$ty+0.08}]um
  paint via3
  box [expr {$cx-0.105}]um [expr {$ty-0.105}]um [expr {$cx+0.105}]um [expr {$ty+0.105}]um
  paint metal4
}
# M4 trunk
box 64.25um [expr {$ty-0.08}]um 66.65um [expr {$ty+0.08}]um
paint metal4

save pll_analog
puts DEBUG_ROUTE_DONE
quit -noprompt
