$ErrorActionPreference = 'Continue'
$stage = 'C:\openprobe'
$tag = 'hpretl/iic-osic-tools:latest'

$script = @'
set -e
cd /rt
# Fix: ngspice batch REQUIRES a .plot/.print/.fourier BEFORE .end, or it logs "no simulations run".
# The consolidated emitter emits its own TB; append a real .plot line right before .end (idempotent):
decks=$(ls ring_gates_consolidated_tb.spice ring_gates_consolidated_tb.spice.txt 2>/dev/null || true)
for d in $decks; do
  if ! grep -qa '^\.plot tran' "$d"; then
    awk '{print} /^\.end/{ if(added!=1){ print ".plot tran v(out) v(outb) v(net1) v(net2)"; added=1 } }' "$d" > "$d.tmp" && mv "$d.tmp" "$d"
  fi
done
bash emit_and_run_sg13g2_consolidated_gates.sh > /rt/emitter.run3.log 2>&1 || true
echo '=== EMITTER-RUN3 DONE ==='
'@
Set-Content -LiteralPath "$stage\fix_and_emit3.sh" -Value $script -Encoding ASCII -NoNewline

$awkProg = @'
/osc|period|freq|PROOF|REAL-GATE|SG13G2/ {
  if ($0 !~ /osdi|redefin|osdi, |redefin, |osdi$|PATH|PYTHONPATH|SPICEOPT|ngspice$/) print NR ": " $0
}
'@
Set-Content -LiteralPath "$stage\osc_meas_filter.awk" -Value $awkProg -Encoding ASCII -NoNewline

$cmd = "docker run --rm -v `"$stage`:/rt`" --entrypoint bash `"$tag`" -lc 'bash /rt/fix_and_emit3.sh'"
$out = & cmd /c $cmd 2>&1
$out | Select-Object -Last 0 | Out-Null

$log = "$stage\emitter.run3.log"
$raw = "$stage\ring_gates_consolidated_tb.spice"
Write-Host '=== raw emitter run3 tail (ngspice meas echoes surface here) ==='
if (Test-Path -LiteralPath $log) {
  $all = [System.IO.File]::ReadAllLines($log)
  $hits = @()
  foreach ($l in $all) {
    if ($l -match 'osc|period|freq|PROOF|REAL-GATE' -and $l -notmatch 'osdi|redefin|osdi, |redefin, |PATH|PYTHONPATH|SPICEOPT') {
      $hits += $l.Trim()
    }
  }
  if ($hits.Count -ge 2) { $hits | Select-Object -Last 3 } else { Write-Host '(no meas echoes found in run3 log)' }
} else {
  Write-Host '(emitter.run3.log not present)'
}
