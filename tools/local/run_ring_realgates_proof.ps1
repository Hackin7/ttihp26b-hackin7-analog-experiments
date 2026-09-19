$ErrorActionPreference = "Stop"
$stage = "C:\openprobe"
docker run --rm -v "${stage}:/rt" `
  --entrypoint bash `
  hpretl/iic-osic-tools:latest `
  -lc "cd /rt && echo '=== osc proof markers ===' && grep -Ei 'osc_period|osc_freq|osc_freq|tr_a|tr_b|oscillation|period|freq' ring_oscillator_real_gate_consolidated_tb.spice | head -10"
