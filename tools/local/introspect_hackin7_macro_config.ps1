$root = 'C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments'
Write-Output '=== config files (json) mentioning MACROS ==='
Get-ChildItem -LiteralPath $root -Recurse -File -Filter 'config.json' -ErrorAction SilentlyContinue |
  ForEach-Object {
    $hits = Select-String -LiteralPath $_.FullName -Pattern 'MACROS' -ErrorAction SilentlyContinue
    if ($hits) { Write-Output $_.FullName }
  }
Write-Output '=== any lef/gds lanes actually on disk (repo) ==='
Get-ChildItem -LiteralPath $root -Recurse -File -Include '*.lef','*.gds','*.lef.gz','*.gds.gz' -ErrorAction SilentlyContinue |
  Select-Object -ExpandProperty FullName
Write-Output '=== files the active config references under analog/ ==='
Get-ChildItem -LiteralPath $root -Recurse -File -Filter 'config.json' -ErrorAction SilentlyContinue |
  ForEach-Object {
    $raw = [System.IO.File]::ReadAllText($_.FullName)
    foreach ($want in @('analog/lef','analog/gds','analog/lef/','analog/gds/','tt_um_hackin7_analog_experiments.lef','tt_um_hackin7_analog_experiments.gds')) {
      if ($raw -match [regex]::Escape($want)) { Write-Output ("  {0} -> {1}" -f $_.Name, $want) }
    }
  }