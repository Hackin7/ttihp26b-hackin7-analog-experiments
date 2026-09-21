# Fresh pll_analog: FETs/caps from spice + snaked R1/R2
drc off
cd /repo/analog/pll/layout
catch {file delete {*}[glob -nocomplain *.mag.lock]}

proc bbox_um {name} {
  load $name
  select top cell
  set b [box values]
  set w [expr {([lindex $b 2] - [lindex $b 0]) * 0.005}]
  set h [expr {([lindex $b 3] - [lindex $b 1]) * 0.005}]
  puts [format "BBOX %s  %.2f x %.2f um  area=%.1f um2" $name $w $h [expr {$w*$h}]]
}

# Ensure snake cells exist
if {![file exists rhigh_R2_snake.mag]} {
  set c [magic::gencell_makecell sg13g2::rhigh w 0.5 l 13.0 m 1 nx 20 snake 1]
  load $c
  save rhigh_R2_snake
}
if {![file exists rhigh_R1_snake.mag]} {
  set c [magic::gencell_makecell sg13g2::rhigh w 0.5 l 7.0 m 1 nx 10 snake 1]
  load $c
  save rhigh_R1_snake
}
bbox_um rhigh_R2_snake
bbox_um rhigh_R1_snake

# Wipe old analog and regenerate without tall resistors
catch {cellname delete pll_analog -noprompt}
file delete -force pll_analog.mag

magic::netlist_to_layout /repo/analog/pll/schematic/pll_analog.spice sg13g2

load pll_analog
# Force editable
select top cell

getcell rhigh_R1_snake
identify XR1
move 5um 8um

getcell rhigh_R2_snake
identify XR2
move 5um 28um

writeall force
save pll_analog
bbox_um pll_analog
puts DONE
quit -noprompt
