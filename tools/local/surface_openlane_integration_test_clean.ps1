$p = 'C:\openprobe\openlane_integration_test.log'
if (-not (Test-Path -LiteralPath $p)) { Write-Output 'openlane_integration_test.log not on host stage yet'; exit 0 }
$rows = New-Object System.Collections.Generic.List[string]
foreach ($l in [System.IO.File]::ReadAllLines($p)) {
  $t = $l.Trim()
  if ($t -match 'osc|period|freq|SG13|gate|LEF|GDS|MACRO|SDC|ring' -and
      $t -notmatch 'osdi|redefin|PATH|PYTHONPATH|writ|Debug|osdi, |redefin, |SPICEOPT') {
    $rows.Add($t)
  }
}
if ($rows.Count -ge 1) {
  $rows | Select-Object -Last 4
} else {
  Write-Output ('no gate/lane rows in log; total lines=' + ([System.IO.File]::ReadAllLines($p)).Count)
  Get-Content -LiteralPath $p | Select-Object -Last 3
}