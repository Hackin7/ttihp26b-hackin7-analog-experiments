$ErrorActionPreference = "Stop"
$stage = "C:\openprobe"
docker run --rm -v "${stage}:/rt" `
  --entrypoint bash `
  hpretl/iic-osic-tools:latest `
  -lc "cd /rt && ngspice -b ring_gates_consolidated_tb.spice 2>&1 \
        | sed -n '/====/,/====/p; /osc_period/p; /osc_freq/p; /OSC PROOF/p; /tr_a/p; /tr_b/p' \
        | grep -viE 'osdi|redefinition|warning, re' | head -12"
