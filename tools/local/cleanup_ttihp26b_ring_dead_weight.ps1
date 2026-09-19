$ErrorActionPreference = "Stop"
$root = "C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments"
if (-not (Test-Path -LiteralPath $root)) { $root = "C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments" }

$dead = New-Object System.Collections.Generic.List[string]

# 1) stale ring runners (superseded by emit_and_run_sg13g2_gates.sh + proof filters)
Get-ChildItem -LiteralPath (Join-Path $root "tools\local") -File -ErrorAction SilentlyContinue |
  Where-Object { $_.Name -match '^run_ring_' -and $_.Name -notmatch 'consolidat' -and $_.Name -notmatch 'proof' -and $_.Name -notmatch 'emit_and_run' } |
  ForEach-Object { $dead.Add($_.FullName) }

# 2) stale probe / prove iteration scripts
Get-ChildItem -LiteralPath (Join-Path $root "tools\local") -File -ErrorAction SilentlyContinue |
  Where-Object { $_.Name -match '^(probe_|prove_|proof_|show_|emit_and_run|extract_)' -and $_.Name -notmatch '(discover_sg13g2_models|emit_and_run_sg13g2_gates|prove_sg13g2_realgate_ring_once|prove_only_sg13g2)' } |
  ForEach-Object { $dead.Add($_.FullName) }

# 3) stale TB iterations in spice dir (keep ONLY the consolidated one)
Get-ChildItem -LiteralPath (Join-Path $root "analog\ring_oscillator\spice") -File -ErrorAction SilentlyContinue |
  Where-Object { $_.Name -match '\.spice$|\.spi$' -and $_.Name -notmatch 'ring_gates_consolidated_tb' } |
  ForEach-Object { $dead.Add($_.FullName) }

# also the analog/spice dir if it exists with old decks
Get-ChildItem -LiteralPath (Join-Path $root "analog\spice") -File -ErrorAction SilentlyContinue |
  Where-Object { $_.Name -match '\.spice$|\.spi$|\.ngs$' } |
  ForEach-Object { $dead.Add($_.FullName) }

# 4) stray root text dumps / placeholder
foreach ($f in @("osc_numbers_ONLY.txt", "osc_numbers_ONLY.txt2", "_unused_placeholder", "Copenprobe")) {
  $p = Join-Path $root $f
  if (Test-Path -LiteralPath $p) { $dead.Add($p) }
}

Write-Host "=== dead-weight inventory ($($dead.Count) paths) ==="
$dead | ForEach-Object { Write-Host ("  {0}" -f $_) }

# safe: only run the removal below when user re-invokes with -Remove
if ($args -contains "-Remove") {
  $dead | ForEach-Object {
    if (Test-Path -LiteralPath $_) {
      Remove-Item -LiteralPath $_ -Recurse -Force
      Write-Host ("  removed: {0}" -f $_)
    }
  }
  Write-Host "=== cleanup complete ==="
} else {
  Write-Host ""
  Write-Host "(dry-run: nothing deleted. Re-run with -Remove to execute.)"
}