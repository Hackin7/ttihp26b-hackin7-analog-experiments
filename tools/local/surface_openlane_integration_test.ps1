$p = 'C:\openprobe\openlane_integration_test.log'
foreach ($l in [System.IO.File]::ReadAllLines($p)) {
  if ($l -match 'osc|period|freq|SG13G2|REAL-GATE|SDC|MACRO|LEF|GDS|ring|rc=') {
    if ($l -notmatch 'osdi|redefin|PATH|PYTHONPATH|writ|Debug|ngspice -b') { $l.Trim() }
  }
}
