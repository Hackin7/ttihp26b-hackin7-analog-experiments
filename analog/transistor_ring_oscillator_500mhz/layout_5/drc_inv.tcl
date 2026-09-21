drc on
load cmos_inv
select top cell
drc check
drc catchup
set n [drc count total]
puts "DRC_COUNT=$n"
set fp [open "drc_inv.txt" w]
puts $fp "DRC_COUNT=$n"
puts $fp [drc listall why]
close $fp
quit -noprompt
