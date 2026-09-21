drc on
load ring_oscillator
select top cell
drc check
drc catchup
set n [drc count total]
puts "DRC_COUNT=$n"
set fp [open "drc_report.txt" w]
puts $fp "DRC_COUNT=$n"
puts $fp [drc listall why]
close $fp
puts "wrote drc_report.txt"
quit -noprompt
