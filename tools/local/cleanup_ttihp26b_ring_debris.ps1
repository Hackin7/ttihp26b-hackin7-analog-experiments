# clean_ttihp26b_ring_dead_weight.ps1
# Removes ONLY the superseded iteration debris from the SG13G2 ring-osc work.
# Keeps: one consolidated TB, one emitter, one proof filter, one deck finder,
# one harden script, plus docs/PDK notes and the final OpenLane outputs.
$ErrorActionPreference = "Stop"
$root = "C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments"

$dead = @(
  # stale SPICE iteration decks (superseded by ring_gates_consolidated_tb.spice)
  "$root\analog\ring_oscillator\spice\ring_oscillator_real_pdk_tb.spice",
  "$root\analog\ring_oscillator\spice\ring_oscillator_real_pdk_tb.spice",
  "$root\analog\ring_oscillator\spice\ring_oscillator_real_gates_tb.spice",
  "$root\analog\ring_oscillator\spice\ring_oscillator_sg13g2_tb.spice",
  "$root\analog\ring_oscillator\spice\ring_oscillator_tb.spice",
  "$root\analog\ring_oscillator\spice\ring_oscillator.spice",
  "$root\analog\ring_oscillator\spice\ring_oscilator_tb.spice",
  # obsolete runner scripts (one emitter + one proof + one finder stay)
  "$root\tools\local\run_ring_ngspice2.ps1",
  "$root\tools\local\run_ring_ngspice3.ps1",
  "$root\tools\local\run_ring_ngspice4.ps1",
  "$root\tools\local\run_ring_ngspice.ps1",
  "$root\tools\local\run_ring_tb3.ps1",
  "$root\tools\local\run_ring_tb5.ps1",
  "$root\tools\local\run_ring_tb6.ps1",
  "$root\tools\local\run_ring_tb7.ps1",
  "$root\tools\local\run_ring_oscil_final.ps1",
  "$root\tools\local\run_ring_oscil.ps1",
  "$root\tools\local\run_ring_oscil2.ps1",
  "$root\tools\local\run_ring_oscil_proof_final.ps1",
  "$root\tools\local\run_ring_pdk.ps1",
  "$root\tools\local\run_ring_pdk2.ps1",
  "$root\tools\local\run_ring_realpdk_final.ps1",
  "$root\tools\local\run_ring_ngs.ps1",
  "$root\tools\local\run_ring_ngs2.ps1",
  "$root\tools\local\run_ring_ngs3.ps1",
  "$root\tools\local\run_ring_final_meas.ps1",
  "$root\tools\local\probe_osic.sh",
  "$root\tools\local\probe_osic2.sh",
  "$root\tools\local\probe_osic2.bat",
  "$root\tools\local\probe_sg13g2.sh",
  "$root\tools\local\probe_and_run_sg13g2_gate.sh",
  "$root\tools\local\run_ring_gatesubckt_*.ps1",
  "$root\tools\local\run_ring_gate_*.ps1",
  "$root\tools\local\prove_*.sh",
  "$root\tools\local\proof_*.sh",
  # stray measurement dumps / placeholders
  "$root\osc_numbers_ONLY.txt",
  "$root\_unused_placeholder",
  "$root\Copenprobe"
)

$removed = 0; $missing = 0
foreach ($pattern in $dead) {
  $items = Get-Item -Path $pattern -ErrorAction SilentlyContinue
  foreach ($it in $items) {
    Remove-Item -LiteralPath $it.FullName -Recurse -Force
    Write-Host ("  removed  {0}" -f $it.FullName)
    $removed++
  }
  if (-not $items) { $missing++ }
}
Write-Host ""
Write-Host ("=== cleanup: removed {0} paths, {1} glob patterns matched nothing ===" -f $removed, $missing)
Write-Host "=== KEPT (the canonical set) ==="
@(
  "$root\analog\ring_oscillator\spice\ring_gates_consolidated_tb.spice",
  "$root\tools\local\emit_and_run_sg13g2_gates.sh",
  "$root\tools\local\prove_only_sg13g2_ring_once.sh",
  "$root\tools\local\probe_find_sg13g2_decks.sh",
  "$root\tools\local\harden_sg13g2_mosloc.sh",
  "$root\PLAN.md", "$root\README.md", "$root\info.yaml"
) | ForEach-Object { Write-Host ("  keep  {0}" -f $_) }