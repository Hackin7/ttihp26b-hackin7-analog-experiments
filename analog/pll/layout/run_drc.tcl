drc off
cd /repo/analog/pll/layout
load pll_analog
select top cell
drc on
drc check
drc catchup
puts "COUNT=[drc count]"
puts "COUNT_TOTAL=[drc count total]"
# Dump categorized why strings
catch {puts [drc listall why]}
set outfile [open /repo/analog/pll/layout/drc_why.txt w]
set errs [drc listall why]
foreach err $errs {
  puts $outfile $err
}
close $outfile
# Also try feedback
puts "FB=[feedback count]"
puts DRC_DONE
quit -noprompt
