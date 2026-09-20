$log = 'C:\openprobe\ring_gates_consolidated_tb_run.raw.log'
$rows = New-Object System.Collections.Generic.List[string]
foreach ($l in [System.IO.File]::ReadAllLines($log)) {
  if ($l -notmatch 'osdi|redefin|osdi,|redefin,|Debug|PATH|PYTHONPATH|writ|osdi, can|redefin, can') {
    $t = $l.Trim()
    if ($t -match 'osc|osc_|period|oscillat|oscill|ring|gate|SG13|sg13|meas|create_clock|outb|osc_proof|real.gate') {
      $rows.Add($t)
    }
  }
}
Write-Output ('osc proof rows surfaced from emitter log = {0}' -f $rows.Count)
if ($rows.Count -gt 0) {
  $rows | Select-Object -Last 790
}