# Extract LVS netlist from pll_analog
drc off
cd /repo/analog/pll/layout
load pll_analog
select top cell

# Clean prior extract artifacts
foreach f [glob -nocomplain *.ext *.spice] {
  # keep only layout extracts in cwd; don't delete leaf mags
}
catch {file delete {*}[glob -nocomplain pll_analog.ext *.ext]}

extract do local
extract all
ext2spice lvs
ext2spice subcircuits on
ext2spice -o /repo/analog/pll/macro/pll_analog_extracted.spice

puts "EXTRACT_DONE"
puts "FB_ERROR=[feedback count error]"
puts "FB_WARNING=[feedback count warning]"
quit -noprompt
