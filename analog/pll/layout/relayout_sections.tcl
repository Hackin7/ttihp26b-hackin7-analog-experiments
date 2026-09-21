# Relayout pll_analog into compact schematic-ordered sections:
#   PFD | CP | bias | loop filter | VCO
#
# docker run --rm --entrypoint /bin/bash \
#   -v "$PWD:/repo" -w /repo/analog/pll/layout hpretl/iic-osic-tools -lc \
#   'magic -dnull -noconsole -rcfile /foss/pdks/ihp-sg13g2/libs.tech/magic/ihp-sg13g2.magicrc relayout_sections.tcl'
drc off
cd /repo/analog/pll/layout
catch {file delete {*}[glob -nocomplain *.mag.lock]}

load pll_analog

# --- remove existing instances (keep / recreate labels below) ---
foreach inst {
  x1 x2 x3 x4
  XM1 XM2 XM3 XM4 XM5 XM6 XM7
  XMn1 XMn2 XMn3 XMn4 XMn5 XMn6 XMn7 XMn8
  XMp1 XMp2 XMp3 XMp4 XMp5 XMp6 XMp7 XMp8
  XC1 XC2 XR1 XR2
} {
  catch {
    select cell $inst
    delete
  }
}

# wipe old floating port pads; recreate at section anchors
select top cell
catch {erase labels}
# clear leftover metal1 stubs / old checkpaint
box -5um -25um 90um 30um
catch {erase labels}
catch {erase metal1}
drc off

# Place cell origin (local 0,0) at (x_um, y_um)
proc place {cell inst x_um y_um} {
  load pll_analog
  select clear
  box ${x_um}um ${y_um}um [expr {$x_um + 0.05}]um [expr {$y_um + 0.05}]um
  getcell $cell
  identify $inst
  select clear
  puts [format "  %-6s %-22s @ %6.2f, %6.2f" $inst $cell $x_um $y_um]
}

puts "=== PFD (stdcells, left) ==="
# Two DFF rows; AND between; INV on up-path toward CP
place sg13g2_dfrbpq_1 x1  0.0  4.8
place sg13g2_dfrbpq_1 x2  0.0  0.0
place sg13g2_and2_1   x3 13.8  2.4
place sg13g2_inv_1    x4 17.2  4.8

puts "=== CP switches ==="
# Schematic top→bottom: M1, M3, M2, M4 (centers = FET origin)
place sg13_lv_pmos_ESLPQL XM1 22.0  9.0
place sg13_lv_pmos_XN8759 XM3 22.0  6.8
place sg13_lv_nmos_VQD2M8 XM2 22.0  4.8
place sg13_lv_nmos_WRM2S2 XM4 22.0  2.8

puts "=== Bias (R2 + mirrors, under PFD/CP) ==="
# R2 origin is cell center; M6/M5/M7 along its top edge
place rhigh_R2_snake      XR2 10.6 -10.0
place sg13_lv_nmos_WRM2S2 XM6 24.0  -3.0
place sg13_lv_nmos_WRM2S2 XM5 27.0  -3.0
place sg13_lv_pmos_ESLPQL XM7 30.5  -3.0

puts "=== Loop filter (R1, C1, C2) ==="
# C1/C2 origins are centers. R1_snake origin is offset from geom center
# local_center ≈ (-10.58, -7.835)
place cap_cmim_4SFK5Q XC1 36.0  0.0
place cap_cmim_ZNKAVF XC2 51.0 -1.0
# R1 stacked above C1 (0.5 µm gap)
place rhigh_R1_snake  XR1 [expr {36.0 + 10.58}] [expr {16.0 + 7.835}]

puts "=== VCO (starved ring columns, schematic L→R) ==="
# cols: bias | stage3 | stage1 | stage2 | buffer
set x0 60.0
set dx 2.3
set yp 7.2
set yi 4.6
set yn 2.2
set ys 0.0

# bias diode
place sg13_lv_pmos_NJKCVT XMp8 $x0 $yp
place sg13_lv_nmos_RUYN9Y XMn8 $x0 $yn

# stage 3 (sch x=1120)
set x [expr {$x0 + $dx}]
place sg13_lv_pmos_NJKCVT XMp7 $x $yp
place sg13_lv_pmos_NJKCVT XMp3 $x $yi
place sg13_lv_nmos_RUYN9Y XMn3 $x $yn
place sg13_lv_nmos_RUYN9Y XMn7 $x $ys

# stage 1 (sch x=1260)
set x [expr {$x0 + 2*$dx}]
place sg13_lv_pmos_NJKCVT XMp6 $x $yp
place sg13_lv_pmos_NJKCVT XMp1 $x $yi
place sg13_lv_nmos_RUYN9Y XMn1 $x $yn
place sg13_lv_nmos_RUYN9Y XMn5 $x $ys

# stage 2 (sch x=1410)
set x [expr {$x0 + 3*$dx}]
place sg13_lv_pmos_NJKCVT XMp5 $x $yp
place sg13_lv_pmos_NJKCVT XMp2 $x $yi
place sg13_lv_nmos_RUYN9Y XMn2 $x $yn
place sg13_lv_nmos_RUYN9Y XMn6 $x $ys

# buffer (sch x=1620)
set x [expr {$x0 + 4*$dx}]
place sg13_lv_pmos_NJKCVT XMp4 $x $yi
place sg13_lv_nmos_RUYN9Y XMn4 $x $yn

puts "=== Section + pin labels ==="
load pll_analog

# section markers (non-port)
proc seclab {text x y} {
  box ${x}um ${y}um [expr {$x+0.2}]um [expr {$y+0.2}]um
  paint metal1
  label $text FreeSans 0.8um 0 0 0
}

seclab PFD     0   10.5
seclab CP     20   11.5
seclab BIAS    8   -18.5
seclab FILTER 30   22.0
seclab VCO    60   10.0

# top-level pins near relevant sections
proc pinlab {name x y portnum} {
  box ${x}um ${y}um [expr {$x+1}]um [expr {$y+1}]um
  paint metal1
  label $name FreeSans 1.0um 0 0 0
  port make $portnum
  port connections n s e w
}

pinlab clk_ref_gate  -2  6.5  0
pinlab vco_out_div   -2  1.5  1
pinlab VPWR          20  12.5 2
pinlab VGND          20 -19.5 3
pinlab vctrl         36  22.5 4
pinlab out           70   6.0 5

save pll_analog

select top cell
set b [box values]
set w [expr {([lindex $b 2]-[lindex $b 0])*0.005}]
set h [expr {([lindex $b 3]-[lindex $b 1])*0.005}]
puts [format "BBOX pll_analog  %.1f x %.1f um  area=%.0f um2" $w $h [expr {$w*$h}]]
puts DONE
quit -noprompt
