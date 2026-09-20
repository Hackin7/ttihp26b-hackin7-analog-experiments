$base = 'C:\Users\zunmun\eda\designs\ttihp26b-hackin7-analog-experiments'
$out  = 'C:\Users\zunmun\AppData\Local\Temp\opencode\launch_scan.txt'
$L = New-Object System.Collections.Generic.List[string]

function Add-Text([string]$t) { $L.Add($t) }

Add-Text '=== README head ==='
$rd = Join-Path $base 'README.md'
if (Test-Path -LiteralPath $rd) { foreach ($ln in @(Get-Content -LiteralPath $rd -TotalCount 60)) { Add-Text $ln } } else { Add-Text '(none)' }
Add-Text ''

Add-Text '=== Makefile ==='
$mk = Join-Path $base 'Makefile'
if (Test-Path -LiteralPath $mk) { foreach ($ln in @(Get-Content -LiteralPath $mk -TotalCount 80)) { Add-Text $ln } } else { Add-Text '(none)' }
Add-Text ''

Add-Text '=== docs listing ==='
$docs = Join-Path $base 'docs'
if (Test-Path -LiteralPath $docs) { foreach ($ln in @(Get-ChildItem -LiteralPath $docs -Force | ForEach-Object { '  ' + $_.Name })) { Add-Text $ln } } else { Add-Text '(none)' }
Add-Text ''

Add-Text '=== runs listing ==='
$runs = Join-Path $base 'runs'
if (Test-Path -LiteralPath $runs) { foreach ($ln in @(Get-ChildItem -LiteralPath $runs -Force | ForEach-Object { '  ' + $_.Name })) { Add-Text $ln } } else { Add-Text '(none)' }
Add-Text ''

Add-Text '=== src listing ==='
$src = Join-Path $base 'src'
if (Test-Path -LiteralPath $src) { foreach ($ln in @(Get-ChildItem -LiteralPath $src -Force | ForEach-Object { '  ' + $_.Name })) { Add-Text $ln } } else { Add-Text '(none)' }

Set-Content -LiteralPath $out -Value $L -Encoding UTF8
Write-Output ($L -join "`n")
