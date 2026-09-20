$designRoot = 'C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments'
$out = 'C:\Users\zunmun\AppData\Local\Temp\opencode\final_run_dir_state.txt'
$lines = New-Object System.Collections.Generic.List[string]

$runDir = Join-Path $designRoot 'runs\wokwi'
if (Test-Path -LiteralPath $runDir) {
  $files = @(Get-ChildItem -LiteralPath $runDir -Recurse -File -ErrorAction SilentlyContinue)
  $lines.Add("runs\wokwi EXISTS with $($files.Count) files")
  $configs = @($files | Where-Object { $_.Name -in @('config.json') })
  foreach ($c in $configs) {
    try {
      $j = Get-Content -LiteralPath $c.FullName -Raw | ConvertFrom-Json
      $mac = $null
      if ($null -ne $j.MACROS) { $mac = ($j.MACROS | ConvertTo-Json -Compress) }
      $lines.Add(('  ' + $c.FullName + '  ->  MACROS=' + $mac))
    } catch {
      $lines.Add(('  ' + $c.FullName + '  -> unparseable'))
    }
  }
} else {
  $lines.Add("runs\wokwi ABSENT - clean slate, next launch reads src\config.json fresh")
}

Set-Content -LiteralPath $out -Value $lines -Encoding UTF8
Write-Output ($lines -join "`n")
