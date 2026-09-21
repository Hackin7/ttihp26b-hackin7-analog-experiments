# Import PFD stdcells from IHP GDS into pll_analog.
# Instance names match schematic/spice: x1/x2=dfrbpq, x3=and2, x4=inv.
#
# Re-run:
#   docker run --rm --entrypoint /bin/bash \
#     -v "$PWD:/repo" -w /repo/analog/pll/layout hpretl/iic-osic-tools -lc \
#     'magic -dnull -noconsole -rcfile /foss/pdks/ihp-sg13g2/libs.tech/magic/ihp-sg13g2.magicrc import_pfd_stdcells.tcl'
drc off
cd /repo/analog/pll/layout
catch {file delete {*}[glob -nocomplain *.mag.lock]}

set PDK_GDS /foss/pdks/ihp-sg13g2/libs.ref/sg13g2_stdcell/gds/sg13g2_stdcell.gds
set CELLS {sg13g2_dfrbpq_1 sg13g2_and2_1 sg13g2_inv_1}

set need_import 0
foreach c $CELLS {
  if {![file exists ${c}.mag]} { set need_import 1 }
}

if {$need_import} {
  puts "=== Reading stdcell GDS ==="
  gds readonly true
  gds flatten false
  gds read $PDK_GDS
  foreach c $CELLS {
    load $c
    save $c
    puts "Saved $c.mag"
  }
} else {
  puts "=== Using existing leaf Mag cells ==="
}

puts "=== Placing into pll_analog ==="
load pll_analog

foreach inst {x1 x2 x3 x4} {
  catch {
    select cell $inst
    delete
  }
}

# Place at unique box origins (avoids Magic "exact copy of itself" on 2nd dfrbpq)
proc place_inst {cell inst x_um y_um} {
  load pll_analog
  select clear
  # getcell instances at the lower-left of the current box
  box ${x_um}um ${y_um}um [expr {$x_um + 0.1}]um [expr {$y_um + 0.1}]um
  getcell $cell
  identify $inst
  select clear
  puts "  placed $inst ($cell) @ ${x_um},${y_um} um"
}

place_inst sg13g2_dfrbpq_1 x1 -40 0
place_inst sg13g2_dfrbpq_1 x2 -40 5
place_inst sg13g2_and2_1   x3 -25 2.5
place_inst sg13g2_inv_1    x4 -15 2.5

# Save only the top cell — never writeall (dumps entire GDS library)
save pll_analog

puts "=== Verify instances ==="
load pll_analog
foreach inst {x1 x2 x3 x4} {
  if {[catch {select cell $inst} err]} {
    puts "MISSING $inst"
  } else {
    puts "OK $inst"
  }
}

puts DONE
quit -noprompt
