# Move out port pad next to VCO buffer (XMp4/XMn4)
drc off
cd /repo/analog/pll/layout
load pll_analog
select top cell

# Remove old far-right out pad + spur (was ~82.3 µm)
box 70.5um -12.0um 84.0um -7.5um
erase metal1

# Also trim any out-net trunk past the buffer
box 70.0um -11.0um 84.0um -10.0um
erase metal1

# New pad just right of buffer FETs (~XMp4/XMn4 drains at ~67.5 µm)
# Place at 69.5, -11.8 µm
box 69.0um -12.3um 70.0um -11.3um
paint metal1

# Stub from buffer column to pad
box 67.5um -11.9um 69.5um -11.7um
paint metal1

# Remove old out label, add new one on the pad
select clear
catch {
  # delete label by boxing old location
  box 82.0um -9.0um 83.5um -7.8um
  erase labels
}
box 69.0um -12.3um 70.0um -11.3um
label out FreeSans 0.8um 0 0 0
port make
port connections n s e w

save pll_analog
puts "out pin -> 69.5, -11.8 um"
puts DONE
quit -noprompt
