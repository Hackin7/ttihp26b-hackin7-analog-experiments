drc on
load ring_oscillator
select top cell
drc check
drc catchup
puts "DRC_COUNT=[drc count total]"
drc listall why
quit -noprompt
