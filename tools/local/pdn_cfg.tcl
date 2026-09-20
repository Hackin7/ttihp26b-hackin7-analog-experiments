# Copyright 2025 LibreLane Contributors
#
# Adapted from OpenLane
#
# Copyright 2020-2022 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Project override: copy of LibreLane 3.0.5 default pdn_cfg.tcl with an
# explicit macro-grid rail added. Without a -followpins stripe the default
# layerless -macro -default grid generates no shapes on IHP SG13G2
# (TopMetal1 macro power pins), which trips PDN-0232/PDN-0233.

source $::env(SCRIPTS_DIR)/openroad/common/io.tcl
source $::env(SCRIPTS_DIR)/openroad/common/set_global_connections.tcl
set_global_connections

set secondary []
foreach vdd $::env(VDD_NETS) gnd $::env(GND_NETS) {
    if { $vdd != $::env(VDD_NET)} {
        lappend secondary $vdd

        set db_net [[ord::get_db_block] findNet $vdd]
        if {$db_net == "NULL"} {
            set net [odb::dbNet_create [ord::get_db_block] $vdd]
            $net setSpecial
            $net setSigType "POWER"
        }
    }

    if { $gnd != $::env(GND_NET)} {
        lappend secondary $gnd

        set db_net [[ord::get_db_block] findNet $gnd]
        if {$db_net == "NULL"} {
            set net [odb::dbNet_create [ord::get_db_block] $gnd]
            $net setSpecial
            $net setSigType "GROUND"
        }
    }
}

set_voltage_domain -name CORE -power $::env(VDD_NET) -ground $::env(GND_NET) \
    -secondary_power $secondary



if { $::env(PDN_MULTILAYER) == 1 } {

    set arg_list [list]
    if { $::env(PDN_ENABLE_PINS) } {
        lappend arg_list -pins "$::env(PDN_VERTICAL_LAYER) $::env(PDN_HORIZONTAL_LAYER)"
    }

    define_pdn_grid \
        -name stdcell_grid \
        -starts_with POWER \
        -voltage_domain CORE \
        {*}$arg_list

    set arg_list [list]
    append_if_equals arg_list PDN_EXTEND_TO "core_ring" -extend_to_core_ring
    append_if_equals arg_list PDN_EXTEND_TO "boundary" -extend_to_boundary

    add_pdn_stripe \
        -grid stdcell_grid \
        -layer $::env(PDN_VERTICAL_LAYER) \
        -width $::env(PDN_VWIDTH) \
        -pitch $::env(PDN_VPITCH) \
        -offset $::env(PDN_VOFFSET) \
        -spacing $::env(PDN_VSPACING) \
        -starts_with POWER \
        {*}$arg_list

    add_pdn_stripe \
        -grid stdcell_grid \
        -layer $::env(PDN_HORIZONTAL_LAYER) \
        -width $::env(PDN_HWIDTH) \
        -pitch $::env(PDN_HPITCH) \
        -offset $::env(PDN_HOFFSET) \
        -spacing $::env(PDN_HSPACING) \
        -starts_with POWER \
        {*}$arg_list

    add_pdn_connect \
        -grid stdcell_grid \
        -layers "$::env(PDN_VERTICAL_LAYER) $::env(PDN_HORIZONTAL_LAYER)"
} else {

    set arg_list [list]
    if { $::env(PDN_ENABLE_PINS) } {
        lappend arg_list -pins "$::env(PDN_VERTICAL_LAYER)"
    }

    define_pdn_grid \
        -name stdcell_grid \
        -starts_with POWER \
        -voltage_domain CORE \
        {*}$arg_list

    set arg_list [list]
    append_if_equals arg_list PDN_EXTEND_TO "core_ring" -extend_to_core_ring
    append_if_equals arg_list PDN_EXTEND_TO "boundary" -extend_to_boundary

    add_pdn_stripe \
        -grid stdcell_grid \
        -layer $::env(PDN_VERTICAL_LAYER) \
        -width $::env(PDN_VWIDTH) \
        -pitch $::env(PDN_VPITCH) \
        -offset $::env(PDN_VOFFSET) \
        -spacing $::env(PDN_VSPACING) \
        -starts_with POWER \
        {*}$arg_list
}

# Adds the standard cell rails if enabled.
if { $::env(PDN_ENABLE_RAILS) == 1 } {
    add_pdn_stripe \
        -grid stdcell_grid \
        -layer $::env(PDN_RAIL_LAYER) \
        -width $::env(PDN_RAIL_WIDTH) \
        -followpins

    add_pdn_connect \
        -grid stdcell_grid \
        -layers "$::env(PDN_RAIL_LAYER) $::env(PDN_VERTICAL_LAYER)"
}


# Adds the core ring if enabled.
if { $::env(PDN_CORE_RING) == 1 } {
    if { $::env(PDN_MULTILAYER) == 1 } {
        set arg_list [list]
        append_if_flag arg_list PDN_CORE_RING_ALLOW_OUT_OF_DIE -allow_out_of_die
        append_if_flag arg_list PDN_CORE_RING_CONNECT_TO_PADS -connect_to_pads
        append_if_equals arg_list PDN_EXTEND_TO "boundary" -extend_to_boundary

        set pdn_core_vertical_layer $::env(PDN_VERTICAL_LAYER)
        set pdn_core_horizontal_layer $::env(PDN_HORIZONTAL_LAYER)

        if { [info exists ::env(PDN_CORE_VERTICAL_LAYER)] } {
            set pdn_core_vertical_layer $::env(PDN_CORE_VERTICAL_LAYER)
        }

        if { [info exists ::env(PDN_CORE_HORIZONTAL_LAYER)] } {
            set pdn_core_horizontal_layer $::env(PDN_CORE_HORIZONTAL_LAYER)
        }

        add_pdn_ring \
            -grid stdcell_grid \
            -layers "$pdn_core_vertical_layer $pdn_core_horizontal_layer" \
            -widths "$::env(PDN_CORE_RING_VWIDTH) $::env(PDN_CORE_RING_HWIDTH)" \
            -spacings "$::env(PDN_CORE_RING_VSPACING) $::env(PDN_CORE_RING_HSPACING)" \
            -core_offset "$::env(PDN_CORE_RING_VOFFSET) $::env(PDN_CORE_RING_HOFFSET)" \
            {*}$arg_list

        if { [info exists ::env(PDN_CORE_VERTICAL_LAYER)] } {
            add_pdn_connect \
                -grid stdcell_grid \
                -layers "$::env(PDN_CORE_VERTICAL_LAYER) $::env(PDN_HORIZONTAL_LAYER)"
        }

        if { [info exists ::env(PDN_CORE_HORIZONTAL_LAYER)] } {
            add_pdn_connect \
                -grid stdcell_grid \
                -layers "$::env(PDN_CORE_HORIZONTAL_LAYER) $::env(PDN_VERTICAL_LAYER)"
        }

        if { [info exists ::env(PDN_CORE_VERTICAL_LAYER)] && [info exists ::env(PDN_CORE_HORIZONTAL_LAYER)] } {
            add_pdn_connect \
                -grid stdcell_grid \
                -layers "$::env(PDN_CORE_VERTICAL_LAYER) $::env(PDN_CORE_HORIZONTAL_LAYER)"
        }

    } else {
        throw APPLICATION "PDN_CORE_RING cannot be used when PDN_MULTILAYER is set to false."
    }
}

define_pdn_grid \
    -macro \
    -default \
    -name macro \
    -starts_with POWER \
    -halo "$::env(PDN_HORIZONTAL_HALO) $::env(PDN_VERTICAL_HALO)"

# Analog GDS vias Metal1 rails up to TopMetal1 pads. A dummy stripe is
# required on this grid so pdngen does not trip PDN-0232/0233; keep it on
# TopMetal1 (not followpins — followpins here drew illegal TM1 slivers).
add_pdn_stripe \
    -grid macro \
    -layer $::env(PDN_VERTICAL_LAYER) \
    -width $::env(PDN_VWIDTH) \
    -nets {VPWR} \
    -offset 0.97 \
    -pitch $::env(PDN_VPITCH) \
    -number_of_straps 1 \
    -extend_to_boundary

# pdngen always cuts TopMetal1 around CLASS BLOCK macros (~1.6–3.3 µm).
# After pdngen, drop full-height TT-top jumpers that overlap the analog TM1
# pads and the surviving strap remnants so extract sees chip VPWR/VGND.
# Tiny Tapeout pin check requires every VGND/VDPWR LEF PORT rectangle to
# start within 10 µm of the bottom and reach within 10 µm of the top, so
# also replace the cut-strap BPins with one full-height pin on each jumper.
proc analog_add_tm1_sbox {net_name layer x1 y1 x2 y2} {
    set net [[ord::get_db_block] findNet $net_name]
    if {$net == "NULL"} {
        puts "WARNING: analog TM1 jumper skipped; net $net_name not found"
        return
    }
    $net setSpecial
    set swire [odb::dbSWire_create $net "ROUTED"]
    odb::dbSBox_create $swire $layer $x1 $y1 $x2 $y2 "STRIPE"
    puts "  analog TM1 jumper $net_name [$layer getName] ($x1 $y1) ($x2 $y2)"
}

proc analog_tm1_pin_spans_die {box die_y1 die_y2 edge} {
    if {([$box yMin] - $die_y1) > $edge} {
        return 0
    }
    if {($die_y2 - [$box yMax]) > $edge} {
        return 0
    }
    return 1
}

proc analog_add_tm1_bpin {bterm layer x1 y1 x2 y2} {
    set bpin [odb::dbBPin_create $bterm]
    $bpin setPlacementStatus "FIRM"
    odb::dbBox_create $bpin $layer $x1 $y1 $x2 $y2
    puts "  analog TM1 BPin [$bterm getName] [$layer getName] ($x1 $y1) ($x2 $y2)"
}

proc analog_fix_power_pins {} {
    puts "Adding analog TopMetal1 PDN jumpers and full-height power pins..."
    set block [ord::get_db_block]
    set tech [ord::get_db_tech]
    set layer [$tech findLayer TopMetal1]
    if {$layer == "NULL"} {
        puts "WARNING: analog TM1 jumper skipped; TopMetal1 not found"
        return
    }
    set inst [$block findInst u_ring_oscillator]
    if {$inst == "NULL"} {
        puts "WARNING: analog TM1 jumper skipped; u_ring_oscillator not found"
        return
    }

    set dbu [$tech getDbUnitsPerMicron]
    set die [$block getDieArea]
    set die_y1 [$die yMin]
    set die_y2 [$die yMax]
    set edge [expr {10 * $dbu}]
    set ix [[$inst getBBox] xMin]
    set layer_name [$layer getName]

    foreach net_name {VPWR VGND} {
        set bterm [$block findBTerm $net_name]
        if {$bterm == "NULL"} {
            puts "WARNING: analog power pin fix skipped; $net_name bterm not found"
            continue
        }

        set pin_y1 ""
        set pin_y2 ""
        set strap_xs [dict create]
        foreach bpin [$bterm getBPins] {
            foreach box [$bpin getBoxes] {
                set box_layer [$box getTechLayer]
                if {$box_layer == "NULL" || [$box_layer getName] != $layer_name} {
                    continue
                }
                if {[analog_tm1_pin_spans_die $box $die_y1 $die_y2 $edge]} {
                    set pin_y1 [$box yMin]
                    set pin_y2 [$box yMax]
                    dict set strap_xs [$box xMin] [$box xMax]
                }
            }
        }

        if {$pin_y1 == "" || $pin_y2 == ""} {
            set pin_y1 [expr {$die_y1 + round(3.15 * $dbu)}]
            set pin_y2 [expr {$die_y2 - round(3.56 * $dbu)}]
        }

        if {$net_name == "VPWR"} {
            set jx1 [expr {$ix + round(0.97 * $dbu)}]
            set jx2 [expr {$ix + round(3.17 * $dbu)}]
        } else {
            set jx1 [expr {$ix + round(7.17 * $dbu)}]
            set jx2 [expr {$ix + round(9.37 * $dbu)}]
        }
        analog_add_tm1_sbox $net_name $layer $jx1 $pin_y1 $jx2 $pin_y2
        dict set strap_xs $jx1 $jx2

        set to_destroy {}
        foreach bpin [$bterm getBPins] {
            lappend to_destroy $bpin
        }
        foreach bpin $to_destroy {
            odb::dbBPin_destroy $bpin
        }

        foreach x1 [lsort -integer [dict keys $strap_xs]] {
            analog_add_tm1_bpin $bterm $layer $x1 $pin_y1 [dict get $strap_xs $x1] $pin_y2
        }
    }
}

if {[llength [info commands ::pdngen_orig]] == 0 && [llength [info commands ::pdngen]]} {
    rename ::pdngen ::pdngen_orig
    proc ::pdngen {args} {
        ::pdngen_orig {*}$args
        analog_fix_power_pins
    }
}