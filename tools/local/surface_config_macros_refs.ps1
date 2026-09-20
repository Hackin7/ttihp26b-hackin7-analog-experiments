$cfgPath = 'C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments\src\config.json'
$cfg = Get-Content -LiteralPath $cfgPath -Raw | ConvertFrom-Json

Write-Output '=== MACROS block ==='
if ($null -ne $cfg.MACROS) {
  foreach ($m in $cfg.MACROS.PSObject.Properties) {
    Write-Output ('  macro: {0}' -f $m.Name)
    foreach ($k in $m.Value.PSObject.Properties) {
      Write-Output ('      {0} = [{1}]' -f $k.Name, $k.Value)
    }
  }
} else {
  Write-Output '  (no MACROS key)'
}

Write-Output ''
Write-Output '=== referenced LEF/GDS files on disk ==='
$designRoot = 'C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments'
if ($null -ne $cfg.MACROS) {
  foreach ($m in $cfg.MACROS.PSObject.Properties) {
    foreach ($k in $m.Value.PSObject.Properties) {
      $rel = [string]$k.Value
      if ($rel -match '\.(lef|gds)($|\.)') {
        $full = Join-Path $designRoot $rel
        Write-Output ('  {0,-12} -> {1}  [exists={2}]' -f $k.Name, $rel, (Test-Path -LiteralPath $full))
      }
    }
  }
}

Write-Output ''
Write-Output '=== EXTRA_LEF_FILES / EXTRA_GDS_FILES ==='
foreach ($arrName in @('EXTRA_LEF_FILES','EXTRA_GDS_FILES','EXTRA_LEFS','EXTRA_GDS')) {
  if ($null -ne $cfg.$arrName) {
    Write-Output ("-- " + $arrName + " --")
    foreach ($e in @($cfg.$arrName)) {
      $full = Join-Path $designRoot $e
      Write-Output ('    {0}  [exists={1}]' -f $e, (Test-Path -LiteralPath $full))
    }
  }
}
