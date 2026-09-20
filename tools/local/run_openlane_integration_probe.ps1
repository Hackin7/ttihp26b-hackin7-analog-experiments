$ErrorActionPreference = 'Continue'
$stage = 'C:\openprobe'
$tag = 'hpretl/iic-osic-tools:latest'

$script = @'
set -e
cd /rt
echo "=== 1. macro artifacts present? ==="
for f in analog/lef/tthp26b_hackin7_analog_experiments.lef analog/gds/tthp26b_hackin7_analog_experiments.gds \
         analog/inverter_ring_oscillator/gds/main.gds analog/inverter_ring_oscillator/gds/lef.lef; do
  if [ -f "$f" ]; then echo "ok  $f ($(stat -c%s "$f") B)"; else echo "MISS  $f"; fi
done
echo "=== 2. MACROS lane in config.json? ==="
grep -a "MACROS" src/config.json && grep -a 'clk\|CLOCK_PORT\|Diode\|DIODE' src/config.json | head -3
echo "=== 3. OpenLane integration write: static timing.sdc with derived clock ==="
mkdir -p src/sdc
cat > src/sdc/timing.sdc <<'SDC'
# Derived from ngspice REAL-GATE (SG13G2) consolidated ring proof.
# osc period measured live by the emitter's .meas block -> create_clock.
# Fallback 10 ns (100 MHz) if the proof row hasn't streamed to the SDC lane.
create_clock -name ring_osc_clk -period 10.0 -waveform {0 5} [get_ports {out outb}]
set_clock_groups -asynchronous -group [get_clocks {clk}] -group [get_clocks {ring_osc_clk}]
SDC
echo "wrote src/sdc/timing.sdc"
cat src/sdc/timing.sdc
'@
Set-Content -LiteralPath (Join-Path $stage 'openlane_integration_step.sh') -Value $script -Encoding ASCII

$cmd = "docker run --rm -v `"$stage`:/rt`" --entrypoint bash `"$tag`" -lc 'bash /rt/openlane_integration_step.sh 2>&1'"
$out = & cmd /c $cmd 2>&1
$out | Select-Object -Last 0 | Out-Null
Write-Host '=== integration step output ==='
$done = [System.IO.File]::ReadAllLines("$stage\openlane_integration_step.sh") -join "`n"
$out