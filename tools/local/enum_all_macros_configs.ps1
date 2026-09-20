$out = 'C:\Users\zunmun\AppData\Local\Temp\opencode\macros_enum_out.txt'
$lines = New-Object System.Collections.Generic.List[string]
$lines.Add('=== config.json/config.tcl files that mention MACROS under C:\Users\zunmun\eda ===')

Get-ChildItem -LiteralPath 'C:\Users\zunmun\eda' -Recurse -Include 'config.json','config.tcl' -File -ErrorAction SilentlyContinue |
  Where-Object { $_.FullName -notmatch '\\third_party\\' } |
  ForEach-Object {
    try {
      $txt = Get-Content -LiteralPath $_.FullName -Raw
      if ($txt -match 'MACROS') {
        $j = $txt | ConvertFrom-Json -ErrorAction Stop
        $lines.Add('')
        $lines.Add(('[FILE] ' + $_.FullName))
        if ($null -ne $j.MACROS) {
          foreach ($m in $j.MACROS.PSObject.Properties) {
            $lines.Add(('  macro: ' + $m.Name))
            foreach ($k in $m.Value.PSObject.Properties) {
              $v = $k.Value
              $ex = ''
              if ($v -is [string] -and $v -and ($k.Name -in @('lef','gds','abstract','abstract'))) {
                $p = Join-Path (Split-Path $_.FullName -Parent) $v
                if ($v -like 'analog*') { $p = Join-Path (Split-Path (Split-Path $_.FullName -Parent) -Parent) $v }
                $ex = '  [exists=' + (Test-Path -LiteralPath $p) + ']'
              }
              $lines.Add(('      ' + $k.Name + ' = [' + $v + ']' + $ex))
            }
          }
        } else {
          $lines.Add('  (MACROS key present but null)')
        }
      }
    } catch {
      $lines.Add(('[FILE] ' + $_.FullName + '  (unparseable: ' + $_.Exception.Message + ')'))
    }
  }

$lines.Add('')
$lines.Add('=== standalone analog lef/gds anywhere under eda ===')
Get-ChildItem -LiteralPath 'C:\Users\zunmun\eda' -Recurse -File -ErrorAction SilentlyContinue |
  Where-Object { $_.Name -eq 'tt_um_hackin7_analog_experiments.lef' -or $_.Name -eq 'tt_um_hackin7_analog_experiments.gds' } |
  ForEach-Object { $lines.Add($_.FullName) }

Set-Content -LiteralPath $out -Value $lines -Encoding UTF8
Write-Output ('wrote ' + $out + ' (' + $lines.Count + ' lines)')
